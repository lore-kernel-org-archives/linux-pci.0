Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F37480DF3;
	Wed, 15 Jul 2026 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128940; cv=none; b=kXvIyOeZOLSn0oZVNykBMmvHyNkBiD0LTf/xlJr17QI0RL6vkHTuSfsv0DcxWO1PeIiqbygBwYibKquEPO49dQNIMZV7ecpHrnyEVNty2MHic631ykeOn//FNoD0fMdjmExAd7XWybSBHm8iUGrya1FltiDsFRWaT+s9P0gZ2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128940; c=relaxed/simple;
	bh=quQSJ2jQ/gvk0V1l9A0v9b5zEZMaPBDs/37fdJ+Qa3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3lJj2FkszPuXou/tcbmyUuzhmsdL16HIeQiWHjZvQxj39/F3s1dunxoW1vHLmawVzn2c3jwe4golDR2oI/VSqO1pIIMiISM/fk5TaEP0HPda/0xakBYUu3UbQnzZ6zFvF/+D16K/Uzn21xjw0+dXE5hh+gAfuh9HKM74qiaU7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Befs9OG/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Befs9OG/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C151F000E9;
	Wed, 15 Jul 2026 15:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784128939;
	bh=KGuiNvhiz7GwK73I2fwGiAMXn/NZV+2zl5YNbTJDCxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Befs9OG/Frlrr8UBYX8vP9BdKlnWS7AZIc7E97f7lRuCmhxANgrLp5q9Ktw1V+fsm
	 Kep2BU61F3925OdJa0M36aCZFhIqyJWtPI09c9GsVK30OXLPMFKRKtApCPEGC1WV6L
	 cuHqaGmod6Dx9NY9C6QzItn/rcvO3djww6YaFirpgOZ8v87ezXK4c3MP0f28v7kh2r
	 Kj0vscXlp8QY2Pg8lE3hog5cMP/WOXZorlYfEvmGgOQnpvV5cHRb2Q4dvBHw3BsbCk
	 phArcS5WmqyiZOZ7aTapjmlSJECVbUudKZ2ksYswn7S0ShX3VD51y5yYc67liYA/u2
	 +526XH/RfJn+w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v1 1/4] ACPI: PCI: Use a mutex guard to simplify acpi_get_pci_dev()
Date: Wed, 15 Jul 2026 17:15:02 +0200
Message-ID: <2417350.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <5115219.31r3eYUQgx@rafael.j.wysocki>
References: <5115219.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Use a mutex guard in acpi_get_pci_dev() for the physical_node_lock
locking and drop local variable pci_dev that becomes redundant after
that change.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/pci_root.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -307,24 +307,20 @@ struct pci_dev *acpi_get_pci_dev(acpi_ha
 {
 	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
 	struct acpi_device_physical_node *pn;
-	struct pci_dev *pci_dev = NULL;
 
 	if (!adev)
 		return NULL;
 
-	mutex_lock(&adev->physical_node_lock);
+	guard(mutex)(&adev->physical_node_lock);
 
 	list_for_each_entry(pn, &adev->physical_node_list, node) {
 		if (dev_is_pci(pn->dev)) {
 			get_device(pn->dev);
-			pci_dev = to_pci_dev(pn->dev);
-			break;
+			return to_pci_dev(pn->dev);
 		}
 	}
 
-	mutex_unlock(&adev->physical_node_lock);
-
-	return pci_dev;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
 



