Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D734A3C2BB0
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 05:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790661362; cv=none; b=nqwOFgMR2B8R2t57oZ9PS4GBcczl+2ML7HndfC5eMGTVDr89TWy+kgYFcHj8BAb7JDoz2UGag5n4LzkssM8uRWJnrsIo28om8HLAnLiQPwYt2BG9qnjB7kdbrwWZgQmrJIoR/cQmjQuv+Pr0cBiZ8KPn9jWKFVaR5OVOIH81YR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790661362; c=relaxed/simple;
	bh=vhB/YPZ5bhnNzIhRbpbcWq107ObS8fBRqIibFgpDl7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jsIL3yB3rvNV/jtB6YyKetu1XwrADDSeciuE0eXeMtxXIQo+hSE1h/6KGSuaEvDs6bgH6u40uBxFcpq0v0c62nRjZxkzfNCotg8u0aG5+REmbagmPN+9Bb3xwcyotRyrPpw4AH3t6o9r5qm+WtvLbPmNH/SOHIUoaVSYLv3k9NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahD3kJbw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahD3kJbw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374E01F000FF;
	Tue, 29 Sep 2026 05:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790661360;
	bh=EHOXOVNYVI2nIh5JqWZ4iZZra03DeIbwCSev8Aw0hDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ahD3kJbwRTTDdhUOTn2n26Fyp3PHz+S7ZYJplQCRB+CguckvWR1kW0nDotlKlfbHr
	 l9k6IDbZL6XeyAp5z9h4xa5ZyQKRv6byMCWpugdqz8TzAokkaUxCxSzXMalgb3gzxc
	 th719eVDbSzYXHKgCwmWO3LUAou86wnbh6b8ikgrajN5ERzY5arAiATOwLmdvGi2tD
	 xb5Ze2JZGh3Y+wrOyjBaxAkdk+r5qMBEwqfMy+KPPi8Zv1ZWFH1CQGyXPudAiYXkRQ
	 nI4J+U7b8sZcLqG9kyYI4Ur3xksUeEadOSjkseQDtgCFsFQyb3SjOG9ub/O/VebN6B
	 ZsRVdKCfFJGAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929034510.2023173-12-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 05:55:59 +0000
Message-Id: <20260929055600.374E01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] iommu/arm-smmu-v3: memory corruption from dropped ATC_INV when SMM=
U is suspended
--

commit 1d62496e7c0326798403d88bba79adbf58c43810
Author: Pranjal Shrivastava <praan@google.com>

iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to gate CMDQ submissions

This commit introduces a CMDQ_PROD_STOP_FLAG to safely gate command queue
submissions during device suspension. It checks this flag in the cmpxchg
loop to avoid abandoning batches and indefinite polling during drains.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
[ ... ]
> @@ -726,13 +727,42 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_d=
evice *smmu,
>  	do {
>  		u64 old;
> =20
> +		/*
> +		 * If the SMMU is suspended/suspending, any new CMDs are elided.
> +		 * This loop is the Point of Commitment. If we haven't cmpxchg'd
> +		 * our new indices yet, we can safely bail. Once the indices are
> +		 * committed, we MUST write valid commands to those slots to
> +		 * avoid indefinite polling in the drain function.
> +		 */
> +		if (Q_STOP(llq.prod)) {
> +			local_irq_restore(flags);
> +			return 0;
> +		}

[Severity: High]
Can this early return cause memory corruption by silently dropping ATC
invalidations?

When the SMMU suspends, Q_STOP(llq.prod) becomes true. If a driver or
background thread then calls dma_unmap() to free a buffer while a PCIe
endpoint (with ATS enabled) is suspended to a state like D0, the SMMU
driver will observe the stop flag here in __arm_smmu_cmdq_issue_cmdlist().

By bailing out and returning 0 (success) without actually submitting the
CMDQ_OP_ATC_INV command to the hardware, the IOMMU core is misled into
freeing the memory while the PCIe endpoint's Address Translation Cache
(ATC) retains the stale translation. When the PCI device resumes, or if
it issues a TLP while in D0, it could use the stale ATC entry to access
the now-freed memory, bypassing IOMMU protections.

Are we assuming endpoint drivers clear their own ATC or that a hardware
reset handles it? Client endpoint drivers typically lack an API to
manually clear the ATC, and SMMU hardware resets do not broadcast ATC
invalidations to endpoints.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929034510.2023=
173-1-praan@google.com?part=3D11
