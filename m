Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53240 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933281AbaGRJ3B (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jul 2014 05:29:01 -0400
Message-ID: <1405675599.6072.8.camel@weser.hi.pengutronix.de>
Subject: Re: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
From: Lucas Stach <l.stach@pengutronix.de>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Shawn Guo <shawn.guo@freescale.com>,
	Richard Zhu <r65037@freescale.com>,
	Fabio Estevam <festevam@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marek =?UTF-8?Q?Va=C5=A1ut?= <marex@denx.de>,
	David =?ISO-8859-1?Q?M=FCller?= "(ELSOFT AG)"
	<d.mueller@elsoft.ch>, Sascha Hauer <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Date: Fri, 18 Jul 2014 11:26:39 +0200
In-Reply-To: <CAJ+vNU0DNCT5pcvnptNBo-tPTVOH1HnrCwy7uCZt33dfyq8U-g@mail.gmail.com>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
	 <20140626031247.GN2224@dragon>
	 <CAOMZO5A0pQfJRwb41046UpkbG6xH7c+EVu+YuY71Zuyq5gHaDA@mail.gmail.com>
	 <20140626054937.GB7859@dragon>
	 <CAJ+vNU0DNCT5pcvnptNBo-tPTVOH1HnrCwy7uCZt33dfyq8U-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tim,

Am Donnerstag, den 26.06.2014, 17:29 -0700 schrieb Tim Harvey:
[...]
> Shawn / Richard,
> 
> I am also affected by this issue on IMX6 boards that I support. If I
> enable PCI in the bootloader I see similar hangs.
> 
> I have the following hardware configurations on my bench:
>   1. IMX6DL + i210 (same PCI setup as Fabio's above, but DL instead of Q)
>   2. IMX6Q + ath9k device
>   3. IMX6DL + PLX PEX860x PCIe-to-PCIe bridge with various devices
> behind the bridge, using a clock buffer from IMX6 PCIe clock
>   4. IMX6Q + PLX PEX860x PCIe-to-PCIe bridge with various devices
> behind the bridge, using a clock buffer from IMX6 PCIe clock
>   5. IMX6Q + PLX PEX860x PCIe-to-PCIe bridge with various devices
> behind the bridge using a clock generator (always on, ignoring the
> PCIe clock)
> 
> For all of the above I have no PCI issues using
> 3.14/3.15/3.16-rc2/vendor 3.10.17_1.0.0_ga unless I enable PCI in the
> bootloader. When I do so, all of the above configurations hang
> somewhere around PCI init/enumeration. The same occurs with the most
> recent vendor kernel 3.10.17_1.0.0_ga kernel (works when PCI is
> disabled in the bootloader, hangs otherwise).
> 
> When I apply Fabio's patch above to the 3.16-rc2 kernel I find that
> scenarios #4 and #5 above then work, #3 boots but the PLX bridge fails
> all config cycles (0xff's), #2 boots but with no PCIe link, and #1
> above still hangs. Previously, when I have dug into this particular
> 'hang' issue on 3.15 I found that the delay needed to be between
> imx6_pcie_probe() requesting and asserting reset_gpio low, and before
> setting IOMUX_GPR1:18 to power down the PCIe PHY (note here, that the
> PHY is currently enabled in the bootloader when PCI is enabled there).
> 
> When I apply Fabio's patch above to the most recent vendor kernel
> 3.10.17_1.0.0_ga I still hang in all cases.
> 
> So while I agree there is something horribly wrong with IMX6 PCI
> still, I don't think Fabio's patch is the right solution and I don't
> have anything better at this point in time. I'm happy to share any
> hardware with anyone that can work through this issue.
> 
Can you try if the attached patch makes any difference?

Regards,
Lucas
------------------------------>8---------------------------------
>From 0e2fc443c760290166f6371d50813e6c30a678da Mon Sep 17 00:00:00 2001
From: Lucas Stach <l.stach@pengutronix.de>
Date: Thu, 17 Jul 2014 18:54:44 +0200
Subject: [PATCH] try forcing LTSSM into detect state

---
 drivers/pci/host/pci-imx6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index a568efaa331c..afa450c54aba 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -215,6 +215,8 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
 
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 			IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-- 
2.0.1


-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

