Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888242E738D
	for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787411283; cv=none; b=EnkO8zVDWR4SQPdZ0WTl+g+kO8EtPxN6+uaUYt1ujA64+RYCTkIStXy+sinXnbXJccVWbfSUP1g09eHli1z0Z7mmvdbnxzJ42AzCN6F2J6aAOzmTZSiA9GyHIWzO75ISjtBWyKc/x/KkHLurhQdagqwOSet5SdhyecOnMV9TYtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787411283; c=relaxed/simple;
	bh=fM/v5LfJ7wD6zkHTL7r/iIf5dy1yBXXY+Csxk9byOzE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yqo50Iz/t2ZfnrTBWUfKXxpb+WMQJhfDrtvk91isarqynsoOGXNpHpAu03eCy4+2gmatYedRHu5uQltPn5xUgFax6wNuo8QJMRKUEOLrEX+HMs03Od8ojKMeTkqix6QStWJm2HGNzUK8y0b1ulrxXbsp6Bj4LUMgjp74OC10jVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDIxLJM8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDIxLJM8"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso1528998b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 08:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787411282; x=1788016082; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fUMtOGS8zyhBJC5CYlKc1rnb8z62m4Hv9NO3LFP4g2Y=;
        b=cDIxLJM83DTuFH0987g/NmIogO8F+QzWXE7WdlEOkZePM7PDUpqhVdzhC3H48+bC/o
         1lS/xUqJxghkE/2kB6eG7QRrKJWrqTCw3oEdIuwpxL5QpNNIrVqG0SoOIyMNRea7Q1yz
         sF8jphwSINgUlg53Fys95xDmJSEqasJB0ehbJGsZNT3Qb756lA6EoCBDIjVSlFW/D2AM
         NoJEn3mAjLAPOXRkmuJ48BpCX/l/u0QzTL9IaZ8/MDydsJ66Ofal1KLuEDgUdVCVAjMU
         9TDmJLGzdOmd0QPpUR/uowbwc3uGpW0/Yswv8f7NXkTWmF/lqgRA22XmmnsvOZZHTAs6
         h0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787411282; x=1788016082;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fUMtOGS8zyhBJC5CYlKc1rnb8z62m4Hv9NO3LFP4g2Y=;
        b=V2/fPN0OBmJvnZ1KWtTX6OY45bYXPWe93BuhAD8lvj4txITcrZKQ1XaU/K9DPQz2IS
         /ohaRxaYx4TJgKUDROCzhWbbqLxQbvROHAqOSV+dMeijx44n72jgsVi1BYr1HfmbyNbD
         goF+XfAIkMSZHOH4kQds/WvoBrgQyk0b+DvdstDM0xYEGOLMpKLnUeIF5nwalKGBYqfJ
         XDvDhdHsrQl8j0aD3So1U7QLXV4bKFvcc9MOta+po89F/cft40ethawRzYJ2bqxv9oMb
         K33JwwaCnOsvyZYub947rdaJifqG1oHMaHGDXl5xZNBxJ0y39U6vYcl+5JjL7etsrUSU
         DhbA==
X-Forwarded-Encrypted: i=1; AHgh+RqdtWVHRbwfsSp52yvhE7IwMCZJITgP2/IS8OdbZntUXH1L1iPUfzu/W/H3XGmdpZAvYo4l3nHls5c=@vger.kernel.org
X-Gm-Message-State: AFuF++m7v04V98HdVAjs0bChH0/nsFlzm6UmgnDcj/Kzo9dRiu3zFJr3
	Q8I4EiZfmJZh42RzzlMjVRin+rtrC25agQrfgcEUMhP5SsIKyFNeKK2f
X-Gm-Gg: AR+sD10l9Xih7ePRZ5KciS6knMZ4TMnKphi+TxNaHsxzbbIWsTFU8+z3c1cCTkcQ3FE
	XBYKSkQsB7vaQ/SU3JSNe3FGU+x9yjaFexKP5G+nscVrPI4IW8Gd19Jo9LxsnDAf0HqkOTChQxE
	ptCsx95uvDSJxkaIPdM8utOBlyfrQycCpOhGcJXhdmEHIkprYQOrVPhDuZzUz3jzsizQsoOJKqO
	q6aWcivnrunH1JlyC/yENUC5oaAMm4dGxjqv1oZGhvDKVSj6Y5V3AYT+m3eeSaAPI58Mnq0My14
	+HLbh+Sgyr6Gg/4iqVg7U3BNZxyVP50/QDv5oNi4MMd58lmmYeQ5X4QxTfFAofj/bBZrGmNUDKj
	neEmCd5Uux9rkjpJmzS6OyfpD5kuo4oE6mzzYBiToRtcMntSrkwta+mdVdS3CVB0iaNWeVnuVKp
	M3PC7EnYmR1Au3+LrOKCxgdOnkWtH3eM4S4ZvD8DmYJPJwq5W8GTl/uBNYIRheXxCi0pTD/tMym
	DvKf6MZiJ+jMbe1MVA+KKNAgoOyNHaMCYJdGI5qQA07VRRql+QLVYDR
X-Received: by 2002:a05:6a00:14d0:b0:848:42d0:bc91 with SMTP id d2e1a72fcca58-851f9f95fc7mr21277878b3a.12.1787411281658;
        Sat, 22 Aug 2026 08:08:01 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f03b1ebsm628242b3a.30.2026.08.22.08.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 08:08:01 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Subject: [PATCH 0/3] PCI: dra7xx: fix resource leaks in probe error paths
Date: Sat, 22 Aug 2026 23:07:46 +0800
Message-Id: <20260822-dra7xx-v1-0-23e204d5548b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEK7iWoC/yXMyw5AMBCF4VeRWWtS41qvIhbKYCyQFmnSeHfF8
 kv+czxYMkwW6siDoYstb2tAEkfQz906keAhGFBiIStEMZiudE6kSmGuSWeYKAjxbmhk9x017W9
 76oX6413DfT/2cu1bagAAAA==
X-Change-ID: 20260822-dra7xx-39925beb4219
To: Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sekhar Nori <nsekhar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787411275; l=537;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=fM/v5LfJ7wD6zkHTL7r/iIf5dy1yBXXY+Csxk9byOzE=;
 b=nRvz5HHIz8g2YI3VEGB1Qw2A519Mv7ta0J4annH4nPc7wj0hYrfySM/gTClQZT0ijV6yohPmy
 pjxILiQUbKNA702EBlHiLsSmzd0RTyknl08z/9SNgFtDLvrdsbDqwip
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Felix Gu (3):
      PCI: dra7xx: Fix clock enable leak on probe failure
      PCI: dra7xx: Fix device link leak when devm_phy_get() fails
      PCI: dra7xx: Fix device links leak when dra7xx_pcie_enable_phy() fails

 drivers/pci/controller/dwc/pci-dra7xx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)
---
base-commit: 903c1cf6dff9964e71eda98a39e2e5d442050472
change-id: 20260822-dra7xx-39925beb4219

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

