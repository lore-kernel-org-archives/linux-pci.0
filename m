Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A74AE109
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271312; cv=none; b=gtiIzc2pWDeeMVGyMPVQma/A3C5Sw93tY6U2tUF176TG2TO9lbIBCwOspGk0NEDoQMkWqmeyZfdmGUQPGqKsevFJSdpVzkEqjjE2f23gJFxazm/TUd/9+JFT8Tc1oC652Lv+3Y3jHBhn52KGq4BJ7veOYKWG2mi/2dPLtnMJC+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271312; c=relaxed/simple;
	bh=llwqWsHEBwaL/pw4iOEvyij6ElQ8QiZYinQU56qHsxU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=togwL85SDDtrQZyfAflWYpP63ym8vhajkDCpcEWkNQO76iNx/lcZ+CKer0+/hIQmoH7Ngx4zSkwzTyDujbXAPmFZVKAZeuBuCWtyakyI06TB2wYiWC208+nRXPE7IQDg2N3VbNqDVR0Yf6O5m8V1BIZTUTCy25tFqQyosF2UpgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vipu+y2A; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vipu+y2A"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39e3c10ac70so146247a91.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 10:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271309; x=1790876109; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N0rfVeKGfaHWBFQak5OwGNeTtzDcqQjSrfmq86KyFwA=;
        b=Vipu+y2AVysEPiWrg+ZvN2bP8StBJ+u8yGM72xHCWmhBUSMTT91G64cDFMhNzaXU1u
         dWvAbBBoKLc6jcpg7czw3We3EyP96y4lKpeQ0zlmlVSxqqJv/dD6YczwafqC7fl6Kmpf
         dzARDUtjHOmpsYmyKTzfBLDI+4duIc6vD7hx+MhogeO2gJHAcXgkBIBljQ14ltvJU3L4
         HLCNGcV5wowO0Y892z952JYQdqxweSJsYg/bvUfCAocREA27LEQwHJr1SyCmxp/pbxLU
         J2UxKYsjVE8RWDiobs1T4gmzdKYjp9YW6YpaNAl3bTggxzikDqzlvHfPXjW3qjCTs/t6
         MvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271309; x=1790876109;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N0rfVeKGfaHWBFQak5OwGNeTtzDcqQjSrfmq86KyFwA=;
        b=dFh2Je+aeUau+T+BHZfanvLr48xIphFZLQMrTxJmOSQdh1NrtO+E/HAbki1Bbn6MFT
         Axf3U8+LlOZYeVTgQUWvaUhWzVlZnqRDApdUTgvmIBrTAMmkVKuWpkPzsDvhyNtYvlfd
         1XOx4CxCRiA7+IW0tWRm9BSYTLEgNyycBu0xFdfpjVwuWcuZxKIDI7cNv+ktBaoi1GRA
         SFY+LqOqtj1vylj6LmISYFrW3oALVsK7+U18r6692KKIX4zc6eO+mbhm/w+zszW3RtK5
         FyKPLxWBNTa04abrKGL3HGvaB7U6mCzjIrKGm5R1V7U5sqfF7fv3uXeudP52UWJrFAV5
         NC/A==
X-Forwarded-Encrypted: i=1; AKwUvBweCW6ttNAbL7uzDn0x+vdwojY7tj7Z6zwb4yLwIcFGyr4ZKWFzXEZTGcQk6hxvScrehMsNiqSTElc=@vger.kernel.org
X-Gm-Message-State: AFuF++lYCoJ3xcLzYs3BAzKw+f18uMjzLFX4foG85nE1E9RXUiLbLUv2
	FakKuNoC1kSxTBh99Nse+8Wq/0COKOhTNlAlNV5s0yBpY+juPwSIMnX8LPqY14bx/RgZAJen65M
	VPxmMJYXpWjNeWg==
X-Received: from pgdu27.prod.google.com ([2002:a05:6a02:2f5b:b0:cc7:54bc:3f81])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2541:b0:39e:6c69:9b9e with SMTP id 98e67ed59e1d1-3a0992905acmr2586055a91.67.1790271308552;
 Thu, 24 Sep 2026 10:35:08 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:47 +0000
In-Reply-To: <20260924173501.856380-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924173501.856380-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924173501.856380-2-dmatlack@google.com>
Subject: [PATCH 01/15] PCI/DPC: Allocate the DPC save buffer during device setup
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

Allocate the DPC capability's save buffer in pci_dpc_init() rather than
in dpc_probe().

dpc_probe() runs when the portdrv DPC service binds to a port, which is
long after the device has been added, and does not happen at all if the
service is not enabled. Until then pci_save_dpc_state() silently saves
nothing, so a reset in that window loses the DPC Control register.

Allocating during device setup makes buffer existence depend only on the
capability being present, which is what the save and restore paths
already assume. It also puts every capability save buffer in one phase
of a device's life, which a later patch relies on.

The size is a compile-time constant, so nothing about the allocation
itself has to move with it.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pcie/dpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d861..b7f79266f66d 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -408,6 +408,9 @@ void pci_dpc_init(struct pci_dev *pdev)
 	if (!pdev->dpc_cap)
 		return;
 
+	if (pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_DPC, sizeof(u16)))
+		pci_err(pdev, "unable to allocate suspend buffer for DPC\n");
+
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
 	if (!(cap & PCI_EXP_DPC_CAP_RP_EXT))
 		return;
@@ -499,7 +502,6 @@ static int dpc_probe(struct pcie_device *dev)
 		 FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), pdev->dpc_rp_log_size,
 		 FLAG(cap, PCI_EXP_DPC_CAP_DL_ACTIVE));
 
-	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_DPC, sizeof(u16));
 	return status;
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

