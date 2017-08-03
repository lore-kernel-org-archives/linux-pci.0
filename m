Return-Path: <SRS0=IFNJ=7F=nxp.com=roy.zang@kernel.org>
Return-Path: <SRS0=IFNJ=7F=nxp.com=roy.zang@kernel.org>
From: Roy Zang <roy.zang@nxp.com>
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "Minghuan
 Lian" <minghuan.Lian@freescale.com>, Mingkai Hu <mingkai.hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH] PCI: layerscape: Add support for ls2088a and ls1088a
Date: Thu, 3 Aug 2017 18:22:48 +0000
Message-ID: <DB6PR04MB2949CCDAADC03863B80852108BB10@DB6PR04MB2949.eurprd04.prod.outlook.com>
References: <1499333984-17668-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <20170802212942.GA7667@bhelgaas-glaptop.roam.corp.google.com>
 <AM5PR0402MB2771BBF476E6A3DEFADE43F484B10@AM5PR0402MB2771.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On 08/02/2017 10:36 PM, Z.q. Hou wrote:=0A=
> add "fsl,ls1088a-pcie" to ls_pcie_of_match[], then ls1088a pcie DT nodes =
use the compatible string "fsl,ls1088a-pcie"?=0A=
=0A=
I'd suggest going this way.=0A=
=0A=
Roy=0A=
=0A=
