Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA6B3B71BD
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785446167; cv=none; b=JYIOMZlltApRdxXuQWKfXnLHi8ZOzrndnvskqSGjSB19W4uADheDTTbgBAKqdKTvriztfrUNQOjKotNHhJfq9OsAm6KGfcjPa/LcrGyXqe9LAjU3PI5+BR50T5JYRTh1huZgMjvjvcAGkAGB5/eZNV4iEgQQGSTaufDWD0c+4LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785446167; c=relaxed/simple;
	bh=WG0+e1KN1nsoMOFFn5MjuvZvyoDnerqjnUnTWeX68Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APUIZ+/HjexpVA3d+AmIRsS/bB1uQl46rBjZQioug3OHoykdePeXSltNATwZbmHvy/Tv8wUqsNxla8Cfjw5t8FAHU5XPcxpHKTBQTZYG1ATPHd3iGDnhxMa30si78A3Ge905u1SEgJE8G2TqwXeW/PHYF7u7qeVMV49DhB0OBOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdANWppI; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdANWppI"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9e7391839cso212335a12.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785446156; x=1786050956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WG0+e1KN1nsoMOFFn5MjuvZvyoDnerqjnUnTWeX68Mg=;
        b=gdANWppIZaHHVrO4NaZ0vAnYOeETJRqHszRJALyTxCLTqgXFXrtYSNK//frvSJEA1M
         3XJJ9haOTo6G6TFEVFdIkZaz52Q8g5dIQV2bVosoXWU/WWUFW/93r52sljYl22mpBKl/
         2MLJqA4PXP/ZhvSSifBMiJxZWjtupSytErT1RK1s73DP0GXqpIkcM5CzcKqA+eoYZkU1
         8HpTUNx7+9bcYo5oBcQR8sogLak4n13pvrOpuY+MEVc05W3e9bhnbfFlWDdj5mvoouCI
         HnAYRTRyxcZIqKGWZbU3wEQlEpc7dIhx8SWOIQw7iUrd9xDOnXw6dWZtVg/1OHfI5+BD
         2i+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785446156; x=1786050956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WG0+e1KN1nsoMOFFn5MjuvZvyoDnerqjnUnTWeX68Mg=;
        b=F6+DRKW3xlOsXH3PqgnBZlJI65NVZ51YhIvCmYuK8uTZ8UwcT03HCiZbNCcXf0PW92
         KJIiYxfXB+kSENiJQ+SUz86LaJkcJitRhlmRJAfeq8ALpNtOArKK01zlAGJeLl8jhD7e
         X0xEv0tpdNLq8C0RNCJmA52osAJSjjvV/CrrEGBOACajb8L1Ni8A8zCdpMjZ8lvRYlVj
         cbiDci9gd39dvyDxxQBu1ZaoaocNoJ80BTFJtt2Trxaf+nBf43v2oTsjBo18zIlNJv9Z
         LGRM4qR0KmJ/J7lZslUZ3aqcceoRRVteO6XGKyIQ17yEZF7wpwDmsPiUFW2ebQTahFB/
         wVgg==
X-Forwarded-Encrypted: i=1; AHgh+Rq14sAqq03pJpiq7AhiPWtHeZ2Ty393AKng1oHXpi1kCpsnsSlEByuKqy1shCFGuTGRoYetHnqg63w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+KROuLZL8d6J8NdNEjF3WirKjD8wxA0Vzu0FvwSl5Zii/vCR
	0VIWbXalyS/yKE8jMNcGSaiidqyQ+o+kEKhmB1sN/ehLypPEDFRhPk4=
X-Gm-Gg: AR+sD13ehuJjhPfyeOmkiUJ4bI+5QL96E1qXODBPIgz3YiqLMrnuKCUIQ2ItFQdFlGb
	8OQOvqyje/fA6C0ryUC0oQG5heEdtYASaB23t/GMk4J5QbQ+kYyClpC6xBhwsIHipPbeCQEV+k0
	nQaCS3DomZACGfJqacXqaS/OMyCGDNrzNA9Zwv49MYrAzfNUjfVgnNK+FHN3vd9RfCuRAJePUEc
	7dAlVlZvFxLd1CVOZ5kTlTR+L/4J5PQnlvgQDh4vxakmZuHoGytnTgZWOQQ4toRBzfQAZP5jAUr
	uUrF6QUOwwZ+JvVGUNiQjBIevWPRbRzAtgatmxihCP1CC5fCt3FOQRpWgEBniKCkpuq91RRlibt
	ohL7SAxOHIAt25W5O6YYyTB2NIcbFDOWyA9HRM7yKKlDu2j3rHiJ5BC/2s1mRQzmH5BtBubj0HW
	vqdfL/e4cuKizdTlN+qawpHtOuEwyGEQdTtLbJgmx0ysd4tTt7JjGP/mgrsCYSR06+0ll1r0yjU
	yiuj+jRgAs83xnOS1rcBcEyVW64teyKLsleyQ==
X-Received: by 2002:a17:90b:380b:b0:387:e0db:3faf with SMTP id 98e67ed59e1d1-38f9c0abaecmr3050277a91.40.1785446155807;
        Thu, 30 Jul 2026 14:15:55 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([106.221.78.187])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7263cfd9sm36251186c88.4.2026.07.30.14.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:15:55 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: YehezkelShB@gmail.com,
	andreas.noever@gmail.com,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dev@deq.rocks,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	jarkko@kernel.org,
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mingo@redhat.com,
	paul@paul-moore.com,
	platform-driver-x86@vger.kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	tglx@kernel.org,
	westeri@kernel.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: Re: [PATCH v5 2/2] thunderbolt: Add device links for Apple T2 NHI
Date: Thu, 30 Jul 2026 17:15:42 -0400
Message-ID: <20260730211542.1422-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730113209.GF20844@black.igk.intel.com>
References: <20260730113209.GF20844@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Agree. It should be preparatory patch for the series.

I think ur ideas should be implimeneted AFTER the patch, because this
patch adds a kind-of important feature to T2 macs, and well ur ideas
are for code quality, and well it takes time for patches to upstream
