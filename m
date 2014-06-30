Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38486 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbaF3NqG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jun 2014 09:46:06 -0400
Message-ID: <1404135864.4305.23.camel@weser.hi.pengutronix.de>
Subject: Re: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
From: Lucas Stach <l.stach@pengutronix.de>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Shawn Guo <shawn.guo@freescale.com>,
	Richard Zhu <r65037@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Date: Mon, 30 Jun 2014 15:44:24 +0200
In-Reply-To: <20140628143712.GA7869@dragon>
References: <20140624153559.GA5741@dragon>
	 <CAOMZO5AT54hOF2bi9bQwmBcdtG0QHyofQgoRG6Mw_RpDQXzx=w@mail.gmail.com>
	 <20140625062243.GD3242@dragon>
	 <CAOMZO5BuOhWo7SCEPFmNRUQBi=5JhDrVv0yvBQM2d_jMyLkbyw@mail.gmail.com>
	 <1403693452.4249.1.camel@weser.hi.pengutronix.de>
	 <20140625125306.GB6917@dragon>
	 <1403772229.4254.4.camel@weser.hi.pengutronix.de>
	 <20140628143712.GA7869@dragon>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Samstag, den 28.06.2014, 22:37 +0800 schrieb Shawn Guo:
> On Thu, Jun 26, 2014 at 10:43:49AM +0200, Lucas Stach wrote:
> > Am Mittwoch, den 25.06.2014, 20:53 +0800 schrieb Shawn Guo:
> > > On Wed, Jun 25, 2014 at 12:50:52PM +0200, Lucas Stach wrote:
> > > > Am Mittwoch, den 25.06.2014, 07:50 -0300 schrieb Fabio Estevam:
> > > > > On Wed, Jun 25, 2014 at 3:22 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > > 
> > > > > > Please test against v3.16-rc1 or -rc2.  The breakage on linux-next
> > > > > > should be another issue.
> > > > > 
> > > > > Yes, I see it now. Tested on -rc2 and suspend/resume works with PCI
> > > > > driver removed.
> > > > 
> > > > Can you please send me a dmesg from a working boot?
> > > 
> > > What do you mean by "working boot"?  Boot is always working.  What fails
> > > is system resuming.
> > > 
> > > Shawn
> > > 
> > Oops, what I meant is a dmesg after a working resume (from kernel 3.15).
> > I can see how failing to resume from L2 can cause the hang and we should
> > really implement the PHY PD toggling in the pcie driver, but I would
> > like to understand why you don't hit this on 3.15.
> 
> Sorry, Lucas.  I just noticed that in my 3.15 testing PCIe is not
> enabled in device tree at all.  So the issue should have already been
> there before your changes to PCIe driver.
> 
Hi Shawn,

can you please test the attached patch on top of 3.16-rc* to see if it
helps? If it works for you I would like to try and get this into 3.16 as
a bugfix.

Regards,
Lucas

--------------------------->8-----------------------------
>From f3bfdc9c19249188fa153b1568c3129cd31af4f5 Mon Sep 17 00:00:00 2001
From: Lucas Stach <l.stach@pengutronix.de>
Date: Mon, 30 Jun 2014 15:33:04 +0200
Subject: [PATCH] PCI: imx6: add workaround for errata ERR005723

Fixes system hang after resume from suspend to mem.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pci-imx6.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index a568efaa331c..5c58a3ee5dbf 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -589,6 +589,38 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int imx6_pcie_suspend(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+			IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
+
+	return 0;
+}
+
+static int imx6_pcie_resume(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+
+	/*
+	 * This is a workaround for
+	 * ERR005723: PCIe does not support L2 power down
+	 * Toggling the PHY PD bit around system L2 state switching seems to be
+	 * enough to wake the PCIe logic after a power down.
+	 */
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(imx6_pcie_pm_ops,
+		imx6_pcie_suspend,
+		imx6_pcie_resume);
+
 static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6q-pcie", },
 	{},
@@ -600,6 +632,7 @@ static struct platform_driver imx6_pcie_driver = {
 		.name	= "imx6q-pcie",
 		.owner	= THIS_MODULE,
 		.of_match_table = imx6_pcie_of_match,
+		.pm = &imx6_pcie_pm_ops,
 	},
 };
 
-- 
2.0.0


-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

