Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699605;
	b=mCTv8O1R4ua7k+b1dxieKIxsx6tfpk2lL881+wggB1NqLRRxXXUsWkWk31fW3e+J953f
	 By8LtlCebekfJfhyFkLvItO1oddtVh/Kkf77QdaBW60A74gq9QntRMcEJ0HfhbMdegOah
	 wbdypAbnarFjZbqNrsVE5Rn7292ihpBv4hJWkChH+2koJw0jyySTswaCJb3LEuz8tZpWo
	 bGY7ijqXdEoif9dJQvsyrun79NzwrFyatKPtap57YG5LktlOjMXQhTpwQB5TIziL+ZnsB
	 B/NcFw++cvHNVNByodRxZNDcq+whxoXZ1pFfyhU2MqOmHz2FvpZogzH3ifN21+eT6EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699605;
	h=DMARC-Filter:Received:Received:Message-ID:In-Reply-To:References:
	 From:Date:Subject:To:Cc;
	bh=GywX1JTW5G9RS3NFM0rTXOVteHN0YTo8GojaiyI3LGU=;
	b=Ak5Xg4OmDwoyh7ndKOLzjuoIQplHehC/7siNwDl2gO/4Z93c3EyQynX8wWIO4iURsR9J
	 HlOSXA3s8raatjUh1EXJkJakl59F8A2f+6i2P/C5FQzJvqotHgfAiXo1sP08Mt67c5hRn
	 CM+km/f7dxfl88IxqKSFYgtr3nv6nvHLgVonYAvUOqZ1LSiHnvHECmoCKzrgmBmoMQ7Il
	 BO5BuyolMyubueOF/nqu3dcg9ZfB/2zKa0JdodDNK+xg2+FhrLf0grpp3qQRB+P9IuZWq
	 eQlUqwRkHTap7bKZt7LoiThHDQGZ1o7jkAt/k9H8X9aeji6ytx0sibbBrJD5fua/k3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4E4606D823
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 09:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C4E4606D823
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 60E7F78F1;
	Tue, 03 Nov 2026 10:53:22 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 582C1600CEE0; Tue,  3 Nov 2026 10:53:22 +0100 (CET)
Message-ID: <27a3876874161204e7a37ab63e7b27ee9783261f.1793697480.git.lukas@wunner.de>
In-Reply-To: <cover.1793697480.git.lukas@wunner.de>
References: <cover.1793697480.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 3 Nov 2026 10:45:02 +0100
Subject: [PATCH 2/2] PCI/AER: Check validity of Error Source ID register
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Alex Deucher <alexander.deucher@amd.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Keith Busch <kbusch@kernel.org>, Maciej Grochowski <Maciej.Grochowski@sony.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Certain Intel and AMD Root Ports are known to populate the Error Source ID
register with an invalid value.  The AER driver seeks to recognize such
buggy silicon by assuming invalidity if the bus number is zero.  It then
searches for the error-signaling device in the hierarchy below the Root
Port.  This was introduced by commit 28eb27cf0839 ("PCI AER: support
invalid error source IDs").

Alex has provided dmesg output which shows an invalid Error Source ID with
a non-zero bus number.  The AER driver's heuristic fails to recognize its
invalidity:

  pcieport 0000:00:07.1: AER: Correctable Error message received from 0000:01:00.0 (no details found)

The Root Port at 0000:00:07.1 has subordinate bus 04, so an error source
on bus 01 is obviously invalid.  The range of subordinate buses is cached
and checking against it is cheap.

Do that instead of relying on a heuristic.  Emit a message when an invalid
Error Source ID is detected to alert silicon validation engineers.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=222095
Tested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.h       |  7 ++++++-
 drivers/pci/pcie/aer.c  | 33 +++++++++++++++++++++++++--------
 drivers/pci/pcie/rcec.c | 14 ++++++++++++++
 3 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c960..aa392bb6a482 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -871,6 +871,9 @@ static inline bool pci_dev_binding_disallowed(struct pci_dev *dev)
  * @id: Value from register PCI_ERR_ROOT_ERR_SRC
  * @severity: AER severity, 0-UNCOR Non-fatal, 1-UNCOR fatal, 2-COR
  * @root_ratelimit_print: Flag to log or not log the root's error. 0=NotLog/1=Log
+ * @id_valid: Whether @id is a valid value.  Some Root Ports report an invalid
+ *	Error Source ID, necessitating a search for the error-signaling device
+ *	in the hierarchy below the Root Port.
  * @multi_error_valid: If multiple errors are reported
  * @first_error: First reported error
  * @__pad2: Padding for alignment
@@ -893,7 +896,8 @@ struct aer_err_info {
 
 	unsigned int severity:2;
 	unsigned int root_ratelimit_print:1;
-	unsigned int __pad1:4;
+	unsigned int __pad1:3;
+	unsigned int id_valid:1;
 	unsigned int multi_error_valid:1;
 
 	unsigned int first_error:5;
@@ -955,6 +959,7 @@ void pcie_link_rcec(struct pci_dev *rcec);
 void pcie_walk_rcec(struct pci_dev *rcec,
 		    int (*cb)(struct pci_dev *, void *),
 		    void *userdata);
+bool pci_rcec_associated(struct pci_dev *rcec, u16 id);
 #else
 static inline void pci_rcec_init(struct pci_dev *dev) { }
 static inline void pci_rcec_exit(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d492c7ce01e1..9957c36bf215 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -951,12 +951,13 @@ static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
 {
 	u16 source = info->id;
 
-	pci_info(dev, "%s%s Error message%s from %04x:%02x:%02x.%d%s\n",
+	pci_info(dev, "%s%s Error message%s from %04x:%02x:%02x.%d%s%s\n",
 		 info->multi_error_valid ? "Multiple " : "",
 		 aer_error_severity_string[info->severity],
 		 info->multi_error_valid ? "s received, first one" : " received",
 		 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
 		 PCI_SLOT(source), PCI_FUNC(source),
+		 info->id_valid ? "" : " (invalid source)",
 		 found ? "" : " (no details found)");
 }
 
@@ -1146,6 +1147,24 @@ static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
 	return 0;
 }
 
+static bool source_id_valid(struct pci_dev *root, u16 id)
+{
+	/* The Root Port or RCEC can itself be a valid Error Source */
+	if (pci_dev_id(root) == id)
+		return true;
+
+	/* For RCECs, @id shall be in range of its associated buses/devices */
+	if (pci_pcie_type(root) == PCI_EXP_TYPE_RC_EC)
+		return pci_rcec_associated(root, id);
+
+	/* For Root Ports, @id shall be in range of its subordinate buses */
+	if (!root->subordinate)
+		return false;
+
+	return root->subordinate->busn_res.start <= PCI_BUS_NUM(id) &&
+	       root->subordinate->busn_res.end   >= PCI_BUS_NUM(id);
+}
+
 /**
  * is_error_source - check whether the device is source of reported error
  * @dev: pointer to pci_dev to be checked
@@ -1157,11 +1176,8 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 	u32 status, mask;
 	u16 reg16;
 
-	/*
-	 * When bus ID is equal to 0, it might be a bad ID
-	 * reported by Root Port.
-	 */
-	if ((PCI_BUS_NUM(e_info->id) != 0) &&
+	/* Some Root Ports report an invalid Error Source ID */
+	if (e_info->id_valid &&
 	    !(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_AERSID)) {
 		/* Device ID match? */
 		if (e_info->id == pci_dev_id(dev))
@@ -1174,8 +1190,7 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 
 	/*
 	 * When either
-	 *      1) bus ID is equal to 0. Some ports might lose the bus
-	 *              ID of error source id;
+	 *      1) Error Source ID register is invalid;
 	 *      2) bus flag PCI_BUS_FLAGS_NO_AERSID is set
 	 *      3) There are multiple errors and prior ID comparing fails;
 	 * We check AER status registers to find possible reporter.
@@ -1566,6 +1581,8 @@ static void aer_isr_one_error_type(struct pci_dev *root,
 {
 	bool found;
 
+	info->id_valid = source_id_valid(root, info->id);
+
 	found = find_source_device(root, info);
 
 	/*
diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
index 2bf6d9d549ba..609d656300fa 100644
--- a/drivers/pci/pcie/rcec.c
+++ b/drivers/pci/pcie/rcec.c
@@ -21,6 +21,20 @@ struct walk_rcec_data {
 	void *user_data;
 };
 
+bool pci_rcec_associated(struct pci_dev *rcec, u16 id)
+{
+	if (!rcec->rcec_ea)
+		return false;
+
+	if (rcec->bus->number == PCI_BUS_NUM(id)) {
+		unsigned long bitmap = rcec->rcec_ea->bitmap;
+		return test_bit(PCI_SLOT(id), &bitmap);
+	}
+
+	return rcec->rcec_ea->nextbusn <= PCI_BUS_NUM(id) &&
+	       rcec->rcec_ea->lastbusn >= PCI_BUS_NUM(id);
+}
+
 static bool rcec_assoc_rciep(struct pci_dev *rcec, struct pci_dev *rciep)
 {
 	unsigned long bitmap = rcec->rcec_ea->bitmap;
-- 
2.53.0

