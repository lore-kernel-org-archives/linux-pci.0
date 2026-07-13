Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331FC335BB4
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783970121; cv=none; b=JswsEVQPwxP0j3R7krgzOcm60+Lj95SlRHDNcBEzHGixirvuekHF8WXQ+7LHFa1uhkj9vleVZF7rYD/9VT/6ES0bSvXzpDlWHV8O1Xl+eq1Xy1C9snCXa0bM/7XNKoXqJNwtuTIWoRTFrfF0XlUU8oZhrMVOUtkPjS0A4y0ah+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783970121; c=relaxed/simple;
	bh=9qAfPRoCLlfdF028Ljp49ipCizhmiMIi++9QhbkSS3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=plnTN+0FGmQGZqE0GLgNFAnTaRSsCqvbQOiw+hJ1hPFNoK/nyhNMWErAItQoDZO3VOoglHU9Ki/Q4Eqc+PeH/T6P4e33rL6rWr91XGLmJRAcpm0H7nlZ/xxL5Fsh/CCSQ2mhzuYMAwpHNg/DM2puC3gwGkeSPCgEFPmCGc6N9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAair0VV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAair0VV"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493f45e20cdso21582905e9.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 12:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783970118; x=1784574918; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/OR4pADGjSGyZmbpds3y/m2o2xcnrhWjT0awRz3wxjA=;
        b=kAair0VVNX2qILkEY7wbozUyX5chzg6RZ85JptANXBsBP3rgpWP09IpVFgvJL6SZ66
         kLjrX9rJENk2MLNUSSiS/jA2EsrGUrDHO/PKddtddnrboQcbyjY4Rs8P28eLqopD4AdD
         jg2ox9A0QO27IHYU8t6MAkLkr8ctj5+bq3HNeXiQhqNwJwAdWv64LRL4vT4ioc3lqlKE
         zKnPO3GoE/x543pzFXaUk4/ntm6iXwfDGorZxLn91b0EPoYW8i8blk2WHgJoJ5rn7//r
         ZjizJQQnPyHtMHScFXgxqsjJjL1uxFaUaxdqXfKen3HKpJ7wi5QnLfypkNH2pyZ32bZw
         Z4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970118; x=1784574918;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/OR4pADGjSGyZmbpds3y/m2o2xcnrhWjT0awRz3wxjA=;
        b=ZkjSW7zgneTcL1mrv1F/B/XodLTXYQYL7tJ9TwRNcBB3R5f5KBM+ZNhYGbuToY+5ZK
         KWbVeClLAthQ0Z9e0eEX8FtlFuqcboYyBJ02T4SfjxkgyeuZZ6+fnflt0WrkYU0HAvYm
         3Gl501JMK/OPaFZ8Ps+ZRriAyRvhR9EOfnDUn8s/i5KvACm7n9POdK3UCZZox/uiuRcb
         0YukrycfiQ6jbbtJI2GJ8GteqmBVdrGKxdBHIjkYq5W2H+Wq4QHAL0IDuhrmctxP7uzn
         +XMzNfK+gzCM9xt+nF8UO+iGTz0vsuSB5W9f4HmJprDj6JpcgZNz7iAmTVU1TQLzDI/N
         tpeQ==
X-Gm-Message-State: AOJu0YzzOZQgu/R6Pc84uY+q1hdeMJEZxYXDYFsuZYefjfy6lvI3Qbcs
	1I3NcMoSi/1VZprjt87w8MuBIWZX4Bo+1DfW4MIFgRDmdyJ52VrvujFf
X-Gm-Gg: AfdE7cn3gRLlto0jnxsm/u/bjZg+OyWgwMUIcuObJfwjtSNiUkY31AW9lisefQTlZzi
	4GmgFDcdiWosRiHDBaAVrYMHmZ6b7Z8d1G5LKo9gXR/JHIFzyTHLb5jNId7+FkkMkKdL4xQKZWH
	BBFql9I6NZZYilmMlz8YCa801227iQfX6hybPNIgl8ZQt9HS39d8WVSIz6xzfBRYlrCN97sM4/K
	f0QY6QZ0FiA9tV1nQ98rBwApYbnOxw/I1pSMvrqiRRoViN9oidM0+FRrJ7XT41sFIyGBUKzAYGC
	rEJumD40m9MIlFZ5L/jp4N1Moith+iyqUIGBsfvFsqmNh68ckLPY4h3aWUc+GNHliSlTyPYyAnc
	juPJscNH7tiREbYq0BUkYzO3eh74LkJJossI5I9l7ZkTkHC4EqGE1913TJN8rEyOP3c5CAtKrCF
	FFmF5rJCazsgqFy7Jh8xBSJS9lNVCakPIyEmYY
X-Received: by 2002:a05:600d:109:b0:493:e8bc:a75b with SMTP id 5b1f17b1804b1-493f882b13cmr70608755e9.30.1783970118332;
        Mon, 13 Jul 2026 12:15:18 -0700 (PDT)
Received: from [127.0.1.1] ([197.147.18.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495087384casm16132425e9.8.2026.07.13.12.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:15:16 -0700 (PDT)
From: D'Orus Tsitera <dorustsitera@gmail.com>
Date: Mon, 13 Jul 2026 19:14:47 +0000
Subject: [PATCH] docs: ABI: fix typo in sysfs-bus-pci
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-docs-fix-similiar-v1-1-257e25150346@gmail.com>
X-B4-Tracking: v=1; b=H4sIACY5VWoC/x2MSQqAMAwAvyI5G6gt1OUr4kFr1IC20oAI4t8NH
 odh5gGhzCTQFQ9kulg4RYWqLCBsY1wJeVYGa6w3deVwTkFw4RuFD955zDj5qfXB+KWxDrQ7M6n
 /n/3wvh9IaCfCYwAAAA==
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, 
 D'Orus Tsitera <dorustsitera@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783970116; l=1076;
 i=dorustsitera@gmail.com; s=20260713; h=from:subject:message-id;
 bh=9qAfPRoCLlfdF028Ljp49ipCizhmiMIi++9QhbkSS3w=;
 b=qBZTrDZAI/U8MO/zdGGUSoZLfnbMP8rJqXRrVqqgHiFte6AxvusdDQbr3yZZyw0O1djTtgZwi
 vIniyHe9HZCDknKnt7hSbcVOVt7WExT3RFxzoivG8vbRf7fIFAc1wXV
X-Developer-Key: i=dorustsitera@gmail.com; a=ed25519;
 pk=GqXY5hJYjkTr3AXE+gNJm9JHfxrha/aTmo6zmxQJt0g=

Replace "similiar" with "similar" in
Documentation/ABI/testing/sysfs-bus-pci.

Signed-off-by: D'Orus Tsitera <dorustsitera@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index b767db2c52cb..55ea1db749a1 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -171,7 +171,7 @@ Description:
 		all devices attached through the subordinate bus of a specific
 		bridge device, writing 1 to this will try to do it.  This will
 		affect all devices attached to the system through this bridge
-		similiar to writing 1 to their individual "reset" file, so use
+		similar to writing 1 to their individual "reset" file, so use
 		with caution.
 
 What:		/sys/bus/pci/devices/.../vpd

---
base-commit: 0f26556c5eeea62cc934fa8938b148aa5844a6b6
change-id: 20260713-docs-fix-similiar-b6b96c06f823

Best regards,
-- 
D'Orus Tsitera <dorustsitera@gmail.com>

