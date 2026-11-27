Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780288;
	b=uIytrK5VDaVLRXyrneBxnv9x/srX6CZ5UajyRdQSHtxJEhTdXHJk/bPdEJmKW7D5Y0RT
	 igqrJrt0jRg8KYDl5ZcJi5S33sCgGwIXlLEuUedP3naDr82n5VuxVkNgLruVZWN1dy6l7
	 2qP4LlM7r/cUnvqLT7SQjEnWgpiakKGaQ6IuFMEq2/RmAfj8j+bZZ+yG+bWgvjSIpVx/a
	 YBjdBRpljd+owyQDoSlxdUDdc+X5FPBA/TQKcZQv4tM4wiydJOxNFdsNn/xQQuBUCAqB4
	 /WYh5Fy000zfiIopEUOC96KevN+ZJirawj/mDw3ZeZiJeeCoxHGoc8JTi8UuwwNun3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780288;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=iQ5TDW0ireyGnsBVOn8mmXfwXErfqnGFqIZfAm6/CIM=;
	b=hzjvFmaq4Nm9uGaEqfaucdf02IVfMn6Frxuq1FuMtlQy/Y0Hq3jOJZxpYNi6i5gf2Rfs
	 X0EnOT2QoNdKBPRfK/aYuA3AiiJLafaAK1+DUeNNZY2T25vrGTZ2yj9YCsXUGBkbKqUOk
	 ApJKLThH5Wya5uFlrF8r0e/1yIi4i9wSX0SUcdVjnn6S/l30Z7mbF/r5ax4gAq3CFXS2T
	 0xgFNxJKPHe89d8A2ckvU3sseP/azXET+21pnnJAvj6R8AEgIIXiz1x75oJsBD7CN736v
	 qmQVblTeZce1zBkrrA5IymcE0tduRqAGleYLQlhs+I8DojnFgFK87tfIHOjuHWrB4YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=radxa.com;
	spf=pass smtp.mailfrom=radxa.com;
	arc=none smtp.remote-ip=54.243.244.52
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46F5606A31C;
	Fri, 27 Nov 2026 11:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E46F5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1795780185taa66da07
X-QQ-Originating-IP: f0SUzmEYAJzkwOOwV3JKYBaIagdQueZcoEpeiB0+z6g=
Received: from [192.168.30.32] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 19:49:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3009671951727450534
EX-QQ-RecipientCnt: 13
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 27 Nov 2026 19:49:33 +0800
Subject: [PATCH RESEND 2/2] PCI: of: Avoid config reads for disabled bridge
 nodes
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-pci-of-disabled-bridges-v1-2-3bedcbe51cda@radxa.com>
References: <20261127-pci-of-disabled-bridges-v1-0-3bedcbe51cda@radxa.com>
In-Reply-To: <20261127-pci-of-disabled-bridges-v1-0-3bedcbe51cda@radxa.com>
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
 h=from:subject:message-id; bh=EKe2Judq3uRYAXuTpmnytmE2WcqkoXisaI8xWOa6IMk=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDNmcecGyxqwLSjy2vb8Yu5hrc8W8jx6SO2Nz1CR8vwi/0
 z/x411FRykLgxgXg6yYIotCPMNc9srca0/FSvVg5rAygQxh4OIUgIksj2JkOPRJ2ru16fiLWvmX
 HGctxRtr7D4tm3Hjw76/2/9d6MvMm8zIcOlQganE+Q37OxaWvhURrBaWmOB60auvNF3+tfbsOZV
 HWAA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MO9Y9egDQC/mRchk5cULCi+k5JHEGTcJA6RbfA8mFvzsgpV1/o/RW7a+
	C23oSwMyyjo+YbVxfpBqdn5tVHDX6sigMW3HzUIVY42/yMM35+GVPokbRmmUCa5LuNCpMLD
	onE5jv1couEYvzGEgJqLxlkrBhzZubjFtYH6KLI+ZZWdwVVM87/qVV3BalehD29dOXA+WHW
	UixWD/O0ToYMFlzhsdOZeHU1Hzy2m+O48hPgrm0mwAkTMRCVxvZzFxDR6HHZd6t7fOPQY0o
	5c47EbpYNPiIuIqU/RLPEltXxCllA2pW/rH47iLF9egLrGixmge5z+CIfxSyraHFzamTH+0
	NYY6m4d5BVUK6SlX//dFAPOrQodYbVxVhg7p0zx9mhxRyNe2kpgQ1xopbKdJ+Vr1fzJIbYP
	RUmUqWHYzX/lmE/LBB7VIL6uYZ4gT2+Qt8D4PPnf/WTtuqjQyaBS2QTyaRSX2dRmGLPIdQB
	Xm/Aew1N/DDOb+DkTu+VgcsSlf+L3CTKN1iIWDIIDW3P5iD/gT8AXtWuAAWDAcGHqqYI51P
	l0lH/AYK2DOC87cPwQpuuDBUY2/cTHYV7ftwwRguULkljAopaMN/q7t3nBvfcnW9DrbDgzq
	1oo0xNyump1K3JwHtWuxkRY9B2xWUE9qtiRKIStYQIdctUfdjnajZ4O3kF9AY7zeELBx+EU
	iHOUU4DVNEzrcWeuBhPZV47Q1sdwnyyaMrDcS9Gu5Gd0VSkH9uXzy3HOy5y3/T696esGpw5
	Lu+I+1CiMGeTo9jzh0L+Dk9lsKYlCtxjmwkQVgBKRxS1g4qiBYJzY6VNWKUfJ9aKN2iugS2
	gik4xpfmTM23xGV2Mlw6KEEVTrjf6yZmNC4CnEEro7w3zKRRwBtakECu1swDlUBrGmuVnAy
	YQVoXBsOO5diRYoMb4NKWqoyBuMiNI+OhqDWGYiAH1nTT2lAkcJciJO6xOefnOjEghbNYzE
	wbnBlAUzisSuBdzVYAkMvecdRksIQVaslxyES7lfnXKK7iJu35jZXIRkZYNycDxZBJY8trD
	9xh4s0LIFJ9WErn3+3WYesH+7h9OEeShxrGMdPPZJoz9Xs5pPr74oc6HyBxtlXPoJf5RJ/M
	NqQ50SS3nAhl2DYgzNgSQg=
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
2.56.1

