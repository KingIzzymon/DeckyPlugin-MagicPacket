import {
  ButtonItem,
  definePlugin,
  PanelSection,
  PanelSectionRow,
  ServerAPI,
  staticClasses
} from "decky-frontend-lib";
import { VFC } from "react";
import { FaWifi } from "react-icons/fa";

const Content: VFC<{ serverAPI: ServerAPI }> = ({ serverAPI }) => {
  return (
    <PanelSection>
      <PanelSectionRow>
        <ButtonItem
          layout="below"
          onClick={async () => {
            await serverAPI!.callPluginMethod("sendpacket", {});
            console.log("[MagicPacket] Called 'sendpacket'");
          }}
          >
          Wake / Sleep
        </ButtonItem>
        <ButtonItem
          layout="below"
          onClick={async () => {
            await serverAPI!.callPluginMethod("configurator", {});
            console.log("[MagicPacket] Called 'configurator'");
            const result = await serverAPI!.callPluginMethod("configurator", {});
            console.log(result);
          }}
          >
          Configurator
        </ButtonItem>
      </PanelSectionRow>
    </PanelSection>
  );
};

export default definePlugin((serverApi: ServerAPI) => {
  return {
    title: <div className={staticClasses.Title}>MagicPacket</div>,
    content: <Content serverAPI={serverApi} />,
    icon: <FaWifi />,
    alwaysRender: true
  };
});
