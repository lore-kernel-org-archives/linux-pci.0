Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18810428470;
	Thu,  3 Sep 2026 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423423; cv=none; b=qEelhsY58CpoICOSwjHi4kJm8sLEC3tJ7uOa/7Ym+yFiIFQLM0mAdBEdfbUzBQ0iC+nRfCH4b6yPmauw87mjs9wsi99B1IeW7TgUK/S6dY5KTrSbj5FiK0fCjEwpyAuUkdSgaeF25mT9fUbfDybWW9bTZopWvr+qaVYeEPmO4zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423423; c=relaxed/simple;
	bh=nFgHUmXY0H0fGkq1ZSQWmQyJVVAEuW1XpraJXIMbN64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XuU/YcJsc0GtzdPAMunLtL3PqsPQmbnf3CggNw9RQ/ljjMP5eFIWmrJ2RW2llP8whbbM8AIvQT+M+fLbDA9SFrox/DitVmg+bTwSNpyYHWT+mR/lUucpPKYgyzA99v7myx8+peSqwYg9+6zKd2S+B85WbQLrzF8YpacD6882Jlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmru68w9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmru68w9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2211F00A3A;
	Thu,  3 Sep 2026 08:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788423421;
	bh=gWcXeQFwAUR5SUy0OZaHIclAg5KjbV7/WpZ9VNjLN1I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hmru68w90RnA2Jajtar28jrPB2qzKnLYqrvFPh8co+i8C0+L64kd0u01HLid+g23a
	 svFKgJ8uxpmYfIHC6TsOin+q2N4uQxxECJTgRKh9z/ytrABpehoHg9e3Sf+lydYMHW
	 9QOkDUfnxfSLRQEnl1SmnVwGgeSjAGXHRVOGTUnhSFepqq8OMC7uu2CbjczBtbD6EG
	 KB0t5jtWCbxIimaxa3suaMpJyt4hugX+8IO4L4s8CVbe2vq02qptUAJVtdUOs4b8sw
	 DL9EIKaCUwEsbzl0iFSDCz7k93WffG0oOVd6JeW3TWrrSpTnjCY+bd9vxuYGuti08R
	 v5CU1Zt75S01Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/8] hwtracing: hisi_ptt: Add pattern PMU config for
 trace format selection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260903075241.1445338-8-liusizhe5@huawei.com>
References: <20260903075241.1445338-1-liusizhe5@huawei.com>
 <20260903075241.1445338-8-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:17:01 +0000
Message-Id: <20260903081701.7C2211F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The `pattern` field in `struct hisi_ptt_trace_ctrl` is defined as a=
 1-bit bitfield, despite being documented and parsed as a 4-bit field.
- [Low] Typo in the newly added documentation: 'message-type-basedfield' is=
 missing a space.
--

commit 089e32a211137f88a4d8b5c44e954565dc797fe5
Author: Sizhe Liu <liusizhe5@huawei.com>

hwtracing: hisi_ptt: Add pattern PMU config for trace format selection

This commit introduces a pattern PMU config field for controlling the TLP
header format traced by the hardware. It allows selecting between a legacy
format and a new format using a 4-bit configuration value.

> diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-=
ptt.rst
> index f6a2655f99e57..c95eaa12f4d35 100644
> --- a/Documentation/trace/hisi-ptt.rst
> +++ b/Documentation/trace/hisi-ptt.rst
[ ... ]
> @@ -255,7 +255,28 @@ directly from the TLP header.
>       DW2 [                     Header DW2                            ]
>       DW3 [                     Header DW3                            ]
> =20
> -5. Memory Management
> +5. Trace pattern
> +-----------------
> +
> +You can control whether the trace is taken with the new version of the
> +TLP header format by specifying the `pattern` parameter. The default
> +value is 0, which means the legacy format is used for backward
> +compatibility. The parameter value is 4 bit and bit[3:1] are currently
> +reserved for extension. Current supported values are shown below:
> +
> +- 4'b0000: legacy trace format
> +    DW2 and DW3 are printed with generic field names only, and
> +    no message-type-basedfield decoding.

[Severity: Low]
This isn't a bug, but there is a typo here: "message-type-basedfield" is
missing a space.

[ ... ]
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/his=
i_ptt.h
> index 46030aa880811..584f65ba1e320 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.h
> +++ b/drivers/hwtracing/ptt/hisi_ptt.h
[ ... ]
> @@ -139,6 +142,7 @@ struct hisi_ptt_trace_ctrl {
>  	u32 filter:16;
>  	u32 format:1;
>  	u32 type:4;
> +	u32 pattern:1;
>  };

[Severity: Low]
Could this 1-bit bitfield inadvertently truncate the 4-bit pattern value?

The documentation and hisi_ptt_pmu_init_configs() parse the pattern as a
4-bit field, but assigning it to this 1-bit bitfield will truncate it.

If future extensions utilize the reserved bits (e.g., a value of 2 or 3),
the truncation would silently drop those bits, which could cause the
driver to mistakenly fall back to the legacy format.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903075241.1445=
338-1-liusizhe5@huawei.com?part=3D7
