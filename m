Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794619128;
	b=nBaOkNQSAIPHrA73wscg1Qqx47M3jto1qGzm4X43Yl+gf9MfHKTSkj1xhWYa8b+eY00S
	 85wwWc+Xa/xapkyEfgCshJ0q2knb2/St4jeyDRC5DaeRwSMMXIKiKRDt53F3gk/vUkWdY
	 3VNddvlElgKUFmUcRww3Ulw4EFL9oDRpR9KIOgT7WnpRXJURwUuXJllAUqc5vSf2BAcAy
	 FnGgisnhdz79lBPMnIhRjr7E94Q7nVn4By7M2gwdsa0ASArcsrOHXK5KcR4DarVQJqg78
	 maXXw2IdG7xHZOlJvxxMqQh1x7Lqi70UtYw47nYCxuytyyP6jolSw82lFnkMyYSJVXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794619128;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wmVGPgSL0c8qID+VDI0TPgSKhatmVBsYpSBuw3LOSy8=;
	b=kYsw7+2WcGC+I39rSoUqpHZtNurWfYrZg+OQc6N5rer0o/raPYIozNuAN1stKJQ1hod5
	 RyHU5C1bJJNn8sEY7EdvDmxBq6hY4DsGDWM5GFavmrerfuZirWCvmDV18Dbi+3ROiPuHU
	 PE2r9A1eid0WmrtIxPQUFAiwcz2hQ/DbMO08z3SrcMsYPBYTGu7VzIF91vt0E2BwWZ4rV
	 4bHTRlGy2zRmezDTV6URJh/OgNmszY0ZRWX6W9KkaLAJCRHWl+pK624913Ch3Ad9+tzbQ
	 NZqxL5gZaSh0RU+qR5/v1A3fyFH6m9H1xUezpULp14P7O15IDT3cy+i8os75GNy4AJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cG9nu54o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE5606A336;
	Sat, 14 Nov 2026 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cG9nu54o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070BD1F000C4;
	Sat, 14 Nov 2026 01:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794619128;
	bh=wmVGPgSL0c8qID+VDI0TPgSKhatmVBsYpSBuw3LOSy8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cG9nu54oWUwSepxqOgG86lSOoydJGG5oWOoJFj6KoBlOvC7wRpgSImvAcYdCbpzlC
	 1mdJuZa6mQ5F2w1yQPW6V4Ut9sMcNjAqZSjlqhxglFOYAVz/Lq16bj7q6ESBKTAxM+
	 +5sKFQv67utTG4rywYoTHpqaWpPnOB0LzE7ZLscmr2ZUE2TZfMfFtlse3X/NDPtDSD
	 tgPu2hl58Sr5ZnjZGefpX5UwBRXtXY4TQDO9XPng0Jhb1OTGmML5E0vi5283GEeuzQ
	 Xzhp+qA6Y6etAeOv2tMsYiUr095egyDcc6Eq3bHlkQVahSm2eiUvvnaD+2H6gMfcTb
	 k0VlvYxyCYmqw==
Message-ID: <sashiko-outbox-214001@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] PCI: qcom-ep: Set initial interconnect bandwidth
 before enabling clocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261114-monaco_ep-v3-4-7fe227cdfac0@oss.qualcomm.com>
References: <20261114-monaco_ep-v3-0-7fe227cdfac0@oss.qualcomm.com>
 <20261114-monaco_ep-v3-4-7fe227cdfac0@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 01:18:47 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: qcom-ep: missing Fixes trailer for commit 01794236666a
--

commit 41911bfe7f3846f665ed95b61c308e2f3f2bb60e
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

> PCI: qcom-ep: Set initial interconnect bandwidth before enabling clocks
>
> Some Qualcomm platforms require the interconnect bandwidth constraints
> to be set before enabling the interconnect clocks, otherwise some
> clocks get stuck in the off state.
>
> Move the icc_set_bw() call before clk_bulk_prepare_enable() so the
> bandwidth vote is in place first.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

[Severity: Low]
This fixes the ordering between icc_set_bw() and clock enablement so
interconnect clocks do not get stuck in the off state.  Should the commit
message include:

  Fixes: 01794236666a ("PCI: qcom-ep: Add ICC bandwidth voting support")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-monaco_ep-=
v3-0-7fe227cdfac0@oss.qualcomm.com?part=3D4
