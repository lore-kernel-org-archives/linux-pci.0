Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207487;
	b=mEJZWdBY54JYEejhsMRbw4Y3i8Lz6ZyiVM8Kp6Joy/tp8hdyLdXXt3fOx6RbrkDKEtdC
	 2N4thfJEjL9XWyE4r/Vcdd60MPM9Un6MTpq812sqTgZ0g5x1LxNdt1AoQ/G/d0XBqbNSV
	 I1wuqVXwz98XOHu1IIatArbLBpEsFAO8ritX4mWL/57hvliDyI480l+cJLKdEbBeUTVv6
	 DBzhx1aBD9SR23/Wf0G4d5k0qKrEeTe/EeGU5V156N8a4xJ36jdX2VuJuz8eS98MJdAkD
	 j5YHKg3BQSIc+OEsFdh8GobfUXmKA91xeIxE9L42lBdfuoRTCpOtxJOvHsG1uhBvlmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OBAS8LSYWCRFarKET5k50Emev7tmcCz5Lq+Z90k9nVI=;
	b=006411tE9PgSvPDia5LdEizyqiPN0EhPUB8vlmyQaVlyHAhPZ3j0qSh3mq6xBDqZfQEg
	 EB4FwjPpuQChcODM5l29WpRSpfPeVXBlNWuCcfv7QE/gEozF4u4TUnUH776WhJQwnoOSN
	 YsRMrjm6P+WAIEM44o7lBxYgLulzjTVgh7ddFxpga7XbdWij99rHtj3+z2RnXzqn5aG1o
	 cRpwWVgPFRaU5TIGJzlwmmDpUNNrA1GnIp4Ln/JLKBSbQby0P59wNxhAVFCCIo2h13YOw
	 sP7RjqR5l5E3qGhLXhqvzhMNNI5VAdQwOQTkrqABCHM87Wfqm3HXnXNnWoVz080BTtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mmkcO1JN;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C29606A31D
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 17:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C29606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mmkcO1JN
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a215e64962so13795145e9.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793207485; x=1793812285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OBAS8LSYWCRFarKET5k50Emev7tmcCz5Lq+Z90k9nVI=;
        b=mmkcO1JNN7XK0kk9rUyfJsIkeuA6S9rPXoVmVjclVsR9+UUP5tIwhTnb6+dYlT3iNS
         HizHtW1P57YqRbzyHS+4jFtxAzrAzJmkO+Tux3Eisaqp9+wmbaoIZpBq4qlNuxWbDPYF
         h2rw/+3GO5gg9tiBP7bjGjLjs/T4iwXCF8jkmKe7NH32VuqdcUmjge5gWefB1I4VG6Xh
         s6/qoPGgLvmhNWebT9rpgWGHuEQG3qwYL0NLT9tAmsRUWhgz9lHaZL6rbSYN3FWu1MY9
         RkDw/LyR+NC2RPS7+/DvGlJvxsqJ8nlKo53bX6doJUETJqp+6YZG/vxYzORAt2KaoHA2
         5k1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207485; x=1793812285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OBAS8LSYWCRFarKET5k50Emev7tmcCz5Lq+Z90k9nVI=;
        b=Ya2GNL5THmtt9SaNNFkPXacDsf0SJIkIGtRrtrLGww/tdY4QfN0oFgFjn+YYt7Z6Cn
         R3GUEI2Zj/AVd9RTktBMJTnR/+8iM8OBwnPxlCZK1IRXZvtFarX0SjEcUavk4CwRnStD
         Xw/KyDUGqk+lVSN4Pv5lLyVi6m7fSgbTmutbc2Y21TF1d27vQ3HyBhUprhMGoPXsuzI+
         ZwVeTlVKWZOkq0MHA2hG5n6nZWrZezhRS/5DacBZjhP8LCMOoROkeoaO/jefvXh1dpLE
         rGNsG21ukirlQgFKRRF7B2E4qAxEkZqwFzQyMmQwF9b9g6CItK8LYBEKZIZlF2AblJ0W
         aRQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqWJfMOaP9tPFdBwrLGav4qG2SAAIW1/hB7+dXN5BAk3j7yjurWQ/Rwk7HHYHEMFe2QE3wl652/VA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJRY4g/QXW0KqsC9SnOrpAS5uF/B1C5ovJBC4pKJ7NjNyZhpsW
	r0EfOpN7tvPpXlT1IHAHbdE4MQ+peb3J23jf2R5N9WQVff0PpZEaO8nWgjenRuQe8bw=
X-Gm-Gg: AYBFou0Cab6zCUzbW6witzgpRmhUaRd4Ok1wvVDG3u8hdJU38orCBfNCYK4SkpWn07N
	CVFO3c9AgCpHWXPizsBUyDDMmC9TZ8noLgNuo7r/vwn1wqHT71IgGT4deJ+3QMTRQO5yHnXLJea
	zI8nw03wwHcESEXT2IpM0Bs+7Pcmo0b0HYMNBx6oKKoIr77plX8qMkaNU2PQ2lbnH6TDPW+WPkZ
	qwpVuQcqWxXwdSYwiK28Z+XA5iP+uWjiH0ZFkQ/xwj2fYmEzeLbJXlTpTZkJ49mgbvVPdgI0Kky
	6jADvB6ffHR+sN2xrl/bYgGSVaCGgoItY/7B09qmmldItbv9hFQA+EKchK3fRDBIugEvhpyFDBL
	Vlfa+Nl3MSBvMCoZUGNWd5Qhg8tHO8dc8XQm/FwLSEjXRsPY5ofDvKKFpjWusoNy60yFalLt4Ku
	GhU21zDUkMAhjcRf1BygSrYgQPFqqAFO90oIGqvQ81PzCQVfY/DdA+Xky3J1nTrtIoF3xGCom4K
	FsUhkbipNxhcWH7GhvF9+f6Bsh8gfewsqH/MY2GWsB4KsyHLNxzf5W5E22k4jF800gGmKn4SLCI
	7UnTC8ZKcZHFdUu93gpl/xSulk7H+hcF/j8chIftJuFClVBalu6EHzIQQh1tD+1brDzY9v80Czu
	KQshW1B2LsJhd+nPqWUhID/1fr9m1kUHjFCWzGmLW/6cNAw==
X-Received: by 2002:a05:600d:8492:b0:4a5:5fb9:5d35 with SMTP id 5b1f17b1804b1-4a9672f7853mr41963935e9.21.1793207485112;
        Wed, 28 Oct 2026 10:11:25 -0700 (PDT)
Received: from tachyon.internal (2.155.41.158.dyn.user.ono.com. [2.155.41.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa813d2950sm4897195e9.8.2026.10.28.10.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:11:24 -0700 (PDT)
From: =?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
To: shawn.lin@rock-chips.com
Cc: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	manivannan.sadhasivam@oss.qualcomm.com,
	bhelgaas@google.com,
	robh@kernel.org,
	heiko@sntech.de,
	dlemoal@kernel.org,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iav@iav.lv
Subject: Re: [PATCH v3] PCI: rockchip: Don't lengthen PERST# when power is already valid
Date: Wed, 28 Oct 2026 17:11:22 +0000
Message-ID: <20261028171122.3422629-1-ehbello@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <95aeecc0-2794-4cc6-a635-5c042afc1405@rock-chips.com>
References: <20261028005603.2399220-1-ehbello@gmail.com> <cf541723-eb4c-4ba6-92c5-33baafc20e7c@rock-chips.com> <20261028015923.2436122-1-ehbello@gmail.com> <95aeecc0-2794-4cc6-a635-5c042afc1405@rock-chips.com>
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

On Wed, 28 Oct 2026 02:21:14 +0000, Shawn Lin wrote:

> Was it possible to add a DT property for configurable delay? I came
> across several EPs need quite a longer wait time, so add it in the
> vendor tree for dwc-based IP[1]. That could be applied here to slove
> your cases and others', and might avoid regression.
>
> [1]
> https://github.com/rockchip-linux/kernel/blob/develop-6.12/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L865

Thanks -- that is a better shape than mine, and I will do it.

I will mirror the vendor driver: rockchip,perst-inactive-ms for the pulse, and
rockchip,s2r-perst-inactive-ms for the resume path, since the two paths want
different values here as well.

One thing I would rather ask than guess: should the default stay at
PCIE_T_PVPERL_MS, with affected boards setting the property, or should the
default be the spec minimum, with the property there for endpoints that need
longer?

What makes me ask is where T_PVPERL is measured from. It runs from power
stable to PERST# inactive, so on a board whose slot rails are regulator-
always-on it is already satisfied seconds before the driver touches the
GPIO, and the 100 ms then only widens the pulse. The one pulse-width floor
the spec gives is T_PERST, 100 us.

On my board that difference decides whether the JMB585 answers config reads at
all: 0 of 5 boots with a 100 ms pulse, 5 of 5 with a short one, with the
power-settling time held constant across both.

Keeping the current default is the safer change and I am happy to do that. I
would just rather we did it knowingly, instead of carrying a number that was
only ever right for boards which power the slot at the moment they assert
PERST#.

Secondary question: do you want the vendor-prefixed names, or would the DT
binding maintainers prefer something generic, given the timing comes from the
CEM spec rather than from Rockchip?
