Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148953;
	b=0JEW51pEiiHSdHEsMHcT9v2+Q9nnmGYxEb1asZa/peVBO69ppbHJlghqzh9HU9Zg4TEn
	 5fZNkAN/Bj9e/qh5PzRhZo7cpOeKc88wYaNboYx96WZ04kMVAvxtnvmQotYp9RMEzfIG7
	 uS8TB+8UcgmAMz4fy+oZvqLX6DkiyLhKj7oaqdOaNiLahLgSiIErEau5JoV+35c11QIUW
	 NQKaaCkaS4QDPw5D7UUWOoEtwuZAw4CinGmcKwnA3n9neb6yTjwvpWrdfA/C+uhJLB8Mf
	 MDR1aN1ly4j3PP4nRcoPpw2SYJ1hPI1jPhLdMel2jAFAOfhi2WTc9RZz5zaLpBtHpnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PAsTokA7Hgc1ku+L2Oft5fOaAKv9i/M7eJ7+DNq9b9k=;
	b=BmoUcP8SKwhSKKOOxnhN0VmX1V2ii8HygmXbj/ForA20xFaoRB2KWsMzxgm8LqsuIhxn
	 Z3OUzhClATsz1X+Z7LIZP6lQVnUxbIRbyp7fhFG3lD/b7PElclCUTyPHKv+xlUtkCL7fw
	 z6oFTSAO0B38yg/b3D1rbf6pQNr0bwx92IwIw2YNg9JM+D5nqb4bBKa7OwqvCNPqragk2
	 fo3MVYHn5pYOYA2ZxAz/+R9bhjXAQqwriXgIqDlpNRmuA6V+y6lcHmHYczZV0kEY5PK6d
	 3MWk8M1scNMR2Cd2r7720b4uJKt/XZYAfVu8rp8Kp8rDvaDy1joHSWJMipU3b7+FTKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0BmF++g;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCF5606A31D
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 00:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DCF5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0BmF++g
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso3363325e9.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 17:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793148952; x=1793753752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PAsTokA7Hgc1ku+L2Oft5fOaAKv9i/M7eJ7+DNq9b9k=;
        b=f0BmF++gIrsae/Hwij3CebxuoKhvrOBcBTXvCW+7m0+oSZrjytHilILdtPW5mHckP2
         WJvkHYZMRkfSoBZnikgve/4H89OlmdjltI3qdNzVGdNvhqo9G9p98Klk9RLildbUad3y
         wF/rFPODp2pGcnK3OCisBYNUREk0IiRPrCwe6BssXbdD0f5504jWthwc2aqLRN6K6PcY
         /U/b9127bd3JyvSz5p9LrwMY3qcXxLiYMM2a0TR/vFMcqf4g5WPXZCCxnbzG7StN8kl0
         EQ3N6iJ9s78Jwyw/8+h1VaEzVX2V/jvSIoAmU/4dMqxNE+OS6S5bo7hNrJmBdqcSQCNh
         Tb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793148952; x=1793753752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PAsTokA7Hgc1ku+L2Oft5fOaAKv9i/M7eJ7+DNq9b9k=;
        b=rGZQKhYVeyGYpWXqRoUHrTLlIdQg4M7t6cAMCKI0R8OiY4NbWYQJqPfld19GEhOTgC
         cqbqIAb8jUBzvvXx/1twMG9NptuL5hXj4MTJYfvPgpm1D6cOiamGzr6rdkLzXZO0TOZY
         aqUCqj4R4j8P75v+mpuSVQGc/DxQy4BuP/a1ncYTyezvGfJIdSGdHJkev85ZhduciuHN
         21LKqbyoRAw6S1JDsQaUau/PRMEF8hNcPljFgKJzRCSYTNDlbdvCTJEQP3br8Tes1oSN
         MQsIPPBzKX9EQOIKADn20OKSuY0eqgu+1igvoh1f7fX4svsRl6+OE/w4DhH5Bx3heFEf
         GU2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzM7B7eJ+QVZ1rnIOk9IbkShMdLIeJbMKGC/G57hvBeUNbk8hgGgaIdRZp/py+n0DIGWGpT3ESTl3c=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNzlxtyht3aHTFNtxaByMqTWLWmeR4RoCURdxYIDPxN3NPbfPO
	k0I9BQ+e7d2L2oKrYwlrHi6EBSnj+28e4vpHuR05RrPx/kbuWWjjdyU7
X-Gm-Gg: AYBFou3d3LKEmNcAOfZAUc5zhqutCJGLcFjG98XYeO7nx7HvxoSdJBkGC9sjM5ZNGx+
	B7xNf5CilVz0PHQDrhR2VbAzJPumMFiOB2MwlnqXnmgxjOVdW9Bcvd8D4MbEe3Fe0LIJ/FD0aFP
	PVbFcbXZgcVellGS1BrO8QyoWM7svIuGRiB/D8uoae8Jaz4m4NWcvxR3cUkmjcTQgmL19/pAXsK
	0T+N4k/tA0rhxUDAYHws3BpXMQEkgSpAh73A9tGr8AVN97drKM9CGVxaK5HqoTKilI880XcBUeY
	Kre63OFBFAo5rcwDnNhbPOz6gX3UGszw7lfQObWqRsrcLmSl/5Xl5zGvZ5U1EkVSPvcY1STP96G
	ezO7FnYay2pIu5r23+N1fiwJuMUIv6WJepdaKHDGNnAo/nXurW3Gnt6xWHiciLMu+i6/IRJL2Lb
	hdVe5Erkr1xZlLUjlU4xkoIeoIjwsN1qoqeFd1fCxD1qpHNBy9uzS13AVP2bLpXwq3+GQSGFgjQ
	zlOilKc1zwpEy27oy/veMRjfqYjlEa3q3/aGD8BJkJlhi3n+gBRTnyhB8TUm30XMqIt83slfCDy
	XK7ATW4nzWwjfOz9yuM9KiLbi2v+TeEIiN1tUsvMhTStD1v716iCsRwBjIH+I75pjJvB39Qr717
	vAMCo2/xjBeB+aw0W5ef9XVf/OHB0D57Qlto15yt2rHQB5A==
X-Received: by 2002:a05:600c:3b1e:b0:4a2:10f9:37ce with SMTP id 5b1f17b1804b1-4a9665870e9mr14042925e9.15.1793148951455;
        Tue, 27 Oct 2026 17:55:51 -0700 (PDT)
Received: from tachyon.internal (2.155.41.158.dyn.user.ono.com. [2.155.41.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd8dcfsm25111999f8f.50.2026.10.27.17.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:55:50 -0700 (PDT)
From: =?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
To: iav@iav.lv
Cc: shawn.lin@rock-chips.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	robh@kernel.org,
	heiko@sntech.de,
	dlemoal@kernel.org,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	manivannan.sadhasivam@oss.qualcomm.com
Subject: Re: [PATCH v2] PCI: rockchip: Skip the Tpvperl wait when power is already valid
Date: Wed, 28 Oct 2026 00:55:48 +0000
Message-ID: <20261028005548.2399155-1-ehbello@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016-h64-pcie-resume-tpvperl@iav.lv>
References: <20260911211559.207990-1-ehbello@gmail.com> <179196286749.38040.5597453767131590054.b4-reply@b4> <20261016-h64-pcie-resume-tpvperl@iav.lv>
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

On Thu, 16 Oct 2026 01:21 +0300, Igor Velkov wrote:
> A data point from a Kobol Helios64 (RK3399, JMB585 on pcie0, ep-gpios as in
> the mainline DTS):
> - Enumeration at boot works with and without this patch.

Thank you -- this is the most useful thing anyone could have sent. It says
that on a second RK3399 board with the same endpoint chip the patch causes
no boot regression, and that your board does not have the failure I am
chasing. Both halves matter: the first is the thing I could not test, and
the second says the failure is not simply "RK3399 plus JMB585".

The boards differ in ways that could matter here: ROCK Pi 4 has
vpcie3v3-supply = <&vcc3v3_pcie>, which is regulator-always-on, and no 12V
supply; Helios64 drives pcie_power from a GPIO and feeds vpcie12v from
vcc12v_dcin. On your board the endpoint's rails may genuinely come up with
the probe rather than seconds earlier, which would make the sleep do what it
was written to do.

That distinction now has measurements behind it. I instrumented the driver
with two module parameters, one sleeping before the gpiod acquisition and
one in place of the existing msleep, plus a ktime delta across the two
gpiod_set_value() calls, so the PERST# pulse the endpoint sees can be set
and read on one kernel. On ROCK Pi 4C the pulse is 1 ms without the sleep
and 108 ms with it, and what decides enumeration is the pulse width alone:
delaying the assertion by 200 ms changes nothing, while 100 ms inside the
assertion fails every time (0 of 5). Since vcc3v3_pcie here is
regulator-always-on, Tpvperl is met in the failing configurations too, so it
cannot be the discriminator -- the wait being redundant is only why it is
safe to skip.

If your board genuinely powers the slot at probe, you would expect no
pulse-width sensitivity at all, which is consistent with it enumerating
either way. If you ever want to check that directly, the two-knob patch is
throwaway but small, and I am happy to send it off-list.

> - Resume from s2idle fails in rockchip_pcie_resume_noirq. On plain v7.3-rc7
>   with the mainline DTB, 13 cycles pass and the 14th fails [...]
>   On an Armbian kernel with this patch [...] the first resume ends in a
>   synchronous external abort in rockchip_pcie_rd_conf from pci_power_up.

Two things, one agreeing with you and one asking for more.

Agreeing: the failure happens on plain v7.3-rc7 without the patch, so it is
a pre-existing resume bug and not something this patch introduces. Your
conclusion that it does not depend on the Tpvperl wait is supported by your
own first measurement.

Asking: the with-patch run is on an Armbian kernel and the without-patch run
is on mainline v7.3-rc7, so the comparison is between two kernels, not
between two values of one condition. "First resume aborts" versus "13 cycles
pass" is a big enough difference that I do not want to attribute it to
either kernel without a same-kernel A/B. If you are willing, the cheapest
version is one kernel with the patch applied and the resume hunk neutered,
i.e. in rockchip_pcie_resume_noirq() replace

	rockchip->supplies_pre_enabled = rockchip_pcie_supplies_enabled(rockchip);

with

	rockchip->supplies_pre_enabled = false;

so the full wait is always performed on resume and only the probe path
differs. If your first resume then survives, the resume hunk is the problem
and I will drop it: the failure this patch is about is at probe, and the
resume re-evaluation came out of an automated review of v1 rather than out
of any measurement of mine. I would rather ship the narrow change that was
measured.

> - Plain v7.3-rc7 also hit an asynchronous SError during the bus scan at probe
>   in 1 of 4 boots.

That one I recognise. On ROCK Pi 4 a config read that gets no usable
completion comes back as an external abort rather than as all-ones, which is
why a non-responding endpoint takes the machine down instead of just failing
enumeration. Yours is during the bus scan on an unpatched kernel, so it
looks like the same root-port behaviour showing up independently of this
patch. If you have the log with the faulting address I would be interested,
but it belongs in its own thread rather than this one.
