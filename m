Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49733F59A
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585329; cv=none; b=Vyvsb70zUOVi/Zu9L51DevsZ8eApoVLQg0cc3Tkc7tXrrpXDfmDj4+Kb6fhSy6RChldSlTmhEh6tmgsTguPy4OfSlTb9WtJytmaAW8+RSq314AysZ4wpKCTfSZKt8eFd8LRHLkB4t0p+okMmMVuCCC7sDEWeATJA8pD7JpuMdPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585329; c=relaxed/simple;
	bh=nvFyjCT5ppH/Q/ZoWQSkEOugTOmlUlVEiME03kna43M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEVvoWpb5IS6i49VsQ5e/sCKvb31htDZQAr3tLtCswlibwMTVwkU2hlNHPVCBZxMl1Tyk5Ec+Z00MQV+lB/KnZT6Zy9iBjSQysynXLhP7dKK/aBAq4BhYrkMuI8mvtyKcNJp9OfHs5ivPvO6gIgBGtYVnjUmLJdaESXkYJucFM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+vqdimJ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+vqdimJ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36bcf3d2565so605210a91.3
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585325; x=1781190125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaX3iBh5aQ6ieP4wRDACjZGRgQdbq9tB2uoE6aInkl8=;
        b=k+vqdimJVhQIwiOXTPEluKSN82aPaYZbR4Wdh5bMJaYz0eaiTE1HpFogEkkGMJT2BD
         3gyQ+jup4TDLoVawAMcBYrRea+CPYuRECpiJZoOY/DrQ9+2JxytLpLWqqgQ5BGpNMXrK
         BLFR7IL5WEed7YFjr3o7l/qr6EHV+2ii2CWt1/8P+H1AGC1+0Z1yZSCS1isboTcLfg6s
         MDtlobdbTD/WM1N4eTnmjIsNe1LwhrUyHpOrdIiBA3wvnbKl1t/FjadenOeo05sbdLqh
         eKN9reiTA6fRBH4xEwQXJoqPYMbloI0xhQCJ9lVLAb3NZ9g2YB70gbcuVEpDSPePFWHl
         3zGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585325; x=1781190125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xaX3iBh5aQ6ieP4wRDACjZGRgQdbq9tB2uoE6aInkl8=;
        b=fyE3KHblezVEvgY3XUXugvOEJdPH3zFzaC39njrdjBTmgUoTmLBkmhVCgQGphNcW2O
         cc2wVQ8YyoB89rLy6zqIpr6YwUOyphPJmPmyw/Fg7rl5IOjxiVuwuBfBoqYCUllaJTos
         Nq+pMDtMVGvzFiSAL5+1y/R8sBqEWXxt3OIy496Za+ivAa+mW6R7m1tc0Q8l15fo0NYO
         /hClb+GY3iCIPDNKoFCry8VsQKf6CFdAlnO0JjgGsftQtgiAvsyrg/PTcRCe7iwJiVsD
         y2zz2HkKnq7qAE73DEFoeH8GZehaD5RL7y0dEA7NOPTXZYqrAYm2KFN6HAmvdgAnmi9P
         Cb7g==
X-Gm-Message-State: AOJu0YwdtFrH9DOYufIf/q0Z4SDFbdShMEivSuQKkCEctPFME9PaYGSf
	lq1exuBZn0Cbqh2/moRM5rICGWKJ3CPC1XCVaK7O/vpuqHdbHvj+YNCC
X-Gm-Gg: Acq92OFRFQksxZoMaQIcFw/bGXTC6DM64oc5GpCP2xFg8l0f569FzRBiLfpXLZj3bry
	bJWfdsk1EpmQRIFpUbAnwQB7svPyq9Ync5+nexSATkRZuIVdGm2c/l3t1U8ypfFpO9C7+vj5rgo
	7RQnzzf/PfaBAOhX3re1JjdMyQEbnGKeb09X8i458iv23+j5ZKsSAxwmAihcrWwJolDSTpMtupP
	DvV2BMxHHPb8tKry3RAdejStzx5WpL5n5MQrTrR5DMO+FaXlKFBYch3bT4/facyzgS+8eGoiuh3
	yx7D9yAjs4QGiKz7rAaCi2aspaZj6wub8wgnfmtG67TOfFHWx7PE4YtwjTEx1qipF6bUJY1oEKa
	mqBxyql77vX1oS9oWnh/2rxAbXKOIIduJwslFtK7CjmALtJJ6SrRF1TfnO4Vq41J6Af+KHa91nv
	SXaK0a0t4FyGKile7hasJNKAarybDNzHHVau19yZ4=
X-Received: by 2002:a17:90b:3bc4:b0:36a:1ed8:6fe6 with SMTP id 98e67ed59e1d1-36e332f7e45mr8166646a91.24.1780585324132;
        Thu, 04 Jun 2026 08:02:04 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:41::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6d109dcdsm4398717a91.9.2026.06.04.08.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:03 -0700 (PDT)
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
Subject: [RFC 06/12] PCI: Convert vfio_pci_core.c to pci_is_sriov_* helpers
Date: Thu,  4 Jun 2026 08:01:47 -0700
Message-ID: <20260604150153.3619662-7-dimitri.daskalakis1@gmail.com>
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
 drivers/vfio/pci/vfio_pci_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f8d093aacf8..ad8069612cb2 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1856,7 +1856,7 @@ int vfio_pci_core_match_token_uuid(struct vfio_device *core_vdev,
 	 *
 	 * If the VF token is provided but unused, an error is generated.
 	 */
-	if (vdev->pdev->is_virtfn) {
+	if (pci_is_sriov_virtfn(vdev->pdev)) {
 		struct vfio_pci_core_device *pf_vdev = vdev->sriov_pf_core_dev;
 		bool match;
 
@@ -1979,13 +1979,13 @@ static int vfio_pci_bus_notifier(struct notifier_block *nb,
 	struct pci_dev *physfn = pci_physfn(pdev);
 
 	if (action == BUS_NOTIFY_ADD_DEVICE &&
-	    pdev->is_virtfn && physfn == vdev->pdev) {
+	    pci_is_sriov_virtfn(pdev) && physfn == vdev->pdev) {
 		pci_info(vdev->pdev, "Captured SR-IOV VF %s driver_override\n",
 			 pci_name(pdev));
 		WARN_ON(device_set_driver_override(&pdev->dev,
 						   vdev->vdev.ops->name));
 	} else if (action == BUS_NOTIFY_BOUND_DRIVER &&
-		   pdev->is_virtfn && physfn == vdev->pdev) {
+		   pci_is_sriov_virtfn(pdev) && physfn == vdev->pdev) {
 		struct pci_driver *drv = pci_dev_driver(pdev);
 
 		if (drv && drv != pci_dev_driver(vdev->pdev))
@@ -2005,7 +2005,7 @@ static int vfio_pci_vf_init(struct vfio_pci_core_device *vdev)
 	struct pci_dev *physfn;
 	int ret;
 
-	if (pdev->is_virtfn) {
+	if (pci_is_sriov_virtfn(pdev)) {
 		/*
 		 * If this VF was created by our vfio_pci_core_sriov_configure()
 		 * then we can find the PF vfio_pci_core_device now, and due to
@@ -2025,7 +2025,7 @@ static int vfio_pci_vf_init(struct vfio_pci_core_device *vdev)
 	}
 
 	/* Not a SRIOV PF */
-	if (!pdev->is_physfn)
+	if (!pci_is_sriov_physfn(pdev))
 		return 0;
 
 	vdev->vf_token = kzalloc_obj(*vdev->vf_token);
@@ -2166,7 +2166,7 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 		return -EBUSY;
 	}
 
-	if (pci_is_root_bus(pdev->bus) || pdev->is_virtfn) {
+	if (pci_is_root_bus(pdev->bus) || pci_is_sriov_virtfn(pdev)) {
 		ret = vfio_assign_device_set(&vdev->vdev, vdev);
 	} else if (!pci_probe_reset_slot(pdev->slot)) {
 		ret = vfio_assign_device_set(&vdev->vdev, pdev->slot);
-- 
2.52.0

