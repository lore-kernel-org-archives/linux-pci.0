Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907101;
	b=d+y3jC9PhnsbTiDL6JHnL0NqXb3lYfF5N7SvbLhhpoBjpneI1m8slTsGL/Dkr6Shaik9
	 l5NhzfdDOZ9BqXSr5+So8ZjRtpKgMqePUOnkoN/jJJ3naAB/6KtT3hncUcnvs3+bvLWmg
	 ONlDDxbLr3sgaOGKpaNP5jyi51juwb1dPUOfY5bpjddq3cHm8AkR0SbUiR4fy3+IDSGpH
	 11kDsoQiO2ucF7YWr3IBLJZE/pj3GksMnLcWZnkebo7R5/PbKbNe1bKrzmcAPYTx3RMXg
	 m6zDwQfmxai1h7b5uykd96RGf85t3wGWzkvqfz83s8DqDzmWFpTIyZGGusvT5vy1bqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907101;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Wh1I8mQTAIVGpFAVE9YQXYRLxcerlJCe1n7oS8WqiTY=;
	b=mSD2jNoICeVczWh+zlsZWsMhaz4DAR6NmmxGlpL6S+mkpGoE1qc2pJMF5k4O1DQ6T0ym
	 DcY5s8zrfiOcgeLy5j8/X+Y7pCF4tz9gZ0o2h1IMnYvLS+PfWNR13LDIvz2NK9C+xj2NV
	 3MQZE6UOHD34khIZNQ4aXvS5ZcoLmeoNlif4BxJfMytAA62FZS30Es9IaIvAiXpk+nWS6
	 Gihssl6rsCGWCKM6rrwzSidnxZTa1zD1OunstnMLk13Q8FIGA49ZQb2MUhQUvJXA5AXA5
	 T3emhIQpHnnFLr4ZVRsJ116IgEVymUV7J69hc3SnWHuG2EiFQCZ7pVBcw3Tl2LVKFDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kbD8yVaZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E0F606EEA8
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kbD8yVaZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22311F000C1;
	Thu,  5 Nov 2026 19:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907082;
	bh=Wh1I8mQTAIVGpFAVE9YQXYRLxcerlJCe1n7oS8WqiTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kbD8yVaZMiT4x8vYP3RrV1d1uRAS2q511B7HGwEYqPSzft2/MBwm+cSEO9y10QF/2
	 nqolvn+AyM7hYT4KB+xVcgW0JZp71vU3wPWnYNUq+3oMGWDTwZYp8MiUvTKXjNEw/C
	 9F6/pNJwZHBoW0j1adf+vAfSTB/ANl+y6iiEB+fYTHFqF0gzTA19pjEEwpFHy/+brm
	 ff1gNQ4Tgnl/sK31cOmxEyETbIGxu8Xl4qr6xQ1b8x8fBeB9DF/Jk1QDX21B1nPVDT
	 E9ECOvCopFKEMWLHEu1pEMlxprYGeHy4bCL4RcfLuW+7dwmxh8xlNt7kfu3DJD0UTn
	 YVM72I3fBi+0w==
Message-ID: <sashiko-outbox-199917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] genirq: Add disable_irq_noflush()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Keith Busch" <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105191556.4042191-2-kbusch@meta.com>
References: <20261105191556.4042191-1-kbusch@meta.com>
 <20261105191556.4042191-2-kbusch@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:31:21 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Keith Busch <kbusch@kernel.org>
>=20
> Drivers that switch between interrupt and polled completions don't need
> the mask write flushed to the device; the disabled state already
> keeps their handler from running and a late interrupt is replayed on
> enable. Add an optional irq_chip::irq_mask_noflush() callback, falling
> back to irq_mask(), and disable_irq_noflush() to mask through it right
> away rather than lazily.
>=20
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105191556.4042=
191-1-kbusch@meta.com?part=3D1

