Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Leo Li <leoyang.li@nxp.com>
To: Xiaowei Bao <xiaowei.bao@nxp.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, Madalin-cristian Bucur
 <madalin.bucur@nxp.com>, Sumit Garg <sumit.garg@nxp.com>, "Y.b. Lu"
 <yangbo.lu@nxp.com>, "hongtao.jia@nxp.com" <hongtao.jia@nxp.com>, Andy Tang
 <andy.tang@nxp.com>, "kishon@ti.com" <kishon@ti.com>, "jingoohan1@gmail.com"
 <jingoohan1@gmail.com>, "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
 "songxiaowei@hisilicon.com" <songxiaowei@hisilicon.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "Z.q. Hou" <zhiqiang.hou@nxp.com>, "Mingkai
 Hu" <mingkai.hu@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>
Subject: RE: [PATCH 0/3] dts: Add the property of IB and OB
Date: Fri, 3 Nov 2017 17:06:58 +0000
Message-ID: <AM4PR0401MB1699C33E678BB7DD027307568F5D0@AM4PR0401MB1699.eurprd04.prod.outlook.com>
References: <20171103093115.14915-1-xiaowei.bao@nxp.com>
In-Reply-To: <20171103093115.14915-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Xiaowei Bao <xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Bao Xiaowei [mailto:xiaowei.bao@nxp.com]
> Sent: Friday, November 03, 2017 4:31 AM
> To: robh+dt@kernel.org; mark.rutland@arm.com; catalin.marinas@arm.com;
> will.deacon@arm.com; bhelgaas@google.com; shawnguo@kernel.org;
> Madalin-cristian Bucur <madalin.bucur@nxp.com>; Sumit Garg
> <sumit.garg@nxp.com>; Y.b. Lu <yangbo.lu@nxp.com>; hongtao.jia@nxp.com;
> Andy Tang <andy.tang@nxp.com>; Leo Li <leoyang.li@nxp.com>;
> kishon@ti.com; jingoohan1@gmail.com; pbrobinson@gmail.com;
> songxiaowei@hisilicon.com; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Z.q. Hou
> <zhiqiang.hou@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>
> Cc: Xiaowei Bao <xiaowei.bao@nxp.com>
> Subject: [PATCH 0/3] dts: Add the property of IB and OB

When you send a v2 series, please include v2 in the title of all patches like "[PATCH v2 0/3]"...

Also the title of this summary email should really be the summary of all 3 patches like "Adding PCIe EP support to ls1046a".

-Leo


> 
> Depend on
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fpatchw
> ork.ozlabs.org%2Fpatch%2F815382%2F&data=02%7C01%7Cleoyang.li%40nxp.c
> om%7C7db015020c8a414f57e708d522a03165%7C686ea1d3bc2b4c6fa92cd99c
> 5c301635%7C0%7C0%7C636452993777387982&sdata=19Fmzg%2FOJGl%2Bgizv
> xfY1yELlFgWKRuZ%2FVNbx49yz2Wk%3D&reserved=0
> 
> Bao Xiaowei (3):
>   ARMv8: dts: ls1046a: add the property of IB and OB
>   ARMv8: layerscape: add the pcie ep function support
>   ARMv8: pcie: make the DWC EP driver support for layerscape
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   6 ++
>  drivers/pci/dwc/Kconfig                        |   1 +
>  drivers/pci/dwc/pci-layerscape.c               | 122 +++++++++++++++++++++++--
>  3 files changed, 123 insertions(+), 6 deletions(-)
> 
> --
> 2.14.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
