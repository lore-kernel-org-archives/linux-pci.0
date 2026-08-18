Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39184438026
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043341; cv=none; b=FydN3AA7MrJe57l03pYB04rQFd9Qh7Ddht0SLFvKncpv/2YQue/0ot0p9ZCXUn91zKi/3m0+wBeaFMbl0N8bJUXzjjtp2YslvIJypZ16S6agQTd9CTQuyJ2KF5pa5oLB8pClpDRU5/DMxwRCyUwbA/JMgiigBmy607phLfoyyBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043341; c=relaxed/simple;
	bh=3cA87ROwuHAvUqFC+lorDaD20AvisBqSwzUjFEna9FI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e4luebV/19intH/2dBqAHHkBvW4eGbmzbUNpLiP8Vl2FBzTl8xJEemUhZ1EKJWHhBEOMmGqX5NELXFL5kV1wZvAM9v7XNs8T15YEvIwGcUgzZjUNiOWkMwMLoc20NNGroVTQ98/1HwddM2ao+jS2fwjZnPVOG5VDrzgk4jBgrWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQrPs7jG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQrPs7jG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910201F000E9;
	Tue, 18 Aug 2026 08:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787043339;
	bh=qYtJXYGhdHjgZBKE901K5mrjs6fZzYObhnPRFxPQO+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GQrPs7jGKarVxYfw7QrPGqOGNhLcaCbvDo8yHaZl8J2FfrReipam8OgNfCI4erDZN
	 SMBcc92HILCyDwBNl3uF5RtNOHoTdmIAN2Z+Yvp2D3VtLiwjHqM1drrzFsnDjpJQ+w
	 IbPrvaiPT7VZbnK+41zphUIiPu7mDppT8798Uw/8Gun8yYMbrYRc8e3YBXsL7/iXNp
	 hrY7OcU8thAda4wiPuQicuHPJYHew26Ig3tUGMyIidWh9mVIWtF4q2GHMVd94K8XgH
	 lh2sAJZpsUfJHLk05V4dHKveHyN+mR66oYTWdTk9aFUihR5CI9PuxokpvV5OKgy1sR
	 8mq5xuSH72HMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260818084633.1673214-2-zhiw@nvidia.com>
References: <20260818084633.1673214-1-zhiw@nvidia.com>
 <20260818084633.1673214-2-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 08:55:38 +0000
Message-Id: <20260818085539.910201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `ExtSriovVfBars` struct is constructed without an `// INVARIANT=
:` comment explaining why its invariants are satisfied.
--

--- Patch [1]: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV=
 support ---
commit e0446bc8a9435cb9072472f040f7215e21d10ce1
Author: Zhi Wang <zhiw@nvidia.com>

rust: pci: add extended capability and SR-IOV support

This commit adds Rust PCI abstractions for locating and accessing PCIe
extended capabilities. It provides specific support for the SR-IOV
extended capability and a decoded VF BAR iterator.

Link: https://lore.kernel.org/rust-for-linux/20260804161612.776752-1-zhiw@n=
vidia.com/

> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
> new file mode 100644
> index 0000000000000..ddb3fd73e1955
> --- /dev/null
> +++ b/rust/kernel/pci/cap.rs

[ ... ]

> +struct ExtSriovVfBars {
> +    bars: [ExtSriovVfBar; NUM_VF_BARS],
> +    bar_count: usize,
> +    next_bar: usize,
> +}
> +
> +impl ExtSriovVfBars {
> +    fn new(slots: [u32; NUM_VF_BARS]) -> Result<Self> {

[ ... ]

> +            bars[bar_count] =3D ExtSriovVfBar { address, is_64bit };
> +            bar_count +=3D 1;
> +        }
> +
> +        Ok(Self {
> +            bars,
> +            bar_count,
> +            next_bar: 0,
> +        })

[Severity: Low]
This isn't a bug, but the Rust subsystem guidelines require an // INVARIANT:
comment when constructing a struct that has documented invariants.
ExtSriovVfBars documents its invariants above, but is constructed here
without explaining how they are satisfied. Could an // INVARIANT: comment
be added here?

> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818084633.1673=
214-2-zhiw@nvidia.com?part=3D1
