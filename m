Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663CA478E42
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778843414; cv=none; b=cSEcORUxRf4z+Qjp3ikqm+k6UcIK2iSA58/boCi/Lj834gbLABxXHDoblIlJxAMcsc1Od3eadqzqxwNdZYbJDn8Z+1Zk/fhC1o8An77U23ghglA7+iyOKFY1EJ85Xb4j4Yi689AeJpHMlBxJ4BPIsqbejIniWPHeukjCGDkLtW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778843414; c=relaxed/simple;
	bh=eyLj1Y8O3foCF54U8Qz86c9Ndu4lUoiNJ1e4LruAnnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGj3kdByzdsvbiSPoORe3MpZ1jT6lodJAh5xgQdmhhQGacCZOTMAGGbcra5NpeE93jZQrk4KFZyKWyNs5ik5rVnxXeXucusUVP5FDLMsUjOviQlvOoC51XLTH+vBARbOM8IP0hqznjZiUwIWwJw4RaXzSH7CYT31E7U62Bmk+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6aJjsXw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6aJjsXw"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ba21d32776so61775875ad.2
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 04:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778843412; x=1779448212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlIr2DfZQIdjqO1PohDAMuDJ1pNth5joQyu5k813drM=;
        b=p6aJjsXw/9iH6YDyNytS0udeVf0hoZS1yfFPZF/jx2ZBjoSO/wINSzlmWa59+QYtj/
         VbvIX4Xf7X7MrAUrZAjcWzgBBL0D4KgvTZ+qVvGveR6bR5JprzkN1PiUw4ZDhfRPZRhx
         rc3zgaNM546EZdhmOOAq2YElVFS854QwxMsDkEyhoovV41Bbjl777wwO/tISESnIokKq
         A6JG8tUGf5UY2VFtHbLDhjvnzJ1ksIzqWEzzJ633cI2LdG4Hb7UN5GAZ3tCcQ0KOCePp
         Q08pPtnQUCBiNtudZbyXONBXwY7DG5+MuQnNOLj/DTRa8spy5vVY0NgvIp15ilDfNfa9
         BrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778843412; x=1779448212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PlIr2DfZQIdjqO1PohDAMuDJ1pNth5joQyu5k813drM=;
        b=AB6QdETJu3SQBKvflppGX0PBAN5wXpL+W+zxDEGMFF/OdjZ1TN2U47u7jgMtekrVjG
         odTvjgJu9NTfiogkkr6UryRXgR02U4vN7X1mtfAVpULJujd3nPm6N4czqOGyFS7J0828
         B1ma3Wpbb8DDKtBxxxRFCIWJXF1kwkCrI8QyKTbOH31gdnztoNRW1kc7JydrMkw76d0U
         HtmV4TJWsl5NxObNMOlFvld1zGs9mzm+5GB2pbWNWzzTSkG5OAz0Ti4mGeUHwoNn7nE9
         PkwwyaYjvA2GsCvPwtcsy+psSGVcP8dUVGVgj4F7ISTDURI0kr7B7Fq+XA15VBDCmHnL
         Ukcg==
X-Forwarded-Encrypted: i=1; AFNElJ/dndsN32BDquFOtQBbL+htD68WB7BewJGYIotLuTcvsUftNvCpD0VoquaCocDDJsJdu5RGRPvmrAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG5kLJSvRxZqNQFPQdB4Z6yf4zR5t++E5Uc73cx9sl5Q4nFAhu
	HZZhB3ZHPtv8/IRXRHqLsvMxnBuLm5xUf3Mz4LNb55RD+yxVP6fUrnQP
X-Gm-Gg: Acq92OF693Dehzh6xBy1NAASuvC7FmuFt5cu5L2np8XspLlziMI+gjTvY3xopVd+/Qn
	sq8KS8MTJc710Au1jt8F1VBlyWqEKm/AyOjk/Te/kGlhaXH/p05ybs2FE/9vvItHydmh7Jy3plC
	kK1JO0WNzQRlzBamuFad2Xfwxp8D+FXqm82JJZrtQ+L20nzCLKaprVd9+KedKluQ/la3VeKy/mm
	8KATzh+hYmDaQr3i3M1mBVoW4hwL6fcHIhy3aVgCZ+30+5i+O9PL1rZkeE02pQW8VmPgaYReGnP
	pGEf8DW24Ej4dCEyTHgwOHI1d1WkRmMX+gRetpGEInaZEv9Ub41HNjxa4ZrtUg4M6n25BD5LTzM
	8G1jPiv5pjUiXpNm5IAJAFP5TUAFJ5sAKBOjHdD+xPaM9rpxo+2UQLYLLn6G7z8RUDnWQsjBMyb
	yNpU3LCIucXD7uPLYpIGdW5WU5aP++jHItKF5c3S/R
X-Received: by 2002:a17:902:f788:b0:2b0:61c2:8e83 with SMTP id d9443c01a7336-2bd7e88f4a9mr40644855ad.20.1778843412499;
        Fri, 15 May 2026 04:10:12 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d008:80b:a00:27ff:feb6:42dd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c264241sm54566645ad.36.2026.05.15.04.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:10:11 -0700 (PDT)
From: Pramod Maurya <pramod.nexgen@gmail.com>
To: bhelgaas@google.com
Cc: kees@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pramod.nexgen@gmail.com
Subject: [PATCH v1 1/1] PCI: ibmphp: Simplify ibmphp_init_devno() to take struct slot *
Date: Fri, 15 May 2026 07:09:44 -0400
Message-ID: <20260515110944.216993-2-pramod.nexgen@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515110944.216993-1-pramod.nexgen@gmail.com>
References: <20260515110944.216993-1-pramod.nexgen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ibmphp_init_devno() takes a struct slot ** parameter but only ever
dereferences it to access the slot's fields.  No re-assignment of the
pointer itself is performed, so the double indirection is unnecessary.

Simplify the function to take a struct slot * instead, update all
internal accesses from (*cur_slot)-> to cur_slot->, and update the
single call site in ibmphp_ebda.c to pass tmp_slot directly instead
of &tmp_slot.

Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
---
 drivers/pci/hotplug/ibmphp.h      |  3 ++-
 drivers/pci/hotplug/ibmphp_core.c | 30 +++++++++++++++---------------
 drivers/pci/hotplug/ibmphp_ebda.c |  2 +-
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/hotplug/ibmphp.h b/drivers/pci/hotplug/ibmphp.h
index c248a09be7b5..e80c45eeaa73 100644
--- a/drivers/pci/hotplug/ibmphp.h
+++ b/drivers/pci/hotplug/ibmphp.h
@@ -733,7 +733,8 @@ struct controller {
 
 /* Functions */
 
-int ibmphp_init_devno(struct slot **);	/* This function is called from EBDA, so we need it not be static */
+/* ibmphp_ebda.c calls this, so it cannot be static */
+int ibmphp_init_devno(struct slot *cur_slot);
 int ibmphp_do_disable_slot(struct slot *slot_cur);
 int ibmphp_update_slot_info(struct slot *);	/* This function is called from HPC, so we need it to not be static */
 int ibmphp_configure_card(struct pci_func *, u8);
diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index aca86c092d4a..b122769baee1 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -109,7 +109,7 @@ static int __init get_max_slots(void)
  * Parameters: struct slot
  * Returns 0 or errors
  */
-int ibmphp_init_devno(struct slot **cur_slot)
+int ibmphp_init_devno(struct slot *cur_slot)
 {
 	struct irq_routing_table *rtable;
 	int len;
@@ -130,21 +130,21 @@ int ibmphp_init_devno(struct slot **cur_slot)
 		return -1;
 	}
 	for (loop = 0; loop < len; loop++) {
-		if ((*cur_slot)->number == rtable->slots[loop].slot &&
-		    (*cur_slot)->bus == rtable->slots[loop].bus) {
-			(*cur_slot)->device = PCI_SLOT(rtable->slots[loop].devfn);
+		if (cur_slot->number == rtable->slots[loop].slot &&
+		    cur_slot->bus == rtable->slots[loop].bus) {
+			cur_slot->device = PCI_SLOT(rtable->slots[loop].devfn);
 			for (i = 0; i < 4; i++)
-				(*cur_slot)->irq[i] = IO_APIC_get_PCI_irq_vector((int) (*cur_slot)->bus,
-						(int) (*cur_slot)->device, i);
-
-			debug("(*cur_slot)->irq[0] = %x\n",
-					(*cur_slot)->irq[0]);
-			debug("(*cur_slot)->irq[1] = %x\n",
-					(*cur_slot)->irq[1]);
-			debug("(*cur_slot)->irq[2] = %x\n",
-					(*cur_slot)->irq[2]);
-			debug("(*cur_slot)->irq[3] = %x\n",
-					(*cur_slot)->irq[3]);
+				cur_slot->irq[i] = IO_APIC_get_PCI_irq_vector((int) cur_slot->bus,
+						(int) cur_slot->device, i);
+
+			debug("cur_slot->irq[0] = %x\n",
+					cur_slot->irq[0]);
+			debug("cur_slot->irq[1] = %x\n",
+					cur_slot->irq[1]);
+			debug("cur_slot->irq[2] = %x\n",
+					cur_slot->irq[2]);
+			debug("cur_slot->irq[3] = %x\n",
+					cur_slot->irq[3]);
 
 			debug("rtable->exclusive_irqs = %x\n",
 					rtable->exclusive_irqs);
diff --git a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
index c1939b88e75b..0b018ae3b348 100644
--- a/drivers/pci/hotplug/ibmphp_ebda.c
+++ b/drivers/pci/hotplug/ibmphp_ebda.c
@@ -880,7 +880,7 @@ static int __init ebda_rsrc_controller(void)
 			if (rc)
 				goto error;
 
-			rc = ibmphp_init_devno(&tmp_slot);
+			rc = ibmphp_init_devno(tmp_slot);
 			if (rc)
 				goto error;
 			tmp_slot->hotplug_slot.ops = &ibmphp_hotplug_slot_ops;
-- 
2.52.0

