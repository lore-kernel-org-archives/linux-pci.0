Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934001AbcLAUYZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Dec 2016 15:24:25 -0500
Date: Thu, 1 Dec 2016 14:24:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH v10 12/12] PCI: Add MCFG quirks for Cavium ThunderX
 pass1.x host controller
Message-ID: <20161201202416.GB8263@bhelgaas-glaptop.roam.corp.google.com>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161201083106.12247.20708.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <acb37ba2-e92e-f35b-d650-798193f7c9a5@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <acb37ba2-e92e-f35b-d650-798193f7c9a5@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 01, 2016 at 08:02:29PM +0100, Tomasz Nowicki wrote:
> On 01.12.2016 09:31, Bjorn Helgaas wrote:
> >From: Tomasz Nowicki <tn@semihalf.com>
> >
> >ThunderX pass1.x requires to emulate the EA headers for on-chip devices
> >hence it has to use custom pci_thunder_ecam_ops for accessing PCI config
> >space (pci-thuner-ecam.c). Add new entries to MCFG quirk array where it can
> >be applied while probing ACPI based PCI host controller.
> >
> >ThunderX pass1.x is using the same way for accessing off-chip devices
> >(so-called PEM) as silicon pass-2.x so we need to add PEM quirk entries
> >too.
> >
> >Quirk is considered for ThunderX silicon pass1.x only which is identified
> >via MCFG revision 2.
> >
> >[bhelgaas: change Makefile/ifdefs so quirk doesn't depend on
> >CONFIG_PCI_HOST_THUNDER_ECAM]
> >Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> >Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >---
> > drivers/acpi/pci_mcfg.c             |   15 +++++++++++++++
> > drivers/pci/host/Makefile           |    2 +-
> > drivers/pci/host/pci-thunder-ecam.c |    9 ++++++++-
> > include/linux/pci-ecam.h            |    1 +
> > 4 files changed, 25 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> >index a48b508..cdceaf5 100644
> >--- a/drivers/acpi/pci_mcfg.c
> >+++ b/drivers/acpi/pci_mcfg.c
> >@@ -93,6 +93,21 @@ static struct mcfg_fixup mcfg_quirks[] = {
> > 	/* SoC pass2.x */
> > 	THUNDER_PEM_QUIRK(1, 0UL),
> > 	THUNDER_PEM_QUIRK(1, 1UL),
> >+
> >+#define THUNDER_ECAM_QUIRK(rev, node)					\
> >+	{ "CAVIUM", "THUNDERX", rev, node, MCFG_BUS_ANY,		\
> >+	&pci_thunder_ecam_ops },
> 
> Nit: 0-3 and 10-11 are segment ranges:
> 
> +#define THUNDER_ECAM_QUIRK(rev, seg)			\
> +	{ "CAVIUM", "THUNDERX", rev, seg, MCFG_BUS_ANY,	\
> +	&pci_thunder_ecam_ops },

> > extern struct pci_ecam_ops thunder_pem_ecam_ops; /* Cavium ThunderX 2.x */
> >+extern struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
> 
> nit: thunder_pem_ecam_ops is also valid for ThunderX pass1.x too. We
> add relevant entries to mcfg_quirks array above. Also we use passY.X
> for SoC version.
> 
> extern struct pci_ecam_ops thunder_pem_ecam_ops; /* Cavium ThunderX
> pass2.x and pass1.x */
> extern struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX
> pass1.x */

I updated these with the following incremental diff.  I hope this is what
you meant!

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index f4e9c1c..d34d196 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -95,7 +95,7 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	THUNDER_PEM_QUIRK(1, 1UL),
 
 #define THUNDER_ECAM_QUIRK(rev, seg)					\
-	{ "CAVIUM", "THUNDERX", rev, seg, MCFG_BUS_ANY,		\
+	{ "CAVIUM", "THUNDERX", rev, seg, MCFG_BUS_ANY,			\
 	&pci_thunder_ecam_ops }
 	/* SoC pass1.x */
 	THUNDER_PEM_QUIRK(2,  0),	/* off-chip devices */
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 2afa70b..00eb8eb 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -62,7 +62,7 @@ extern struct pci_ecam_ops pci_generic_ecam_ops;
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 extern struct pci_ecam_ops pci_32b_ops;		/* 32-bit accesses only */
 extern struct pci_ecam_ops hisi_pcie_ops;	/* HiSilicon */
-extern struct pci_ecam_ops thunder_pem_ecam_ops; /* Cavium ThunderX 2.x */
+extern struct pci_ecam_ops thunder_pem_ecam_ops; /* Cavium ThunderX 1.x & 2.x */
 extern struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
 #endif
 
