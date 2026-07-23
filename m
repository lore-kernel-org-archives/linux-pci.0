Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236C44734D9
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826735; cv=none; b=NM/hThO6BWCIrbKu3zlG1DfQ66FN0u9r7LKXp9abCh/3pBZf6xQE/oU+sN5DzDYsqAQTI8mlDNZiprACi0BYCYnvTTdZq7oEwbr1/dXER/UcsCGk9Gwp+tCy7b7I5nMmubHWfrnp0AoToNTkGoByqrMLeZNI9hAqcPXWxeR5eyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826735; c=relaxed/simple;
	bh=cd0Adk5mNcB7erjdwBRPq4x+Gy6E248zaz50LO/zCo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NtFBOFQu78TihfgW5ESsya4UADAk6Xq2zzNxOQ1peLs1SntC1vWHnSG9MLjIIQmKd5HkviKxmrYru7e9yDinOQnsnFc6NEsGavx4fk9fBuGugGIq5S5BbDq2a0WCLAc77bH4gUXRTAR2g5knXF56KH9gkiahnt3nWT8L5UBe+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIQQDNUs; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIQQDNUs"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-382ef647e20so960123a91.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 10:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784826733; x=1785431533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vNva5I7AzbDFEIUBgp42Wxbu8b4xlloX8/TO40EkcI0=;
        b=DIQQDNUsmywH7kQzdGJ9mfotJ2ZWur06TzPaCzx3nRGNwL16qnYKY4suWVylRZ8Uyz
         YvxcwxMby716JhpsVJzKo7KQlRrTqSubH3+wtbkF5kmmQJgglX7rgB9HH9UzR9iX0vd7
         3VupRr4Oog8HKYq1zwqsqJt2Ge1/3HkvBMHiEHc1vwyO1mGM3cDbYexhrenvcxLYadF1
         eg7iHJMcYoAV+P1/Yci2VPpMB3qFMkijwdoyMj6NUybWsZoT6lcIcmcd46fM/w6kRYo/
         OB7/diZ9rQMAY5Z6rGafE4oa08YW6HdvuZ6S7SKYgnUyMUBgqw+1gyXGfNpaYg8/0Zlr
         xlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784826733; x=1785431533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vNva5I7AzbDFEIUBgp42Wxbu8b4xlloX8/TO40EkcI0=;
        b=CmYIjDJ1DK71HBSE/kyWGClsy9ktlBy+VuvDLWczRsBWFQF7eu45Mr+YEKPmmNm550
         rv41TSbySafKXJImJMns54wH7PY6jZzznwvfwJDCPpsFcYY1r0vwO5GnDiksJ6ObkRF5
         T+/2RljJ+gnmHkJIwZw7YE1KeQ1BEhwcuYwgr7/D52/re7xN0+FDKERHCue3dU3S80G0
         f8mC6hnKnfdTQBHgan4JERPTBwXY8BhhsBM2uG3xLbm6kmvc2X23wi+0FehLkAEgmJEi
         n0f9eYpTfGxM/A+xjFBRRnnucw+pzIt8g40TyYtZmQr3BNdpzBcwbUBgIQVkmzja/PIs
         xROA==
X-Forwarded-Encrypted: i=1; AHgh+RoQclR3OtNflkRBTmzbwzfjGiKfXuNwBQ4H1x18KUm1gWWOsf2ampIPXvcYIyDTNNQculW3VoUbDlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5AGciQXffa6rk9CPFffSSRLuAXfhxHByI7HP7LWObAhvXidD7
	FIF1cr0LOy6n7bW2vvg6B4UyPB1Qj5ODb9y20U1G0kQS8P9nQ4EL1QZq
X-Gm-Gg: AR+sD12KLgQRhHSuIOH5EdG6eVIcEmSJFzqnuqht4WyrWXXp4/6Ikf2O82vnwp6I3q+
	RN/DI/Y6UMsrFHxY+1ESw60/prTprtKqDryvm3UxlJu71cGlkwcl1624prlneAVeNEi17c4y+WO
	6NACy/xbYX9R2C1vOlmjCxPtlZwtCYqTundRP4TFg0r/NHMMZO6KKkfb5jv40Y1aKkOSXD9I9gR
	Kpf+cRqBZE0ObwsNqjwmQl4Df5vYRbQ0hmv3sFkGTM+HtIwFkUxWzPlNgqKUb2s+YCuIv7rbqnw
	QQRZVre2uahsQd8VEAlRHRda019eJriZLl4BOa4YIHW1Ys0+ivUlmcGRJzoTdA26Tc4fOsrH020
	od8D/1bGPnf8VCurDOVu4VATMV+7x2GOksCGRmRYy+MJeUYTPGOhlARnlI7UPeuF8QHzfxoY2pK
	TmwvObZkbNHlWLz62PQfg=
X-Received: by 2002:a17:90b:3944:b0:38e:7268:220d with SMTP id 98e67ed59e1d1-38ec65f99bcmr3945283a91.20.1784826733454;
        Thu, 23 Jul 2026 10:12:13 -0700 (PDT)
Received: from kernel ([45.251.35.26])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f42bbsm19016480c88.14.2026.07.23.10.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:12:12 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: bhelgaas@google.com
Cc: alex@shazbot.org,
	skhan@linuxfoundation.org,
	jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Subject: [PATCH v2] PCI: Fix 32-bit config write in Intel RP MPC ACS quirk
Date: Thu, 23 Jul 2026 22:42:03 +0530
Message-ID: <20260723171203.4892-1-raizudeen.kerneldev@gmail.com>
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

Fixes: d99321b63b1f ("PCI: Enable quirks for PCIe ACS on Intel PCH root ports")
Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
Changes in v2:
- Added "Fixes:" tag and CC'd Alex Williamson as requested by Bjorn Helgaas.

Link to v1: https://lore.kernel.org/linux-pci/20260723160641.GC836122@bhelgaas/T/#t

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

