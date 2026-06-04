Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0226D383C97
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780609270; cv=none; b=nnBLLT1PY8TNSQ7RMT7E1NtQgPQvEomDEuDfF94SVBR/zkjwwXmBGTbIXRuD3BuQ9e0xjUJr8SkNVsn05+3tbZSXKHi9x/17HvXE4uO3tEXjWx0xwxlbYorHTZFu9lml64bBE26smiWn9i05EkeHb3hhpwtr/8axIrelOHcCUck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780609270; c=relaxed/simple;
	bh=iwrswBJVKTwLA6WOK9Dd++QjAONk9nR9gcKya6+ACTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1eMqy7AuFcVUrKcAZ4fNjW5JHoLeX17vMQP/AtsTi24u500LNlYhgydqiONf8mCCzd8nFSl1ti6ijrqOLiP+1+hQX8mteRBp7+FU8TP8iGhk0wYcfFyJxuM0W9tfgCDGpWV28Rmxl7vleck2htdV3Ba/hlsZsnOSAA/hRFsL7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8uTjZPg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8uTjZPg"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bec450b950dso179397866b.2
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780609267; x=1781214067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfcxoGDaJILvxFVxDFDsHjuia9nA8l/j+nI00h06Kto=;
        b=m8uTjZPg7uYzkp8EbrQpFe+/Pa4mDuRs7tWYKWGZ0d2UnBNexX0zg3+KMTEohuR4bV
         saiX2CgbEi2yMlmHlO1cQMHOZqa3dg0VBF+Vr2RLEkpjOoNNb9JBMpbbJyeCPuhkfEFa
         a+hZoEsQftoKvyt5yZv6aeQVpVOXeSYZGITPNtDtShtg/rjOIaiOvslIDFOd1xE4jrr9
         2kZ3r1kGMi7canNPU4pBeM/60SUcur8DXfB6t4JnTfMqAW7dbkdWi9ucArVa2oo3V4jw
         itnHN+0/rWWjCKEPy82BS/KN1pxuh/w+tlVZT+KnubRLgDAMvAiSn6hyrJ4LjbjpWTl5
         m78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780609267; x=1781214067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RfcxoGDaJILvxFVxDFDsHjuia9nA8l/j+nI00h06Kto=;
        b=BA+IGgjTDP29ndfjVBBRglc0zNDXrZjAr39mNNnaiBQCS1p3w4sfNUEeeLjpON8NKs
         loFZItD0tdnEg5YNGeTiGAmrsZROOpYxg0qHitAr5ssRNWUWHa0RoPIBRVc1FfAYn6K/
         U4skKd12QjhvolASkSYEfd4pnKun3KXquPwFXFMua1hPvfW3pntHeOxPEGPztaogE2YZ
         zZLyB8IKqtcA+9v/eLCGGCaPoUxL6bFLG5LTCPHS4neF9iaMsEfF7NfiRv587OLXmuSw
         7rbHWu4ibimit+BY3LWntX15LGXLpMdj3kxdD3FSkKmiWDS0N2Oyoe35VuYjaJ6V6YiR
         Q2kA==
X-Gm-Message-State: AOJu0YwJJMPBJQJubMDuFjHQSTOJcP/7VZxvlIALHT6cbIWjvwy96mDu
	Qed7z/o1pRtHO1etekLF5EdhtP2b+4sp+as8pUpS7IVf/jMpnmykbmQ3ntJtMToDeuU=
X-Gm-Gg: Acq92OF9F0JNld4ZLVbz7RCr/PHC+Ldrz8GTjoPaUT2kvVeAgj2b0s0q71TviLppoCB
	CYaqT3NUuoxPmZfiKkAQyOKnHv/4J9H+Gkmg+ytZ7E/22bW8QUq4+zQtVGeLuKYTp8B+nBJiqdb
	Hexq+xKntGK8kYh4iYsDYivoQdCy3P540LmeMArimxgWaZTCKJ2jFjmZIQYavZLGML76DKT2yI7
	j1WTqN8Nqv/0Yk+FgV7Rwd+fEloN8gcmFrEkY7LEPzDRTeA44uDYOr8OctpKcVtaNVIEMXvqfEl
	YZiKOwGfla+zsIykEQeFREyZ23fl9v5uwGJQRx+mldW467ynk2mNzP7U8OVU7BuzzqVS1uyk20C
	vlRA0kNOPz/fefIZODNx67csijMK6dVGTVcuAaaEKtj1vc/jmRHtFCPXRqaQdpURj86JzJJjKw7
	tHiiClwZi/Tdoao7xbqoyxRQXLvY22g0lfqEYPqb2krP+WSDwdkONx7R3849RRUzHRBFA=
X-Received: by 2002:a17:907:6e94:b0:bf0:550:d9f with SMTP id a640c23a62f3a-bf372159fe1mr20930766b.31.1780609267139;
        Thu, 04 Jun 2026 14:41:07 -0700 (PDT)
Received: from ali-monster-pc.localdomain ([45.92.224.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf05176fd20sm371173466b.7.2026.06.04.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 14:41:06 -0700 (PDT)
From: Ali Alaei <ali.alaei.tabatabaei@gmail.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	lpieralisi@kernel.org,
	Ali Alaei <ali.alaei.tabatabaei@gmail.com>
Subject: [PATCH v2] PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow Lake-HX
Date: Thu,  4 Jun 2026 23:40:51 +0200
Message-ID: <20260604214051.11132-1-ali.alaei.tabatabaei@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604185953.17177-1-ali.alaei.tabatabaei@gmail.com>
References: <20260604185953.17177-1-ali.alaei.tabatabaei@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Arrow Lake-HX platforms (e.g., Core Ultra 9 275HX) use VMD device
8086:ad0b, which is already in the driver's ID table. However, on these
platforms the VMCONFIG register's BUS_RESTRICT_CFG field returns 3 during
probe. vmd_get_bus_number_start() only handles values 0-2 and returns
-ENODEV for anything else, causing VMD probe to fail and leaving NVMe
drives behind the VMD controller invisible to the OS.

Handle cfg=3 the same as cfg=2 (busn_start=224).

Also add a PCI_POSSIBLE_ERROR() check after reading VMCONFIG: when a
device is removed or a config read fails, pci_read_config_word() returns
0xFFFF, and BUS_RESTRICT_CFG(0xFFFF) = 3. Without this check the new
case 3 would silently treat a read failure as a valid configuration,
masking the error instead of aborting probe. The driver already applies
this pattern for the VMLOCK read in vmd_get_phys_offsets().

Tested on: Acer Predator PH16-73 with Intel Core Ultra 9 275HX
           (VMD controller 0000:00:0e.0, 8086:ad0b).

v2: Add PCI_POSSIBLE_ERROR() guard after VMCONFIG read to avoid treating
    a config read failure (0xFFFF) as a valid cfg=3 value.

Signed-off-by: Ali Alaei <ali.alaei.tabatabaei@gmail.com>
---
 drivers/pci/controller/vmd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index XXXXXXX..YYYYYYY 100644
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
@@ -649,6 +651,7 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 		case 1:
 			vmd->busn_start = 128;
 			break;
+		case 3:
 		case 2:
 			vmd->busn_start = 224;
 			break;
--
2.49.0
