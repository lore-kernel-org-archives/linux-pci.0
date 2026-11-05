Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793913857;
	b=bIdZGfgkPvtYa23n+Wb2rP54t2++dbJkuWYH5sguJGDDwLovcVe356LKn8QuuS32lEVa
	 EPOnRYnFG0Yj63WlkszkJpqeSe6ub1KMoLXchwqIQV/30IZ+4QYqMQ+8n99VUlicQ3QT7
	 nHBK5ONwmvaA5Fcq712hITM6e5hVY9vtlSniwDmTNiEU1dlxGpbhYRxJRoWX6OGNY4+Gx
	 lllYyeU73265FgzwfqjpqCyYdrQMiwt2NT8I1CGzC/aD0XQTquviLDDmEqIgCGjYA9y//
	 so8Q9inycvbJx+Rk0s+0arA9ThoWDG3Qcz0XzSSVhEQ4Ypk98vtP5zGmySCyq1tQQMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jXM9i0x2nDS9j+rZWPBPawv/gGcnm2DhRQRnMf6xoMc=;
	b=QbSAJB6+1oKVFrKwTNn13t1FBNP9IUCHa1Ijr43QyZHisbg64GehpJ3fJV19IY0G01FD
	 9O5AkM3RiqI6Fo4YRZop2vFTxixqaRL9eQXa8Wu/qYzVqCdKBlpYhhSCICPiaS22bI4do
	 QB9u489FTwUs3OmIQ4C7yJXuDQsctL9Rga8hhOBH5JN3zuaA+zMbUOR+7H1Ik5VcDqb+x
	 CZe1xI+/2NroxfRLptP9kLh4IG4uopCTH/9kcGdVvOTi9H2k24HXOa0r8KP4GvStRcNKP
	 6BSAvysH4nLEFR1050kBoHwCR0QPy2Jwm16UdkkwQC7tiBQNyWiB27hzZZjWA1lTcUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=riscstar.com;
	spf=pass smtp.mailfrom=riscstar.com;
	dkim=pass header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=fKiUei81;
	arc=none smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F05606A328
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 21:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03F05606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=fKiUei81
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4f66bb2ab57so913580b6e.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 13:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar.com; s=google; t=1793913856; x=1794518656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jXM9i0x2nDS9j+rZWPBPawv/gGcnm2DhRQRnMf6xoMc=;
        b=fKiUei81luLqDunXx0uXFyfzq9l+RZI+4d7jsR6KRIGot9KXcyMSJK2FTExt6HmKcc
         XntdaeBJc1d6fqQJnymjqu8PKa8fc4nYa4fqG7eX/JsMdNMlJnBVy852Gh8q62ybyEOb
         mZVzq9KFeNtxxmgR8LbklUU+QhZ8ilj9czecGgSv+H09YZU9A32RfbQqILHXzIh4e9dh
         5dR32UkV6vDAqKEp9NyMk9BcmFHAH2R3cEK5NXPu0IIf8stJlAoD184ByPZS/ZR04p4Q
         VKvSyERo5fEQrYpfPL59OccEBoQY79qRWWj6eXQqoBCRb04YtKG9ffKtcUyypXJntSkr
         schQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793913856; x=1794518656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jXM9i0x2nDS9j+rZWPBPawv/gGcnm2DhRQRnMf6xoMc=;
        b=GhgS10jSQ/bxxfyToIBqpmwvLPOs63x+hMYdA/KWXyeT0pELQylIuoBJbxDb/8ftii
         M7GBBS0XEKyZVNcjgJwxM7AHOsewXdXlVtMWZ/Z8cdrBVwW9CCtc0L5vK+Uhexof/8C1
         p/7wNhcde8XJ8HGyOnodZ6EI3bwDEi3xyZbMAxXFdQ0uFedV9KTxGfCqeigoOR0kPxZp
         +Km8cOvbBvCiGRk9FZe3K/+TJKzBYnomwrDco1xYv72dgTLVpNMRmyIOuoXYegNPVEvW
         e++bgSPxcff/kEHyE49V/HKTLccxdtzALUQbLXl2o5b2847uobCu60re6KJSHPSnlczF
         ZwoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwu+U7Nd/ffmuuKa/236UKxeRDzzy6zcFR+zMK9RbVLUGzIbudehUkQM2cVO9ROh1ey96u/TqsH++Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VIlblKAqzUYOVT6R7KcHaUNxJDyeOMUdy/4fA8JU2Y2/wjxAS
	aB9f5Zo7BDHQb1MQ+SdQtv+z3qUGU8TWXMm10+TrpPlWnta9UDogyd9D+eptSd+P+Aw=
X-Gm-Gg: AYBFou1tU7IdQlnaJui8Z6fmEAnEr/y/Eb2rlgVos0s6bZE5tRtZm6XmOQ+FFfJxWTr
	vpVVl650R4R9qoZDDXwKmlJkvHLYHVSLQH88qsIzHgVEjGbWeUPiKNgrJCj1cKHcHHuH+Coi1/T
	lk+7IcoBo1gwlUrf8bI2G1rflftRcX8zWVVoTm4VCZXQL8BvbASPf+V3hC82lGKmotDezfIdkwp
	5E0ODtb1dENqu32roYjpo1IIVWiVK1rmD+FwiMOMmReBQ8B58M424mcbZ5CIECIE3rrmvqnh+Lh
	LTs8OU7D3w0GNochdDyl9Bffn/N/AJjLVxcvMRV8av2+/HczKKqP6CD9afWXm6Wr7Sh1+RM71w4
	Er6vmMwzmFhJCEjgi/5CLIWwS67wa6dWEebjjDx++3dPVqmJQp3qtr/Z7t6TjrCntBrL6ohY5RS
	+/bDrZraKG1OxEwxd8ZhWIXCqTbhMgWYDywkm96+d+beGmnPXMOXcpPf2u63xV/DVSdm4CdPhom
	H29Po1tDJ9nA2bI/VucrZjLNvH9IcLlbsS6roJX5FtyA+wL6DcE0DqOx2DSVKbFFZ9FM+5mZjy4
	ddQAwlIs1ULdOf0jR3nV8U/NHyEErxiGFw==
X-Received: by 2002:a05:6808:14c6:b0:4f3:6c2b:5f22 with SMTP id 5614622812f47-567e105f241mr438912b6e.29.1793913855869;
        Thu, 05 Nov 2026 13:24:15 -0800 (PST)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm5349897b6e.3.2026.11.05.13.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 13:24:15 -0800 (PST)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] PCI: of: update endpoint ranges dynamically
Date: Thu,  5 Nov 2026 15:24:10 -0600
Message-ID: <20261105212412.591931-1-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
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

This series fixes a bug in PCI devicetree handling code.

If a PCI endpoint function is represented in devicetree, and it
implements a PCI endpoint bus, its ranges property must be created
dynamically.  This is because the PCI function's BAR addresses are
assigned during PCI enumeration, and a static ranges property cannot
assume a particular static BAR address matches what was assigned.

The solution is to dynamically generate a ranges property for PCI
functions defined in devicetree that implement a PCI endpoint bus.

					-Alex

Note: this series depends on the patch "PCI: of: drop the reg_num
argument to of_pci_set_address()" found in this series:
  https://lore.kernel.org/lkml/20261105153801.435566-5-elder@riscstar.com/

The entire series (based on v7.4-rc1 and including that series as
prerequisite) is available here:
  https://github.com/riscstar/linux/tree/outgoing/dynamic_ranges-v4

Version 3 is available here:
  https://lore.kernel.org/lkml/20260924222444.1351466-1-elder@riscstar.com/

Between version 3 and version 4:
- Dramatically simplified the description in this cover letter.  See
  earlier versions for a more lengthy explanation.
- Dropped the first patch, which allowed a null pointer for the flags
  argument to of_pci_get_addr_flags().  This wasn't really necessary
  and didn't really add value.
- Indicated clearly that Andrea della Porta has tested this series on
  the Raspberry Pi 5, which uses PCI endpoint bus for its RP1 chip.
  The current statically-defined ranges property works for this system,
  and when the necessary PCI quirk is enabled, the dynamically generated
  ranges property works correctly as well.

Between version 2 and version 3:
- The ranges property for a PCI endpoint with an existing devicetree node
  is only updated if its ranges property has an empty value (i.e., it is
  "ranges;", or is not defined)

Version 2 is available here:
  https://lore.kernel.org/lkml/20260910021919.3421449-1-elder@riscstar.com/

Between version 1 and version 2:
- Included the first patch (which was previously posted in a different
  series)
- Modified the last patch so the ranges property is updated only for
  PCI endpoints having at least one "pci-ep-bus" node
- Rebased on v7.3-rc2 (and the prerequisite series)

Version 1 is available here:
  https://lore.kernel.org/lkml/20260813220717.1394644-1-elder@riscstar.com/



Alex Elder (2):
  PCI: of: introduce of_pci_build_prop_ranges()
  PCI: of: introduce of_pci_update_endpoint_node_ranges()

 drivers/pci/of.c          |  97 ++++++++++++++++++++++++++---
 drivers/pci/of_property.c | 126 +++++++++++++++++++++++++-------------
 drivers/pci/pci.h         |   1 +
 3 files changed, 173 insertions(+), 51 deletions(-)


base-commit: 8c786803613eb0d3352417509611d1db877c65af
-- 
2.53.0

