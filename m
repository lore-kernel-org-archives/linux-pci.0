Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793925794;
	b=kFR/TARGiBGdnohXvD7UcLZsEc6QG2+ExWDh9+9A1b/fzXleba9ofcdGP2lZ/3j1Mu5q
	 W8GvXsnGBbTBVamgwH/X5RFQIvX2JvM+lh7/xoHwpqqUivc6O/LP+dOmYPkiZal81vbRH
	 mVHxKPVKS1AsquEbZ3lkWdxvhAVMEF6Xed/SsRJ5akVYlNcbpMVE4tT86EghAzRzP2SpW
	 gS0xIRvbzR+AkpRCmnxIpPcB3krOldcjxOU6DAnhOKd9KnqUr5q2NPD/AKXsjb4t2OG8e
	 4SLo8/omoMVnXNA2rahbHJgacg3Upn4RL9+rmygvs/VUr8TrS0ld5UTcsOPQmh9zy9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Ko9lBiZy6mSuKQIVTlOLgBpFZr5J5ifQKI8Or80My08=;
	b=cSuo/V0GCakDl0sfAScvGCHaJiaMTJ9qp0TtVtf7tlRRf6MyZ+YWaOW+gbsGenBUrUPW
	 MBWvtLxXdzc0+UFDTTFjAHKE/txKA4KTixZyXtwMwpWZppBHiF/0RjMRUsxXM7KyrrSB4
	 vLS6MNGPRX2T+q/ExqofqOzsP4ZW44lXK8zOT7faz43WPDdwgANKVcFMAAq5BmmxhIABf
	 1f5Z7y732GOIZit2kitWW9Ia7cb/mSmnGBmRSc04o6Mc7FkxJnYcaXfrzbUszaqE70XUJ
	 zUK7zEhCZTN9PquTK2PP3VqQU8wcpaMLApm13U0KKMHDsQZdRsgZ+9t6XfqDFOlEo9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dMLuccPY;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9FA606EEA3
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 00:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC9FA606EEA3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dMLuccPY
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4a7de733fa9so84457b6e.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 16:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925793; x=1794530593; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ko9lBiZy6mSuKQIVTlOLgBpFZr5J5ifQKI8Or80My08=;
        b=dMLuccPYt2as19f9gKIoyHFm4EQ53K5zyjyxoBEtNOOC3rg27vHMGIiJVFDF7QV2gY
         62JhU0GHW5T1GDNJgNneDXX5ACBr9bKUpwQVGXLuMPgM6rfhSLMMakBSbXiWuVeMJwjY
         WU7CL5ucp/JMsaslIE4CdZ/50ADTpTWcHjdalPHlHYPVWNaWdNV/BUmol1ahM7C1xgBv
         6lZ65/t2gF3J5OiJLSBy7Bg+Mu4eHCguuj8Rn6lH1w+gCK6R/TYe1Y7aw5lzQ45Bu9ed
         GNHGCLSP5NSGKEHKf+BZId/NdQ51tQcZri/ROeZbcfYk0tSCamdL+Y0Am3bhRxf/6ogX
         4t6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925793; x=1794530593;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ko9lBiZy6mSuKQIVTlOLgBpFZr5J5ifQKI8Or80My08=;
        b=lyGalIqzsrgAx1rIVru/yril9nwlQzrteTTGzqMRRJAuqKj49do5AOxnd103woD/oA
         w2+lvO3k0w8JxQ1SY4S6eGiqKXzknFAGhqSDGNpfusY9DVBbF2XYncpjWAPOO+RyMn9P
         TedFk2hrwe2cCZegmrVKzgn60LrgFo6M4iD3dgedzOwfZI/yhC0BAGz9CJiFHBdJxLav
         0Xg9wTvoqk6L+jO6sPnMurEH2neZKW2nSiexKuijN4WnZ6L8x9rLENsYI5lk4pdtRrqX
         4plgIGTSa/FC3Qs7PJ7KHFZg5UWcxy7hs6zY/w17G/UMs1593iTOBae75U4LNNUHLIiG
         qrpw==
X-Forwarded-Encrypted: i=1; AKwUvBxNiSbNFXbHU9yCozEoKXYaRsTxE/dQHWzOE3NuL+ETwt9dHxynVORCgo8QO53Gau++6Kczh/SPHM0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8C+r+443QI/BCqocQKVB+tjHx+Vwt/infs56dK+7AJ2MpW0lEH
	IAlnAvzRLlqEydCex5m1AmXR8F6ORRdzkBZ7Lup6sKx0el9ZzokIP+5vuvzlalpia+JXbrviTHf
	5al7tnuIgbE/jLg==
X-Received: from iobgs6.prod.google.com ([2002:a05:6602:4fc6:b0:9c7:69c7:3d52])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:5087:b0:4f4:857c:98ae with SMTP id 5614622812f47-567e0faea86mr686749b6e.11.1793925792669;
 Thu, 05 Nov 2026 16:43:12 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:14 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-14-dmatlack@google.com>
Subject: [PATCH v2 13/17] PCI/VC: Split the VC Resource Control restore into a helper
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Lukas Wunner <lukas@wunner.de>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Move the restore of the VC Resource Control register out of
pci_vc_do_save_buffer() and into pci_vc_restore_res_ctrl().

Restoring this register is more involved than the rest of the walk: the
enable bit has to be preserved across the write, the port arbitration
table may have to be reloaded, and the VC may have to be re-enabled
afterwards. Inlined in the middle of a loop that is already sizing,
saving and restoring three kinds of register, it is hard to see where
that sequence begins and ends.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/vc.c | 51 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index a4ff7f5f66dd..5b507207d56d 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -168,6 +168,37 @@ static void pci_vc_enable(struct pci_dev *dev, int pos, int res)
 		pci_err(link, "VC%d negotiation stuck pending\n", id);
 }
 
+/**
+ * pci_vc_restore_res_ctrl - Restore a VC Resource Control Register
+ * @dev: device
+ * @pos: starting position of VC capability (VC/VC9/MFVC)
+ * @res: VC resource number, ie. VCn (0-7)
+ * @ctrl: saved VC Resource Control Register
+ */
+static void pci_vc_restore_res_ctrl(struct pci_dev *dev, int pos, int res,
+				    u32 ctrl)
+{
+	int ctrl_pos = pos + PCI_VC_RES_CTRL + (res * PCI_CAP_VC_PER_VC_SIZEOF);
+	u32 tmp;
+
+	/*
+	 * For an FLR case, the VC config may remain.  Preserve enable bit,
+	 * restore the rest.
+	 */
+	pci_read_config_dword(dev, ctrl_pos, &tmp);
+	tmp &= PCI_VC_RES_CTRL_ENABLE;
+	tmp |= ctrl & ~PCI_VC_RES_CTRL_ENABLE;
+	pci_write_config_dword(dev, ctrl_pos, tmp);
+
+	/* Load port arbitration table if used */
+	if (ctrl & PCI_VC_RES_CTRL_ARB_SELECT)
+		pci_vc_load_port_arb_table(dev, pos, res);
+
+	/* Re-enable if needed */
+	if ((ctrl ^ tmp) & PCI_VC_RES_CTRL_ENABLE)
+		pci_vc_enable(dev, pos, res);
+}
+
 /**
  * pci_vc_do_save_buffer - Size, save, or restore VC state
  * @dev: device
@@ -311,23 +342,9 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
 			if (save)
 				pci_read_config_dword(dev, ctrl_pos,
 						      (u32 *)buf);
-			else {
-				u32 tmp, ctrl = *(u32 *)buf;
-				/*
-				 * For an FLR case, the VC config may remain.
-				 * Preserve enable bit, restore the rest.
-				 */
-				pci_read_config_dword(dev, ctrl_pos, &tmp);
-				tmp &= PCI_VC_RES_CTRL_ENABLE;
-				tmp |= ctrl & ~PCI_VC_RES_CTRL_ENABLE;
-				pci_write_config_dword(dev, ctrl_pos, tmp);
-				/* Load port arbitration table if used */
-				if (ctrl & PCI_VC_RES_CTRL_ARB_SELECT)
-					pci_vc_load_port_arb_table(dev, pos, i);
-				/* Re-enable if needed */
-				if ((ctrl ^ tmp) & PCI_VC_RES_CTRL_ENABLE)
-					pci_vc_enable(dev, pos, i);
-			}
+			else
+				pci_vc_restore_res_ctrl(dev, pos, i,
+							*(u32 *)buf);
 			buf += 4;
 		}
 		len += 4;
-- 
2.56.0.455.g6c5a503b38-goog

