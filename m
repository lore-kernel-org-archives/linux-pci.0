Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521B51A9FB7
	for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 01:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349091; cv=none; b=V1o8DzC2oU8c+7RJg1eRB3ec08iX75eWLNJcRrs+UtaLTufGKYh+eRUYXczfiWDT6iQjRixTfTHugGfU2ARYtDe6HPeeBaZz0LH/4/b56psgFiWEklWb7g3+6dXLNIlk+X/80UDKXQNIQ6fV7/SPOACjJyLMx7SRq8baSnEmhhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349091; c=relaxed/simple;
	bh=EVl1dseH/hcQ6vvbH95CZ40hP0Pvxu+bkOOT1iVUm+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jwaws0GJmaU4B2J+ny+mfFpNjCjDbV2L7IXNGfa3b0dT1LH1+L6dVabm6pzDJLHHlBiFDkgDn3XFuMSK2fGjcCAj2T5UBiXnx5NNVHaKS12/bzBgBVSTfoPIvVj/WGGcGTK4C24bZMemtPkwva6M1feoBPnGaYIpJQh0ZtKb+/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HctuGOHF; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HctuGOHF"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91058dd77a2so25854196d6.3
        for <linux-pci@vger.kernel.org>; Sun, 13 Sep 2026 18:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789349089; x=1789953889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qJIMkfpIudRGMH24Z8qD5n1KKI9enVz4TS3USZ/AkDA=;
        b=HctuGOHFrYU7DFaNZeCAd5DZGOIoCTDiAX8OwbEAllzjSHFd4vft41PTef3XY8VT2R
         9bBap0BESMwhIdvMpzsiTxi7xIkxxxkJNIp+hkNUmeuO8sqZakTysNm/s3frPIet/tIo
         GbzxZPYDg372QGKGu7Dq8AOhVOd6Gtvx2d6ev0Y7yXujoSi/63C6oOeKVIw5q5f/Kvo2
         Dmtrc51TkngQmmfu+Fn6/e9yCSHKlqoXbucY6SrpWffU9DU65w4+JDQtgcv/jFbElJSo
         13BE/k2BW6JQTm0D0PJcqQC6SABNFVibUi/Nu+LEkfq0v3BFELEegGHam3R3vxBe5xBt
         AQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789349089; x=1789953889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qJIMkfpIudRGMH24Z8qD5n1KKI9enVz4TS3USZ/AkDA=;
        b=UZ+3pw5pivYqHThk9AsQ1AesrplWGBjJM5zw3o19WD2rcgyFwebizG8soGUeGoV0HW
         zcRhBZqPiPUhi448kp1MnSrKGjG819LBcQubKKeSTWkTeR97chHaqSMHErusn8U+Oy0t
         0vd5gJHl6FcSJSVYPnRC//zYZeKIcWmvtSg7SHLhwjROc/fOBOoU+SvZgjJ8/H3IHqhC
         6Af+5y0b8N0pst6r71Goj+IqLpwl/OP0U9LE251AavVoc2WQ8JB0dUCONZdzLwe0yRW9
         exB2ur8lmZV3QbWDaFzVmlAnjDK9NBc37zNF9knUVsosZhsX0vM6FNHcM0CM5LH5/zo0
         cjFw==
X-Gm-Message-State: AFuF++lBxiSDL8Ldj7lArE0YONJO+PBXGNsCCgsNSoNw7jBkRj6nmhR1
	Oq+++HiORv9BS3OgLmLq3flZDdRXmnwYTpBfdS9ugukOkHGiykpbAVY=
X-Gm-Gg: AYBFou1M/OFueC+NO5qpBgmJA6o+QctyY4aYRRQFYkdaQZn4lOAdv+SmJeGcYDmhs7V
	SZAfuG2qKMypQ1IM4h7NNQ1rj5KT58i3k6fkVVrJzg5vks0kInqWunNyA26Tj9e2wlFi92AuPgx
	85sSVLE7fIYkUWyUntwszBJlhnM1AzxncihuacVuO1nd0ei4pq2pVmAlzRSJbp5Dt2EHQ+cif6A
	HiskUfMPxSc482o3nVPFhNKKwYTS47UeS5vnRaHf4qh8/sZRcbOrmW5zS8aP1A6UyLqKg7UqITG
	H12e8MFLivRbaZVYVYcZN5yBIFn2CtqtgY8qX/9cfmc/JfQ8kx9jY1yJ6GbHc7axGauiRbDj/7O
	ehbzPoT2lB+qpJ+kUPFn8kUokiiZIy+C5nZYrtoYi9jdkmzKkMt+84PwpUXliIUgIv3D1G3LuKT
	yuw6sqC9GNWZW2jYXmj+ceEMiGzc/DegPLzlvYX131/6bR3M2GExb2lC4XqeqfLwl7LioCxvywe
	EgL8pv2RzmMn/yp2K1aB5N7Y0XDo0da0YACGe6EoYjrhUTq5jwtFmQU2zrkUYTzrPb3FErV70fr
	zgmFK3aAC2CirYWaoDtqFxww/oF1jcTlHQ==
X-Received: by 2002:a05:620a:4885:b0:939:5f4d:67b0 with SMTP id af79cd13be357-93a29766649mr86078085a.8.1789349089174;
        Sun, 13 Sep 2026 18:24:49 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e809fd0bsm850352585a.33.2026.09.13.18.24.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 18:24:48 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH 1/2] PCI: shpchp: Release MSI and MMIO resources on init failure
Date: Sun, 13 Sep 2026 21:24:33 -0400
Message-ID: <20260914012434.47010-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If request_irq() fails after enabling MSI, shpc_init() unmaps the
registers but leaves MSI enabled and the MMIO region reserved.

Disable MSI before unmapping and release the reserved region on the
failure path. Reuse the region cleanup for an ioremap() failure.
pci_disable_msi() also handles the INTx fallback where MSI was not enabled.

These omissions are already present in the initial Git import.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Assisted-by: OpenAI:GPT-5.6
---
Validated with an ARM64 W=1 object build and strict checkpatch.
No hardware runtime, IRQ-failure injection or hotplug testing was done.

diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
index 183bf43..4492c7d 100644
--- a/drivers/pci/hotplug/shpchp_hpc.c
+++ b/drivers/pci/hotplug/shpchp_hpc.c
@@ -943,9 +943,8 @@ int shpc_init(struct controller *ctrl, struct pci_dev *pdev)
 	if (!ctrl->creg) {
 		ctrl_err(ctrl, "Cannot remap MMIO region %lx @ %lx\n",
 			 ctrl->mmio_size, ctrl->mmio_base);
-		release_mem_region(ctrl->mmio_base, ctrl->mmio_size);
 		rc = -1;
-		goto abort;
+		goto abort_release_region;
 	}
 	ctrl_dbg(ctrl, "ctrl->creg %p\n", ctrl->creg);
 
@@ -1008,7 +1007,7 @@ int shpc_init(struct controller *ctrl, struct pci_dev *pdev)
 		if (rc) {
 			ctrl_err(ctrl, "Can't get irq %d for the hotplug controller\n",
 				 ctrl->pci_dev->irq);
-			goto abort_iounmap;
+			goto abort_disable_msi;
 		}
 	}
 	ctrl_dbg(ctrl, "HPC at %s irq=%x\n", pci_name(pdev), pdev->irq);
@@ -1041,8 +1040,11 @@ int shpc_init(struct controller *ctrl, struct pci_dev *pdev)
 	return 0;
 
 	/* We end up here for the many possible ways to fail this API.  */
-abort_iounmap:
+abort_disable_msi:
+	pci_disable_msi(pdev);
 	iounmap(ctrl->creg);
+abort_release_region:
+	release_mem_region(ctrl->mmio_base, ctrl->mmio_size);
 abort:
 	return rc;
 }
