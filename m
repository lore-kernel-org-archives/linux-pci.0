Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C80C1EA65
	for <linux-pci@vger.kernel.org>; Sun, 28 Jun 2026 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782657329; cv=none; b=sSs7ds7r7u1V7QfryXnhyrR6eRXGmebtL2VFEXA9CHBMHzTIupdCuvxELTGRS2wSvL2JPkNGtfZD/xNd6T5XMiGZhY0R0am0JsR3fHEJpdscrs96/ctgj6CaU551o4IvaLGlR2IuSELIn081oms32Nx8Mz6OZkBAcQPzE/b2N3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782657329; c=relaxed/simple;
	bh=K/wN1VuoJ/0b6BhKWf1ylXD7YwxGtRzJoQOHDQqUok4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Glg920kGvdSicpwX0+uzLABwGavpc+LDW+8vJh0xGCGgRDrtIyMbKjA3cCbxqupqOeiLDa63boeVODAqUUIdb/SUsdWR8JMRP29EuN+pN5+z1bVfUCZ15eaYfT2IGTf/3MH5POd7JjQOkFgqU4RmIZavrce1F0jawIA9ux0BAYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiaPTnVp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiaPTnVp"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c125c082ee2so31533666b.0
        for <linux-pci@vger.kernel.org>; Sun, 28 Jun 2026 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782657326; x=1783262126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B315SlpNXaHWQGkatzEXmrZ3+2/cgcrvpR1dcwtIrX4=;
        b=AiaPTnVpwg9CKfPs9mCFrzG2Z6Y2yDserTiWOblcgRkCfCWxs2eSzLlHSPgrGgrBWd
         97u46Im9qpUVCWqIInES+Hv4KHYXWFkrB9hkDDkvqOdlCM6+JUbywKzlNpQnd0Ufndux
         5bGJaMSoefdqqXjBQee/cwu4wl1Ov9aMGx191M+FUG528o8h7adbyal1NKdHAxHu1zN6
         m5pAZuDwo+XR+ro/64+vUIU/E/B5K8fc29OwkcmMWe9iEKW0uRcYZ7V7NGYUVzVZQRy6
         6fVLtkvohRUWejic09e6aevuu3OgZFkOJzztmUfiTqNac2WsZf0jZyWj3hCy22y1OYtw
         LqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782657326; x=1783262126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B315SlpNXaHWQGkatzEXmrZ3+2/cgcrvpR1dcwtIrX4=;
        b=inWjmXxYqNNL6U1PnJ5psHJaCSppm0zIkSiqBCsRxFzhpXtPCa5rzbspBLgz4zqr8H
         jxztTCPCzJfZ/O9lJWg31bCStsutyb7TDb0CMaXwcDA4hrSBOQbs9MDD52KslobiH0wi
         0DB57ggTxCsrj+yJkvK0EDDSoSch1AvQFw2fkA2xv7kLxp2w3xKK5C2KmiS+T1WBq0IJ
         qi6zUbXzeUJ/3E+9BMPtAs9bUU91mFFSBzWGggnT3eBCjlC+K/X6VZdoZMfZssCxIx0h
         CnmahBhCr61oeMyUKj/vd5zwtS0bueLgxM6irq3fNmS29Zh5crLJI2cXQd5gn1VyEzOL
         OJbA==
X-Gm-Message-State: AOJu0YzVDZiYdsWKbZYjPdw1qEd98ctSIg7q8AgXaIsITizqot83mPGC
	azBFEPMSrr747CWpWNvj5VU0JaFdXrTiR6P4OzxRelMSDaU/SoHcoT6S6KQGLPEvJfFGdQ==
X-Gm-Gg: AfdE7cnI+D+sGoeVBJttei1ihuJvdMHH1PgdxjmU/JxGfjFUHRv7UQDBMEJMheFonbz
	5bqi5HnvwMQx0JAxMdd4eWwlIkV6kIv6ZlAqjgHNJXFAz0lZ96naIt+fZ6tvS84gR5+DZ27S4zy
	jKA5scYOMGqD8AyafEtNuADHZoI57C+zLDz7NRIrgwmBsh45eifpBB3BJRKMUCwYElpcBdIc2ms
	sMfChJi8k4Rs6f3awbMr5D09FaaUx7vQOHNk3fcSucwQNV2qTvhqHRx9vn9IPPV1l2rG5ab7r9u
	0uVdg7xr8CI3bSVR99jNOFsDpoOQvUp/0fCvXSoHxRa48gPA1fSMGjwomAXQzUgsLtjfiCtImYb
	4khMGDMQ5XxRMpN0EJefo6IcfshrUUm1tf/s4vmVbUrhMn/WqtRfqWnOQg/rIqA7ksj976Wftrh
	oK4KqKhujXnEvS8FBepgnFQ1rObGy7+K51CYVpvdVsh2HPNQ==
X-Received: by 2002:a17:907:a804:b0:bec:4a86:938d with SMTP id a640c23a62f3a-c1205b748f1mr723003766b.0.1782657326000;
        Sun, 28 Jun 2026 07:35:26 -0700 (PDT)
Received: from ali-monster-pc.localdomain ([45.92.224.105])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f47d5a35sm5699286a12.17.2026.06.28.07.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 07:35:25 -0700 (PDT)
From: Ali Alaei <ali.alaei.tabatabaei@gmail.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	lpieralisi@kernel.org,
	nirmal.patel@linux.intel.com,
	jonathan.derrick@linux.dev,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	Ali Alaei <ali.alaei.tabatabaei@gmail.com>
Subject: [PATCH v3] PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow Lake-HX
Date: Sun, 28 Jun 2026 16:34:50 +0200
Message-ID: <20260628143450.92492-1-ali.alaei.tabatabaei@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604214051.11132-1-ali.alaei.tabatabaei@gmail.com>
References: <20260604214051.11132-1-ali.alaei.tabatabaei@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Intel Arrow Lake-HX systems (e.g. Core Ultra 9 275HX on Acer Predator
PH16-73), the VMD controller reports BUS_RESTRICT_CFG = 3 in the VMCONFIG
register. The existing switch statement only handled values 0, 1, and 2,
causing vmd_get_bus_number_start() to return -ENODEV and aborting the
entire VMD probe. This leaves NVMe drives behind the VMD controller
invisible to the kernel.

Hardware registers (VMCAP/VMCONFIG at offsets 0x40/0x44):
  VMD 0000:00:0e.0 (8086:ad0b): VMCAP=0x000f, VMCONFIG=0x03b8
  BUS_RESTRICT_CFG(0x03b8) = (0x03b8 >> 8) & 0x3 = 3

Add cfg=3 as a fallthrough to cfg=2, setting busn_start=224, which is
the correct bus number base for this hardware.

Also add a PCI_POSSIBLE_ERROR() guard after reading VMCONFIG: a failed
config space read returns 0xFFFF, and BUS_RESTRICT_CFG(0xFFFF) = 3,
so without this guard a removed or errored device would falsely match
the new case 3 instead of being caught as an error.

Signed-off-by: Ali Alaei <ali.alaei.tabatabaei@gmail.com>
---
Changes in v3:
 - Move changelog to after '---' (was incorrectly in commit message body)
 - Add missing VMD maintainers to CC (Nirmal Patel, Jonathan Derrick)

Changes in v2:
 - Add PCI_POSSIBLE_ERROR() guard after VMCONFIG read to prevent a
   failed config read (0xFFFF) from falsely matching case 3

 drivers/pci/controller/vmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index xxxxxxx..yyyyyyy 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -640,6 +640,8 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 	pci_read_config_word(dev, PCI_REG_VMCAP, &reg);
 	if (BUS_RESTRICT_CAP(reg)) {
 		pci_read_config_word(dev, PCI_REG_VMCONFIG, &reg);
+		if (PCI_POSSIBLE_ERROR(reg))
+			return -ENODEV;

 		switch (BUS_RESTRICT_CFG(reg)) {
 		case 0:
@@ -651,6 +653,7 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 		case 1:
 			vmd->busn_start = 128;
 			break;
+		case 3:
 		case 2:
 			vmd->busn_start = 224;
 			break;
--
2.49.0
