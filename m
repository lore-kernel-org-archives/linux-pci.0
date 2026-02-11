Received: from mail-m1973182.qiye.163.com (mail-m1973182.qiye.163.com [220.197.31.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF6F352F88;
	Wed, 11 Feb 2026 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770798636; cv=none; b=Yi0V0N/sGh6p2rlBABidpsGoamIyBPHajgZ23MP/lBiWRVmg73BVibLaymKOo8zZhOWzdjhW6HkSIkXLpdkl/DjJw6VOPL/zRWuCC15RwJ0xmK2WVbCsEwpX0WPe0E8rC0oqm5nSG96M9WV/xPBnQArxlfRfro6ljhsINPnZs68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770798636; c=relaxed/simple;
	bh=39IhSfP889KuErdo30Vg2Tp412GVcDTlaLzshjaoxo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jlQX08ucvlM09oN34VypU2vYUVn5rMsjXyaDgjx4UJ1c443luWVeTBc1IJby4GGjT8I+ExJmT31xkwTvC8qnMeIBRpSpTPwuykiDJ8Np2gLSf8CMlP7DnXMCMbijSldvYKv7psaz0CSsO430REIeLp6hQU6fCGJcEEpSejr2/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=EfZ5Fa+Z; arc=none smtp.client-ip=220.197.31.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="EfZ5Fa+Z"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 33d869564;
	Wed, 11 Feb 2026 16:25:14 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/3] PCI/MSI: Add warning to pci_free_irq_vectors() documentation
Date: Wed, 11 Feb 2026 16:24:58 +0800
Message-Id: <1770798299-202288-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1770798299-202288-1-git-send-email-shawn.lin@rock-chips.com>
References: <1770798299-202288-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c4bcdf5b209cckunm6cb3bb0ee1970
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx1KHVZLThpMTxlDQ0JJQxhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=EfZ5Fa+ZO5GOTYaBK/OjHlkREhkNMJNcMzNN3NqN4ScVvp6BUXm6ez+Lo+NaJNKAX01uVyXaS2zj0of3tgJrqZnznFdDuU2tNoi8PTp8dQJWr9+lzDZ5JqMW1QLUH3lvjdntfuvfqgHn115NvazdgYeCSqwF7o+k15ZtlZcIEHw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=UNLkQLdTwuW2iDIl9UAI8P2DkWhepEE7viKVGVG8WIM=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Update the kernel-doc comment for pci_free_irq_vectors() to warn drivers
that this function should not be called when the device has been enabled
with pcim_enable_device().

For legacy reasons, pcim_enable_device() activates automatic management
of IRQ vectors via pcim_msi_release(). Calling pci_free_irq_vectors() on
such devices can cause double-free issues.

This warning complements the documentation in msi-howto.rst and helps
developers who primarily read function API documentation when working
with the PCI/MSI subsystem.

Suggested-by: Philipp Stanner <phasta@kernel.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/pci/msi/api.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 818d55f..c18559b 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -370,6 +370,11 @@ EXPORT_SYMBOL(pci_irq_get_affinity);
  * Undo the interrupt vector allocations and possible device MSI/MSI-X
  * enablement earlier done through pci_alloc_irq_vectors_affinity() or
  * pci_alloc_irq_vectors().
+ *
+ * WARNING: Do not call this function if the device has been enabled
+ * with pcim_enable_device(). In that case, IRQ vectors are automatically
+ * managed via pcim_msi_release() and calling pci_free_irq_vectors() can
+ * lead to double-free issues.
  */
 void pci_free_irq_vectors(struct pci_dev *dev)
 {
-- 
2.7.4

