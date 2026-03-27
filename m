Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF883BED74
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605414; cv=none; b=G4YD7zbV+WqB5T8Nzhc5H8gbDrjEfoeBtW1ypwqhZax4rlXjiJumG6nMW6jgFNd6bz5M9iJrm+qIwsdyFM/tR7jB5/hj/AHwsn3dlYECyN4hIyplPTRsfnKir+9Wpa47UR7fRWflRDiYEjOPmCvwRYonL2oc0u/z+gUfh7QELjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605414; c=relaxed/simple;
	bh=7wd4z96GOFh8UfRdNGdzPn4g1oWMDjWopo+cAcFHE+E=;
	h=Message-Id:From:Date:Subject:To:Cc; b=Ayt+dpBryiTuqhQC8kvJRvlKH7emAEmg3V6Zi06U/onLoWcmIz6gPhbmQYnjekLk2QC3HGxrd+1IqEwG+u2nLVbXT+kQ4EHi8WJ7rsadAtVPe+nunZYNgdEnrEdkeQYcUh33RBwtj+yMCrnpwTO2+QNENamP0gF/C4HI11y45Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 6C77538B4;
	Fri, 27 Mar 2026 10:56:42 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 65B2D6024CB9; Fri, 27 Mar 2026 10:56:42 +0100 (CET)
Message-Id: <734338c2e8b669db5a5a3b45d34131b55ffebfca.1774605029.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 27 Mar 2026 10:56:43 +0100
Subject: [PATCH] PCI/AER: Stop ruling out unbound devices as error source
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Stefan Roese <sr@denx.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

When searching for the error source, the AER driver rules out devices
whose enable_cnt is zero.  This was introduced in 2009 by commit
28eb27cf0839 ("PCI AER: support invalid error source IDs") without
providing a rationale.

Drivers typically call pci_enable_device() on probe, hence the enable_cnt
check essentially filters out unbound devices.  At the time of the commit,
drivers had to opt in to AER by calling pci_enable_pcie_error_reporting()
and so any AER-enabled device could be assumed to be bound to a driver.
The check thus made sense because it allowed skipping config space
accesses to devices which were known not to be the error source.

But since 2022, AER is universally enabled on all devices when they are
enumerated, cf. commit f26e58bf6f54 ("PCI/AER: Enable error reporting when
AER is native").

Errors may very well be reported by unbound devices, e.g. due to link
instability.  By ruling them out as error source, errors reported by them
are neither logged nor cleared.  When they do get bound and another error
occurs, the earlier error is reported together with the new error, which
may confuse users.  Stop doing so.

Fixes: f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v6.0+
---
 drivers/pci/pcie/aer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 4299c55..384d026 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1039,8 +1039,6 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 	 *      3) There are multiple errors and prior ID comparing fails;
 	 * We check AER status registers to find possible reporter.
 	 */
-	if (atomic_read(&dev->enable_cnt) == 0)
-		return false;
 
 	/* Check if AER is enabled */
 	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &reg16);
-- 
2.51.0

