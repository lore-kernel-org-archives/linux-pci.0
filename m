Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57690 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755811AbcBDWo7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 17:44:59 -0500
Date: Thu, 4 Feb 2016 16:44:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manish Jaggi <mjaggi@caviumnetworks.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Tirumalesh Chalamarla <tchalamarla@cavium.com>,
	"Richter, Robert" <Robert.Richter@caviumnetworks.com>
Subject: Re: [PATCH] PCI: Add cavium acs pci quirk
Message-ID: <20160204224456.GF7031@localhost>
References: <56ABC5AE.1050209@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56ABC5AE.1050209@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 30, 2016 at 01:33:58AM +0530, Manish Jaggi wrote:
> 
> Cavium devices matching this quirk do not perform
> peer-to-peer with other functions, allowing masking out
> these bits as if they were unimplemented in the ACS capability.
> 
> Acked-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> Signed-off-by: Manish Jaggi <mjaggi@caviumnetworks.com>

Applied as follows to pci/virtualization for v4.6, thanks, Manish!

Note that this quirk applies to *all* Cavium devices.  I assume that's
what you want; I only mention it because your comment says "Cavium
devices matching this quirk ...", which is all of them because the
code says PCI_ANY_ID.

Bjorn


commit b404bcfbf035413dcce539c8ba2c9986d220d8ed
Author: Manish Jaggi <mjaggi@caviumnetworks.com>
Date:   Sat Jan 30 01:33:58 2016 +0530

    PCI: Add ACS quirk for all Cavium devices
    
    Cavium devices matching this quirk do not perform peer-to-peer with other
    functions, allowing masking out these bits as if they were unimplemented in
    the ACS capability.
    
    Signed-off-by: Manish Jaggi <mjaggi@caviumnetworks.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0575a1e..85fa6a2a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3832,6 +3832,19 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
 #endif
 }
 
+static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
+{
+	/*
+	 * Cavium devices matching this quirk do not perform peer-to-peer
+	 * with other functions, allowing masking out these bits as if they
+	 * were unimplemented in the ACS capability.
+	 */
+	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
+		       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
+
+	return acs_flags ? 0 : 1;
+}
+
 /*
  * Many Intel PCH root ports do provide ACS-like features to disable peer
  * transactions and validate bus numbers in requests, but do not provide an
@@ -3984,6 +3997,8 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_pch_acs },
 	{ 0x19a2, 0x710, pci_quirk_mf_endpoint_acs }, /* Emulex BE3-R */
 	{ 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R */
+	/* Cavium ThunderX */
+	{ PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, pci_quirk_cavium_acs },
 	{ 0 }
 };
 
