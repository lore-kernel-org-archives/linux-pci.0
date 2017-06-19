Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750925AbdFSSBO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Jun 2017 14:01:14 -0400
Date: Mon, 19 Jun 2017 13:01:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PCI: Workaround AMD EHCI controller PME bug
Message-ID: <20170619180111.GL11129@bhelgaas-glaptop.roam.corp.google.com>
References: <20170616094054.8044-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170616094054.8044-1-kai.heng.feng@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Alan]

On Fri, Jun 16, 2017 at 05:40:54PM +0800, Kai-Heng Feng wrote:
> On an AMD Carrizo laptop, when EHCI runtime PM is enabled, EHCI ports do
> not respond to any device plugging event.
> 
> As Alan Stern points out [1], the PME signal is not enabled when
> controller is in D3, therefore it's not being woken up when new deivces
> get plugged in.
> 
> Testing shows PME signal works when the EHCI power state is D2.
> 
> Bjorn Helgaas suggests to flip bits PCI_PM_CAP_PME_D3 and
> PCI_PM_CAP_PME_D3cold in PCI fixup.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=196091
> Link: https://support.amd.com/TechDocs/46837.pdf (Section 23)
> Link: https://support.amd.com/TechDocs/42413.pdf (Appendix A2)
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied (patch below) to pci/pm for v4.13, thanks!

Note that I added parens because bitwise NOT is higher precedence than
bitwise shift right, and I think we want the shift before the NOT.  Please
double-check.

> ---
>  arch/x86/pci/fixup.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 6d52b94f4bb9..0f71a908e262 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -571,3 +571,18 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2fc0, pci_invalid_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_invalid_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_invalid_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_invalid_bar);
> +
> +/*
> + * Device [1022:7808]
> + * 23. USB Wake on Connect/Disconnect with Low Speed Devices
> + * https://support.amd.com/TechDocs/46837.pdf
> + * Appendix A2
> + * https://support.amd.com/TechDocs/42413.pdf
> + */
> +static void pci_fixup_amd_ehci_pme(struct pci_dev *dev)
> +{
> +	dev_info(&dev->dev, "PME# does not work under D3, disabling it\n");
> +	dev->pme_support &= ~(PCI_PM_CAP_PME_D3 | PCI_PM_CAP_PME_D3cold)
> +		>> PCI_PM_CAP_PME_SHIFT;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x7808, pci_fixup_amd_ehci_pme);



commit dd263935a118821257b793a847e6837c2ac6bc84
Author: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri Jun 16 17:40:54 2017 +0800

    x86/PCI: Avoid AMD SB7xx EHCI USB wakeup defect
    
    On an AMD Carrizo laptop, when EHCI runtime PM is enabled, EHCI ports do
    not assert PME# for device plug/unplug events while in D3.
    
    As Alan Stern points out [1], the PME signal is not enabled when controller
    is in D3, therefore it's not being woken up when new devices get plugged
    in.
    
    Testing shows PME signal works when the EHCI power state is D2.
    
    Clear the PCI_PM_CAP_PME_D3 and PCI_PM_CAP_PME_D3cold bits in
    dev->pme_support to indicate the device will not assert PME# from those
    states.
    
    [1] http://lkml.kernel.org/r/Pine.LNX.4.44L0.1706121010010.2092-100000@iolanthe.rowland.org
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=196091
    Link: https://support.amd.com/TechDocs/46837.pdf (Section 23)
    Link: https://support.amd.com/TechDocs/42413.pdf (Appendix A2)
    Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
    [bhelgaas: changelog, add parens in quirk]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 6d52b94f4bb9..2259acdcede5 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -571,3 +571,18 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2fc0, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_invalid_bar);
+
+/*
+ * Device [1022:7808]
+ * 23. USB Wake on Connect/Disconnect with Low Speed Devices
+ * https://support.amd.com/TechDocs/46837.pdf
+ * Appendix A2
+ * https://support.amd.com/TechDocs/42413.pdf
+ */
+static void pci_fixup_amd_ehci_pme(struct pci_dev *dev)
+{
+	dev_info(&dev->dev, "PME# does not work under D3, disabling it\n");
+	dev->pme_support &= ~((PCI_PM_CAP_PME_D3 | PCI_PM_CAP_PME_D3cold)
+		>> PCI_PM_CAP_PME_SHIFT);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x7808, pci_fixup_amd_ehci_pme);
