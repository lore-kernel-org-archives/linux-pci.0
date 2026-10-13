Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F104A3D20
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921196; cv=none; b=nCAgz8SJhApUD0hBqncHiU3aifagzh3wT4dx1BawXnkvLu/NaKsYa9C4bYeO3oViJ7sA5EJqU5JSdJc0ljRtbjm6/YDPBRf3cWMBKmjRtVPlfRwomSrswNtP4mvPk+P4+JgwGVkTYS+n0LxSmbpeizoLshC1Ni7S8RzSvqEMV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921196; c=relaxed/simple;
	bh=NT5dFfrYb1ob/8n2zC/8j7UnE/B6jq54K1lcUh46XzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CvH+d1HzwVKWaDGJVX4TQEDbN/cGCB2WMO+QKPY210nF98RLUfEZak4mtP71Fkr8I8isFz8d+G1qQl9jFW/Yww90MP6cKVlHh8CHaFR2bfP0bPy74NxzpYNAssW7ooaJgQ1vwFOxm0H1pwb929ZB2ydxJ6/QNQwt3dCtituJXZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n41OO2vB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n41OO2vB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26491F000FF;
	Tue, 13 Oct 2026 19:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791921194;
	bh=arZ7sSdUtOWdv2WG3nLfLUd23nRngzsYu99K1Hpt7f0=;
	h=From:To:Cc:Subject:Date;
	b=n41OO2vBu2mZD3duuMo48q67ys/JkgQsiLwKJ+Pgw5IhzHIJh0Dnqk0L8aGpb7q/Y
	 UbldyQUSigNetp1q9tbg3WHhhc9BuPj8diMA8VKD5TgsmeGG8TYjkSWSm3X1B4zcdx
	 l9oNg5Y38X1G3c9cAUTLxML78sgNG0FuY7s524/JeFpsDpR0dqvYmtlirxSjWbenyd
	 mwfkER3WDjijOTI/WbI56QlL+v/C/AU/L2w89FacO5lC9MBmlaPO/2ljuGTRK7SKLM
	 SRWp8kN1DZiXQCnZEqxvQxusrxE5p1RtqBaroF21m0sgycdK+TtFv4WLBmDoH+HaIL
	 NfBt0/ALVqANA==
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Update saved Max Read Request Size in pcie_set_readrq()
Date: Tue, 13 Oct 2026 21:53:08 +0200
Message-ID: <20261013195307.181647-2-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=cassel@kernel.org; h=from:subject; bh=NT5dFfrYb1ob/8n2zC/8j7UnE/B6jq54K1lcUh46XzA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLLO9SgXneM1nC0SLbTf5Wfe06TOax2LXayDdk+t7eg9N 7Oz835iRwkLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACbyPomRYdFTc072wBT9p5tW aLW/T+t8Y7zOmbNf2fH4xzBO8WPfZjN84Zt9TfHeioNZl/wSez48vrLxiFDLzk8S2k5T2/6n867 jBQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

pcie_set_readrq() changes the Max Read Request Size (MRRS) in the Device
Control register but leaves the copy saved by pci_save_state() alone, so
a pci_restore_state() that is not preceded by pci_save_state() puts back
the old value.

Since commit a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all
times"), the PCI core saves the state of a device when the device is
added, before a driver is bound.  The MRRS is usually set after that, by
the driver or by an enable fixup, some of which limit the MRRS to what
the hardware can handle, e.g. quirk_brcm_5719_limit_mrrs() and the
keystone and Loongson fixups.  Unless the state is saved again, a
pci_restore_state() after a reset, e.g. in the driver's ->slot_reset()
during error recovery, puts back the MRRS that the device had when it
was added.

Update the saved copy of Device Control when pcie_set_readrq() changes
the MRRS, like pcie_set_mps() does for the Max Payload Size.

Suggested-by: Shawn Lin <shawn.lin@rock-chips.com>
Assisted-by: LLM
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5b126cd342ca..30a583aeea65 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5944,8 +5944,12 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 
 	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 						  PCI_EXP_DEVCTL_READRQ, v);
+	if (ret)
+		return pcibios_err_to_errno(ret);
 
-	return pcibios_err_to_errno(ret);
+	pcie_update_saved_devctl(dev, PCI_EXP_DEVCTL_READRQ, v);
+
+	return 0;
 }
 EXPORT_SYMBOL(pcie_set_readrq);
 

base-commit: 581cf67cb6f66eabc6bcd7f61dd64b2559270507
-- 
2.56.0

