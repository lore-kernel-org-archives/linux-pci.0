Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:37389 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbeCESXV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Mar 2018 13:23:21 -0500
Subject: Re: [PATCH v9 0/3] PCI: dwc: Enables MSI-X driver support
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "m-karicheri2@ti.com" <m-karicheri2@ti.com>,
        "thomas.petazzoni@free-electrons.com"
        <thomas.petazzoni@free-electrons.com>,
        "minghuan.Lian@freescale.com" <minghuan.Lian@freescale.com>,
        "mingkai.hu@freescale.com" <mingkai.hu@freescale.com>,
        "tie-fei.zang@freescale.com" <tie-fei.zang@freescale.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
        "svarbanov@mm-sol.com" <svarbanov@mm-sol.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        Shawn Guo <shawn.guo@linaro.org>, Vignesh R <vigneshr@ti.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
References: <cover.1519834018.git.gustavo.pimentel@synopsys.com>
 <20180302180320.GA5404@red-moon>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <23de1d16-ee47-9e53-c1c4-4437f37cc358@synopsys.com>
Date: Mon, 5 Mar 2018 18:22:53 +0000
MIME-Version: 1.0
In-Reply-To: <20180302180320.GA5404@red-moon>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 02/03/2018 18:03, Lorenzo Pieralisi wrote:
> [+cc Shawn, Vignesh, Pratyush]
> On Wed, Feb 28, 2018 at 04:10:22PM +0000, Gustavo Pimentel wrote:
>> Changes into a new IRQ handler mechanism (multiplexed IRQ domain hierarchy)
>> more suitable and appropriate to use on pcie-designware and on each SoC
>> specific driver in order to allow new and more complex features like MSI-X.
>>
>> Adds Synopsys Root Complex driver support for MSI-X feature.
>>
>> Expands the maximum number of IRQs from 32 to 256 distributed by
>> a maximum of 8 controller registers.
>>
>> The patch set was made against the Bjorn's master branch (v4.16-rc1).
>>
>> Gustavo Pimentel (3):
>>   PCI: dwc: Add new IRQ API
>>   PCI: dwc: Remove old IRQ API
>>   PCI: dwc: Expand maximum number of IRQs from 32 to 256
>>
>>  drivers/pci/dwc/pci-exynos.c           |  18 --
>>  drivers/pci/dwc/pci-imx6.c             |  18 --
>>  drivers/pci/dwc/pci-keystone-dw.c      |  91 +-------
>>  drivers/pci/dwc/pci-keystone.c         |   1 +
>>  drivers/pci/dwc/pci-keystone.h         |   4 +-
>>  drivers/pci/dwc/pci-layerscape.c       |   3 +-
>>  drivers/pci/dwc/pcie-artpec6.c         |  18 --
>>  drivers/pci/dwc/pcie-designware-host.c | 398 +++++++++++++++++++--------------
> 
> Hi Gustavo,
> 
> I was reviewing a patch and this raised a question:
> 
> -  why pcie-histb.c is not in the list of converted drivers above,
>    given that it uses dw_handle_msi_irq() the same way as others
>    you converted ?
> 
> Is it correct to leave pcie-histb.c as-is ? I do not think it is.

At the time the first series of this patch came out there wasn't such driver and
I just start working on this topic on December... Nevertheless, you are right it
should follow the same procedure that others.

diff --git a/drivers/pci/dwc/pcie-histb.c b/drivers/pci/dwc/pcie-histb.c
index 70b5c0b..5d47b90 100644
--- a/drivers/pci/dwc/pcie-histb.c
+++ b/drivers/pci/dwc/pcie-histb.c
@@ -207,13 +207,6 @@ static struct dw_pcie_host_ops histb_pcie_host_ops = {
 	.host_init = histb_pcie_host_init,
 };

-static irqreturn_t histb_pcie_msi_irq_handler(int irq, void *arg)
-{
-	struct pcie_port *pp = arg;
-
-	return dw_handle_msi_irq(pp);
-}
-
 static void histb_pcie_host_disable(struct histb_pcie *hipcie)
 {
 	reset_control_assert(hipcie->soft_reset);
@@ -393,14 +386,6 @@ static int histb_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "Failed to get MSI IRQ\n");
 			return pp->msi_irq;
 		}
-
-		ret = devm_request_irq(dev, pp->msi_irq,
-				       histb_pcie_msi_irq_handler,
-				       IRQF_SHARED, "histb-pcie-msi", pp);
-		if (ret) {
-			dev_err(dev, "cannot request MSI IRQ\n");
-			return ret;
-		}
 	}

 	hipcie->phy = devm_phy_get(dev, "phy");
-- 
2.7.4
> 
> I also would like to get this tested on DRA7 and SPEAR13XX which
> are the other host drivers using dw_handle_msi_irq() (even though
> in a different way than pcie-histb.c).

I think Kishon has already tested, however he never added the tested-by.

> 
> The difference here seems to be struct pcie_port->msi_irq usage, that's
> extremely confusing how it is used (or not used) in the drivers I
> mentioned above.
> 
> I have CC'ed the related maintainers I need feedback and this needs
> testing; this series code is in my branch:
> 
> pci/dwc-msi
> 
> Thanks,
> Lorenzo
> 
>>  drivers/pci/dwc/pcie-designware-plat.c |  16 --
>>  drivers/pci/dwc/pcie-designware.h      |  30 ++-
>>  drivers/pci/dwc/pcie-qcom.c            |  16 --
>>  11 files changed, 258 insertions(+), 355 deletions(-)
>>
>> -- 
>> 2.7.4
>>
>>

Thanks,
Gustavo
