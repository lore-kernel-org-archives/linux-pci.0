Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7DA36197E
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785572731; cv=none; b=Q/HDtnzFfvZFLBJZEe5OhDHvOG4QjEHd1BKEwhXZBR379MiAU+Z/Ios5JErKTMHQIcgUd25Qz+OexYlmPndtHGbM3NkkZZe15Ppxd5tJIKUNSolQ8P4lnGepoZE/sc9LaFyth35auwPHRzJ8pHb91Mjl0g3xnQY4JxIDdmy0SKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785572731; c=relaxed/simple;
	bh=+CaLhkTCz3P5fdOZHT1VKVnlDou+5WauiE3gIfowDw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6RsQTT2Soh4gXIIbVBJ1fIxiNmeFwEygjxh4mAmZiLgjI+C1h33CV0GDHMWCm3x1YzBTzh+COHOYzE7eGYcvlStg+BCzNJL99owIY/QAZQZFkE43orGf6ncJKAJEGCBgefnsUfuirX3+8MgGwp8SY1aZZgDkwotijNxl4ZuNaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LkMHrvvv; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LkMHrvvv"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7ebd88be784so1210619a34.2
        for <linux-pci@vger.kernel.org>; Sat, 01 Aug 2026 01:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785572727; x=1786177527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+CaLhkTCz3P5fdOZHT1VKVnlDou+5WauiE3gIfowDw4=;
        b=LkMHrvvv32SgdFO/RLi9xeeGfJIQNm8fn3v5U3aNR6TM2PWAcbELgpex1JzV/p9Of4
         2yhWzi6KIrckMv1j15NvUUKsgm5bwN97Jm6MF7KX+dUXyBdSTQxFWG7WI64+FTiddgMb
         m20uy3N+iaI8pScy0d35t+vqjQsllLMDtoGQx3V3KC9R7aE63RtaQbnibO1eFdELBcoS
         iyydidrBiBC3cZ9Vy4H7TscN1NurSnJOsBuhL38fR+pftY9GpQ5zUckLxlIp1PcozyFg
         FXbCPm/6vuppmZW3W/APN6aUQJ3PSzzzW1OpRIpXluReDpCttnHfHstDnBl5jhKXnhYn
         gY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785572727; x=1786177527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+CaLhkTCz3P5fdOZHT1VKVnlDou+5WauiE3gIfowDw4=;
        b=sQ92bP3imEMnQfncixy2TtCxMUXpjBXAilwMSp9FUfnjRcRgr1zob+iLGRwfojOmi9
         TEqwWs3NmBWIZhZC579iDJZ7VQNhS2VcNw3tt08Do18KdIUjio1HlaoASPZJVAihlWO5
         8JL9UhEv0TdB2RgMdW6UGmg1jTXYbjjQQGtPnx5jrJXKlH3FnEa3pNinsX4w6FfGXfzy
         sC6eiA2EQaTlAdeiarzUhTb0ftR1T2Ib0oo6w5apRQbaEOh9Yf4YAgXwk6lBRRFDI+5V
         z2Xhput3NuoYF2SRVm3A6kKUDGOK7CTTXTWi4uxGym1riidP9oUbQBkY03wpMYSRt5Bs
         k2Qw==
X-Forwarded-Encrypted: i=1; AHgh+RpRrMOdYD88Hj59BgxSfzOwamgcnUt22qxsGT7porgZUAvXXTV+IZaGCIeglSbkIjgcu/sFJd0aFj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1+sZ+QQAMlX6Vrsx4wTQ2WWe5eDoYJ3l1reldfgAEnhv1rwT5
	VtzIfE/S675tAK/epLdFN9kFBzrgs+9DnWriU9GwVrK4uqaZDjaiXqgRLYVIXz9sVc8=
X-Gm-Gg: AR+sD10RaT96kxqLS9VR7T/8gN1eBSQ51fg/CNEP7ife7sF/PCn2uXwwgD1Rl3JiCDc
	WYrII7A+eG5PMyjv2GQOh6SIuot+Nv9sGULQkIe+oNGJWeNc/dW4PqmVpdc2pob7PCPrvoYfStf
	D26F+aXcQz7JKA+u0+DmEu4Qgu/iox0BmNVQRT5iRjme7RfTpzwyHov4mRA+WvlX6Yh/jKnjS2V
	T6PG8/p1wxI1mN9AE4loVdzxghbk+c3plv9MzyBXRAGg6ZHhGD409KDjKYbuwBrucMxZsJy7yeL
	uxwE7I+rOo3O1flZdg2+Q/sd+4UEgTGFwUCm8MjrpYxE9qFnQoqkB/Am+frtMT+QUHXxRhMaejr
	P45HzwPL4P2Rg3HUB7gHqDD8/Hd7HrG0T3/eI5sXghtfFYtZeeX8Hq8a9M6STIOiuhMwrYbRY7K
	w+w6YnJRCz2M/sJsJbTLgcx3LmiFXiknBfNW59sYg2FmPgQH/lvkazpnDCxnFN2x/25QbIo+8DZ
	tWZnWS8p5aVag7A+gTy/3kYhDBSt3H90S5Wa9HZVhnuc8kPCHrMT20CEzdO3Cf8gqVpbLKaUD++
	mGE8b05XF1Hw
X-Received: by 2002:a05:6830:4114:b0:7e9:bd00:c6ad with SMTP id 46e09a7af769-7f196f29291mr5823693a34.16.1785572727570;
        Sat, 01 Aug 2026 01:25:27 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7f18f0da967sm2998424a34.23.2026.08.01.01.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 01:25:26 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: lukas@wunner.de
Cc: agovindjee@purestorage.com,
	an.luo@enflame-tech.com,
	ashishk@purestorage.com,
	bill.wu@enflame-tech.com,
	dio.sun@enflame-tech.com,
	fernando.hu@enflame-tech.com,
	helgaas@kernel.org,
	jrangi@purestorage.com,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	mahesh@linux.ibm.com,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	oohall@gmail.com,
	qingshun.wang@linux.intel.com,
	rhan@purestorage.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	sconnor@purestorage.com,
	terry.bowman@amd.com,
	xin.wang@enflame-tech.com,
	yang.yicong@picoheart.com,
	yurypm@arista.com,
	zhenzhong.duan@intel.com
Subject: [PATCH 0/6] PCI/AER: Support Advisory Non-Fatal Errors
Date: Sat,  1 Aug 2026 02:24:18 -0600
Message-ID: <20260801082419.7780-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <amztrrIGvz8gPxQb@wunner.de>
References: <amztrrIGvz8gPxQb@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a part of me that wonders whether all of the complexity in AER
handling is really worth it...

Advisory error is one of those insane things in the spec.. It feels like
the spec makes it unreasonably complicated for the driver to discriminate.
What if we decoupled the message received by the root port from checking &
logging the AER status registers? In other words, when the root port
receives a message we log the severity we received and whether it was
multiple errors.

Then, when we get to the device that sent the message we just always check the
CE and the UE status registers? If any status is set that is also unmasked then
we log the corresponding TLP Header for that. In addition we log the device
status register so users can know what severities were signaled.

We can use the Error Message severity received at the root port to decide
whether to walk the pci bus and do the error_detected() stuff. If there are
multiple UE status bits set at the reporter & Dev Status register says there
was a Non Fatal Error as well a Correctable Error I don't think I care if
simply logs everything in UE status as a UE, everything in CE status as CE
as long as it also tells me the Dev Status Bits that are set.

Going a little further I would be fine with just always checking both CE/UE
status because it seems like it simplifies things a lot & two/three extra
config reads/writes is almost a nop if you're already at the device probing
it for the other AER things.

Thank you!
