Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF032339861
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585331; cv=none; b=EmFPQTS79Wlpr+7WcUOGD0G1vtpkyizAFuBZ2EtMKcrUIGM9KZDaUb8y0SxjcnpKB33gofLLuXM5exkFpeMsgEMQxAJBFwrNJtdoeGAXjUze6p38+me09wC/em8yvcwSexnC+nnqeO98our9/em0GSGq1CXOAIWDkgCgExQP/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585331; c=relaxed/simple;
	bh=c87l4ayOOQdKWyV24U9yzvfPBhhJgg0gsW2q68ZSy7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QapVrU7d1uPB4S2CidYRslW6WouXBQzhWMrdqPtrdxPHYqAFXZ93DY+j5JS9xEloXYwi6xeJ4NCbzwp6LdrvpplkghCtDm+gB9hBZxFetgdg79PCKf11ljoPyGcC4F2Cy8mqzC2cnhAaEpHbEHtOVpseEHqy0QSb/t+aHnrcHLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPHPTWre; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPHPTWre"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36baec934b6so1175771a91.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585326; x=1781190126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hIFtvWihjq2T5uRD8ilA/smzXwEZg9tgf7CPYlO5lE=;
        b=jPHPTWre22kf5Baj99FGEmgJdvS00aFptAyRiI5jvNH9sQchjnaezr2aTkCdScsdSp
         tbaSD7JDpfn9a7xE68d+NJh/2ZdKvxd3ahoEhMd8B6utRmz1awK6rOi16hPfm4qN+nUy
         rNPnk6O3bRvZp3DHu5yR49kAZdqSvxffOCSLhRTMFNEEj1D7iyEoCyGrtwJXTI96gwm5
         rqAdCRQbhPUrD0hSJY+XncgOI4O91Vu5DriFoAqmvUTMV0VN7Qkf1BOn1kfAf9wtVo/b
         LjSOEdkLpAZ47IBy1vlOo69idv4HFMXIbaHCYPecpM33rM22idcQYtEnmdwl1LnCYoHF
         +x2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585326; x=1781190126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2hIFtvWihjq2T5uRD8ilA/smzXwEZg9tgf7CPYlO5lE=;
        b=nFQ1F9eBfOGDtW1OKpMk2qy331iDVXwRHHoFg3guYSujeSqv9hwq5Ku1PlM7wwEUCB
         ETI7pUG5whosW6lGUDqY5A0r54LQDKY8HvV5zVnyyb5AdmuJDQlrFWTJqtFBJZw4M1TQ
         GLVWnw2iofK7FWI6ByC0qt6aah4nx4WqMyVF0RQwXu9fnwImhe7JW/d46Is3kkAnm31n
         vzCmIiofF8MwyfkAlB9uE1e1/VU2EtCyMG7tF4ATZUteNa3Ir2q1e9Hmz6yGrLG9PDVF
         IsLm6YrhwjrcwCKC3xXgrTv34NiBqVmEM+7E7ZeFR4VtUW59qpHfUq7XFTjmjq28pOK5
         IbOg==
X-Gm-Message-State: AOJu0YybKjz44Af5KTujZdqdiODUC4S/vwqrtohg8rze6L87zEN83NxL
	z6nwH4MT8ubQBjQ36Et2agRDXp/9WejLbviA9qlAR1y+s697nCVE2gxF
X-Gm-Gg: Acq92OH+2vs6H45B/bKBplCzXIdB3EkkdwpgmbZ2zXXjjzvR60/zuwg6yUMTPzDzBpn
	K9D6GKV0mX7gd8BF8ppl2jPlUNTnmtuL4tRKbBZpS8YbpVftwXPbZjGUykUhRWuhL+b58AUIVF/
	FzKBTRGrQaxX3d4ENMiIdoLdcgAXJ1McYogvx2SnJAACMxl3elviOH9+sH0ihknkvndiH2qHpkb
	t5UxvvvzAJYt+VEJnCUF+G/FjvZ+m/veKIPEZYGlVTyYqMihFDUljg2FiZ/wxC3kDgPjQ8lVhmJ
	J9tzwzVnbkpbhpMn3HFDt+md28VFDF5S1aD+QWBxquV2B7F5g0ciUBpbVo9HyI3ed0+upgBnOht
	LYkgY/xrMgxUD1b5DymLUPnqptWrwtAb0iXCP3M7di3SfrumssLCHhMrtW5zlCjS6os7wvXh9
X-Received: by 2002:a17:90b:2b8c:b0:36a:8519:a4e9 with SMTP id 98e67ed59e1d1-36f7898e08dmr3643368a91.18.1780585325710;
        Thu, 04 Jun 2026 08:02:05 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:55::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f711e7b53sm3448820a91.14.2026.06.04.08.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:05 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [RFC 07/12] PCI: Convert xen-pciback and pci-driver to pci_is_sriov_* helpers
Date: Thu,  4 Jun 2026 08:01:48 -0700
Message-ID: <20260604150153.3619662-8-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dimitri Daskalakis <daskald@meta.com>

No functional changes.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/pci/pci-driver.c           | 4 ++--
 drivers/xen/xen-pciback/pci_stub.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d10ece0889f0..926f80bccd70 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -357,7 +357,7 @@ static void local_pci_probe_callback(struct work_struct *work)
 static bool pci_physfn_is_probed(struct pci_dev *dev)
 {
 #ifdef CONFIG_PCI_IOV
-	return dev->is_virtfn && dev->physfn->is_probed;
+	return pci_is_sriov_virtfn(dev) && dev->physfn->is_probed;
 #else
 	return false;
 #endif
@@ -453,7 +453,7 @@ static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
 #ifdef CONFIG_PCI_IOV
 static inline bool pci_device_can_probe(struct pci_dev *pdev)
 {
-	return (!pdev->is_virtfn || pdev->physfn->sriov->drivers_autoprobe ||
+	return (!pci_is_sriov_virtfn(pdev) || pdev->physfn->sriov->drivers_autoprobe ||
 		device_has_driver_override(&pdev->dev));
 }
 #else
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 79a2b5dfd694..fd5a13f79fcf 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -1695,7 +1695,7 @@ static int pci_stub_notifier(struct notifier_block *nb,
 	if (action != BUS_NOTIFY_UNBIND_DRIVER)
 		return NOTIFY_DONE;
 
-	if (!pdev->is_physfn)
+	if (!pci_is_sriov_physfn(pdev))
 		return NOTIFY_DONE;
 
 	for (;;) {
-- 
2.52.0

