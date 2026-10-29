Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237933;
	b=C4bXYCH1McDcLej4zsQCQ9tCSok9Pkw7U+sDI8BOItAb8Y+7wtAIH96iu7/Ti3ZXRjk5
	 jNvOCPat5jBnchKG1e2IfHUUzFB+4Tg1HQMtV7i5UMHmgowSrQQ+1Wojca8TAQ6OjiNfg
	 PGYuMT60D2uGIjH4C6fdiKv8Zg5oIC+IJM7RqAIS9RGJtHUD2K5a0d2GMAtdORoD8xZGa
	 DtC9OaO6K2TneZkhYmqJq2hMLQY5nfmLtxqZH6RZevxoZ0Q+XUDHMN61jTd+0+h9yZhEZ
	 JT9ev2ozxtckAo7W7VF9SO3Th9wzPlhtJvADDuF3Q24dqO5FzUxUCdjXKLECgSugr1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/cTHNomGdMzdwGOEPd/Mb+9dZ6EWwM9vGNpl5GZyT/s=;
	b=CMoMEyjOaw/cm69HX+1HfgPoGOZX9zHESo6l4pFTYSG+NA5Ge2cCjMzleVc7BaNpNfEO
	 p4sRMda5mlIECXD86rlEHjE87CZlBljUeiXhNWhRfWIxV5md6RPaiuGCQ0o6hxzkjcNhy
	 54ULo5oRHl+HvFp4H/ZZAUlzmAIY+rB2WuQysh2krst4onG7oKN86/PeCvcA+fBUCkduq
	 hHRn2KLfYmn/ZQxH4raieqJxOhf/j7VDVbfFO7G94Bz13intiGq+KIfxSeEjvibEMZLdl
	 55eFuxdX6dxjHvR7G2rBqoYNsTJJpWoUP880F5Z/NL26l0PD7YhbwaTfDVyvX/myE1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L6c+IPE+;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11BA606A33F
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 01:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F11BA606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L6c+IPE+
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e0d1da913so137104f8f.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 18:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793237931; x=1793842731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/cTHNomGdMzdwGOEPd/Mb+9dZ6EWwM9vGNpl5GZyT/s=;
        b=L6c+IPE+TusQzbodaS4Y8bDimeOge0wsfqMCW09n1Xz70yNq0U95vP2JdsERw5EuIU
         Aq9f9+D7DXAqUux6+m96MwkWa6k9MknozLsKMTQJHXERZo0mT+larlyUAIvXjTkFVuYm
         Cn0coLa4xlTb1kcTnZPWBvbr+evtFxizLmVV6BbCrrv/oswQl3iBu47c1Fk9XiNW7SEi
         R40Hc4C6LQEKRyArjcAeR7UtoinslXuLkB0cOe16olQBRR+6gmYAqVZ7v1tCeT/TE2s0
         dgVEM1YAG71RjPDbaDQJDAJMUv/nQAdazE4UpVLZLkjjwyzi56d1fX/Iupz7HP7mPYwO
         OlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793237931; x=1793842731;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/cTHNomGdMzdwGOEPd/Mb+9dZ6EWwM9vGNpl5GZyT/s=;
        b=a8emmXwS27bdqxs+k8GBXAfP6AoSDi7+idIUdQEIlmwnO7qLS1e/omaoX1UZFB+hma
         m4FeXO2/yBUpQaF67iNjZRjp+vb3hS/cl+TL7BOWaG7FHX8/IYSm+ClzBtDASUwd30GB
         n09Plj56Y8EwNP5T74IzNi82bL0FWdh93TnD5KLv6ctkuvBH5wqq5oAm7r8iDBGY+YZt
         qtjGUtqVFHCTegFQoh9t1PjVM548jPGqJjoo1FRIycq1m1glWTN103CLj7e/E7oBfzOD
         h8JxrHXDQ8gqZ6KDiSj8OGby8dR/XjsptNRyic1CzyAWi2YdKPp5U07eqIpf+/1KlBFM
         vRoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZy9IeIOV4n3BsZ6Zra/4EyXmyx5w1jOW1DY1RrOk9/KcSw5WXcUHiBZLTe+JMbJXewb75KH522Ug=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhYYl1sOzErA6NmnehGOgMRThM2qlbIPF4JuXtN8E+fjjaD1Rk
	T+tdLeuLM8Ec7S1cYjLRb1NOQxKUhuu+a8eRUecgOX8SizP2oUQXf82T
X-Gm-Gg: AYBFou1X4VIPRaAOMmB0Ez646mwoc4dAtpSdsqHtcCug84NlbgIMUbk76C/Mq3ngJD1
	9GilUdZgfZrFlc0thD0zpw10S2p+rkKTfvulr9Ezq1BWOalJckDM9d3a4j9+A6VWuciL8r4l/Lb
	Vep3k9vT5ONgW92chDKoS5VmIKitw74h65RHsCemyCJ5dRQ2mXY8vFUJ90yAbEx5mjgJoXqERIM
	35BzJQWaxb49A+rs5e+2T0STUHOXbCktbP3NeDwLQCE9yBd9vFT/H3qTNSlR1ppezoamX2DfdvD
	PvoRmCWCSgaO6GpdYeo51HtGDeJSmHKNvaj5TML62D3Cw4+snNZwoCvN0t5lr1G9mk+eJlpuQIP
	vRwlUwdctdmIiUsG8V1upnPPXNqAS8fv6NvhYj84ROyW9JPDSOzQYTIPYEJVfYxkKnQ0ghcEWbg
	139eX6W6i4pAReuR55qKdS42eYl65Biz+eni7demZ4Jv8ubjd3qTbNangYAyMuF21sCJFrXQmAi
	gBfLKaQGejqk42SA97IzOH0xf+x2eFF6p7xg9lxAN1BKQXDwyQlAF0LDEdDn/banPPec5F4HXxi
	26qhd+M9Jc5J+BBJYIrmNitpXm/PEcf61sbDKwKYFhquBMUNNl94gkbZusrKt3br++gAahN2zqq
	zF/Im/G1Cca+leeqo6UGTKJbxyjtiRPNhBuOGYWdvLIxgtKbNUDHMvjCvcFZYk3Pk1zaZTyo8Zq
	qO3VCOdJ9z6cWsdBhi8w8lDjY=
X-Received: by 2002:a5d:540c:0:b0:48a:fad8:52a2 with SMTP id ffacd0b85a97d-48e64ba60d3mr2291450f8f.23.1793237931074;
        Wed, 28 Oct 2026 18:38:51 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-077-007-226-156.77.7.pool.telefonica.de. [77.7.226.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd8ddasm34154098f8f.48.2026.10.28.18.38.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 18:38:49 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH v4 2/2] docs/zh_CN: PCI: Update the pci_device_id header reference
Date: Thu, 29 Oct 2026 02:37:17 +0100
Message-Id: <203f4407e5ed5335cda17a74fa6aeac311a572d5.1793221199.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1793221199.git.kmehltretter@gmail.com>
References: <cover.1793221199.git.kmehltretter@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

struct pci_device_id moved from <linux/mod_devicetable.h> to
<linux/device-id/pci.h>. Update the header reference in the Chinese PCI
guide to match its new location.

Fixes: ad428f5811bd ("mod_devicetable.h: Split into per subsystem headers")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/translations/zh_CN/PCI/pci.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/PCI/pci.rst b/Documentation/translations/zh_CN/PCI/pci.rst
index 347f5c3f5ce99bade1221f083b208972baf102ec..452e073b8c067ce16c76d9a5a5883532ebce3296 100644
--- a/Documentation/translations/zh_CN/PCI/pci.rst
+++ b/Documentation/translations/zh_CN/PCI/pci.rst
@@ -92,7 +92,7 @@ ID表是一个由 ``struct pci_device_id`` 结构体成员组成的数组，以
 
 该API在以下内核代码中:
 
-include/linux/mod_devicetable.h
+include/linux/device-id/pci.h
 pci_device_id
 
 大多数驱动程序只需要 ``PCI_DEVICE()`` 或 ``PCI_DEVICE_CLASS()`` 来设置一个
