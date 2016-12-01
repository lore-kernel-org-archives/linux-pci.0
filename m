Return-Path: <SRS0=z0wH=XQ=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=z0wH=XQ=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH v10 00/12] PCI: ARM64 ECAM quirks
To: Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni
	<gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya
	<okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <d3f1a4ca-99e6-f0a5-d20b-d2753058d93d@huawei.com>
Date: Thu, 1 Dec 2016 21:02:25 +0800
MIME-Version: 1.0
In-Reply-To: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

Thank you for reworking the patchset.
I found some complie errors and can fix the errors by the below modification.

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index cdceaf5..c84330a 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -53,7 +53,7 @@ struct mcfg_fixup {
  /*     { OEM_ID, OEM_TABLE_ID, REV, SEGMENT, BUS_RANGE, ops, cfgres }, */

  #define QCOM_ECAM32(seg) \
-   { "QCOM  ", "QDF2432 ", 1, seg, MCFG_BUS_ANY, &pci_32b_ops },
+ { "QCOM  ", "QDF2432 ", 1, seg, MCFG_BUS_ANY, &pci_32b_ops }
         QCOM_ECAM32(0),
         QCOM_ECAM32(1),
         QCOM_ECAM32(2),
@@ -96,7 +96,7 @@ struct mcfg_fixup {

  #define THUNDER_ECAM_QUIRK(rev, node)                                  \
         { "CAVIUM", "THUNDERX", rev, node, MCFG_BUS_ANY,                \
-   &pci_thunder_ecam_ops },
+ &pci_thunder_ecam_ops }
         /* SoC pass1.x */
         THUNDER_PEM_QUIRK(2,  0),       /* off-chip devices */
         THUNDER_PEM_QUIRK(2,  1),       /* off-chip devices */
diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
index 7b03939..2066410 100644
--- a/drivers/pci/host/pci-thunder-pem.c
+++ b/drivers/pci/host/pci-thunder-pem.c
@@ -21,6 +21,7 @@
  #include <linux/pci-acpi.h>
  #include <linux/pci-ecam.h>
  #include <linux/platform_device.h>
+#include "../pci.h"

  #if defined(CONFIG_PCI_HOST_THUNDER_PEM) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))

@@ -324,6 +325,11 @@ static int thunder_pem_acpi_init(struct pci_config_window *cfg)
         struct acpi_device *adev = to_acpi_device(dev);
         struct acpi_pci_root *root = acpi_driver_data(adev);
         struct resource *res_pem;
+ int ret;
+
+ res_pem = devm_kzalloc(&adev->dev, sizeof(*res_pem), GFP_KERNEL);
+ if (!res_pem)
+         return -ENOMEM;

         ret = acpi_get_rc_resources("THRX0002", root->segment, res_pem);
         if (ret) {
diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index ee378c2..6b39939 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -22,6 +22,7 @@
  #include <linux/pci-acpi.h>
  #include <linux/pci-ecam.h>
  #include <linux/regmap.h>
+#include "../pci.h"

  #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)

@@ -80,15 +81,20 @@ static int hisi_pcie_init(struct pci_config_window *cfg)
         struct acpi_pci_root *root = acpi_driver_data(adev);
         struct resource *res;
         void __iomem *reg_base;
+ int ret;
+
+ res = devm_kzalloc(&adev->dev, sizeof(*res), GFP_KERNEL);
+ if (!res)
+         return -ENOMEM;

         /*
          * Retrieve RC base and size from a HISI0081 device with _UID
          * matching our segment.
          */
-   res = acpi_get_rc_resources("HISI0081", root->segment);
-   if (!res) {
-           dev_err(dev, "can't get rc base address\n");
-           return -ENOMEM;
+ ret = acpi_get_rc_resources("HISI0081", root->segment, res);
+ if (ret) {
+         dev_err(&adev->dev, "can't get rc base address");
+         return ret;
         }

         reg_base = devm_ioremap(dev, res->start, resource_size(res));


Thanks,
Dongdong
在 2016/12/1 16:29, Bjorn Helgaas 写道:
> This is what I've collected on my pci/ecam branch so far.  This is
> preliminary and probably doesn't even build since I made several
> changes, but at least it's a strawman.  I called it v10 to keep it
> separate from the previous postings of the various pieces.
>
>   ACPI: Add acpi_resource_consumer() to find device that claims a resource
>   PCI: Search ACPI namespace to ensure ECAM space is reserved
>   x86/PCI: Use acpi_resource_consumer() to search ACPI namespace for MMCFG
>
>     acpi_resource_consumer() takes a resource and returns an
>     acpi_device that has _CRS that contains the resource.  The idea is
>     that we call this on a resource from MCFG.  We *should* find a
>     PNP0C02 or other device that reserves that resource.  On x86 we
>     already do this in a more hand-coded way.  I probably wouldn't
>     merge the x86 patch for v4.10 but I included it here as an
>     example.
>
>     I don't think it's worth trying to fabricate ACPI devices or _CRS
>     resources to compensate for firmware that doesn't describe
>     everything.  This check will emit a warning if the MCFG region is
>     not reserved, and that's probably enough to motivate firmware
>     fixes for the next round of hardware.  The ECAM code itself does
>     reserve the region, so that part will be safe from other users.
>     Unreported non-ECAM register space is still a landmine and there's
>     no real way to look for it.
>
>   arm64: PCI: Manage controller-specific data on per-controller basis
>
>     Tomasz's fix for pci_acpi_scan_root(), unchanged.
>
>   PCI/ACPI: Extend pci_mcfg_lookup() to return ECAM config accessors
>   PCI/ACPI: Check for platform-specific MCFG quirks
>
>     Tomasz's quirk infrastructure.  I put this under
>     CONFIG_PCI_QUIRKS.
>
>   PCI/ACPI: Provide acpi_get_rc_resources() for ARM64 platform
>
>     Dongdong's interface to look up a _HID with a _UID matching the
>     segment.  I don't have an opinion on using _UID yet.  It's
>     encapsulated so it could be changed easily.  I put this under
>     CONFIG_PCI_QUIRKS && CONFIG_ARM64.
>
>   PCI: Add MCFG quirks for Qualcomm QDF2432 host controller
>
>     Christopher's Qualcomm quirks.  Basically unchanged except to put
>     the quirk ops under CONFIG_ACPI and CONFIG_PCI_QUIRKS.
>
>   PCI: Add MCFG quirks for HiSilicon Hip05/06/07 host controllers
>
>     Dongdong's HiSilicon quirks.  Here's where it gets interesting.  I
>     moved this to the existing pcie-hisi.c instead of adding
>     pcie-hisi-acpi.c.  I changed the Makefile so we always build
>     pcie-hisi.c on ARM64.  I added ifdefs so we get the quirk code if
>     CONFIG_ACPI and CONFIG_PCI_QUIRKS and we get the original platform
>     driver if CONFIG_PCI_HISI.  It's possible to have both, and if we
>     process the MCFG quirk we get the quirk code.
>
>     I'm confused about why the quirk accessors are so much different
>     than the original accessors.  hisi_pcie_acpi_rd_conf() looks much
>     different than hisi_pcie_cfg_read().  The original driver claims
>     Hipxx only supports 32-bit config accesses, but the quirk
>     accessors don't enforce that.
>
>   PCI: thunder-pem: Factor out resource lookup
>   PCI: Add MCFG quirks for Cavium ThunderX pass2.x host controller
>   PCI: Add MCFG quirks for Cavium ThunderX pass1.x host controller
>
>     Tomasz's ThunderX quirks.  I restructured the PEM init I could do
>     the same ifdef tricks as in hisi.  The quirks make a lot more
>     sense here -- they use the same accessors as the original platform
>     driver.  Only the initialization is different.
>
> The Makefile looks a little strange:
>
>   obj-$(CONFIG_ARM64) += pcie-hisi.o
>   obj-$(CONFIG_ARM64) += pci-thunder-ecam.o
>   obj-$(CONFIG_ARM64) += pci-thunder-pem.o
>
> and the ifdefs inside those files are a little unwieldy.  But I think
> they do accomplish the goals of:
>
>   - Adding no new files,
>
>   - Including the MCFG quirks whenever CONFIG_ACPI and
>     CONFIG_PCI_QUIRKS are enabled, regardless of the driver-specific
>     config,
>
>   - Including the original platform drivers when they are specifically
>     enabled, and
>
>   - Sharing the same code for the platform driver and the quirks
>     (except for HiSi, which I don't understand)
>
> I started looking at the Duc's X-Gene quirks, but I haven't wrapped my
> head around those yet.  I'm going to push this branch to get build
> testing and so you can comment on it.
>
> If by some miracle it builds and you test it, please collect the dmesg
> log and /proc/iomem contents.
>
> ---
>
> Bjorn Helgaas (5):
>       ACPI: Add acpi_resource_consumer() to find device that claims a resource
>       PCI: Search ACPI namespace to ensure ECAM space is reserved
>       x86/PCI: Use acpi_resource_consumer() to search ACPI namespace for MMCFG
>       PCI: Add MCFG quirks for HiSilicon Hip05/06/07 host controllers
>       PCI: thunder-pem: Factor out resource lookup
>
> Christopher Covington (1):
>       PCI: Add MCFG quirks for Qualcomm QDF2432 host controller
>
> Dongdong Liu (1):
>       PCI/ACPI: Provide acpi_get_rc_resources() for ARM64 platform
>
> Tomasz Nowicki (5):
>       arm64: PCI: Manage controller-specific data on per-controller basis
>       PCI/ACPI: Extend pci_mcfg_lookup() to return ECAM config accessors
>       PCI/ACPI: Check for platform-specific MCFG quirks
>       PCI: Add MCFG quirks for Cavium ThunderX pass2.x host controller
>       PCI: Add MCFG quirks for Cavium ThunderX pass1.x host controller
>
>
>  arch/arm64/kernel/pci.c             |   34 +++----
>  arch/x86/pci/mmconfig-shared.c      |   69 ++-------------
>  drivers/acpi/pci_mcfg.c             |  165 ++++++++++++++++++++++++++++++++++-
>  drivers/acpi/resource.c             |   57 ++++++++++++
>  drivers/pci/ecam.c                  |   31 +++++++
>  drivers/pci/host/Makefile           |    6 +
>  drivers/pci/host/pci-thunder-ecam.c |    9 ++
>  drivers/pci/host/pci-thunder-pem.c  |   88 ++++++++++++++-----
>  drivers/pci/host/pcie-hisi.c        |   95 ++++++++++++++++++++
>  drivers/pci/pci-acpi.c              |   71 +++++++++++++++
>  drivers/pci/pci.h                   |    4 +
>  include/linux/acpi.h                |    7 +
>  include/linux/pci-acpi.h            |    4 +
>  include/linux/pci-ecam.h            |    7 +
>  14 files changed, 537 insertions(+), 110 deletions(-)
>
> .
>
