Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E3D34B437
	for <linux-pci@vger.kernel.org>; Thu,  2 Apr 2026 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775168300; cv=none; b=B4Pdii8KDvyExG6S9UyRiA873ZTTCYskyBZRYiGLHGVeEwkv7pZEWgVVdAZVau6qgi7TaTGZgYz2u6oRYkqBSxS7lH9P3nLh/JknQYjT4O2TZEtv9Y4Q9eBMwjM73npa4zdiJn1ZmUkoaPDG57cEkV59p/G7lK2Vj6EKkW2m7qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775168300; c=relaxed/simple;
	bh=ss6SBO4aBnxZfQtgA58c8zVrUCdwWva/CrkOsUnHsXc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jqrx8Tys+GSeoDt/K0+FjthzF1taV3BKdulAl560+ioagQM9aEHYh6rXsnOFnd4BiQ/+hKV4qmB7zBkwXgeow19ByphexGzKfOsseYBDVpqjXdzQ/2xShQ/IxDRVCFJhsqlfJmsdpGxf1p1zCFKYIsycltMx/yQKHF2XhPUET4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsNYtb54; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsNYtb54"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48891776099so14319505e9.2
        for <linux-pci@vger.kernel.org>; Thu, 02 Apr 2026 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775168297; x=1775773097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DbIp1ob/MgbLUlDr1JF2AIWekXiUFRu+YrNw5NosV6o=;
        b=jsNYtb54jVsaacCdNUNvnudksp/3MPqlOCgkgAFDf/isEzdjXo2nSznF6UgohIPnGK
         I8SALRnAjhrI9gehCuX/rMqBbu09sdR0kE2qKCQlvCajQgXCk65Gxicd0lGJICtEqdNR
         jV4E525n49fo389jf5kX519zMYzIa1x/VfpZRn6jD5ah0b2ZMVbFV9OOtCeDkcPUjPw6
         TM3jb+C4YSgBMzVWNWhOgQcLuwkdg4Lp3FoTghGe9UDvX+3PNreMAdn0QjeJH7WHHZKg
         mEjgyJBmwHqobi/yP8sg2PUjLuv4E/V6WQTi8I++sYE6IpdGcPAUZK9k1PtAwPv7cpXu
         pMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775168297; x=1775773097;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbIp1ob/MgbLUlDr1JF2AIWekXiUFRu+YrNw5NosV6o=;
        b=QMR6Dke789hU32Tk0FViEA/tVKarrMWXK57P5w0zABS95a/kv3Z360ZDd3X5+PnmqW
         vlDlmfTeVlUbO359Cx4EOCFiVCCk5LosnxWnydNhGBunhf7xzWt0gNdzJfieKOmFmVcM
         hhKPhwBiv07pXQsf1d1G3TGJEtiKzKmC+FDp10eL7II+/KTydq+CKadanJC2pFZRECDP
         7kgrJMg6DrIizRZTfKinUsGzcb91e24K+9GNZGQz7N7D9TZbhnsDJvjt+z4cC3rDnucp
         4na4OTWpcBvvY/EwHBZ76dkXwRaolwcJu5o0Hix+cXD3pUbulmveEa7OgzYHojbghJaJ
         Lbpw==
X-Forwarded-Encrypted: i=1; AJvYcCXTYSlMqCOz6BeSBwqAhWsIWFQAnhuZCdss4gA18gBOq0dkbTrVueRjYJRjdq3p1dKmEcFAtzbVOLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt3trkFLFDs3ozpuwNQ6kxv0m10GURdvpE9ZbobawB408vHcvz
	41pRaavqHhBjlmFLvpg9f0hZ26FzQDGyBrBX+EZq+gzMHZVZOXpjtPIH
X-Gm-Gg: ATEYQzz8BiYb7DvlkoOQke9Qb/sk73lGB7HoM9UoBVy7qAvqs0P232oTz9nOA3hG+sd
	fGLbhv81pYdubXBBmZ2GzBUYkIjoXcbXlNb54N67GIi6hvnvlcUNImHcpQv/BxBx7lO6mxKG6kW
	CPJvtbAZ8/b47kV1lRhX+t7n6aed35765CvP2sL1PsGpzPxrdtG4QMuFoH1B2F5MUNd27swiPSt
	EAWPBYm2VeW+eUC8GD18x9BdJzrYV8CAKX3x13C+la9bvmcJp0ivdzkWIGvRfafBX6gcm9C94G7
	5y11zpBJbSQji08iTRXpcT+9rDohLMeUCaMWuD9qaOnPqnxZnnGtfZFasrKh1gaaWAwzqKEIVdv
	OQG+WayXzD8IrEOqoB5udTSB9pUx5vKzLkUuHW1CkPjdJPSXxU/hn+uKpXIEmujGORuq4bwQAbr
	4chwbx6uW1ZPdUoZUea6dWcr+taIFLnRFWsufTVUY07VeD2muFUvP2QV5l5JMMzqDMi6nHGJeLJ
	wytSLEe8zqFzQm3REpSefQbmdQNfB2sQYZt7YqUDKZZSWky2tWUDbMeqa+2ZzWu0Q==
X-Received: by 2002:a05:600c:6305:b0:486:d76c:fa57 with SMTP id 5b1f17b1804b1-4889978da75mr10428725e9.17.1775168297272;
        Thu, 02 Apr 2026 15:18:17 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f19:9500:c168:ad27:2fdd:9334? (p200300ea8f199500c168ad272fdd9334.dip0.t-ipconnect.de. [2003:ea:8f19:9500:c168:ad27:2fdd:9334])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888b142319sm90294465e9.7.2026.04.02.15.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 15:18:16 -0700 (PDT)
Message-ID: <b0ce592d-c34c-4e0b-b389-4e346b3a0c44@gmail.com>
Date: Fri, 3 Apr 2026 00:18:15 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] PCI: Remove no_pci_devices
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <dd9ea7c1-44f5-4364-a3d5-885b1c99159f@gmail.com>
Content-Language: en-US
In-Reply-To: <dd9ea7c1-44f5-4364-a3d5-885b1c99159f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After having removed the last usage of no_pci_devices(), this function
can be removed.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/probe.c | 17 -----------------
 include/linux/pci.h |  3 ---
 2 files changed, 20 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bd..19d73f613 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -67,23 +67,6 @@ static struct resource *get_pci_domain_busn_res(int domain_nr)
 	return &r->res;
 }
 
-/*
- * Some device drivers need know if PCI is initiated.
- * Basically, we think PCI is not initiated when there
- * is no device to be found on the pci_bus_type.
- */
-int no_pci_devices(void)
-{
-	struct device *dev;
-	int no_devices;
-
-	dev = bus_find_next_device(&pci_bus_type, NULL);
-	no_devices = (dev == NULL);
-	put_device(dev);
-	return no_devices;
-}
-EXPORT_SYMBOL(no_pci_devices);
-
 /*
  * PCI Bus Class
  */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8861eeb43..cc98713e3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1201,8 +1201,6 @@ extern const struct bus_type pci_bus_type;
 /* Do NOT directly access these two variables, unless you are arch-specific PCI
  * code, or PCI core code. */
 extern struct list_head pci_root_buses;	/* List of all known PCI buses */
-/* Some device drivers need know if PCI is initiated */
-int no_pci_devices(void);
 
 void pcibios_resource_survey_bus(struct pci_bus *bus);
 void pcibios_bus_add_device(struct pci_dev *pdev);
@@ -2140,7 +2138,6 @@ static inline struct pci_dev *pci_get_base_class(unsigned int class,
 static inline int pci_dev_present(const struct pci_device_id *ids)
 { return 0; }
 
-#define no_pci_devices()	(1)
 #define pci_dev_put(dev)	do { } while (0)
 
 static inline void pci_set_master(struct pci_dev *dev) { }
-- 
2.53.0


