Return-Path: <SRS0=mElY=7E=nxp.com=roy.zang@kernel.org>
Return-Path: <SRS0=mElY=7E=nxp.com=roy.zang@kernel.org>
From: Roy Zang <roy.zang@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Z.q. Hou" <zhiqiang.hou@nxp.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "Minghuan
 Lian" <minghuan.Lian@freescale.com>, Mingkai Hu <mingkai.hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH] PCI: layerscape: Add support for ls2088a and ls1088a
Date: Wed, 2 Aug 2017 21:38:27 +0000
Message-ID: <AM5PR04MB2945C9A811888349090A68868BB00@AM5PR04MB2945.eurprd04.prod.outlook.com>
References: <1499333984-17668-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <20170802212942.GA7667@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: multipart/alternative;
	boundary="_000_AM5PR04MB2945C9A811888349090A68868BB00AM5PR04MB2945eurp_"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

--_000_AM5PR04MB2945C9A811888349090A68868BB00AM5PR04MB2945eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On 08/02/2017 04:30 PM, Bjorn Helgaas wrote:

+        "fsl,ls2088a-pcie", "fsl,ls1088a-pcie"


You add "fsl,ls1088a-pcie" here, but not in the ls_pcie_of_match[]
table in the driver, so I don't think this will actually make the
driver claim ls1088a devices, will it?

the same query.

Thank.

Roy

--_000_AM5PR04MB2945C9A811888349090A68868BB00AM5PR04MB2945eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body text=3D"#000000" bgcolor=3D"#FFFFFF">
<div class=3D"moz-cite-prefix">On 08/02/2017 04:30 PM, Bjorn Helgaas wrote:=
<br>
</div>
<blockquote type=3D"cite" cite=3D"mid:20170802212942.GA7667@bhelgaas-glapto=
p.roam.corp.google.com">
<blockquote type=3D"cite" style=3D"color: #000000;">
<pre wrap=3D"">&#43;        &quot;fsl,ls2088a-pcie&quot;, &quot;fsl,ls1088a=
-pcie&quot;=0A=
</pre>
</blockquote>
<pre wrap=3D"">You add &quot;fsl,ls1088a-pcie&quot; here, but not in the ls=
_pcie_of_match[]=0A=
table in the driver, so I don't think this will actually make the=0A=
driver claim ls1088a devices, will it?</pre>
</blockquote>
<p>the same query.</p>
<p>Thank.<br>
</p>
<p>Roy<br>
</p>
</body>
</html>

--_000_AM5PR04MB2945C9A811888349090A68868BB00AM5PR04MB2945eurp_--
