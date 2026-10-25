Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792886927;
	b=nmVhIHGuDQBSsYTlPLHd8t9YF3mPKvtInL9WjkjGeqp+7pug6VG4k+FBCssM+Vcyak1q
	 UWmLl54LJddNjw6iMgkVrjCDNJfkFLygoFIrufAt9wAkEcj4gRLwwt+RCkj4Mks0IbILh
	 uDiqCenGmRMbZ0vf+Rnz+t8/5Z1zAhdHcvTpoH2LAZl5OBCAypXTB4rKr/atNMgTF3weL
	 G/S8WHGzpa8b5ef/DZGop9HifvNeyGhlEd8XZZT+gbyRXQFyYFJ54BIm1zt/bVBQ5SEqb
	 iIZRm8x2A8fyQBieNCqFNEx8ga6GtReVmFEgaEqYREDwOJFWF1yyTYdhpXaMQwm+/tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792886927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cgyevGVp9g4VgGASqjd6XW/YILwpx+wn5Xx2UTAVZZ8=;
	b=ZJNbgZDa3tECjLF3WWI8eaFtKGBZLvzcmUK9pQxH1WZGENlPOX/41e4jCO7PACmRHN5C
	 LR93cbEQ7cFzsHCc6kpNkCdX0IjILjOoy09Ool0eWTfL+S1Tc2UqULHBt9eRrmQmO15rn
	 0xoq2zmEm8xjAOFSGAO83ruY38kH9VHRhzHkum4hVC8qPDEUxQaDHX4eUkLOwU/Q/ae9l
	 oNUVjPNNnAdwMFOpPJMna+cTuEN6C4yNZdT/nwnM9zqXqm6fIeyczhn/bMZb25aZBQTZt
	 kbWRCmLq6SprVEaXHQMQhckOKU0kN9JzYQNxyeyWbt5YFNTHopoBqRsvU2Tvgb6W3Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZYkP3o9S;
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41981606A325
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 00:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41981606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZYkP3o9S
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66fca0709caso1578438d50.1
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 17:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792886926; x=1793491726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cgyevGVp9g4VgGASqjd6XW/YILwpx+wn5Xx2UTAVZZ8=;
        b=ZYkP3o9SYQFERtwy+4U+G22ixdDASO8v9r/LmuciEhg9oCtsdsmS+J/mkfwt8EW7qO
         ZEGKrKJQIGpT/7QIefLvRIAr/gyThdy+kNIeK+GYc3c0l6vKNjC8UOqTXGLfGyeapNX1
         KUS0v1kEWHxjRBjvWLEcDPK/XF58PvEw2RYxFLbkzj0vIwsbghdkqylM6YNhVHZGGsgP
         YNFMM3Zz+eneFHcsuDZAUxf3X5Mt/xJVcTxQDqUi25g5zXF4c7zVbhRHgzbjxOXkVX6b
         ifG/uKw+X1vVrRhQLMWgSBo548ZfnmOk+GaULUFLocDikU7DOIEjaxnxJMEPqTHyqeIU
         bpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792886926; x=1793491726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cgyevGVp9g4VgGASqjd6XW/YILwpx+wn5Xx2UTAVZZ8=;
        b=HIK1IiOiVNMJI7ky7nQgfOigFb619SPuZ+kEA8D6tHWcWtF/rKSrGvTVy6QeC47au+
         WIr7F9JmAjAhYZaXoLauSpz29rZKRNjZBvY+32D1y0Nv+/FXzlOLN8IEzIiqqMHzn8+E
         XWiU1jes5TFiV6L/eGDwQ02bVz62DTM3627tx6a6IXlfGW7M0t2cTzR0nJBQfQdYmZ0U
         5Ts8pSbbW9e9CWrGfCyotjJUjeIlV9ZrFvLVVWzK63wKYbaNCbVOuNLr1p46CcdIBU+S
         yVEAoVC3O5IBBHzOQqrDw7nPleUVYy+Z5YOp85ECurPHwAT20wV4ZZka6QdMx7Z4ezBR
         84/g==
X-Gm-Message-State: AFq9FYItfV2ylJBiJ29fRG9YMbW6Bg7YM4BVYNxYLevviNu/1VFu2Xg9
	I9TVYoqya6qE86bJGF1gLMJZzQEhO9/KXpWMRTOZm3GAV/eV4rMKYaZUM6cXEQ==
X-Gm-Gg: AYBFou3NEwZVETeBSGBMtxfcqVXO8WiObO9GgmPQli7XGG+yHtKXg312ANSkjbwytfF
	UaeSnh7WPWFbV3YBTPllKo+uEhsAMuFCyStWx68WoCnmFuyHlfnYWSYutT8dssJruEDSxR0Mgh1
	B9VimnRXMNTFXGk7VjaWunUd8StXXCZWGVjMn0RNNywuJ9+8Gahe4YcSAnGKnhx7x4lel92KtFx
	ZzdrLdAYFHlmFT5JHOzIEFMY9YpGUMGg07zCn9bXhvZi8jswTkrWuK6jWdrSIBts1Xic+2o3xip
	iFZI0sRXjPofM37KMDyePYT3ypUFMARBxjqmgvSJm5Q6uwC867XzWWqd/YDMswDdG5rYdZxGg7U
	SyGvWEP03QFWmaMm5MdO9Jt9FqEwUObaAJwJ2HMMPXc09M0td8nY6nEU7X5SAYlZGPcAO4keS+v
	Clr+hNGQMZg6WsPhscVn56Y4ot9GO38yGw4JHjZ8S30yqjWiCK/70jq7clThYqTYoEhe73Qt2x3
	2OYiS8B7e6S6hWbvbQ/yG0hNZd877dsnGknrgcz00RUyj+Ur2jPIR7jwTUDWl7mpFb8KwUiL5jh
X-Received: by 2002:a05:690e:4283:20b0:679:c17e:4081 with SMTP id 956f58d0204a3-67a4549f4a0mr1631522d50.101.1792886926241;
        Sat, 24 Oct 2026 17:08:46 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:4f::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a4626fb03sm1466332d50.17.2026.10.24.17.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 17:08:45 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	Nikita Vetoshkin <nekto0n@meta.com>
Subject: [PATCH 4/5] PCI/sysfs: Use user config accessors for link attributes
Date: Sat, 24 Oct 2026 17:08:32 -0700
Message-ID: <20261025000836.58294-5-thepacketgeek@gmail.com>
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
Tested-by: Nikita Vetoshkin <nekto0n@meta.com>
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

