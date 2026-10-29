Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301644;
	b=zkvREfc7rOGY1I6bNM+Bpwyv0Eh4ITuUUdaelWeT2fAUHoJ9gNpHrsXrrtx2zsP+KLpQ
	 OTaZLs6WtTJ/pKG4WzVMIi/ZwOW7A15RnLCj9ay6uD8KwHX50zzbyQEufhMVsnATuXofE
	 0a035R4xR+afNRCYhRDasRdjfV4XXsEBNahXWA4OS4ZVXj0sUoFh3Wxw4eAgeB3IeGm2Z
	 EZ8gL1tsXdHNVlLD5sUPL4kwKIIL9Cwzbq7Fpkj7dYgy3Se3YjMSG3jZ+Qf1FkGFQSrsY
	 C6SQobQWAQyJIv1ZzGuprxyh4XI7tX3Q4SG0+33Qiv+W3KvQ4meP9np0dHKirezkj+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oLQ+mmN5dLQLmkoJUCAuKfUnNuDhfYCRTO7wyp1kLyI=;
	b=jLG9D9BwbcLdJY2wnn5AS7Cq3VHzXir+BUB2FaiLkWPe882V5ganZCOxAAu5PPVGoTVN
	 S/05on+/plfenlkc0545eSdtk4CdUhiv0nCZwFOsFkfDxqnnJPc2m6uQa2PrKvwimePZx
	 2Xs1kz4deiLgFOAoV1mOd0ZrCqs6baXu6inbEMwAzu3xXSwSBrbI8gNSwSYykymUqroDA
	 eb7lqM4YxAPU0NWS1acVVqMrn/vR/pHAi2yLzv30lKSGflzwdzX+lbIpcFvYsFpSvZzXC
	 y8/WOToDeK9RJfPu3LBT5DjRtkLHJLRPpWqLQUhEssa/ayhfrTbz+XJZYQL/0NuToIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lsNs9LwW;
	arc=none smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967E860A2600
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 19:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 967E860A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lsNs9LwW
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6798eb0d13fso2675567d50.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793301643; x=1793906443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oLQ+mmN5dLQLmkoJUCAuKfUnNuDhfYCRTO7wyp1kLyI=;
        b=lsNs9LwWwBdIbm2FihFgxoP/fMqkuzDz9ocenyA/JzEWYK52Q6R0nyMw6B8yNQSkKR
         YRbMh3bDBWU5FpLF7oWl1GQA2SJne/g46o0VLzbEJtiflvIG21gn/+8AW75Sc48Clgcl
         XfP5O7A/S9UCLq1iUkNOzYvWp+N9tCxZZpoKNEiQF+cJaFDsNa3n424jLMynJrL+M5pG
         x//bVIyWx7WOm8wjKG0Dd0lYrzIWWRuXHTpmfKEa94d55KBXu/HOv9aSL1DL8vmpSL77
         hZSjAEO0lYcQfhXNArbWuG4XqrtHR2FTpa+sFcOggOw7W5GcHezrsvAII+H6gvVYVyGN
         NS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793301643; x=1793906443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oLQ+mmN5dLQLmkoJUCAuKfUnNuDhfYCRTO7wyp1kLyI=;
        b=CTXthz8npeX6zDEU8bWEFuVjMv4/45vcHyrKOWPg18N7ZgJvosXOPOWjrTtwN/wlZt
         ZCGVnrwUMEYQJ4Mwr3EBFTJLabHUgcVyUzre9jolqtUVJwbrfVx6+WEoH4elYaqgYZZN
         UuDi33rfCs4SdyXsdqnq9bLo7tQtlC8BHy8RcL/UWzChFR1LyoOoJmDx8C3WYHZLuYzH
         gIVjbF/w4t9z4wSB7VRygqee9iFfuhFE4RoITyfS21/PgON1HPuHig9ESxOT6xmjA/Z8
         O0W1LpWgNR2E4sIeUECp8nAblAhn1LROl2gAYqYBIul6LI1gHf+sL7PCOozBZUg3iK3Y
         pL0w==
X-Gm-Message-State: AFq9FYJyTwrt46NX4dAIzUq00tNB16A6pivuBqrBe2VtEVzuNlAFEDrZ
	daoCIk6SZR+aPQUkPRfrE4CYDOKSMj61wmOoJjrerv65J37I3GJLdiu8
X-Gm-Gg: AYBFou2yUcOLrz7rqX+WtZpV57MRdMKUrGO4/v12uq5tgGvvyY8Bc4tCmt53l3dVHcn
	DnTkxIiCFuSBy+kT1F8BT83DfQu7LLB7udKGphU0iJvgbpSFjN75Oq4ty2I54NTic1QE2TBKHOJ
	O2u6LLj8xwgVomBmk5S3uwTu4GOf7CS3L6MrNvVRFOMGaDQTdnV/L5CgUbhv9C4181Hfuirqehi
	AH6dv1tbQoyDRy5VRuXm8UpfayXAB0fZkXj+69fUc2x9hnHRKH70Ch+8MFpDARDM9Ztrb7mBKCU
	3exkE0Y7tmiLDiZ0O7AGlLiV8W7CCmfeKXgRkVryh7fxs/jgPfDb6hwS7S4P3DlG/i6Pi+ftjgD
	e7IdHXjWp8DHtHW6v6JiLaY4LYkBD3WxIR/bEODhbayYfdlx23Vxjw7ai9KLYs6lmCcby+AvCsD
	6vhBukp5J3XUHgLyz70zgDxXI84uEgym4w5479OEuv9apnN+Qn8HBPJSOYrRWUpR3oR0Y9qFuRG
	WTNqI0FRyHXURZ0vrxpHXPRnAt/DyY4lU2pIqfLp+fwHhe39jbIO89cNKyFqH+TMG2XHOZAjd6H
	NuCocceWH1REU7A2JkloRhF5AIZZ
X-Received: by 2002:a05:690e:4812:b0:679:9eb4:45fb with SMTP id 956f58d0204a3-67ba502320emr24880d50.133.1793301642649;
        Thu, 29 Oct 2026 12:20:42 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:45::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67ba3a97758sm147801d50.23.2026.10.29.12.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 12:20:42 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	Alex Williamson <alex@shazbot.org>,
	kvm@vger.kernel.org,
	Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
Subject: [PATCH v2 4/5] PCI/sysfs: Use user config accessors for link attributes
Date: Thu, 29 Oct 2026 12:20:28 -0700
Message-ID: <20261029192032.1325629-5-thepacketgeek@gmail.com>
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

max_link_width, current_link_speed and current_link_width read the PCIe
Link Capabilities and Link Status registers with the kernel config
accessors. Those don't check block_cfg_access so a read that races
with a reset goes to the device mid-reset and can fail or return a bogus
value.

Use pcie_capability_user_read_{word,dword}() instead so the read waits for
any pci_cfg_access_lock() holder (e.g. pci_reset_function()) to finish. For
max_link_width, this means inlining the pcie_get_width_cap() logic
instead of creating an additional helper with this single calling location.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
Tested-by: Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci-sysfs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index b37a285d717d..a272f8583a8f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -208,14 +208,16 @@ static ssize_t max_link_width_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	ssize_t ret;
+	u32 lnkcap;
 
 	/* We read PCI_EXP_LNKCAP, so we need the device to be accessible. */
 	pci_config_pm_runtime_get(pdev);
-	ret = sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
+	pcie_capability_user_read_dword(pdev, PCI_EXP_LNKCAP, &lnkcap);
 	pci_config_pm_runtime_put(pdev);
 
-	return ret;
+	return sysfs_emit(buf, "%u\n", lnkcap ?
+			  FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap) :
+			  PCIE_LNK_WIDTH_UNKNOWN);
 }
 static DEVICE_ATTR_RO(max_link_width);
 
@@ -228,7 +230,8 @@ static ssize_t current_link_speed_show(struct device *dev,
 	enum pci_bus_speed speed;
 
 	pci_config_pm_runtime_get(pci_dev);
-	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
+	err = pcie_capability_user_read_word(pci_dev, PCI_EXP_LNKSTA,
+					     &linkstat);
 	pci_config_pm_runtime_put(pci_dev);
 
 	if (err)
@@ -248,7 +251,8 @@ static ssize_t current_link_width_show(struct device *dev,
 	int err;
 
 	pci_config_pm_runtime_get(pci_dev);
-	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
+	err = pcie_capability_user_read_word(pci_dev, PCI_EXP_LNKSTA,
+					     &linkstat);
 	pci_config_pm_runtime_put(pci_dev);
 
 	if (err)
-- 
2.53.0-Meta

