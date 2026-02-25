Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F73E8C5B
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039042; cv=none; b=NS07/iAc6JtuDG0mX//cEM+oiui7A2j746HcNCgJGs0xcEF+8Y8z42LPq5ETXQ2FeZa8XhcA19+KcWu1U2xuqRXjpfVSakdHqn8SKSZndao+jXTl3B1nAEbP/ywM1vv7sq9UAIJgNshNRy6ucXmOtN9Fx8G2al9ymkqkJdjHSqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039042; c=relaxed/simple;
	bh=gdnQ2oa8KH5dZ6v9FdwvXRJzfd31Kif7Og4mRlS0AJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwHuGOuZaO5DfXo2S1OP19or4KnA2I+89hjCWDTtjSxuDdyiRm0E7z3bF6cFflbXQGJIk+4sEgR6r5CTsTWW115u453QbWqHmvD5oS/pPi7Pn0vDfx2lxd6SOrr0zZf8EYj76lsI6UU87cy8ZnHAPYhD6YBx4SZ6NDs/wNe93p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/ek3fgJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/ek3fgJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C04C19421;
	Wed, 25 Feb 2026 17:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772039042;
	bh=gdnQ2oa8KH5dZ6v9FdwvXRJzfd31Kif7Og4mRlS0AJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/ek3fgJpzB+yzzTkfRFDws85m9H4P6S+1qMQ2wdOwV9lvp2cGDLYxKZpQdL4iMQ9
	 ft9wWpBt05FwNVmRWvQjVCw47pj1Z+y9LwMRbq0h5je0GPPwaDSWl8bi9Nt7jjIaJI
	 3E8FF2iHzaMsf0FVZQeVXrlG+TiaNH04fMYKFAX718La1FkAz25tKMJeceq7lsmcKF
	 KH7ztSy35PuAIDRxf3YDtw1B/kBwB/xut+EyUy6UakrFi/daVO7DPKkFxdyb5NKyOw
	 51aRQvZJd+ryXyDMlJ5BOirglxJN5trmRDkzUtTIUQfHPEFjRu/Ddgdw4czrZqKsgO
	 Vn2jno+1FHwKg==
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 2/9] PCI: endpoint: Describe reserved subregions within BARs
Date: Wed, 25 Feb 2026 18:03:25 +0100
Message-ID: <20260225170324.4033466-13-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225170324.4033466-11-cassel@kernel.org>
References: <20260225170324.4033466-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2499; i=cassel@kernel.org; h=from:subject; bh=v0TCYkwR/jCRhmmjaPbfNq0OZyqA5YkaaLgpPTYSH3Q=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLnayfFeCTpTPLbV8Dn4v3EK3KNeaWbkMo/9UALjkQ5Q cUtPyZ3lLIwiHExyIopsvj+cNlf3O0+5bjiHRuYOaxMIEMYuDgFYCJnOxj+R59lzd7rVhLT8FFg 1s8Hl8zvJAi2nfDcpfrDcHfbuu5H/xgZTjI7vvPZWNrkm3TswPbKHykvcsyFXhy7sXzug0dy2m9 /cwAA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Koichiro Den <den@valinux.co.jp>

Some endpoint controllers expose platform-owned, fixed register windows
within a BAR that EPF drivers must not reprogram (e.g. a BAR marked
BAR_RESERVED). Even in that case, EPF drivers may need to reference a
well-defined subset of that BAR, e.g. to reuse an integrated DMA
controller MMIO window as a doorbell target.

Introduce struct pci_epc_bar_rsvd_region and extend struct
pci_epc_bar_desc so EPC drivers can advertise such fixed subregions in a
controller-agnostic way.

No functional change for existing users.

Tested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 include/linux/pci-epc.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index c22f8a6cf9a3..f7f48f43d370 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -203,6 +203,30 @@ enum pci_epc_bar_type {
 	BAR_64BIT_UPPER,
 };
 
+/**
+ * enum pci_epc_bar_rsvd_region_type - type of a fixed subregion behind a BAR
+ * @PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO: Integrated DMA controller MMIO window
+ *
+ * BARs marked BAR_RESERVED are owned by the SoC/EPC hardware and must not be
+ * reprogrammed by EPF drivers. Some of them still expose fixed subregions that
+ * EPFs may want to reference (e.g. embedded doorbell fallback).
+ */
+enum pci_epc_bar_rsvd_region_type {
+	PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO = 0,
+};
+
+/**
+ * struct pci_epc_bar_rsvd_region - fixed subregion behind a BAR
+ * @type: reserved region type
+ * @offset: offset within the BAR aperture
+ * @size: size of the reserved region
+ */
+struct pci_epc_bar_rsvd_region {
+	enum pci_epc_bar_rsvd_region_type	type;
+	resource_size_t				offset;
+	resource_size_t				size;
+};
+
 /**
  * struct pci_epc_bar_desc - hardware description for a BAR
  * @type: the type of the BAR
@@ -216,11 +240,15 @@ enum pci_epc_bar_type {
  *		(If BARx is a 64-bit BAR that an EPF driver is not allowed to
  *		touch, then both BARx and BARx+1 must be set to type
  *		BAR_RESERVED.)
+ * @nr_rsvd_regions: number of fixed subregions described for BAR_RESERVED
+ * @rsvd_regions: fixed subregions behind BAR_RESERVED
  */
 struct pci_epc_bar_desc {
 	enum pci_epc_bar_type type;
 	u64 fixed_size;
 	bool only_64bit;
+	u8 nr_rsvd_regions;
+	const struct pci_epc_bar_rsvd_region *rsvd_regions;
 };
 
 /**
-- 
2.53.0

