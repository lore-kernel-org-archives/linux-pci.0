Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301641;
	b=On04mVCu2gAbtaNq/gyVvCOGsPO905c5C9XEeW77apRqAXeaxs+hbVFmgGgILAexVDbe
	 kwOv23EkpO2hsCX3HeohxN7XG3e+qHH01TiRubFGoeo7hH1pnQHRN0LzKrxCAiCq52L5p
	 2xFa2awN24zwiDl/daZFkF8g6KhLPQaVxX8qCYNblRJyERM977eE/SH4zq/+W36fAQtBH
	 y7Gxi8V6566M0xCgC61EXyIx+lBg2eKn12wHIQN8TAFrcbxlmie9mEUcEfPvlUlf2baBg
	 DRunDeDqSW4z/1tMrPiV7Nh0s0f+gffaTY5fbupAHz8ElLoxykXFGVVEf0oK99Mhbbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oo07AymxXKphZjVTkZm9UuDYPtSNG1/pfgaxaGNq8To=;
	b=GmShVvYwyal0ekH/WFPRTyyRhhuvyMJ+JzQ004ypCU0oel1Cp6llVRCfrddbCL6BtFkx
	 iX9IglyZZ/x1dr77ufdiu2EIxB2G5689yrlW5sZO/taAFECzGiS3fpC+sYMDIEAyGNbCX
	 /NGi6cmo58RAauO03X9q9x7Hn5Sig/ppQejRKfoL/InUCdnmTRhG4Zxw3L0qKRJPSDOAw
	 d4H8G1bMBaiAc34UA63X4yiQYGI7pti8uq/+pDQgCSxdzcevMf9eWMcPoJ3hGfrr85ixk
	 l0MHW8s+RV7MrcwGnRFUWcvpk0p/yWZtsYB75pCr9AKkir41sLXli6nIp4CuMFohBCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x97OqItx;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE007606A331
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 19:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE007606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x97OqItx
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b125371596so9303697b3.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 12:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793301640; x=1793906440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oo07AymxXKphZjVTkZm9UuDYPtSNG1/pfgaxaGNq8To=;
        b=x97OqItxM0zTlU1SeqXVC4Vhbt/CfmrDOfg8uezTolPAJeuA8wroLbnXN26YCMiQBF
         Suk3OxZmp4X6FdOJfB38LR+WlWTiA4P8eRG7/ZyQmArInsG0aKLJ0GyM7qTaPc3vJuCq
         7Sonh1b5Gu7zlAHMta36NDBL+DmVu4X9QNZ/f9uVFY/K23cQk9+SxzvPbTlBN1RJ/axZ
         Fr6h/4LXhVC6uJb1ovaP56MOa1RoUHMzfuEo54lEDclSiNC3VPaRE+23cqVGRkvR1rAQ
         iyISuOthySarKzuajCYAggn5Ee7exS7sD6LEiQePbozzygzvfiQ2xd7KjRbzMCvszWxM
         sFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793301640; x=1793906440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oo07AymxXKphZjVTkZm9UuDYPtSNG1/pfgaxaGNq8To=;
        b=cQzaX4FiW9Wrb5PbH077u2yqBV4ze1qQt2BDYL67/njAiD1vXrUTKOvw2RQjDS2d2A
         1cuoY4yVxgQMV3W4+ofeDWdgdloBr4Kn0wIXff/EzS9ne2Z8GTqhC1I/ZuSjgORxz0kL
         0SiQ+oclsy+l8sGwUF2ktnWjyRPKVtMaMOK8GxeMwkc1PU2NkaVxdZraoTCDkp8PxnrM
         44rKJ41RsueAyTN0Dm3elNPQYVvowGCjHX0KGki+Mpgf/0F4pPPr4M9ek/fDSF3r0aSS
         dxUJrxFsuhZqXW7nKtH+5AmwB/ofVoNz6WRYwndh+pyObDEat8uPJY3Py+KpJxD6Dqz4
         VXNA==
X-Gm-Message-State: AFq9FYJYNLhHdPMh2S0PT2Pe6vOPKROs2X+rKa4EnHclqFm6kPMADHF8
	SnFei1C4WjQvy+W5Z7AlfzO43guVV0GPuHso7h9aIZIT1qYn2V0auCh4
X-Gm-Gg: AYBFou0R3CTd0+zseGuO2jDeKsrtzil9mZjI3pBEzvQHGuwomJHm+5rLmXJ+d4FtZeM
	nNcPYf9oxGmuQCEMEEw+MNWoFJduoTRWiFI82SSupC8Qiq3zEF0Mv8k15udgs7MKEb5S0Oq9PkL
	LxgtVDUDI6WoMhjpUg4ODJOiMlIv0r1Uv1dc/Q9uc46qnTPUT5wCD7z8OwDEue900LJJouqCYvm
	7t/Zf2S+xMWkotCkx/BgGAjHuhO1cn2mzOSSuNWznBaCbk/D+gYvX+TwyGRegO0sSwJ8hEd2QJu
	uvmWFXwx+20h+rsWxSbdJhJ2Pqzu+Iwlj4F2r9x6+RaEdBddx7IxjXhtf3j0EskvCy1eLjixgCb
	MyKQphz9/YrES2HgSCyGyao1d4jI4y4/Dnez7cLNc2Q7PtLZhjZkkYYSyX8B0xVOWUTL18pxfCz
	NFOvj5d7zzKvhiJkH9OV92dTELiGkeO+QMKFu48uJL+a6LBKmQrzmYweaor/rcJ3BOKb8BGghUh
	sx1rg19UyTEuWbGuMQ1RDPBoZI8YUyshwRzzss6uEjjhrpb8PRXgDTFKgopj5kCWvnFrTYht5kX
	ZJdK4KLU6aqgFDX2tka5jVPQxtpa
X-Received: by 2002:a05:690e:4594:20b0:679:97d1:439e with SMTP id 956f58d0204a3-67ba4cc2978mr56192d50.2.1793301639027;
        Thu, 29 Oct 2026 12:20:39 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:4c::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67ba36dfbf9sm166228d50.2.2026.10.29.12.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 12:20:38 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	Alex Williamson <alex@shazbot.org>,
	kvm@vger.kernel.org,
	Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
Subject: [PATCH v2 2/5] PCI/sysfs: Use user config accessors for bus number attributes
Date: Thu, 29 Oct 2026 12:20:26 -0700
Message-ID: <20261029192032.1325629-3-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029192032.1325629-1-thepacketgeek@gmail.com>
References: <20261029192032.1325629-1-thepacketgeek@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

secondary_bus_number and subordinate_bus_number read config space with
pci_read_config_byte(). The kernel config accessors don't check
block_cfg_access, so a read that races with a reset goes to the device
mid-reset and can fail or return a bogus bus number.

Use pci_user_read_config_byte() instead, as the "config" attribute does,
so the read waits for any pci_cfg_access_lock() holder (e.g.
pci_reset_function()) to finish.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
Tested-by: Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6669e9ad5bd3..b37a285d717d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -267,7 +267,7 @@ static ssize_t secondary_bus_number_show(struct device *dev,
 	int err;
 
 	pci_config_pm_runtime_get(pci_dev);
-	err = pci_read_config_byte(pci_dev, PCI_SECONDARY_BUS, &sec_bus);
+	err = pci_user_read_config_byte(pci_dev, PCI_SECONDARY_BUS, &sec_bus);
 	pci_config_pm_runtime_put(pci_dev);
 
 	if (err)
@@ -286,7 +286,7 @@ static ssize_t subordinate_bus_number_show(struct device *dev,
 	int err;
 
 	pci_config_pm_runtime_get(pci_dev);
-	err = pci_read_config_byte(pci_dev, PCI_SUBORDINATE_BUS, &sub_bus);
+	err = pci_user_read_config_byte(pci_dev, PCI_SUBORDINATE_BUS, &sub_bus);
 	pci_config_pm_runtime_put(pci_dev);
 
 	if (err)
-- 
2.53.0-Meta

