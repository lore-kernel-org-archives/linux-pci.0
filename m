Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 5 Sep 2016 10:25:38 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Po Liu <po.liu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roy Zang <roy.zang@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stuart Yoder <stuart.yoder@nxp.com>,
        Yang-Leo Li <leoyang.li@nxp.com>,
        Minghuan Lian <minghuan.lian@nxp.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@nxp.com>
Subject: Re: [PATCH v4 1/2] nxp/dts: add pcie aer interrupt-name property in
 the dts
Message-ID: <20160905022537.GF25778@tiger>
References: <1465892645-32381-2-git-send-email-po.liu@nxp.com>
 <1472625442-23309-1-git-send-email-po.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472625442-23309-1-git-send-email-po.liu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 31, 2016 at 02:37:21PM +0800, Po Liu wrote:
> NXP some platforms aer interrupt was not MSI/MSI-X/INTx
> but using interrupt line independently. This patch add a "aer"
> interrupt-names for aer interrupt.
> With the interrupt-names "aer", code could probe aer interrupt
> line for pcie root port, replace the aer interrupt service irq.
> This is intend to fixup the Layerscape platforms which aer interrupt
> was not MSI/MSI-X/INTx, but using interrupt line independently.
> 
> Signed-off-by: Po Liu <po.liu@nxp.com>
> ---
> changes for V4:
> 	- Add comments explain why to add this patch
> 	- Move the binding changes to pci code patch
> 
>  arch/arm/boot/dts/ls1021a.dtsi                 |  6 ++++--
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 18 +++++++++---------
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 16 ++++++++--------

Do not mix up arm dts changes with arm64 ones.  Use separate patch
please.

Shawn
