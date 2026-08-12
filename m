Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1924D370AE5
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786502844; cv=none; b=jtXASOMGZ9TcsMap6J1uAypMJf19i7g5CX6DjJHLCVjIjD1XY4NMtOHHW3YN/XhG1XlNyPrsz99tlXRu5jRqw8IMxvTiW7SWcpvXtGiVyKqaUyZbIF4MCL4TmblINaVsrNxAuWD91nk4zlcjfBIkTQEAW+8VO3/M287j/4wNeoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786502844; c=relaxed/simple;
	bh=ALDw7ALpx5kPUnaKuRpbZ57cF4Us+cKtY0dL1YT+XOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dm0+522APFARO+DAtAKr4OCJSY8vTLMF0NdqlmhNngmaVfYh2grADNowbcaOzbQm5RxqbO9L2AckLxPeSjRDB2+LmyXxJPORti6lrPImLWYkMkpYwT8Z0ROKvUeZ0IJ4iH3BYpPrPjldixZcw78A1Et4Zbkxjy9gwEJoGlfn0zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1zqhm9u; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1zqhm9u"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-caf45fc5202so312593a12.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 19:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786502842; x=1787107642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aAuLpf/tdgMm6ZPBoW/USWZ/wPE2gVwN/uVbw8U/1z4=;
        b=K1zqhm9u0HxVChqxW7X/q5+D39PK3smi375aNo+dyp3hg0/blUiUFQhGno5rVfIEaK
         b2hvw3NSPcbKG7sSPOjhI/ITP7AVJMGA+NnenV6d5V4LC/IyFF58eOMLk4ZKUFJ6/rXO
         TDh8JyhFH6YNefKJqzS+Z2GJ4BkIVJlwHBUj36bRQq8jnWmAlZMvASj37faRSUS1n6pC
         rV4bsEipn4NQI/9xS9AnknPhGRHH6nIzGRDjQePjBjpS0VFaAH8uBtyosh/n+QTooEOP
         z3CjvNpYO2ACD19nauQsVLOPThiPAD1qi7tIfHhRE4erLM0KYQRkm+0+TXRAT5vXuhgy
         4PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786502842; x=1787107642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aAuLpf/tdgMm6ZPBoW/USWZ/wPE2gVwN/uVbw8U/1z4=;
        b=mXc9aYKSIc7lCye6pTQ0RbJYvQ0VUO7F2LJasAOJGuwuQvpXVnj3yHF/iPUTJbpMKz
         VCuz0gNCoq8Hhp31FrcgpWOICjK62pxPo8RAXe6QNMQig0QH456YSKpyWq+gLGfElAU7
         4dvEQNwjk7fwh/t6py3r+rt5v5zm36yOu1UCUR2b519fnKjaHXeWjsAe0j/k2gbdKDIq
         hnjetokP9ZQRueHIZP4QzpaqJQAusIcG2YhDSNf2KiraOf1CQ+fCehwEtzDdvSGzoFCX
         QtmkZA/kipTD/qjRU/3gu0rmlcfkZV9NX6CJ4ZZpd3oRi9AW6TuuhyMVUOiI4Iug4jlA
         ksTg==
X-Forwarded-Encrypted: i=1; AHgh+RpSRO3pjemPTZLN6P+0jKUF2REoop/venDKhKpVIxoZhKSNmKgYVibeJduEwJfXUZqHrUCYq2uK82o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcfQnC4XJ6TNgFUFfRcPABXWquiTZZ3bwx+xvfsG4v6f8jJhdo
	BhjtwVQnk5b5msB73zycwiSD6vFY1wQQLazu5sbL4rJDQLv6AGP6dPG5
X-Gm-Gg: AR+sD11HUiE03czba+tCpMmzHomNm07cyiTfpy3ZjGLYWs+Ft7ytptPQQATLu2pEyAX
	P4YCOJxmJGMbq8XnD2NQW8fup0EFaNN5X5U1QHFOCOikWZLoRD1QsfX5cQiejSHtoHsbLxhfTQc
	ZEVi4/GtO+nhQu22aNJnAKYQHLyzZCWLsbpKGLaBbfmwWEbzRZW+hODwPvOf8ZO0cmn+1OYPsW1
	c4HoRfHWML52Q11kkOjpQORAOHY4ant75+3vUXk/T7PvMYuZTUUmI0QSxTk0KtS61radbLgQ4tP
	lpndHoX4I+7uXTSyRel/ffwPK9v6BO9c+XNU55cImRkpwKdNOnSDum6XYp2evquJd8cGd9b/UHJ
	ibAacP34ojwDW7gyno3aTttsYp+ceT/JEvc2MUIrkvjcWYE9ERf0ZvdiiXAjVDdiY0sx6uXa0dw
	05cXTSqalWZBPvJZ27dKmB3vLGKCnIMEVuYXGWc6mQhoKaW0JQHLayABkUceb7m+XWRId5BTT/D
	fbwvgihjg==
X-Received: by 2002:a05:6a21:350f:b0:3c4:2b8b:e88f with SMTP id adf61e73a8af0-3cc3f520e14mr1854571637.5.1786502842272;
        Tue, 11 Aug 2026 19:47:22 -0700 (PDT)
Received: from kernel ([103.219.206.122])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf67912d0sm6965188eec.24.2026.08.11.19.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 19:47:21 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: bhelgaas@google.com,
	gregkh@linuxfoundation.org
Cc: skhan@linuxfoundation.org,
	jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Subject: [PATCH] PCI: Fix use-after-free race in pci_find_bus()
Date: Wed, 12 Aug 2026 08:17:13 +0530
Message-ID: <20260812024713.4958-1-raizudeen.kerneldev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_find_bus() iterates over the list of PCI root buses using
pci_find_next_bus(). This helper acquires pci_bus_sem, retrieves the
next bus and drops the lock before returning the pointer to the caller.

pci_find_bus() then uses this pointer to check the domain and traverses
the child buses via pci_do_find_bus() without holding the pci_bus_sem
lock.

If a PCI bus is concurrently removed for example via hotplug between
loop iterations, the from pointer passed back into pci_find_next_bus()
becomes stale, leading to a user-after-free when dereferencing
from->node.next. Additionally, traversing the bus tree without holding
the lock is a race condition.

Fix this by iterating pci_root_buses list directly using
list_for_each_entry() inside pci_find_bus() while holding the
pci_bus_sem read lock for the entire duration of the search. This
ensures the list and tree structures cannot change while being
traversed, eliminating the use-after-free.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
 drivers/pci/search.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index e3d3177fce54..f50e83061b76 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -142,17 +142,19 @@ static struct pci_bus *pci_do_find_bus(struct pci_bus *bus, unsigned char busnr)
  */
 struct pci_bus *pci_find_bus(int domain, int busnr)
 {
-	struct pci_bus *bus = NULL;
-	struct pci_bus *tmp_bus;
+	struct pci_bus *bus;
+	struct pci_bus *tmp_bus = NULL;
 
-	while ((bus = pci_find_next_bus(bus)) != NULL)  {
-		if (pci_domain_nr(bus) != domain)
-			continue;
-		tmp_bus = pci_do_find_bus(bus, busnr);
-		if (tmp_bus)
-			return tmp_bus;
+	down_read(&pci_bus_sem);
+	list_for_each_entry(bus, &pci_root_buses, node) {
+		if (pci_domain_nr(bus) == domain) {
+			tmp_bus = pci_do_find_bus(bus, busnr);
+			if (tmp_bus)
+				break;
+		}
 	}
-	return NULL;
+	up_read(&pci_bus_sem);
+	return tmp_bus;
 }
 EXPORT_SYMBOL(pci_find_bus);
 
-- 
2.53.0

