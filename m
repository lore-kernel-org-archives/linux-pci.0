Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792886923;
	b=wZYTmmwT9jp+cz4JPu1n1VOH/0KG1RyuqN13096iZNovczdtzkJw9T8ENosoV6lqpRLn
	 MtrtiwGEE55Bs6VcOrEGEOcPhiBqvuhphWeHuZ2wyWUBqJsrGvsypCHsKZhNGiYPCtUXF
	 0La9h2STwhYXIaHV81Jqyr2Bq5rIXYcwlqFp1JSlw9cKJsJM/YAlMen2XGDGsFy2r/XBK
	 6ATf3OgO+XCqlw8yLKPf1oU+NxemIQyiRkoMc9P1NElR1ag16MREToAxd2ZRWgUdlTSUg
	 BtVNfcIKjPRMKbZ3EUaF0KlmskBagvC5yCnF1+95AaU99BO8w2FJOgJM0dAAixPZBJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792886923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pPVrxLHgw9uvnWkIbWwQACs8ELNvhdEnjrajTTffzFc=;
	b=ecxZdAr9h1HOapFrNY0Ow1Fsc5nbfooEK89ifzRxKcIe3HcnepeW2qxf0ULu+mBThbsZ
	 QLC7DZqgFYkyQPcc0b6DfnHKBdSYYpqJg7lUUNqjBk5Km41npH0osYClygCuqQiW2mTem
	 u6vh6VObhP7lk2wO9xLrYOvfqq/Mo8vimZjgOXt3C4XTZjb7IiO/ZSnHSZrnxUhqgTmcG
	 g9Y9a9d9aT8l5sWpFcrVduJpgPfCrdGuYFIt5aWzXw9vUF9FRDspCJM/p48IkmSIglmyO
	 0aZ2cJUNAe/mfu2dv3DoPizlUKyBfBW3n5rRLFEL4JYrO331f9s6h/Y9JGT0N4hQNyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DichRZ6h;
	arc=none smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EDA606A323
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 00:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61EDA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DichRZ6h
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-677dbe051d4so1646715d50.0
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 17:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792886922; x=1793491722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPVrxLHgw9uvnWkIbWwQACs8ELNvhdEnjrajTTffzFc=;
        b=DichRZ6hJkdUXVfBKrhYXbsiCL67VTcfIrOWgv+u8W6Jd+P5WK3cf5Kp0rMNuSwEFZ
         6fEwgAMv3OHfxXZQwVdewFQ6VKY5WXwFB40tMqVEFc4y5+5NEqaOHyo72zJL4EkDxwWY
         ZPtMSbPdoJUknVF0HPe5G42AtUzUeaq5K2dUKQ6IzqSTaKaqOT936cXXz9S0HdEGqPRw
         hjnbNdQTY/z6ZUUi+IlXyaH4meZBe1Lie847+AvLXvLlqI1AQfbXi4UiQqi6YS8XN/SY
         eLM3/rMZ03Lak192bARgduabx0G8XTnNbeOp46NNJoMJQtSDpV5o/R7QKPX2ZQxAApFx
         j0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792886922; x=1793491722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pPVrxLHgw9uvnWkIbWwQACs8ELNvhdEnjrajTTffzFc=;
        b=AvLc6Eb7tuT2aGlZZkJj8/RiA+Smdr1dau+g/V5mxjV79Pb8rzm+kP8+6Y8XQ1u76d
         YnWAEzRpSLIgxIOM11Js+bMewZ52J4kytzR+My1ODbH88D1V2e8LCIzMSh0LkCDlPoSe
         33WCVvf0Q29whcMP5bqrGGiGqEpJLLr3syDx/qY4vTex4iTo7vvWE7l89mwizi5as5mv
         jb8zauxePksdbqNg96Gtb3M5JfSJDnwRSsw2yIxqmSDhu3d0NdwPUAcyQ9rOXtUiNZaP
         nGRuOcXFMsCVSHrNmMrRKnhX+oEGefp5bhzd52o4VeEkP/hQ8Zm2hgaHWEs/2zvqlKm6
         XVpg==
X-Gm-Message-State: AFq9FYKPneJrwWgl/rYu0P9lg+IvEelrMx7oeoYzrTbo2SzhwejSYzkR
	sEvEkapCIuUaGNbxnWZkmJsP2Z22HuDPi1bWxg4nT6UDTh0aYVEjjnal
X-Gm-Gg: AYBFou2W+HwWZlY+Of6WZhAXL6t90bx2X61Owp7FphPEEigGTLshBGs66nmJBcZK9qe
	RG+fins8eSej8FGcZCHc5uIglpynECaya9hG0z/lPXJ6bwvv/CiybXPZMbG3lDK8Zw8r2nyoCpA
	XUoqpUtImWkCRPsb+H/bYnPnsGCOYmHWGj0qYjg0PYOr8F5pvvRnKj5cAHGlLiW3gF+IOqghiGK
	K5xkX39EzcIwc6UPc8kni64rLS82acsAEf6CP0qtlI+ib1nVYeK4RNa08H3tOaDGwDVFhKsdgPL
	VhDu+Q0P7xugjoLMJTDEVbEivxMQCOzY3o7byhiqt1deJF1yHTuCdt/AEige/reWH6VsHwRs6JG
	49joa0NFjL8K/stoMFV8wynUNMoT1PuzROSm4kgpBqh7JCaASsFA8vF6Qike96OQaZvb4liPdoa
	F+ysQ9bXqHv6zP3CcTtZr8ZNOg5pjkGchRAgTqtIL6ISqua3/+44qj4Yn134CmjrEr2+CgvQpIu
	meVF+xWMjmxaHoK05GbkszhTOFYB2djiqqZ0c0aAiz+mJeqfF8OPU0=
X-Received: by 2002:a05:690e:441c:b0:678:3418:8cfd with SMTP id 956f58d0204a3-67a455397cbmr1541589d50.104.1792886922563;
        Sat, 24 Oct 2026 17:08:42 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:4a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a461a715bsm1511878d50.6.2026.10.24.17.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 17:08:42 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	Nikita Vetoshkin <nekto0n@meta.com>
Subject: [PATCH 2/5] PCI/sysfs: Use user config accessors for bus number attributes
Date: Sat, 24 Oct 2026 17:08:30 -0700
Message-ID: <20261025000836.58294-3-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025000836.58294-1-thepacketgeek@gmail.com>
References: <20261025000836.58294-1-thepacketgeek@gmail.com>
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
Tested-by: Nikita Vetoshkin <nekto0n@meta.com>
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

