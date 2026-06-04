Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EA9311C2C
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585323; cv=none; b=IQXaPvfFcawqd8X78gblwwdy+/K/2361elxHDXwLXReYi4Gnjj3R0UIVU5KYuTUVdczzqwHbEJd2l13Q1LAWRLgJ9/jpu2iwJVBqnUCMIZr3WwMgx0DtJtLFAxoKA3GmQumC1Qq3U+u9u4dnHEhSLmxRSHeO2y7jByUAeljJXQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585323; c=relaxed/simple;
	bh=lmjqe+wz2MLmpS3qsZR8wvfKLvk3gZM+AULrTz1+wsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHV5MDC+bBivrXwxVmeitvZmHlcDFeQ17ZJoQKTnLd35mezpnRFg9SrSZ82iHHtYDgs8F8G4rCz7edJgKk2/kYCDOUfmerUPO+jq+urmd0pkLX9T2MMW/ZwTJuaWmDuVgMVEf4PPZM3ti49ON257w4DO7Fi/02T4ID8UTJTyl9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XA4Ry5ci; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XA4Ry5ci"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8422f395a4aso534219b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585321; x=1781190121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxHR67fZ2aTWHsPIWuXVLfBkGwXwQ/JLm/nLvvGQPDw=;
        b=XA4Ry5ciTsxosLc4NggAo2/LVj83bLmwFT8IiJgILcLqY/MMpeQ5QT9BPLFzeJsdzr
         KORDK7r1iMjwe3MF2c8S1TXip5PiWsQN7CpgOpOKkUiEeKLf4S9OzfyqqjJlsN0C4wiq
         qL/AlH5yD1vUBHHCZJrf2wE3J4i0r6G6cUv16bR22y7xJmvmewOyJf3HWxQd6vX0NQoW
         nv2cqM6RQgjKI/fUHAEC15Po1YtKzNff7rjHckN74xDVhVmITG2Mp8MGyE85zFHJUh9b
         4h/Ced+ztJqMc8Qdp0y5TO28L5hTnzrLQc+VONN32yKEez2tQ+SHY/S4WB7JvcyRlAuy
         DPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585321; x=1781190121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xxHR67fZ2aTWHsPIWuXVLfBkGwXwQ/JLm/nLvvGQPDw=;
        b=Miry1lbjT/4I8xbV14R7g4mn7aV8QIKkhKfcoiRTTK0XizkB84kl69QjwdkoeH0OUg
         qJM2v5a/rVK0WNlV74toAerlsmPJe+/01TKWFl3CoIESMI1clugHRylQ44LeRZ60Sz1T
         nnUZsLovokAzmm/EFIXXrRCTZd2sxztrk4lTDPm6to21YrgpyHtsiOoINxAvMD3P0PHe
         KeMhFdhoMOZIlPFAzSPxs0y04BWxD3lYpeT2SqZg1oCgqajwGDCS6N0QGpACpJxKX+xI
         OQe4+ntG6CyRQleViDU9TlIJoOm6w286mM9ErkVhvBjvBt+Dz7mYhxct1PRQOLIOkGPa
         QA1A==
X-Gm-Message-State: AOJu0Yw9tbaWHE+liCjUAoSnYIgVTqGyaJeb8DUZopw4kEQlbgGGFyJI
	ahXxG550OTwVjStnvNCkvqVFNc5Qo8yd8H1MX2pn/JcRWzmwewJydvCD
X-Gm-Gg: Acq92OGOq+LOyg0h/BRJjThur3VOM/QN9unqdKRpRyK8fflPQt/jmdoZ5DhLWlWmtGe
	WJZ4XaeY+9NW0BdDZCNYi21T/x4erlCqgdOlGaTU7g3rG2biWB22NF8lRsZq5PmL6eYCJmzANUA
	sEcy3oPUerY/8qU7N+udsKyAoctUbdqr8RRa0eIu6keEqORRIf/CQF2iwrbd8YqQbEl4U5gm04p
	YSxWjl+IxFE3bvAw9D9HBz8anVM9F1DK4ntM+NplQWS+Wd/7vLzs6qduKPk+8Ew3yki9f2PRK+z
	zNu6zMEt8ONu/ggHuTQACjXC6wAzPP2SWIVwJZ2AhCb2S77CxcB/NuTqWzFxykWGOqViynmer9G
	F9SB13tC2e/i55/Seba1sYTBkLCLglQGrXxsIYKFKMMlmk5RvqSL3k6poxHyFoVFWylUdyaA9Lc
	lLumCzamVgbpstysNjx9+w2nn5PKTRcgHDaE1djw==
X-Received: by 2002:a05:6a00:6c8d:b0:842:47f7:5f1 with SMTP id d2e1a72fcca58-8429b73c68cmr3210028b3a.28.1780585319505;
        Thu, 04 Jun 2026 08:01:59 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282882156sm6223764b3a.33.2026.06.04.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:01:58 -0700 (PDT)
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
Subject: [RFC 03/12] PCI: Convert pci.h to pci_is_sriov_* helpers
Date: Thu,  4 Jun 2026 08:01:44 -0700
Message-ID: <20260604150153.3619662-4-dimitri.daskalakis1@gmail.com>
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
 drivers/pci/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..73b913bcb87a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -954,7 +954,7 @@ void pci_iov_resource_set_size(struct pci_dev *dev, int resno, int size);
 bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev);
 static inline u16 pci_iov_vf_rebar_cap(struct pci_dev *dev)
 {
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return 0;
 
 	return dev->sriov->vf_rebar_cap;
-- 
2.52.0

