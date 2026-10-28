Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793183682;
	b=yeQbRlBK9+ZNVqLe3Nqpjy9W0QgpFQuRXD27tHAa+SYapbqTlhfGOik4SObFkt3f3e4S
	 lUX4sVP/Uuy6lMtDnLoRFISCeFCdPXMDtCxQBESS2eVoVPwL/94og2JF6j9VagrBLMEPB
	 2wQLB6mhkaOIPQOj8ENyquWrb/jJpTccP3wcmw6JGIijxU+xvp0wrIgB/T9CM6Rsu7vmX
	 bJV67X7DgaamXcPgk1PUdWEt4CZJWJKN5B9J0xqf5VAw6iWzGeQfcOshoKJyQBZ00nQQH
	 MAoWNMyvAnEJbyRA++8xfIj2Z2+rSJitjIakqPR8Sc9qbTzx1cOyvV2IqC91umdqcJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793183682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fJvqHOk07FUa6s5/fD4Hq7cD2mBklo9gU81ggaCJZwE=;
	b=R2ptLMEyM3Q1IusXg2nvRR8pjeCmAMY9osJ+iFoDcK9M9YIrhIcdlBXd499wzI6jdQZl
	 64YNCouh2SmwdnQ/U0zMHVJNpH3MBb21CQ4VjATmez/SSkI3kb8HSUKD6OMny6d5M1uCI
	 Eboq/QqqNEy1WAwJaBcaQk8+MZRITvv+mMKw5GPruWWQZsbqk4msJTWPMCh4QTJYmSk2X
	 X+SikpIDJxNJAHZqtmYOut8SSpYhGl/0xhNU6QwRmvZp0Mym/Ba4IaNUagvG8SyYyowge
	 ZXNlMYy+9rAkmc3dUDWJuhBCIpHLAsF8kCBjoJfXOFnmo/zCNUgEyu5V2kn2eVmQ4nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w6jgn5KW;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314CE606A31C
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 10:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 314CE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w6jgn5KW
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3550c917fd3so1152272eec.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 03:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793183676; x=1793788476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fJvqHOk07FUa6s5/fD4Hq7cD2mBklo9gU81ggaCJZwE=;
        b=w6jgn5KWCIwipZN2DshlTNs0liLS/ACzw5DyHXPoxLQ4oTK1oEx7VkDiOvx6IILqnd
         f7nk/OB1aod2dHo2Yt0MX4QxqAYaMrQVq2/c/iRHFrbqBnQX7h7iHvYjiq+7WePyBtjS
         0Yrr5pCBq+/xEweDG/fAAK5VmgQu26vpjDup3pVI1+FiUFv83HSOKfv2+vdQ0ZryyfQg
         DHkLJWXYBp4QbA0kCOm5N/O/Kso10becOMPmaNqdHqENg4r4WhSFBo1BuRBRxJ4EfELN
         KcpqG0saxptR0HHs7zQiFmdKKB791rJ4/l8P3mnR8QpvXXumMayWED1Ha0NhdzeNavfr
         kX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793183676; x=1793788476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fJvqHOk07FUa6s5/fD4Hq7cD2mBklo9gU81ggaCJZwE=;
        b=w+CJSa+dER/cpfHCOgwZ3WRLvO+MH8pjiCcNCR58j7LUOnq20l5rnxrlwkTB3xQ4SE
         n30/Yf9h68Jqgqzgv4XGhYi6WdXWt/BLuUKeJQwCb04oGJyQ35d+p94gUVF8pCjgJ4dK
         azoGeNpGixgcUM3yFs4kaaitgUAS/0mDvMCCrj8N6rEl6//vx/Ecp8ICQhDDe2n3vtDE
         jwHrSXAO9CbS467kbgj9+U8IxSeOw2bY8jtbWCiSaBX26Gui41SuD1UCKPiScKGBdImU
         ID+HSVJ9MT+qLfSQAjEiKFTVC47YV5CEhVFEvq8aopzs40ZiRoJ/udXbRF1T1RPHjOis
         M6WA==
X-Forwarded-Encrypted: i=1; AKwUvBzBKoCYVyA0TGUlS9mxH1LZWow1dE3IJ5Z1HxYwle9jk9RSjI4S9E9ItExgYEaqDZweZF+/z8U+M7E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLx0BZd2oXbdOi4lN4jfwMnkXnTU/LA6ip9x7DijdlMM2aOCFSl
	w2g0sqb013OVplpyxMsVRnnMyFYmTfXLAMuOzs3q0RCy5tDbEXWmX+mv
X-Gm-Gg: AYBFou2eXqQJq6O+gxqUgksPDCjeWAWk+m2BQL5V1b8EH9EiA9g72Fxwr3R5H3JOxks
	64gsmH90bbs6IgsinHgHLd+IGG/3SyVLsV51kIADoDKQiJi+EJeqeQkaWSDUmDS5iGUyYRVLXcO
	oL3hnujl8nLUI9S+baC+cZEmcqnY1ZgQycWOqW9SubVxdrvEao6uTe7SCGeWj69wnr8M02gALPI
	4wWuvhXMC2Xsdn2q52gSflRtG09Oj2mhD0pRjyWq76FUS6SmM26MeXgiRveaDC3XCz79S5GLekv
	yKCeyJl+YUCY4d/zwsACBJ8vxFEHubKZ4sfCOdzbh+PxERBn2fp7nysU0fUS1AgaqcHn1hWEwpd
	sa8eERl7W0zKeZebQy/xfNUnY0ofoHwR1oLN9RKBLtDk9Su6QEziHn1sGWmT75z05sQOuLYTKUE
	pZGjMaHdCwzO/aet0wlM4gNB6YbVpznEkzghRJJzepGSX8H1ubRd0L/utXzoiFm1ptZroN6GFH7
	cFx+hpk6es3/rnx8tIASnLDSjxRTWZtrewLcOJKiTs8bvaIsMgj0sBX0LahIWC7rX4k1tnv3Syx
	B4vHPNJgpJbrMzC0bNYHPsF5ktUrihyiMt6rzbpLczgE5T1wuvI=
X-Received: by 2002:a05:7300:2406:b0:35c:8b96:94d9 with SMTP id 5a478bee46e88-36a203bd31bmr2926356eec.19.1793183675982;
        Wed, 28 Oct 2026 03:34:35 -0700 (PDT)
Received: from localhost.localdomain ([103.177.252.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2399b05dsm5723047eec.25.2026.10.28.03.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 03:34:35 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: mani@kernel.org
Cc: angelogioacchino.delregno@collabora.com,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	matthias.bgg@gmail.com,
	robh@kernel.org,
	ryder.lee@mediatek.com,
	sreekuttan2156239@gmail.com
Subject: Re: [PATCH v4] PCI: mediatek: Fix integer truncation and handle oversized resources
Date: Wed, 28 Oct 2026 10:34:00 +0000
Message-ID: <20261028103400.2532-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <kfnxuro5xf4mhokabg773zcyp7otcjxwpzcn3dlo6y3kpv4uv4@bne4qf3vcif5>
References: <kfnxuro5xf4mhokabg773zcyp7otcjxwpzcn3dlo6y3kpv4uv4@bne4qf3vcif5>
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

Hi Mani,
 
Thanks for the review.
 
I've addressed your comments in v5:
 
- Removed the redundant zero-size check.
- Changed `fls64(size - 1)` to `fls64(size)`.
- Kept the full resource size calculation and added validation to reject oversized windows rather than silently clamping the size order.

 
I'll send the updated patch shortly.
 
Best regards,
Sreeraj
