Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2497949B1FB
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791462854; cv=none; b=VppX2U2TQ6ZNOBY3uD0b8XxotDA7E23BIjU4WIK9MetsWpgfbxia+o9WjbD/W8MhX2xj5WutLQOiMgc2a3yej5O5uwfmI4ZxafMNJWYydgW+peDnxZm+31tADnglR76bPOVfS2+jBlpRSxxJZuqqxRHWQBOmr5ITddVq5fx/oOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791462854; c=relaxed/simple;
	bh=sJo6rVlMb2RS5RdSzBUeVKp0+RRwdbdERu8KplLf4hA=;
	h=Message-ID:From:Date:Subject:To:Cc; b=qKrG1P/44ZU7JEEfiVJp9O9HLthd2v0YxvjVPRaab0SR6RLN6CQQ6KNEl+UZQTUKB1g5jGsVyjjSHXeTP9OQ1WvygEo5mTeipg4C1FvX5Nqfc/njd36wm5uqtna3H/bLa0TrVTD2uO9Sl3WYaJBnuwdy3Ai6S/EefHIBPHADZTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 12987390;
	Thu, 08 Oct 2026 14:26:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0BE12609B7A5; Thu,  8 Oct 2026 14:26:02 +0200 (CEST)
Message-ID: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 8 Oct 2026 14:26:00 +0200
Subject: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Alex Deucher <alexdeucher@gmail.com>, Christian Koenig <christian.koenig@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>, Jason Perlow <jperlow@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Alex is seeing a probe failure of the amdgpu driver after the Root Port
above an AMD Navi10 GPU has been reset.  The reset was performed to
recover from a Firmware First reported Fatal Error.

However all status registers in the Root Port's AER Extended Capability
are blank, so apparently the platform firmware raised a false alarm.

The issue is only occurring since commit eddba19b8b5f ("PCI/AER: Support
Advisory Non-Fatal Errors").  It looks like enabling Advisory Non-Fatal
Errors causes code paths to be exercised in platform firmware which
were never validated before.

Skip error recovery on false alarms, i.e. if no unmasked errors were
actually signaled.

Note that this will also skip recovery if both the Status and Mask
registers are "all ones", as would be the case for inaccessible devices.
However that seems justified because it would imply either a hot-unplug
event or a Surprise Down Error further up in the hierarchy.  Interfering
with recovery from that seems uncalled for.

Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
Reported-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Alex Deucher <alexander.deucher@amd.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222095
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 When applied to pci/for-linus, this will cause a conflict during the
 merge window with a commit queued on pci/aer, d4c842c3af5b ("PCI/AER:
 Fix memory leak in aer_recover_work_func() when pci_dev is missing").
 
 To resolve the conflict, change "if (pdev)" to "if (pdev && err)"
 and move the pci_dev_put() out of the if-clause (so that it gets
 called if pdev != NULL but err == 0).
 
 If this is all too complicated and/or late, I can respin on top of
 pci/aer or v7.4-rc1.
 
 drivers/pci/pcie/aer.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d8dcd238fda1..922a726a52a5 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1360,8 +1360,10 @@ static DEFINE_KFIFO(aer_recover_ring, struct aer_recover_entry,
 
 static void aer_recover_work_func(struct work_struct *work)
 {
+	struct aer_capability_regs *regs;
 	struct aer_recover_entry entry;
 	struct pci_dev *pdev;
+	u32 err;
 
 	while (kfifo_get(&aer_recover_ring, &entry)) {
 		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
@@ -1375,6 +1377,12 @@ static void aer_recover_work_func(struct work_struct *work)
 		}
 		pci_print_aer(pdev, entry.severity, entry.regs);
 
+		regs = entry.regs;
+		if (entry.severity == AER_CORRECTABLE)
+			err = regs->cor_status & ~regs->cor_mask;
+		else
+			err = regs->uncor_status & ~regs->uncor_mask;
+
 		/*
 		 * Memory for aer_capability_regs(entry.regs) is being
 		 * allocated from the ghes_estatus_pool to protect it from
@@ -1385,12 +1393,14 @@ static void aer_recover_work_func(struct work_struct *work)
 		ghes_estatus_pool_region_free((unsigned long)entry.regs,
 					    sizeof(struct aer_capability_regs));
 
-		if (entry.severity == AER_NONFATAL)
-			pcie_do_recovery(pdev, pci_channel_io_normal,
-					 aer_root_reset);
-		else if (entry.severity == AER_FATAL)
-			pcie_do_recovery(pdev, pci_channel_io_frozen,
-					 aer_root_reset);
+		if (err) {
+			if (entry.severity == AER_NONFATAL)
+				pcie_do_recovery(pdev, pci_channel_io_normal,
+						 aer_root_reset);
+			else if (entry.severity == AER_FATAL)
+				pcie_do_recovery(pdev, pci_channel_io_frozen,
+						 aer_root_reset);
+		}
 		pci_dev_put(pdev);
 	}
 }
-- 
2.53.0

