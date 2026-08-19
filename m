Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9744E3264F6
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144293; cv=none; b=Stoe8jbyEwhBmks2lRtJuMG6vC6xJTEN013BxlQW61DkFJWAjfYsgAWSlgwpTYkf+74PRgepX1XdtQjnu5LqGdnz37wVGQ+dk8TNOuo0KrBiW9Okv2trxv3lxE76HWKdBUU6KS3h5rSDREFickyd77K6JF4Nx5yt6MMR6AYs0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144293; c=relaxed/simple;
	bh=+IuzeAKlHLAgJ+HTe85ki0F42Yd9PfTNEINDdk/62S8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X/OTmJsaevwiKifD2tA0D2Q1QsOz7M+mwVGOHViPbtdZvBBPzQQQyswewznD7AnMkVPp5vqm/WiYPKw8RP2NsWsHWMcXWTH9geETXtz6+l1cuUm+MbgjWVDghQobQmRcwN+paYdCuXNzTGdlXALQncnR1LmjrI2fzUaAxaYcoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyHXbded; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyHXbded"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CA51F00A3A;
	Wed, 19 Aug 2026 12:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787144292;
	bh=m+XKvG6tpuI2i2d3hpSjUlLCa3wVr/ZiGa1wHAZyb7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SyHXbdedEQBBKc9MXaim3mIL8Yf1e6A2v2qLeawnGZBSMjdYGWD7WN1WwuoMJnBGk
	 uhI4/Xf6bbXkqpFyVdHaVR4uoeYOaf7tWHteTwrAjUzfUKzWOLR/08ha0MDtQRqSSd
	 WeRZi4PFi46cImdPoWxDQ3BzoO12Xr8cajjw2E4jZTYsgYSfWw5BRKgH7iVBLoy/sR
	 GyxPG//mx0fK04WJR4axrsC6B22bnjEg4wzxtIfQ4TrapMC4ETf6I1c5/pLSS6Rzn/
	 b30xY+01GH16R+gxWihDOcBzsDKQcvwUT/GSHzpH4IyMt1dvlubP1zrluJEjagmlpD
	 GkSSH3mSAKKFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/7] genirq: Add GSIM user space configuration
 (procfs)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luigi Rizzo" <lrizzo@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260819124341.4185621-6-lrizzo@google.com>
References: <20260819124341.4185621-1-lrizzo@google.com>
 <20260819124341.4185621-6-lrizzo@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 12:58:11 +0000
Message-Id: <20260819125812.60CA51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unconditional removal of conditionally created `allow_sw_moderat=
ion` proc entry triggers `WARN(1)` on unsupported IRQs.
--

--- Patch [5]: [PATCH v5 5/7] genirq: Add GSIM user space configuration (pr=
ocfs) ---
commit fc9564358ed0238056ccb83c0aee7d6d588c4901
Author: Luigi Rizzo <lrizzo@google.com>

genirq: Add GSIM user space configuration (procfs)

Introduce procfs interfaces to configure and monitor GSIM at runtime.
This adds a global directory /proc/irq/sw_moderation/ and per-IRQ files=20
to individually allow or disallow moderation.

> diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
> index 2c75feb6634f3..1474d33455410 100644
> --- a/kernel/irq/irq_moderation.c
> +++ b/kernel/irq/irq_moderation.c
[ ... ]
> +void irq_moderation_procfs_add(struct irq_desc *desc, umode_t umode)
> +{
> +	if (!irq_moderation_supported(desc))
> +		return;
> +	proc_create_data("allow_sw_moderation", umode, desc->dir,
> +			 &allow_flag_ops, (void *)(long)desc->irq_data.irq);
> +}
> +
> +void irq_moderation_procfs_remove(struct irq_desc *desc)
> +{
> +	remove_proc_entry("allow_sw_moderation", desc->dir);

[Severity: Medium]
Will this unconditional call to remove_proc_entry() trigger a kernel warning
when unregistering an unsupported IRQ?

In irq_moderation_procfs_add() just above, the "allow_sw_moderation" procfs
entry is only created if irq_moderation_supported(desc) evaluates to true.

Because irq_moderation_procfs_remove() lacks the same check, freeing a dyna=
mic
IRQ that doesn't support moderation will cause remove_proc_entry() to print=
 a
warning stack trace about a missing entry.

Could we add the same !irq_moderation_supported(desc) check here to avoid
the warning?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819124341.4185=
621-1-lrizzo@google.com?part=3D5
