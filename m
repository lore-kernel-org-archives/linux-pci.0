Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794102703;
	b=2QiM9gSBa0NRIPs2Rbw0evrmrGquBvs/jtpr/zcbvhbCADGa8nRsp1azn2KNb4hsqxYn
	 7tH/wVb5w72AwMoowUBM6hyY+TTjgr+Cm6LA66Xv8Ce4yfMRpTaFyqCTTvVrMJwJ5StZ7
	 2IYuaOTE0NN7A0WwVVbU5K8Q/nDqot9mwjn3o4KQ6aw6YY3Lxf8YHAj/oPrHgDoRhTwmZ
	 ORU5r6JuB11avW6J0gY5mFAS/DLFFk/F14Wu7G9M3OUX1QrnuToIW4sCFDLVGfdcTZiml
	 ocK47yOpgcu9T3aJREkC9s3yGGjMSFi2lZCpSmKGiyaz049HikQRNKZY14CZ45njymg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794102703;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1xV/fJ4AuRrR5u3NqFuBRHGOdyiZjuQaysbexctAYug=;
	b=X3QFN0H5q2dp1urKAAvXBLqE63JXl68CONIwgEACNNEvz7Mylk32QtcIopDh7rBxTrRY
	 NkdnSSvWJce7z5Vycja37zdmWZo5QfjFs8CXdtPGeVzumVVoVcqQ8oZIV9ioIP+SdhBvn
	 3ppDXD+Z7ujRstRzVZRyK0IFVyoZxWuiiwah5R9XWtpK1WoiZh0Tx0XBm2lEvPKhnAqum
	 igcwTxRBIjaRVPSFh1Crr8c/JR3fNinpbSmRdm2TMwd8l49yw9Gf7QUzZZtBX3locUbld
	 Lstozenwhh/qC7X/ko42vkvvhaBopyrtaQNT8gQU+ow99GODUb94ZTvmkHPb89pcb1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=calobrisi.com;
	spf=pass smtp.mailfrom=calobrisi.com;
	dkim=pass header.d=calobrisi-com.20260707.gappssmtp.com header.i=@calobrisi-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RVpGsrRk;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113EB606A31C
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 01:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 113EB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=calobrisi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=calobrisi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=calobrisi-com.20260707.gappssmtp.com header.i=@calobrisi-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RVpGsrRk
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93cbc3ab2fdso2891085a.3
        for <linux-pci@vger.kernel.org>; Sat, 07 Nov 2026 17:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=calobrisi-com.20260707.gappssmtp.com; s=20260707; t=1794102688; x=1794707488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1xV/fJ4AuRrR5u3NqFuBRHGOdyiZjuQaysbexctAYug=;
        b=RVpGsrRkBKsl5ZRaGa9drVPBv+Zj0NBO5KR8r03cH6buOy8xfchv7XxTD86SRSpt5K
         ngj56EQu8nsvCRcw/50yqSNXxZApGYGvdlr5LoIFCfuCkCdaZkYPpWdLBcErEjy70caG
         watxhJsBBFpNSeGRmRWZz+w9d/eXpxfwLWmSBjqoP/9CuXhic0rxZtAJRTh0ypAoI7YE
         svU6dhVKI3XSPKgPt+GxIoDuXbfmwKkFEbfzRIUu6oYKfIspYl+HnADRlKp42CQzI7EW
         Z53kdaCpPPya/CH5DkmneTbwpqDgTFLAlNyfXejpFNrVYnYZJ6UHiAsKYMmBgtve77cN
         aj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794102688; x=1794707488;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1xV/fJ4AuRrR5u3NqFuBRHGOdyiZjuQaysbexctAYug=;
        b=aeEDi6j9NOc9Gy9iCt1a6W6gOzjXkoixtYuOpOtiW0rXtPZ+uWr8tOOSfrIjwOmQCp
         HIr64kOQGJKU/cqw8zcErPgIGLkl6nZcPuoZbFIQ6rtgRhEgU46qhCmy8VzdyTG5f0Ye
         dfVUgML8+6WVCMwMPFEAol7EDt2PNGGoTb0el7kMrP889akkSMvb4tlY2kSVGnif/4Ba
         fUSht6IFVEZLTyfiGAOrHxrwIHp7U7z8PGQEVNi8DCVoYFtdMB2QukA5F15qOw39nmCV
         0r3RwfsUFKWO950pZokuGtXkYD8wAQiSWHJJ2xESvz9dbOAjb2ir+XrYAtl4J6hjD5iT
         j3Ag==
X-Forwarded-Encrypted: i=1; AKwUvBx8n0lcm2ecJGSH1wdNADwhnu3IGPdRTCL+iRgDZ5H2Ot0bbdkrXlSAxbuDp3VaHoyhDqC3Ph+CkHY=@vger.kernel.org
X-Gm-Message-State: APuU4Z94U4e1/v0rniVhxtKM3+GuR0/IUuefggCvl4lmwsjRy6mEOLun
	gSviZVMQLCFgmeGwqY9a6q8UdRK98DZhpjJM3SOF6InQ1UFgFgVy+dUvEBiMXFvRGDk=
X-Gm-Gg: AYBFou3P14LixsFMSomBLRn1OdzCYGsi78Z97ZrHIEAwfXq5ux9k1NQbtll2T8e2NpH
	gONuw8HnPN6etjYf9P5Im2euNOi+BjKe6uyPCZWFaE6sSiwVd0tiFD25pDo5w/6TLCM2kuKciXC
	r3/wWQMoTb/ckGZH62DQTYluyPeTpW3JDZsnS+ZG+3tmdd9GaTaLGyHRr3CDiDZqjN9SHXvEt8Z
	QANNxA+U+Gzvdm59csrV8WQ8Q0Po39e1vG8lC0dUJFyfETdrafpQHAbNd7mkff4ABz5o7YIEi2v
	4xdkEszKeDAx9UnB8LIlDgZwHHx0viSqTX3Ug1uZwxjOfp6Tja+Hcrf+dFawX/GL7E6d+C5dw6L
	8CQasD346tDydJUfpsRqbi/d15LME7pQq9xUSHEbTcFKDJS9J6WWqe+AjbirFyTzzTVqoYyv5B5
	mTvURXl9t1GkuA2PMH5Pfw4p51RP2hP/5a33wIrhAGeb5va7DWZWyuVnHmcCSUpWh1a/y+YsHoC
	4VLVPSRuC3zWgIV+FmN5UDqnqVsBoYzG5lDziLTJczsUdJYMDp1cdUuWUHNRcNBR+JAeWseNLx6
	UAxgqdCOIkZYaAbdoM+lyq6bZjbGzHZVGHrQNE2TT1Gnsawzs5YeeZ4YQRCxJSCunvnzaZOZy5P
	bjVCbDTIsx3W98B5QWdJRNiUc55zKcBjkGignrQ==
X-Received: by 2002:a05:620a:1d0b:b0:93e:c12c:fbcd with SMTP id af79cd13be357-947842b51e9mr47600785a.73.1794102687950;
        Sat, 07 Nov 2026 17:51:27 -0800 (PST)
Received: from localhost.localdomain (c-76-99-126-200.hsd1.pa.comcast.net. [76.99.126.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94782ccaea3sm78072585a.4.2026.11.07.17.51.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 17:51:27 -0800 (PST)
From: Doug Calobrisi <doug@calobrisi.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolas Joshua Britton <nbritton@exabit.io>,
	Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Mesih Kilinc <Mesih.Kilinc@sony.com>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v5 00/14] PCI: Resource placement algorithm fixes
Date: Sat,  7 Nov 2026 20:51:07 -0500
Message-ID: <20261108015109.65207-1-doug@calobrisi.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
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

On Fri, 6 Nov 2026, Ilpo Järvinen wrote:
> There have been major changes so any retesting is appreciated

I tested v5 on v7.4-rc1 with four AMD Radeon AI PRO R9700s behind a
PEX88096 switch on an X570 board. Each GPU's window holds a 32G BAR0
and a 2M BAR2, so it's 0x800200000 in size and its BAR0 needs 32G
alignment.

With firmware ReBAR on, the board doesn't POST once two RTX 3090s
are also on the switch. So with ReBAR off I set the four BAR0s to
32G from Linux, then remove and rescan root port 00:03.1 so the
kernel sizes the windows again.

On unpatched v7.4-rc1 the switch window is sized as the plain sum of
its child windows, one R9700 loses its 32G BAR0 and both 3090s lose
their 64-bit BARs.

With v5 everything is assigned:

  pci 0000:0b:04.0: bridge window [mem 0x2800000000-0x67ffffffff 64bit pref]: assigned
  pci 0000:11:00.0: bridge window [mem 0x2800000000-0x30001fffff 64bit pref]: assigned
  pci 0000:11:08.0: bridge window [mem 0x5fffe00000-0x67ffffffff 64bit pref]: assigned
  pci 0000:11:10.0: bridge window [mem 0x37ffe00000-0x3fffffffff 64bit pref]: assigned
  pci 0000:11:18.0: bridge window [mem 0x4000000000-0x48001fffff 64bit pref]: assigned

amdgpu then binds all four and P2P between them works. Logs and the
test script are available if useful.

Tested-by: Doug Calobrisi <doug@calobrisi.com>

Thanks,
Doug
