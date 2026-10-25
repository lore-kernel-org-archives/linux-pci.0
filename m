Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792886925;
	b=G2NCeRZUvpI37HRxkwryNLc2LfFpFMZHCHDumTYW+/t0wKFMqa7Tnjhlil23dleab5c0
	 RlQo4petWMF87GhNQdtfBfbBiXWNtuCu1tc0vy1BmFsY7D6W+cK/ca+JT+NAVmKvn3SKA
	 9tDeq2rqgXrxF21V7XaG6C6FF8e8H8iBj+nQSP/R1iAv5WZ7UspPBaBWGIhrg6L3BKO4o
	 /947uf1rrUmd/nHIAM4uGpB3Kw/XO/1RadZKTRckKCVd5MjSr8zWpG+lFwDlMR9ZZXCoH
	 OHMQvfaPZ8KG4em7CZ0BKMt8i8zQT4BaMJCT8Fwf0vFT9pCIl8AclWGnKO10/OHN1Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792886925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7dfyKzdRYvknKA9F2M27XwH3fnlKeDPMr9i7eMgXHCA=;
	b=sRRfn0KSMroEpM8G3C6d9qUinr8tfVCB/glpOWm+1FL9AnfAt58gUNb0LZW09OZPT/wz
	 owZ08cwNFa07KnB4W1xOvO2cZcG/7Eosq0d6Q/G3gaCqmlr3XjceCkAoFIOPZeKmlzhGM
	 WGpyvwLeLnpp3MJxNSlWF8iuxLL3O4SUwK9ovGnNC2e+/8eJFwItDDe06wPxnkY56lWyr
	 UyacSzMCx4CyKuz1quxZTlkp7L/BSJ9wJ86pmReRhrCcK+6L8CGlx4cZT4FZC52wIOoll
	 x1TbBYKhljmozpgammYbEBYsiKQxETU7D0T+FV26syamErrBw1QRR9w7R2rQ+lblbwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="flQ/kmWx";
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7E1606A31B
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 00:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B7E1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=flQ/kmWx
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b0f59a5fdeso15519357b3.1
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 17:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792886925; x=1793491725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7dfyKzdRYvknKA9F2M27XwH3fnlKeDPMr9i7eMgXHCA=;
        b=flQ/kmWxxS03rLrKqQnRfDvryWFwFlCQaR5t76gjicE2KsEMIM1ydWBjjg/nqxu3JP
         uZoMPXTe9rwgH36lRyIt4ho86CnjIXzro2RDGYQrRi2hVG70954xOW8OiMTthyBoRWln
         HjjLn2Td6zAliuFtCsDA77Hnb/mREkD7X8eWx6CifezkSf96B/41m10JFm+Psu4j/EbB
         aUic8/rXqZkxYwCsiSabO4lYZJwhLZG1UqJKIvtczTCH0TLGEo3OLSpHitSM3Gpdegz4
         O5+YhXa8oxuTXDgi/pgoHtnu412azpP5XDu7oaferVAhlXWFiGDhlgq1ujnE0WcJgmgZ
         0UNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792886925; x=1793491725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7dfyKzdRYvknKA9F2M27XwH3fnlKeDPMr9i7eMgXHCA=;
        b=pn2eeCBaz/PejNRsmc3vVNJD5ytLxQ/wXpKszgC/RSSPYbEZ123jRBKGD7PRYN/WvP
         kQytltIF8MBe0xwavdrbfAQAUM69rNwL9TSyZxDeHs6HYwGagKlSLVEVnJkyt3UvtuOP
         NaO0INsU7QvtRr1gQsk4IFlIEwlHgl0Zte7TijbuUde6o6/62E4Yb7VgAgkxTo23B9oI
         g5q0Bxi7cRHVsk+VEagP+1L5fuMKoJYaQSUiRsyjAW6v3Spl62cw+Q0E2faIm+rDndUr
         SPqRd9qotolTmnMcvR9sA9shE/q6lfr6VPakcNlQ3lWo15pM8+B5udEPLmnZ5pvaTk7d
         /Mrw==
X-Gm-Message-State: AFq9FYJGld3RKTObD0lAzfaMBmnXB8FLDqHgSLAK7SZoQf1lIgO+b/i8
	K/hJ2DK89a6qvO67CGyx4t34+/xMZ5zD+suLgl5bXKUtMGmIxGwwNIkm
X-Gm-Gg: AYBFou23xlfN5C08clYmyvvsNdQ5gdUp4JMuEXmIaaSnVKgS8on1zDqK5frjiURC+G5
	VOZKQTEevGi4lBySwPun+T7iVlfRKYOpn+x/ryl+6m04KwZcI9v7NNEEb5/UQIAK+xy/bqYXuuT
	vIG/MdsW4VIBRDokls41xLbkpAMXfazyzECnUZiWtMHpYZvJlj3ZzgFWiVTwGLxskuXIZJlYgfi
	dbobfSw9QcH1b9400vJl9VfstAzkwfloaRhTYDrgX6JwtLI415anTNZqBrxIbHuzuZPOakQy+OC
	hc0Z+vKclgFIGMftGe3cridxQyukXsOsDJt7WDtJ2JlsuQ94/xKdzcZS5EG0VSFnkCopnRGs40X
	ketKlmN81UIh15iTCz6YrcTsS/rCDOUKc7DC+RSefNpaHyQKiDpjhGEAfyleCV7BquxtUwiLLFA
	tyHBCj4q6eW42uy5ZgE/6lZr1qukXYK3awfgLwTG2qtaybIBW9Q58sbhj5gcmtDl8oPGyWfRlUT
	5sIL78Va21EG/HfQS67G8bKjT58DIhjc2uHhfsmYsAptS6voIsukJB8
X-Received: by 2002:a05:690c:a909:20b0:8b1:4267:3ed8 with SMTP id 00721157ae682-8b166cb48f8mr17793027b3.65.1792886924758;
        Sat, 24 Oct 2026 17:08:44 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:41::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166ded0aasm14148067b3.8.2026.10.24.17.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 17:08:43 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	Nikita Vetoshkin <nekto0n@meta.com>
Subject: [PATCH 3/5] PCI: Add pcie_capability_user_read_{word,dword}()
Date: Sat, 24 Oct 2026 17:08:31 -0700
Message-ID: <20261025000836.58294-4-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025000836.58294-1-thepacketgeek@gmail.com>
References: <20261025000836.58294-1-thepacketgeek@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcie_capability_read_word() and pcie_capability_read_dword() use the
kernel config accessors which don't check block_cfg_access, so they
can't be used for reads on behalf of userspace that should wait for a
reset (or other pci_cfg_access_lock() holder) to finish.

Add pcie_capability_user_read_word() and
pcie_capability_user_read_dword() helpers, which provide the same function
using the user config accessors.

These are for use within the PCI core, so they are declared in
drivers/pci/pci.h and not exported.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
Tested-by: Nikita Vetoshkin <nekto0n@meta.com>
---
 drivers/pci/access.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h    |  2 ++
 2 files changed, 52 insertions(+)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 18a206bb2a94..ff5a16236758 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -490,6 +490,56 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
 }
 EXPORT_SYMBOL(pcie_capability_read_dword);
 
+/*
+ * Same as pcie_capability_read_{word,dword}(), but using the user config
+ * accessors.  Returns 0 on success, negative values indicate error.
+ */
+int pcie_capability_user_read_word(struct pci_dev *dev, int pos, u16 *val)
+{
+	int ret;
+
+	*val = 0;
+	if (pos & 1)
+		return -EINVAL;
+
+	if (pcie_capability_reg_implemented(dev, pos)) {
+		ret = pci_user_read_config_word(dev, pci_pcie_cap(dev) + pos,
+						val);
+		if (ret)
+			*val = 0;
+		return ret;
+	}
+
+	if (pci_is_pcie(dev) && pcie_downstream_port(dev) &&
+	    pos == PCI_EXP_SLTSTA)
+		*val = PCI_EXP_SLTSTA_PDS;
+
+	return 0;
+}
+
+int pcie_capability_user_read_dword(struct pci_dev *dev, int pos, u32 *val)
+{
+	int ret;
+
+	*val = 0;
+	if (pos & 3)
+		return -EINVAL;
+
+	if (pcie_capability_reg_implemented(dev, pos)) {
+		ret = pci_user_read_config_dword(dev, pci_pcie_cap(dev) + pos,
+						 val);
+		if (ret)
+			*val = 0;
+		return ret;
+	}
+
+	if (pci_is_pcie(dev) && pcie_downstream_port(dev) &&
+	    pos == PCI_EXP_SLTSTA)
+		*val = PCI_EXP_SLTSTA_PDS;
+
+	return 0;
+}
+
 int pcie_capability_write_word(struct pci_dev *dev, int pos, u16 val)
 {
 	if (pos & 1)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c960..7c5a2ebc5706 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -128,6 +128,8 @@ extern struct mutex pci_rescan_remove_lock;
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
 bool pcie_cap_has_rtctl(const struct pci_dev *dev);
+int pcie_capability_user_read_word(struct pci_dev *dev, int pos, u16 *val);
+int pcie_capability_user_read_dword(struct pci_dev *dev, int pos, u32 *val);
 
 /* Standard Capability finder */
 /**
-- 
2.53.0-Meta

