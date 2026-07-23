Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D96D3CBE6E
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784789001; cv=none; b=UBsk+q4JfGxNhgQXPfcBrcSWaJsgr+TAR5IetnhezGlVWUpMrrBX8p0vkBS5XkgKNNDpeDOmyL4gNLEiFjLC5vvQJrSwBrs31h965Ay2HZ6N1sNTwazwiLrLeCNcvh31XMRO6SPH8ns+k8FpJMHRNFXpxEboQqU6gJwU10GviYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784789001; c=relaxed/simple;
	bh=DFKhnqtY0aNYV2eR9lPnEc+ekJprQ8SVzkvbIn6H5mA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ujMPELmOjil0WxWdsr2noLIpI+NxOS71DyYTqkY9c0086u+I4EryEINieYX+3PUeAHlc2hWHD/CbpLVxthqy5qcSnH5H+9YvG/CMfIcPBQzIPV0A1x4TRAjGsHgMdC7/oYt8Y8kaH2UcgdT0XihAiemZKCApdst9wycQCFnWXys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLZg6/83; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLZg6/83"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38759bcd877so262722a91.2
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 23:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784788995; x=1785393795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iFJBH+l6Rr0QnYtUEX9bQo9WQo3rO+vvwx8dfmQ65rQ=;
        b=hLZg6/83XChXZJb89ZE0Qyc9+LO0LKJnBUxencH/yrTZVvn12T7t2ikGF0MipBzdmB
         AyZHH9mvvgRzLjHv04CAVfl3oAH164iRVBdIzEVyxYd4wE7F0pYsxmwJ2AAJR2zaj0YV
         zrnScm+VzpAOT1EzuOnvgLS5mUOMzztQ8Xy9z8AlOD4TLzZLo0Bf/ng+FnKrsnLB0Nc8
         ZndYS9M63pmlMV3Rrws+TiWhHFHsyNQJZn05MGgQnJftC/nykOnUvx8Zkj5oqDWNx36b
         93crLnhXn6nwmmmlAMv0I2eC399uWh1WjL0lnqINc/EwxDGU5qc53cMUzQphG0pLVzKc
         tJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784788995; x=1785393795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iFJBH+l6Rr0QnYtUEX9bQo9WQo3rO+vvwx8dfmQ65rQ=;
        b=oT+t+07PiuL7rFTQrxtW4/LQKgjXmpsFiGLOFwTo6LDZ4pCbGi6OOYHf++uMmjSUY9
         H3Zvv/kf43mHxlPlro7cVBEhQduemwUtXECzx2/1ZHZw+AB2PY4u0w+4D7Qm9FrXyG5d
         uX333N74HYMxcJspoV0gLQlnCV+ZtGCXe/+HgPPWekWgsIneyvFfe9una+1ZN6d+XVwg
         mdQPs3Iv5r9sScw/6aYO4D5ew5ixQPJm+9FCWL93K8WXob5X54/Mq788wst4ddkfbUPe
         HAXwLk8zcfxZkzZLjwa+t+WF6+ZWuc/F7vemoP6Qu1q2cLPRf4keA3iWEU9Td9e2zqAF
         pXag==
X-Forwarded-Encrypted: i=1; AHgh+RpLdFjkTSk/ESRy2OqbOIq7JI1u+z7eFuVDzmT3F4zCR2VB31Z4LEtXnT/9Ds9yTFJOIRKf2BW9nSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLLug86wxtbaIs1hvb75XEDpp0H73w4GwUdv0W1cmTXiCVSb0q
	qfnQYewNjba5qOlUvjLDJxPrHaRMYnSSPji14tDYTadCKS3b3otfMI6p87wIvDaTZMU=
X-Gm-Gg: AR+sD1105C/wm1/RaZJ2qBTFvVRIiUn6aFUqDfEZEkl9E2mY7E+J6oDIDT7vKRKFy9m
	5YvtuHA1vFcgrPemdXlfk558R5uPeiMpQZ3AcHXbtuQaLM/O0yJMy9hHLdE9PyiE8r2esWIBu/G
	E1Kjbk86F8W4YK3lNa6HzDux5epjOA+lG72FfCD7cwR0Bb9x6osfjB3C0x+HIC8yHJ7toc61rsb
	xr0BdlSIccWvQxkV6Iw9N4mq1yJGUFSxfVBtEOHOf4ZNymnNLmVXIqHNFp7SkHUS6ZxBux1Ytv9
	97nmT1Z1akvHZ1yyRvp46iGHpk7Ok7vZMeg5yJJKhNTb1nDlIGr/Sk8r/N3SHKvSpTVAzuIpdCC
	DmifImsJM7sigNq3nVB7UfCfDSFvDScGlRLaYAJpi+7LQM2rDYOg8eHYBzqkl3h9RyYSEhrMPQL
	b5L9XP8pbt6KYv0aiPam0=
X-Received: by 2002:a17:90b:4d91:b0:38e:76f8:fcbf with SMTP id 98e67ed59e1d1-38ec6a842b9mr1661047a91.31.1784788995132;
        Wed, 22 Jul 2026 23:43:15 -0700 (PDT)
Received: from kernel ([45.251.35.26])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130ce035sm12643420c88.13.2026.07.22.23.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:43:14 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: bhelgaas@google.com
Cc: skhan@linuxfoundation.org,
	jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Subject: [PATCH] PCI: Fix 32-bit config write in Intel RP MPC ACS quirk
Date: Thu, 23 Jul 2026 12:13:00 +0530
Message-ID: <20260723064300.8081-1-raizudeen.kerneldev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pci_quirk_enable_intel_rp_mpc_acs() reads a 32 bit DWORD from the
MPC register, sets bit 26 (INTEL_MPC_REG_IRBNCE), but it writes it back
using pci_write_config_word().

Because bit 26 resides in the upper 16 bits of the 32 bit register, a 16
bit write to offset 0xd8 completely drops the newly set bit. The quirk
logs that it is enabling IRBNCE, but the hardware never actually
receives the command.

Fix this by using pci_write_config_dword() to ensure the full 32 bit
value is written back to the hardware.

Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846f..0d0cf6f86173 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5361,7 +5361,7 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
 	if (!(mpc & INTEL_MPC_REG_IRBNCE)) {
 		pci_info(dev, "Enabling MPC IRBNCE\n");
 		mpc |= INTEL_MPC_REG_IRBNCE;
-		pci_write_config_word(dev, INTEL_MPC_REG, mpc);
+		pci_write_config_dword(dev, INTEL_MPC_REG, mpc);
 	}
 }
 
-- 
2.53.0

