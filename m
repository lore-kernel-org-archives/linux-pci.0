Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022B9373BFE
	for <linux-pci@vger.kernel.org>; Sat, 10 Oct 2026 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791648806; cv=none; b=cs/vbJYBewMq5xTprv3YCdi3qJiRlOrrIIIDDg0OofDvs/7MYCoBErGTOC9eE9JxnVSZG+YxLp2rY+ALOYC5fQOmMwccX5l9G8C6NHi+2JTwQnTgvvAtEke1dW1AyvFvLzf4XutaPvFjSm0d9fOyUxpmQCjRULSWvuJJqTgEzkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791648806; c=relaxed/simple;
	bh=zW5XbYvhYCeM5TwDWW2MKGEAgDDr7/gtOqtLdR8YYvg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YySD4uYzzGnCVn0OQ62xkFEI4WbfITA2V0hHKY43hiY1V5j6V4avM3hi3oHfHq6CKJD3a0HAx3+IZvZUKVhDG9NIHti21AczP+jIKLId0Q+cIo7NM4GqGssaSGVT8uT9usUE3On9bNY3U4PKAgYFz1WSuRl/cwc2lBvXG/Ahh1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ah8W9BCk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ah8W9BCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DC41F000FF;
	Sat, 10 Oct 2026 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791648805;
	bh=FEOlwz8tVBG6SR05y15QbZFnEgh7Rb57KuzZefasZgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ah8W9BCkZn7tsOeRRRLnCuZj62hcFxEUuR3TPogOmW52ToM47OBafp8LXBK0ORyfC
	 erpnXbUoLklr0sNK7Tpva3YeIXNnV0mR74aRyFLSZz+PkQ31Jn7nJZfcE89jUYfw58
	 9Nl12vDhsE7s2PPMsovJjv+CPgkkZPjD4zFQYCQZU4t9KJt0lQJQ1cDw8jHZevVGdt
	 1XwdXyDeVvQ+T2FnsJppld9YaVbfVrmyKWxrfB+82N/qPGb7IaQpmRLim6EUvPKPce
	 P4clplFer7P/bUgG9Hl1rh7zb94pTFq8PMBZzZhZgJzIk07FcLczRFVnpo+07OdkoL
	 aZxFBknSS7ffQ==
Message-ID: <sashiko-outbox-166726@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: Don't treat ~0 as ready in pci_dev_wait() with
 RRS SV
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gruhlke" <gruhlke@mailbox.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261010160529.27974-2-gruhlke@mailbox.org>
References: <20261010160529.27974-1-gruhlke@mailbox.org>
 <20261010160529.27974-2-gruhlke@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 16:13:24 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> With RRS Software Visibility, pci_dev_wait() considers a device ready as
> soon as reading the Vendor ID doesn't return the RRS value.  Some devices
> don't respond with RRS while they aren't ready, so the read returns ~0
> and pci_dev_wait() stops waiting too early.  This was seen with Intel
> [8086:0a54] and Samsung [144d:a80c] NVMe SSDs.
>=20
> Also check the Command register for ~0, as without RRS Software
> Visibility.
>=20
> Fixes: d591f6804e7e ("PCI: Wait for device readiness with Configuration R=
RS")
> Link: https://lore.kernel.org/r/20250611101442.387378-1-hui.wang@canonica=
l.com
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Alexander Gruhlke <gruhlke@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010160529.2797=
4-1-gruhlke@mailbox.org?part=3D1

