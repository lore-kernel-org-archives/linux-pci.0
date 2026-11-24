Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795510256;
	b=bGrR1SRTEzHrBsHIDCBarXHlA5FZ/Kvk32c7rW3QAqzE037OgQMYMApYioidfUe6SdIm
	 SlwGFoHZvSbFe3iYdtNJsC8hK3Tx8HMR+4fM/c+7RrSlDwXvxIDwza4NV0JV5HV8koHHf
	 5HcEF1dYOsFFM/1HLohq9thB8b/RX+n571Yug/7amkSzmQnEkSEjiv+/H4mcCHqSZf9nC
	 GRrtrtOr6vU4lgodQnfyFMailFfNc3f5wmVayjauNcT2rx3Xacy6+9xQ27J6tBWHaqeBd
	 dxnkhbAcPGt7Qz5SULL6+eIOEhDQW3chSJw6wZlXm1JG3WI7olQoSdWrEk6pCO7m9iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ad/K9RZ8sjTi38+Gyzvh9/ZX8PvYSN6LWjOvymfH5Kw=;
	b=1zF+7T0eRSOVOucteKau4ydLISLi5f0u+feaAzrxWZTXaCP1170rcdl+r6oeKKY7EMPQ
	 D4DOhNqN1ggdB7XyWx5sgu7H7VpUqMDrxb2+/A/jJnuePtSaOfpKstGmiuT8BNYgLuV3m
	 A6IcV/c4PTH2GA62p7MIZk1YI+TsRIucR7CIjtXl6eD69rdHlcaqvMnWKJ45kfymo59hU
	 1zrvlytKENmxajrl1h/eTZUdgKTNL/jHFD5bGR89Unet9gKmzrpbY+ntHumoQ4oHIgExC
	 exAf5sMwp2et945/q83g/G0i5lwsbged7IZGODuOcrHDLkDbj7l0USGyRivgHGV00Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fi09bL4N;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2496606A321
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 08:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2496606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fi09bL4N
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so36455015e9.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 00:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795510254; x=1796115054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ad/K9RZ8sjTi38+Gyzvh9/ZX8PvYSN6LWjOvymfH5Kw=;
        b=fi09bL4Nu+P4qLcINKdD/gVz6zffLlsVwuQ8SOkfniyHUxDHZQEhIwfN577UvZsg7N
         BAsSj/b+p75J6GPKBCIl18T9gkOsnJFUDbkTZVNa08eJM5ZAbj5BtmNjH0x2YUJ2R2O+
         Q2SU5bHstC699qqDLaUXcObRVaC0Q1w3Uz4apNp9bwAU9STQhsCiRAnPRLXy/j3399Qb
         zJpQHwttnL6eYhl9ZQWjgvu01Eie0JNHqGsoCnIPx4yM7w754j6iJ8jSoQr9nLBBtXmL
         nI3Odpk3XbIb6C7MrK8vQ3VRr4gNrpuMvX8buF5r8L+b2Es1Ckgt6XmsSCR6MztIaQDF
         lovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795510254; x=1796115054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ad/K9RZ8sjTi38+Gyzvh9/ZX8PvYSN6LWjOvymfH5Kw=;
        b=pKmXvjd8MVJ9yGeAXepdxNjIbjuYDQ/skrr7WscP0Lf+3SSMk/84DhTrF3kxW1wYfM
         PJgiABbdsWeTIKvJg0QHvWNylGzVEfE8XLMa6lNCncHtktD4Uapl34beG5Qp+nbpT7Qa
         65eF0J4xwWK5O3mEjMJ0WvaE5mLy9t9d5BbnBwZV9V9dZLelhhUxr5WcQdoBNxhWux8c
         w6PNnSemLwcdJKYcljrGMvtsSyL/LUXgKKw/RIGp6BpH8tmBbbSsQHctBIfoBLb6JiVj
         V+YjHDFg+jKp28dXohqVK26ff4HANSEJcjltaoVUN7toXGSrXjHZWqh9Z3nL6c376get
         ac4w==
X-Gm-Message-State: APuU4Z95baktFIHesUernbUW3BQWkZqc5yAwn4W/1WPdB2siU6gnkVqg
	0R/qHsjLoZXhcXq/SSPBKBmXFe0/VvF6c/BVyz/OY3VsqaEnYAVQQ+ODRTM6EPER
X-Gm-Gg: AZFdTZdyB0DEB3bqB0ZbVsLI/t8bsIjt8AYnRqiv7KVkEEnXOuMxPWy55EjnQY/GZA4
	IU2WX2r8obbf4IA3jEJXNokqmNe7Wwq581c4FiXh8w7jbd4rfaZXGj2VqJTxyLNbEOgkuZcpZTR
	pjtAnV3o5oOTE87/QXeHpRDZ0GqCGi/sCKNW/4yW1Bu+cDzAJgmC/8wzDKMZZeyIQxTTj+WPA5E
	6LJIMRFY9V0FaaHAEoHw1o5H8m8y0TzfwtqDv85+D0LFDVVI5fd5jzvLxNInGuN007PRYkPgrex
	dwoDocMtO8Tze2LqshPqQmQyyZv4+H3b/u10XDZK0TUDX5BBsu2QAIkKprsO1lWpjR9uC8m/9sO
	on2/ZHwAn+pEaTJ4NZnKwpUKQGDMa/9AwbFcMAaIh2pjxpw+MNWKG9e7aUjwKLKOcJUJXuWixPW
	fk5o1DA7kqdfKakySH6g8z06fdJtlp4uZcFZvCsEdJqydCk7yAkM1YrwD+0mjWQt7ml9/xJPoAy
	3KEcKnv6nn4gFPmtom8yLefIZcJM1sXM+vFX+Q5DcX/UFAXVm/B+PGNb3PEIEV3dYfT8NTqLiYQ
	FLl+ZmjBLLXG3x4spwf6QjWm0/zrF8IStr8ZckZ9p4kaMhAV08+8EYabXv5qHPPVK0oOg1xhvtu
	yl8wVaTew6rAWQiNWTKXPp8EkEniDWCyvvi2b5UO5+elWCKtfkrFV+cXi+V90SHaCk4d41FziM7
	fNHwwOxwDGDpAP9FAEI+j/BlYGEu1fqxIG4XXTPD92QYhsNoTtVDE2RN788guMaaB+WKCxK1Mpy
	biXwAzNnYsWsf45sp8=
X-Received: by 2002:a05:600c:19d0:b0:4bb:65ed:b55c with SMTP id 5b1f17b1804b1-4bb88824b18mr287431895e9.33.1795510254155;
        Tue, 24 Nov 2026 00:50:54 -0800 (PST)
Received: from coder-gsekar-hip-hyg-new-69bc66c5b4-skkj6.coder.svc.cluster.local (ec2-13-205-193-176.ap-south-1.compute.amazonaws.com. [13.205.193.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399d52sm407308165e9.6.2026.11.24.00.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 00:50:53 -0800 (PST)
From: Gokulkrishna Sekar <gokulkrishnasr@gmail.com>
X-Google-Original-From: Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	mika.westerberg@linux.intel.com,
	linux-kernel@vger.kernel.org,
	Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v3] PCI: Correct PCIe port type field encoding
Date: Tue, 24 Nov 2026 08:50:38 +0000
Message-ID: <20261124085038.17299-1-Gokulkrishna.Sekar@harman.com>
X-Mailer: git-send-email 2.56.1
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

set_pcie_port_type() validates PCIe port topology and corrects
invalid upstream/downstream port type information in the cached
pcie_flags_reg value.

When performing these corrections, the code updates
PCI_EXP_FLAGS_TYPE using PCI_EXP_TYPE_UPSTREAM or
PCI_EXP_TYPE_DOWNSTREAM directly. The PCI_EXP_TYPE_* values are
decoded port type numbers, not values encoded for the
PCI_EXP_FLAGS_TYPE bitfield, so the corrected type is stored in the
wrong bit position.

As a result, a device whose type has been corrected may subsequently
be reported as PCI_EXP_TYPE_ENDPOINT instead of the intended
upstream or downstream port type.

Use FIELD_MODIFY() to update PCI_EXP_FLAGS_TYPE so the corrected
port type is encoded consistently with the format used in the PCI
Express Capabilities Register.

Fixes: ca78410403dd ("PCI: Get rid of dev->has_secondary_link flag")
Reported-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Link: https://lore.kernel.org/all/20241213070241.3334854-1-gthiagarajan@marvell.com/
Signed-off-by: Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>
---
v3:
 - Updated Link to lore.kernel.org
v2:
 - Use FIELD_MODIFY() as suggested by Bjorn Helgaas
 - Clarify impact by describing the resulting PCI_EXP_TYPE_ENDPOINT
 - Add Fixes tag
 - Add Link tag to previous discussion
 - Add Reported-by

 drivers/pci/probe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f..4c7e0ad1aa1a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1673,8 +1673,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
 		 */
 		if (pcie_downstream_port(parent)) {
 			pci_info(pdev, "claims to be downstream port but is acting as upstream port, correcting type\n");
-			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
-			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM;
+			FIELD_MODIFY(PCI_EXP_FLAGS_TYPE, &pdev->pcie_flags_reg,
+				     PCI_EXP_TYPE_UPSTREAM);
 		}
 	} else if (type == PCI_EXP_TYPE_UPSTREAM) {
 		/*
@@ -1684,8 +1684,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
 		 */
 		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
 			pci_info(pdev, "claims to be upstream port but is acting as downstream port, correcting type\n");
-			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
-			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM;
+			FIELD_MODIFY(PCI_EXP_FLAGS_TYPE, &pdev->pcie_flags_reg,
+				     PCI_EXP_TYPE_DOWNSTREAM);
 		}
 	}
 }
-- 
2.54.0

