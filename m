Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E4D36B910;
	Fri,  9 Oct 2026 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791530826; cv=none; b=C0UweUTCmgETTbPKhcIIIKtU825RpiRZuPbhhWXS6xoE4K3kRSa+nBnkRD4Ss6M7p6XZkvDVbLvgJrQKEwAApo8pv0VMAQGHi/ikO2jt1WjiDXcaagpWhLRD5wc5kMHcHA9dyKvYHvMEXqrCSNcaocNVH4gb2n9xHmqJJFfj/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791530826; c=relaxed/simple;
	bh=3cwJrYCKtB1FyTSVMsTUSjzuHfx8gNgHBHAkIR/ohAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cIFjwZ1KoPA0Fafqx70UkcixLzhsWBCpl6tAYTU7dxl07fUBMWEpwG1IIHEkLxwfyKIgzp+s7b0ZnJvaLJYF9Uy9HlHaZpyuyaHD20AFpY6eNvw2GbPACmNE8NcLV/++uWp6HjO9q69D7YYyq4lX2EXM/Uuho2wcHYeJQlxjDeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip3t1791530731t51b12762
X-QQ-Originating-IP: PRUY8Mjn7j4rupNIkykYInQoN7G/vnDUwEYhaQJZQDo=
Received: from [192.168.30.32] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 Oct 2026 15:25:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17474764714757559024
EX-QQ-RecipientCnt: 13
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 15:25:18 +0800
Subject: [PATCH 2/2] PCI: of: Avoid config reads for disabled bridge nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-pci-of-disabled-bridges-v1-2-08708f9e1802@radxa.com>
References: <20261009-pci-of-disabled-bridges-v1-0-08708f9e1802@radxa.com>
In-Reply-To: <20261009-pci-of-disabled-bridges-v1-0-08708f9e1802@radxa.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 Daniele Briguglio <hello@superkali.me>, dragon@radxa.com, 
 Xilin Wu <sophon@radxa.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4664; i=sophon@radxa.com;
 h=from:subject:message-id; bh=3cwJrYCKtB1FyTSVMsTUSjzuHfx8gNgHBHAkIR/ohAg=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknpj1Rtcxu+Nw64fvM8NrA6LQJkz9MfT/3iZfnzc9LF
 OuL41pFO0pZGMS4GGTFFFkU4hnmslfmXnsqVqoHM4eVCWQIAxenAEzkZRvD/xL+5WqP6zvOL+Wu
 2dho2Bbx0ktbkX3WIdE8tfKPZr9cvjIy9Fg5rE3M8wh/+XpelHPz86e978oUNpf82adQ53EhceY
 9HgA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MtBwujL0y0TRGwywjLaw3qbi/KxW5NO84HTiwqa4vQ8mQVuAFqWEuR/c
	0SURrtX8qvOqZGuT5Uwzk26Nttr82mM0ieURRjvjQz7wbvJDxTGd7BgKvdlM0j6RDhlf8Tk
	s4DtHSPGaiUJB+BERi6/LDfwh0qMv2ag9nZiNJlS/TJZeyXgJRbvLHLTbdhO10NIhNPkbSg
	MBIB2yWhf3xW8oMhfMUFnbRRJF2KObDqmOa27XQM03WOQDzVkRD1wBXyGkv75Da8FB3Yx0O
	uykxf9xvJfZh617wujM7PDKLOBrMhPj0JD4/bLhqEkA0Ha8LgWEVAho9DEBeGpvJuQoENE/
	J7lni0c0GLOl3MhlWqyIIm2AkFlaH2SRAc1CFkvZFe8VSNnzeyH9zPYkhdDhhiIKBJGOlR/
	beSZdGBrSwOtgIP0rShFEfFh+2qVntwjbO5ZhnC3LpWRb55Vj8wg2jheeY828KGPYUECQ2k
	kbxJUPvnIAD62C+Acl962Hr1rSB5zIfr9tpBCjV1SfUdRsmBB1WEt3T8fY2DYTjGNhlsvh1
	JBdvd3g7LfEBOyCMfcvd7ul4qN3dqOwxZqERfIyxIqfrX6CiLXMx/3sNSmQx8nkewh/IhaN
	3LgAoP5O/mLaImbh1ouySX4AZsAqg93dssZxsGHT3UoJ/9cXsLCsgRL25o4JUn2Q+1LE2HR
	jM0oHWif5idcALlVMlhrfw3Zh1Q9/GLvhByvFJ0LmJHFeUWW1Lh8xmewN7WQi+DUw5xHk4g
	OibrBMcFopdEwgs7aH4aX5GeBNNT8BbcUX9ncOEj/wzgJAbzmpDkrE+h8S9Dz8EBgSF05Nq
	BPQKF1QxHQJQvTVMJtJn3H58zwZb9CwugSSJOBUePi61bk7xxo3dgy0bS5hLsGAWjwXBBDS
	BMPESrDYb4XRfY7FjWnNiIc/naqquVej1q9o9BI0pNWnCyQYQRy2HEwcdVFiFBzbx4X/W1B
	1YAp38lnzUUwIC0ceXKs1rbh0K0cngPeUiP7jbaGl7pDlQqABlCWGsJESaMoNzFBehSDInT
	LQ4sn6K2nJ7+4zZUEC5Xa0lieBNx6CcLmUVncRCDs0gngyMiNrc6RZ3H7GrVU0QLqKFE2N4
	srs0iE/pHD3eRVoFHZF5fzlAEzsJIgYfUI44r9e3GdobBEnYJfB9HlHkfZmE2C0BA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

The TC9563 PCI power-control driver powers off external downstream ports
whose device tree nodes have status = "disabled". On the Radxa Dragon Q8B,
reading the Vendor ID of one of these powered-off port functions during
PCI enumeration raises an Arm SError and prevents the board from booting.

A Configuration Read request to an unavailable port receives no
completion and results in a Completion Timeout. The PCIe Root Complex
reports that timeout as an AXI bus error, which triggers an SError on the
CPU. The link between the Root Port and the switch upstream port remains
up, so blocking config accesses only when the Root Port link is down
does not prevent these accesses.

Commit 1a8c251cff20 ("PCI: move OF status = "disabled" detection to
dev->match_driver") kept disabled PCI functions discoverable so that PCI
fixups could still run, while suppressing driver binding later. Preserve
that behavior for endpoint functions.

For an unavailable device tree node with device_type = "pci", skip the
Vendor ID read and return a PCI error response without accessing config
space. This prevents enumeration of the disabled bridge and its
subordinate bus. Perform the check in the generic PCI enumeration path
because probing unavailable bridges is not specific to Qualcomm hosts.

Functions without a device tree node and disabled endpoint functions
remain discoverable.

Link: https://lore.kernel.org/all/fsrr5xg4plfknfcvv5co4ciklz5pywa5bbfxbthwsnjevysr5v@myghuxblnend/
Link: https://lore.kernel.org/all/r22to3joold7ugzwolni4qahyumcekbyugrl2bms3xmiysqtgo@hu5s3dnyqwsj/
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Tested-by: Daniele Briguglio <hello@superkali.me>
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/pci/of.c    | 23 +++++++++++++++++++++++
 drivers/pci/pci.h   |  5 +++++
 drivers/pci/probe.c |  5 +++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 9e82c79be3d8..37e9062065d7 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -46,6 +46,29 @@ int pci_set_of_node(struct pci_dev *dev)
 	return 0;
 }
 
+/**
+ * pci_of_device_skip_config_read - check whether to skip probing a PCI device
+ * @bus: PCI bus to scan
+ * @devfn: device/function number to check
+ *
+ * Return: true only when firmware explicitly describes an unavailable PCI
+ * bridge/port node. Disabled endpoints remain discoverable so fixups still run,
+ * while driver binding is suppressed later in pci_bus_add_device().
+ */
+bool pci_of_device_skip_config_read(struct pci_bus *bus, unsigned int devfn)
+{
+	if (!bus->dev.of_node)
+		return false;
+
+	struct device_node *node __free(device_node) =
+		of_pci_find_child_device(bus->dev.of_node, devfn);
+
+	if (!node || of_device_is_available(node))
+		return false;
+
+	return of_node_is_type(node, "pci");
+}
+
 void pci_release_of_node(struct pci_dev *dev)
 {
 	of_node_put(dev->dev.of_node);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..7cb1d04d947d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1244,6 +1244,7 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
 				u8 *slot_power_limit_scale);
 bool of_pci_preserve_config(struct device_node *node);
 int pci_set_of_node(struct pci_dev *dev);
+bool pci_of_device_skip_config_read(struct pci_bus *bus, unsigned int devfn);
 void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
 void pci_release_bus_of_node(struct pci_bus *bus);
@@ -1284,6 +1285,10 @@ static inline bool of_pci_preserve_config(struct device_node *node)
 }
 
 static inline int pci_set_of_node(struct pci_dev *dev) { return 0; }
+static inline bool pci_of_device_skip_config_read(struct pci_bus *bus, unsigned int devfn)
+{
+	return false;
+}
 static inline void pci_release_of_node(struct pci_dev *dev) { }
 static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
 static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..ce29bf78a6f7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2586,6 +2586,11 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 				int timeout)
 {
+	if (pci_of_device_skip_config_read(bus, devfn)) {
+		PCI_SET_ERROR_RESPONSE(l);
+		return false;
+	}
+
 	return pci_bus_generic_read_dev_vendor_id(bus, devfn, l, timeout);
 }
 EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);

-- 
2.56.0

