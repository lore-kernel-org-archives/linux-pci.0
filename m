Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821554;
	b=K9/dx398gXenRDnFLqoGgt5yOH5B9gfjBM4idN8ru+t0crmbMDpvAss90fI69NmuYs2q
	 0gvgeMeUYdo0NtKEz1agpPDheJmwjwnAK4LHwUL0T3A3zrdY5h7SqRWkyCw5OXm2YQHsy
	 O53x9j/2rbarrifwxAPQ4HNDjsYUfOT7ndhTDj9N9Oy82CoFw01b56JhCUT+GXZTUHKZu
	 VsAwF0sRnPHzNJU9nasW0kADG/faebM4wxrXzLBLVVwJoHTDF52ceimZ5jKCIcKyXMDSC
	 OuNAJP2aRtGvRBlXqevM03XXC+1QnNuyzND2IdfiHL2nuxl6M4BkxftntQW4vwgMi2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
	b=R2GnC6FO+hXOuqjfu//abOdwZogZmINvPjK8ETJ29e9IlNXJyNlVznjblHTT1wEPqBfI
	 Bid+X+j78Ndwi7EtWb0zZGnwtU+BaJ2xubu9IDCr1YDx3JftOw00vIil/8hRFMdSGLgtg
	 k47H6VpQiqGzxMqYB2772vpthtS5zB1M3Xyl3qpnLFryWwDLPkjSBzb7vm9kDTRtgmTXH
	 fAldqS6df9JiT4aAyXPwaF9F9pzRN53+Jr6rwOneKv3oMhU1soh1q/HUaldNVe+niKqyi
	 OV0i9dFG3h6CnGIsDY4GUJRDVmSh/ZJXA39JPXwGVREnABTJ4LJ/BsXSY0ceBkz1uxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhgChsRR;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5736070ABB
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 19:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C5736070ABB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhgChsRR
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b244fb7fffso1559756c88.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 11:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793821553; x=1794426353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
        b=PhgChsRRxoaFlSlkRP6+eJT4KYEi14DqTMP0leDLu81FxLUk2LAC65QwDPBooqvAsn
         iH6XkP8S1MK/SwZxO3AJkItw8VOGPpqeDmiiYKv7myO0lnlZgnop7KC9K2NAgM6ukplu
         Gjsdpkx1k0Dhr49FqliSxtq+PV7zOW1rF8RqXf/q22186XabS9LOxL3XW958WfiYw+PV
         JBjD6srBvq+hK2XBFDtCmpOIf+gS9iJ5nhxA+IIgHZhp3x3Dcb+TLxzecX64kH4ggJZ8
         fI8gag+0WQBADwjfb6rFBnw2H4YR37v7+5aiBzykie/3yy5MmRaIYgT31jdFJ3lzFtA6
         N3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821553; x=1794426353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
        b=egALt4RpbYgGBHu9RcPFLEDOtgo5SeWgNNWlUPDI2fB3mbAyNrEVn+j201BcYsXDOU
         nQcqeVJAr16q+TT+nyKOiasJ2PKFfTLExP8GN6wDJA6U3icF7p5DJapWJ+wuXtkk24v6
         rsc/wvwEPF/Rq377Yk8nB1e8hLKZ6Gen/F/Y5Jk4QF8GVnGS2D2BPUKZ/niZPRBE3tIr
         wqViY6c0Q+ZHV8R4fZ1tynV2zMnJFjky6YLvDzV307C7eOTo3Cleu1KOFCUZhL9iJNWx
         60dDed0WXxFzR675KRqTH3TfOXs7+4cM//nsc0SUlvuk42m6LLaWSYGqXMhfvwGK90Zi
         GDNQ==
X-Forwarded-Encrypted: i=1; AKwUvByAIv+fVGCoVthE2Mxq/aEaMrd5uddruXpluGhGuEcZGG2I6CBvC6At9ccm+yWSU6CM8Hb8f1g3nC8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Lb9Gl2hMKaDKEqtTayAAPbgvjHp5MXQlYnhDkGXgEwdPVUywG
	8hQ+5Yiqs1ONBrq6DgCf2TKga4FOyOlU2evwMkjIPdxGMpIwDKxA8tk=
X-Gm-Gg: AYBFou1czCF8vCKz2ix5I8+XBSEyyT1Qtctf0qFSWJri7OcfK4AZzloHewRwpvv9epg
	aWH2TaBOCZdUbtX+dWU4XKNZ19QRzW7QtOxS9Ba8DxzYoN16pPDNbtuazLn3Do6H6mm8RsHm3+e
	Lr3mo5qv9Z2Ph7IIxfbWgy/fRjISfOVsO2sJ/oG6hylhLSM6bQfnsQz4M82vOiT8KPGOsks/8Bx
	2bQSj0XGq+xYY8wlLKqswoJZSWzd6tinZakoD2OO0DCVMyQV+uOCBHjEIgPO21xyAlBr2eew4Pj
	2oaySV+Pedjv3jxUUjnbTkaQ44F3ndP4dlPlflcNfwOor20AaVgTDLE0JntXes2gnjmgrn3VIYq
	lKD9KamKBZNcPZyhOSWdiPY7alQlmX429muBiZhhNyKJUzJJ4yvw/UxMDVk4geXtw73WgG8jX75
	mEJ7+hYf6+akD7aGtbqkr+CosWgTtJP9wnRAHvoivivBAPrG5VI887og2XfYGXiwPwum9TynQG7
	O+s2TvcSbTVqIPUobqJJHTgCxCEFn3i+fJk+0X2BUvqqNRXxgZsmiVJy70oElFN1+Qeo/AkuL6x
	S3v8bLwSJiusYLK4t12Q8U0nCGM6Mya3MW4ZQadU5pzywCUDXzDYpUovaGALsz4tqg==
X-Received: by 2002:a05:7022:3a02:b0:1ad:e740:e51e with SMTP id a92af1059eb24-1ade740e699mr23857533c88.42.1793821552953;
        Wed, 04 Nov 2026 11:45:52 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm8652168eec.9.2026.11.04.11.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:45:52 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: jic23@kernel.org
Cc: alexandre.belloni@bootlin.com,
	andy@kernel.org,
	asahi@lists.linux.dev,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	brgl@kernel.org,
	dave.hansen@linux.intel.com,
	dlechner@baylibre.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	griffin@kroah.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	j@jannau.net,
	jarkko@kernel.org,
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	lee@kernel.org,
	lenb@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	mfd@lists.linux.dev,
	mingo@redhat.com,
	neal@gompa.dev,
	nuno.sa@analog.com,
	paul@paul-moore.com,
	pavel@kernel.org,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	sre@kernel.org,
	sven@kernel.org,
	tglx@kernel.org,
	wim@linux-watchdog.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: [RFC PATCH 00/14] Add macsmc support for Intel Macs, replacing applesmc
Date: Wed,  4 Nov 2026 14:45:32 -0500
Message-ID: <20261104194532.8259-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101010737.203951cd@jic23-hlaptop>
References: <20261101010737.203951cd@jic23-hlaptop>
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

> Are we looking at ABI changes as a result of this? That
> tends to happen with split ups of unified drivers and mapping
> them to more standard kernel subsystems.
> 
> What is the plan to handle them if so?
> 
> Thanks,
> 
> Jonathan

Most of these changes now expose the stats using standard api's, so this
should not be that big of a problem.

The worst possible thing that can happen is that, the user will have to
change their fan daemon (macfand/t2fanrd to any other standard fan daemon).

And also, sorry for the late reply.
