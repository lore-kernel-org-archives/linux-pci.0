Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEDD391849
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789479327; cv=none; b=ouI9ke1/qbHqkYhTrgeF6V1e9EZGve+aU64JHd2mwhUUFsHJ2tUZShoLXX2qwiLcymZbmUdH8q1KYvwxzdOOxOL1Otbkp3vH9CoW43nmCeVHtC+6SrRKrP6gInF+49q3HP1jFVIjT01+fnscLfji0gTYuAcvnYlim0SKdIQgGo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789479327; c=relaxed/simple;
	bh=I+cwrO+/KbnuG756yjd0+2dyZvUZETXyKCXvXzq+mw8=;
	h=Message-Id:From:Date:Subject:To:Cc; b=sNNP9DHt6fg0oKF/mkSFqg73ZENmzy8/Q6UE/Y/ar2FKzO5IKTr5BicQOFANLL9YPQRS20ivNA7MXDO6Ibe8cbGrPcQiPeHqmYL3uIguJxuU2ZbSh6kBk68hT47KrX75nCR+nbAfKYclcNEiq/C64R9idHOIUnm09pAE3gHxeGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id E775A1D3C;
	Tue, 15 Sep 2026 15:35:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AEA5760A8AEF; Tue, 15 Sep 2026 15:35:13 +0200 (CEST)
Message-Id: <4c908eaab127d82ecfdc1e9948964b2e641d41d8.1789478646.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 15 Sep 2026 15:35:00 +0200
Subject: [PATCH] PCI: Fix order of device disablement on reset
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Riana Tauro <riana.tauro@intel.com>, Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, Keith Busch <kbusch@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Riana reports an AER splat when issuing a Secondary Bus Reset through the
"reset_subordinate" sysfs attribute:

  AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:01:00.0
  PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Requester ID)
    device [8086:e2ff] error status/mask=00100000/00400000
    [20] UnsupReq               (First)
  AER:   TLP Header: 0x40000001 0x0000000f 0x81190008 0x00000000

The Secondary Bus Reset is issued at the Root Port.  Underneath is a
Switch with two Endpoints.  Riana has identified an ordering issue in
pci_bus_save_and_disable_locked() as root cause of the AER splat:
The function calls pci_dev_save_and_disable() for the Switch Upstream Port
first, then recurses down to its subordinate devices.

pci_dev_save_and_disable() quiesces a device by clearing its Command
register (in accordance with PCIe r7.0 sec 6.6.2, "Implementation Note:
Avoiding data corruption from stale completions").

On devices with a Type 1 Configuration Space Header (such as the Switch
Upstream Port), clearing the Command register causes MMIO accesses to
subordinate devices to be handled as Unsupported Requests, as seen in
the AER splat above (PCIe r7.0 sec 7.5.1.1.3 bit 1).

The drivers of subordinate devices are only informed afterwards of the
impending reset via their ->reset_prepare() callback.  They get no chance
to stop access to MMIO space before the Switch Upstream Port disables
access.

Reorder pci_bus_save_and_disable_locked() to recurse first and only then
disable the Switch Upstream Port.  This mirrors the order in
pci_slot_restore_locked() and avoids the AER splat.

Do the same in pci_slot_save_and_disable_locked() for consistency.

Fixes: 090a3c5322e9 ("PCI: Add pci_reset_slot() and pci_reset_bus()")
Reported-by: Riana Tauro <riana.tauro@intel.com> # off-list
Tested-by: Riana Tauro <riana.tauro@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v3.12+
---
 drivers/pci/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6..ce9f74d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5508,9 +5508,9 @@ static void pci_bus_save_and_disable_locked(struct pci_bus *bus)
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_dev_save_and_disable(dev);
 		if (dev->subordinate)
 			pci_bus_save_and_disable_locked(dev->subordinate);
+		pci_dev_save_and_disable(dev);
 	}
 }
 
@@ -5543,9 +5543,9 @@ static void pci_slot_save_and_disable_locked(struct pci_slot *slot)
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
-		pci_dev_save_and_disable(dev);
 		if (dev->subordinate)
 			pci_bus_save_and_disable_locked(dev->subordinate);
+		pci_dev_save_and_disable(dev);
 	}
 }
 
-- 
2.53.0

