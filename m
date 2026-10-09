Received: from mta1.migadu.com (out-239.mta1.migadu.com [95.215.58.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A236894D
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791573648; cv=none; b=la0KRKZ8uOR0iBfKpseiXGCQZu0wvNQaz3ynic0rzLxw5cvBUzsa0erPfdaMI3/VAyIn+L24NMCXIN/djoi3MNFRUPX3Bd3E/F0x7Z27IwNaRscpTV2WZrmut+R4NsWZq7SuugGv7dV6E+0pPCzzF3zLdwf+aM4i6F/BLptMt4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791573648; c=relaxed/simple;
	bh=oOwGbuDH4is48yWx6pl2bm046cUQPMcDmLWPHdbtGuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FV43wKHrUTWrnGTkBCXhCx13k5FkaPy9nBvDxuoHxKZXrQWZY+8KJLavnZ3QpcOFzk7HRWiOTra7eFH8dqAUEHLYj9r+CFASh/g0hiKFiKvt4PpueTbeH4DFE9Zl2coiGQs2pex75onXycMNdfF6whcrQHyWPpn4gNdvPJanYeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ObFu2xAR; arc=none smtp.client-ip=95.215.58.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ObFu2xAR"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oOwGbuDH4is48yWx6pl2bm046cUQPMcDmLWPHdbtGuM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791573643; v=1; x=1792178443;
 b=ObFu2xARXacz+RPqxfr4cECQKNJyjfuwwqPJm4uG1EEVZbkudYe/D0/AcgAx1mReOHcMkVw/
 /43VJbOwCpqG+nlLEOptzIUOfjaaxg4R2+bsQq4Enj1hWEqtEqahkhA1JJgbxXoP+XxxMqF9sMk
 QmoCWaJIlHQ+k9QqQOCjB3XI=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7f7139aa950e2d35;
	Fri, 09 Oct 2026 19:20:36 +0000
X-Mizu-Trace-ID: 7f7139aa950e2d35
X-Migadu-Flow: FLOW_OUT
Message-ID: <497eb268-656f-49ab-8df0-83ede5b36a81@linux.dev>
Date: Sat, 10 Oct 2026 00:50:29 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Alex Deucher <alexdeucher@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, amd-gfx@lists.freedesktop.org,
 Jason Perlow <jperlow@gmail.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
References: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
 <20261008191705.GA917105@bhelgaas> <ash0Rn78gwlQ87Fg@wunner.de>
Content-Language: en-US
From: Aditya Garg <aditya.garg@linux.dev>
In-Reply-To: <ash0Rn78gwlQ87Fg@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi

> I think the firmware on the T2 is upgradable in principle, but Apple isn't
> going to do us the favor to fix it.  So we don't have any other option
> than keeping a blacklist for ANFE-incompatible devices, with the T2 being
> the first device on that blacklist and maybe others to follow.
> 
> I was going to work on this for the remainder of the week, but if you feel
> the feature needs another cycle to mature, I have no objections to
> reverting eddba19b8b5f for v7.3 and re-applying it together with the two
> required fixes to pci/aer.  (The two required fixes being the one for Alex
> and the one for the T2.)
> 
> Thanks,
> 
> Lukas

It would be nice if someone could test this patch:

-->8--

From 88c681d745931ad8b0199a490dc0278bf2a3df9b Mon Sep 17 00:00:00 2001
From: Aditya Garg <aditya.garg@linux.dev>
Date: Fri, 9 Oct 2026 19:17:02 +0000
Subject: [PATCH] Quirk

---
 drivers/pci/pcie/aer.c  |  3 ++-
 drivers/pci/quirks.c    | 12 ++++++++++++
 include/linux/pci.h     |  1 +
 include/linux/pci_ids.h |  1 +
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 922a726a5..cab195f7c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -428,7 +428,8 @@ void pci_aer_init(struct pci_dev *dev)
 	 * Advisory Non-Fatal Errors are masked by default (PCIe r7.0, sec
 	 * 7.8.4.6).
 	 */
-	if (pcie_aer_is_native(dev) && dev->devcap & PCI_EXP_DEVCAP_RBER)
+	if (pcie_aer_is_native(dev) && dev->devcap & PCI_EXP_DEVCAP_RBER &&
+		!dev->no_aer_anfe)
 		pci_clear_and_set_config_dword(dev,
 					       dev->aer_cap + PCI_ERR_COR_MASK,
 					       PCI_ERR_COR_ADV_NFAT, 0);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda..acca89532 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6422,4 +6422,16 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
+
+/*
+ * Unmasking Advisory Non-Fatar Errors on Apple T2 Secure Enclave
+ * processor leads to the Mac shutting down spontaneously. Avoid
+ * doing that.
+ */
+static void quirk_no_aer_anfe(struct pci_dev *dev)
+{
+	dev->no_aer_anfe = 1;
+}
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_T2_SEP, quirk_no_aer_anfe);
 #endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107..83ffa5058 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -514,6 +514,7 @@ struct pci_dev {
 	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
 	unsigned int	rom_attr_enabled:1;	/* Display of ROM attribute enabled? */
 	unsigned int	non_mappable_bars:1;	/* BARs can't be mapped by CPU or peers */
+	unsigned int	no_aer_anfe:1;		/* Don't unmask */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 63774ae2b..103024f74 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1007,6 +1007,7 @@
 #define PCI_DEVICE_ID_APPLE_IPID2_FW	0x006a
 #define PCI_DEVICE_ID_APPLE_IPID2_GMAC	0x006b
 #define PCI_DEVICE_ID_APPLE_TIGON3	0x1645
+#define PCI_DEVICE_ID_APPLE_T2_SEP	0x1802
 
 #define PCI_VENDOR_ID_YAMAHA		0x1073
 #define PCI_DEVICE_ID_YAMAHA_724	0x0004
-- 
2.55.0

-->8--

