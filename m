Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9375304CA
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271320; cv=none; b=UCEip5BBQtjGovZAdu3zkiwdoNKQpuZMKmbZ+lVa7iUVTmzjbWapKf0Y1ZGSqSnvajHr4lUj7Sa/T+eLcHcZx76DPcHWxTEa1XdpuuMjkOnJl7LUfQme6sMVqanQQkqAc3EHUXk6oLhWSb0Vayl628/uIMakasJigL+BPBCy1lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271320; c=relaxed/simple;
	bh=XziPSmJ3eoxn3FwHxFZ7NlkslarIhI2b3MgxlzJYueI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ns70m3YAbvq+s4dGF9Y9GPEhBj9zqU5a6O52VKVYH6Z1nZcAJRZ17+MhokpsqstrVu72JGysgLNq74fHiiXLYWMbATqAaBqY5S/H10pV36MvdC2Pc284xRCVdI41SkEPkmtQiTDbu4937KIwgZYqyJv8mX9cuG63Y+ehzRSNnQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dUTtH+G+; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dUTtH+G+"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cec4226c70so170455ad.1
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 10:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271318; x=1790876118; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=noYPamfewYEtm9bVDAU/nSTNzs0ZIauOG0d/1Q9kwJg=;
        b=dUTtH+G+QjMOuM0+1HOMn0QmwO4XC6Yth7pd+FQ5ahfk8Nqi7g2MrGNMfQsQd1rmXS
         wOVya2Yd06e0OH/38ldtAXNOjv2xQwgMxqln5AQ9oz/75ExwQ00wfuQ34XvKNX9FNPKf
         PD7wqNlJOle8RA3tt7GobSOhXutgUqIKRq6Dlpq+8/Fqt3iOh8Jlaqecs/DEegwYWdFf
         6dx+ThPVW8PQdqwv1KSo2fuSaDVNg6rhv0DQywe7iKxAI1ES5bagXF6/7qKYvgyornfT
         av8o0jOmnpN4FA+0K/vSc2LNIVgxgPkxb547fVvEWle3sJDd5Qz5VqzE22rvzgsjWUHL
         Hu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271318; x=1790876118;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=noYPamfewYEtm9bVDAU/nSTNzs0ZIauOG0d/1Q9kwJg=;
        b=qQdWuHvI0z1h7zNij5CZ56zfq8K94+kIInNj/S/juSbpo2BWNO6ouoA0KGWYudTrhw
         wgPSnOfXi+t4QLT9h1m/1MYBTkL3/RBXYTb7D6aPqlu5r8HRgwRHGsJ7Jy8pDfpulx3i
         zlmh+aLcv2h5xUOA2mSfV0DOZesJ0w4X3CIybxvfIr9zuwn1KXxmMmtPHPRXTPKCEq2w
         tLCoF9oow0IfQ+U/wg8gjhvWU21ZoNc2CvIb9HP4yEu0fYmgrqFZ0GOaCx0l8CaiDrKn
         ucdPOpvfDWNK6YIp7htkL97GpRi0I/J6Y8qiOgEVTBA6PBai/6rLVKxF0i96iqXHX4S1
         hOzg==
X-Forwarded-Encrypted: i=1; AKwUvBwTlmhwSQjGwcZ2rtt8YEn3y/nb/furnidF/+5pg/Pv0xMqQipcZkqFqut7A13u4FczR2XVZx29EtU=@vger.kernel.org
X-Gm-Message-State: AFuF++nYdCDK8HY52OlKVM6Tk0Xo/qkbM468LG4w6Be6vAOjiHoPFSCc
	4zxOL/8uC6jhppfktRbkuSGC2Q5Q2Dodokc34lSlMemOXPJUZfRHWhskauxhbvUPfWDqLHqjZUA
	numyazA79x3daIA==
X-Received: from pltt2.prod.google.com ([2002:a17:902:d142:b0:2df:3e71:8c70])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:37c5:b0:2dd:5363:3219 with SMTP id d9443c01a7336-2df7dc2bfe2mr27467525ad.20.1790271317823;
 Thu, 24 Sep 2026 10:35:17 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:58 +0000
In-Reply-To: <20260924173501.856380-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924173501.856380-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924173501.856380-13-dmatlack@google.com>
Subject: [PATCH 12/15] PCI/VC: Split the VC Resource Control restore into a helper
From: David Matlack <dmatlack@google.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>
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

Assisted-by: LLM
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
2.56.0.rc1.315.gc6ed9934b7-goog

