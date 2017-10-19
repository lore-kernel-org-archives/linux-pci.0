Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751579AbdJSL0s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Oct 2017 07:26:48 -0400
Date: Thu, 19 Oct 2017 06:26:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        Wilson.Snyder@cavium.com, robert.richter@cavium.com,
        david.daney@cavium.com, mjaggi@caviumnetworks.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: Re: [PATCH v7 0/2] PCI: quirks: Cavium ThunderX ACS quirk update
Message-ID: <20171019112645.GD6332@bhelgaas-glaptop.roam.corp.google.com>
References: <1506536439-29318-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <1508244459-2615-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1508244459-2615-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 17, 2017 at 05:47:37AM -0700, Vadim Lomovtsev wrote:
> From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> 
> version 7:
> - update patch description accordingly to review comments;
> - split for two patches: for ACS mask change and device id match change;
> - remove macro #define of ACS flags, put it back to quirk function;
> - remove '__inline_' from device id matching function;
> - wrap code comments to fit into 80 columns;
> - comment fix: change 0xa00 to 0xf800 for matching function description;
> 
> version 6:
> - comment typo fix: change 0xa00 to 0xa000;
> 
> version 5:
> - update code comments accordingly to review comments;
> 
> version 4:
> - update ACS mask (remove TB and TD bits), update commit message (remove
>   ACS register printout);
> 
> version 3:
> - update subject: remove CN8XXX from subject line, replace it with ThunderX;
> 
> version 2:
> - update match function in order to filter only ThunderX devices by device
>   ids to properly filter CN8XXX devices, update subject & description with
>   ACS register info (v2 was rejected by maillist due to triple X in subject);
>   
> Vadim Lomovtsev (2):
>   PCI: quirks: Set Cavium ACS capability quirk flags to assert
>     RR/CR/SV/UF.
>   PCI: quirks: Apply Cavium ThunderX ACS quirk only to Root Ports
> 
>  drivers/pci/quirks.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)

If I'm reading this correctly, the first patch is basically fixing a bug in
the original Cavium ACS quirk (b404bcfbf035 ("PCI: Add ACS quirk for all
Cavium devices")).  Right?

I put them on pci/virtualization for v4.15 as follows (patches unchanged,
changelogs wordsmithed).

You mentioned stable backports.  b404bcfbf035 ("PCI: Add ACS quirk for all
Cavium devices") appeared in v4.6.  b77d537d00d0 ("PCI: Apply Cavium ACS
quirk only to CN81xx/CN83xx/CN88xx devices") appeared in v4.12.  I assume
you would ideally want all this backported as far as v4.6?  We'd have to
figure out how to express that in stable tags.


commit 60f6d5f7ebc4bba83d73115f58b805f2f2618667
Author: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Date:   Tue Oct 17 05:47:38 2017 -0700

    PCI: Set Cavium ACS capability quirk flags to assert RR/CR/SV/UF
    
    The Cavium ThunderX (CN8XXX) family of PCIe Root Ports does not advertise
    an ACS capability.  However, the RTL internally implements similar
    protection as if ACS had Request Redirection, Completion Redirection,
    Source Validation, and Upstream Forwarding features enabled.
    
    Change Cavium ACS capabilities quirk flags accordingly.
    
    Fixes: b404bcfbf035 ("PCI: Add ACS quirk for all Cavium devices")
    Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a4d33619a7bb..c23650cfd5a1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4214,12 +4214,14 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
 static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	/*
-	 * Cavium devices matching this quirk do not perform peer-to-peer
-	 * with other functions, allowing masking out these bits as if they
-	 * were unimplemented in the ACS capability.
+	 * Cavium root ports don't advertise an ACS capability.  However,
+	 * the RTL internally implements similar protection as if ACS had
+	 * Request Redirection, Completion Redirection, Source Validation,
+	 * and Upstream Forwarding features enabled.  Assert that the
+	 * hardware implements and enables equivalent ACS functionality for
+	 * these flags.
 	 */
-	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
-		       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
+	acs_flags &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_SV | PCI_ACS_UF);
 
 	if (!((dev->device >= 0xa000) && (dev->device <= 0xa0ff)))
 		return -ENOTTY;

commit 35da518fcad24f7be515976238a4667b5ccd1711
Author: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Date:   Tue Oct 17 05:47:39 2017 -0700

    PCI: Apply Cavium ThunderX ACS quirk to more Root Ports
    
    Extend the Cavium ThunderX ACS quirk to cover more device IDs and restrict
    it to only Root Ports.
    
    Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
    [bhelgaas: changelog]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c23650cfd5a1..0e22cce05742 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4211,6 +4211,19 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
 #endif
 }
 
+static bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
+{
+	/*
+	 * Effectively selects all downstream ports for whole ThunderX 1
+	 * family by 0xf800 mask (which represents 8 SoCs), while the lower
+	 * bits of device ID are used to indicate which subdevice is used
+	 * within the SoC.
+	 */
+	return (pci_is_pcie(dev) &&
+		(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) &&
+		((dev->device & 0xf800) == 0xa000));
+}
+
 static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	/*
@@ -4223,7 +4236,7 @@ static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
 	 */
 	acs_flags &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_SV | PCI_ACS_UF);
 
-	if (!((dev->device >= 0xa000) && (dev->device <= 0xa0ff)))
+	if (!pci_quirk_cavium_acs_match(dev))
 		return -ENOTTY;
 
 	return acs_flags ? 0 : 1;
