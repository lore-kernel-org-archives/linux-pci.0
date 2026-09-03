Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D613EC81B
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 06:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417681; cv=none; b=uzsPQztvHxcvB95lgTLy+BwM1CpEBvSUZStsfClRs8rygmqv8AlPBD+PIF0H0gTd3OhGF3JL+8XWMZDpp7HdrphAkfqgD6ptdMl2Nv24CXFxfZXd2CDCqFV5Vl0w7ySMDqRLJJXoS+cam9okwvxKD8p4CW6pn7EoA3Ts3xqCSk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417681; c=relaxed/simple;
	bh=SfKssssLeWKCFofjWMwwEAMkU33TViZYopeZNDqTzLM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eq0ZpMsW0uEPANdBI5M7A5YHTrtteVAqFKyNKRZHc56ftIreY9HjwSzBulhzhW4k2k3E6d3TwFgNcqUlP/BNGUkU0swVOFT3+PW1XMEa2+kUcxEu0lEwNeHijaUK0+FzKcjrYUdMjZQouYzYz6voVx+xonOptxtToPzbOCoz5Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7CIxV9a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7CIxV9a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062EB1F000E9;
	Thu,  3 Sep 2026 06:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788417675;
	bh=kDtL7yEn2fBaNyWvwOyoAmPEDlgixjrIr5JhIW1ednI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W7CIxV9aVq75ejoXWJXtSj4dR4vf5PQEJUnsNWhLjt7V9KQMCO1N+Ho7XexROlfET
	 uZiMN7khZ/B/A8JlXQ5L2/0HRR8mL0ZxN72K1WpAAoApcbTCx0d3yCd4UvbwM52zNv
	 0K9wFRrhK66wTtQIAUbTmqr9pxJpPRMvV1G+33VIlge4IukjAwoSFUkVBXF9waikOz
	 BI0tYVfHyWvkJSf+iCTwPOOc+vOIAJ4K1SWOU7URPrli/0IdyqG1l5nSc1gEFq0vHu
	 vN3MRpXrMo7bEEpXPxXOAAet6C84RQqgL2sCKB7YPJzTbvvDm6Qji8JAWVwb58Uma+
	 5/vH7uvuPA2KQ==
From: sashiko-bot@kernel.org
Subject: Re: PCI: bridge window undersized when child bridge windows are
 larger than their alignment (regression since 3958bf16e2fe, v7.0)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolas Joshua Britton" <nbritton@exabit.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260903063124.9316-1-nbritton@exabit.io>
References: <20260903063124.9316-1-nbritton@exabit.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 06:41:14 +0000
Message-Id: <20260903064115.062EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Hi,
>=20
> On a Mac Pro 7,1 with two Radeon Pro Vega II Duo cards, enabling 32 GB
> Resizable BARs leaves exactly half the GPU dies with no BAR at all. The
> shared root-port prefetchable window is sized as the plain sum of its two
> child bridge windows, but each child secretly requires a 32 GB-aligned
> start, so the window that gets allocated is ~32 GB smaller than the span
> that is actually needed. The second child of each pair loses,
> deterministically.
>=20
> There is 1 TiB of free space in the host bridge's _CRS window, so this is
> not address-space exhaustion.
>=20
> This is a regression. On the same machine, with the same script
> (resize-amdgpu-bars, https://github.com/exabit-io/resize-amdgpu-bars,
> [ ... ]
>   - lspci -vvnn from the v7.0.12 + patch boot
>=20
>=20
> #regzbot introduced: 3958bf16e2fe
>=20

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903063124.9316=
-1-nbritton@exabit.io?part=3D1

