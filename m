Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Mark Rutland <mark.rutland@arm.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Bad DT binding (hisi-pcie-almost-ecam)
Date: Mon, 13 Mar 2017 08:14:19 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E2047A8C1@FRAEML521-MBX.china.huawei.com>
References: <20170310174045.GB24571@leverpostej>
In-Reply-To: <20170310174045.GB24571@leverpostej>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mark

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland@arm.com]
> Sent: 10 March 2017 17:41
> To: liudongdong (C); Bjorn Helgaas
> Cc: Gabriele Paoloni; Wangzhou (B); devicetree@vger.kernel.org; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Bad DT binding (hisi-pcie-almost-ecam)
> 
> I've just spotted commit:
> 
>   a2ec1996098c7da0 ("PCI: hisi: Add DT almost-ECAM support for
> Hip06/Hip07 host controllers")
> 
> ... which went in for v4.11-rc1.
> 
> I hadn't seen this until now, and as far as I can tell this never went
> to the devicetree list.

Sorry about this, we'll be more careful next time

> 
> The commit adds the "hisilicon,pcie-almost-ecam", which goes against
> the
> usual DT conventions, and is non-sensical in that it describes the IP
> based on what it isn't.
> 
> This binding shouldn't have gone in as-is, and we should fix it before
> v4.11.
> 
> The binding states that this IP is found in Hip06 and Hip07. For these
> cases we'd usually take the name of the first implementation, e.g.
> something like "hisilicon,hip06-pcie", which can be used as a fallback
> in the compatible list if reused in subsequent SoC generations.
> 
> I also see that "hisilicon,hip06-pcie" already exists, so I'm even more
> suspicious.

For Hip06 the IP is the same but in we have a different BIOS configuration
that allows the controller be ECAM compliant for all the devices of the
hierarchy except the RC.

> 
> What exactly is the "hisilicon,pcie-almost-ecam" binding trying to
> describe? Is it a different IP also found on Hip06, or is it a new
> binding for the same IP?

The reason why we need this new BIOS is to support the recent PCIe quirks
for the ACPI Root Port driver (commit 5b69b85ba1ddd36be01f5c57830b37a3c8256009
"PCI/ACPI: Check for platform-specific MCFG quirks"). So using one BIOS we
support both DT and ACPI.
This is the reason why you see Hip-06 being already there...

About the name to use here from what you suggest we should use
"hisilicon,hip06-pcie-almost-ecam" and re-use it for hip07 SoC.
To be honest I would prefer it either as it is now or to modify the
driver as:

diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
index 52f1e3f..7527b4c 100644
--- a/drivers/pci/dwc/pcie-hisi.c
+++ b/drivers/pci/dwc/pcie-hisi.c
@@ -381,7 +381,11 @@ struct pci_ecam_ops hisi_pcie_platform_ops = {

  static const struct of_device_id hisi_pcie_almost_ecam_of_match[] = {
         {
-           .compatible = "hisilicon,pcie-almost-ecam",
+         .compatible = "hisilicon,pcie-almost-ecam-hip06",
+         .data           = (void *) &hisi_pcie_platform_ops,
+ },
+ {
+         .compatible = "hisilicon,pcie-almost-ecam-hip07",
                 .data       = (void *) &hisi_pcie_platform_ops,
         },
         {},

What do you think?

Many Thanks
Gab


> 
> Thanks,
> Mark.
