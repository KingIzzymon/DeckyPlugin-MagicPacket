import {
  ButtonItem,
  definePlugin,
  PanelSection,
  PanelSectionRow,
  ServerAPI,
  staticClasses,
} from "decky-frontend-lib";
import { VFC } from "react";
import { FaWifi } from "react-icons/fa";

import * as backend from "./backend";

const Content: VFC<{ serverAPI: ServerAPI }> = ({}) => {
  return (
    <PanelSection>
      <PanelSectionRow>
        <ButtonItem
          layout="below"
          onClick={async () => {
            backend.sendpacket()
          }
        }
        >
          Wake / Sleep
        </ButtonItem>
        <ButtonItem
          layout="below"
          onClick={async () => {
            backend.configurator()
          }
        }
        >
          Configurator
        </ButtonItem>
      </PanelSectionRow>
    </PanelSection>
  );
};

export default definePlugin((serverApi: ServerAPI) => {
  backend.setServerAPI(serverApi);

  return {
    title: <div className={staticClasses.Title}>MagicPacket</div>,
    content: <Content serverAPI={serverApi} />,
    icon: <FaWifi />
  };
});