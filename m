Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A1D19C540;
	Mon,  2 Feb 2026 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770041909; cv=none; b=V4X98VWhkoPHRehFrT44so4YSLySGVujg7Sk1z+2BIiTqwTSoFmxf2hgw8NR1JCyXi5G3R0kPiQETyhsBrZZFVAkTsi6xMKeu+CF8F4Zsm4k10ZTRjlFZM3H9mV7wAudqfJScP5NHM+EDYo1FsnDVht/LNFjNES4+YLEX0bG9eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770041909; c=relaxed/simple;
	bh=swQ1GwXUtwiZw43hmtZv2AY9UUQW53Ew/zq1MMk0t+o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mr8Wje/HzKCusgf4W3AHGVO3YnvqV10Pjk0/D/VrDXYwSGQR5a6DoYxBI5TBdupPn6wDmcY+neHHenEgxiXgR99A+pSlt7b7pS55XjlBt5VNZii6puvTQpl1cc6Usho/M/xEKza/xnvn87CQgucGH5e8QN0MNsZIitfjEDgVF+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHZ0NbBB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHZ0NbBB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688A7C116C6;
	Mon,  2 Feb 2026 14:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770041909;
	bh=swQ1GwXUtwiZw43hmtZv2AY9UUQW53Ew/zq1MMk0t+o=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=HHZ0NbBBkM1ck1l3qIyJqKsZH9jae9gr/NiDeYf7hEZiQnCjwRHu7EFEWW66SZecI
	 yaoLufzjDbMjexeQmFHls3vJg+yOY98lox2jQX7qYsrrTa/mZ7khfUuMrXavKHKhDG
	 9sa1Qy3rzvJe6MC79lwI9a97zPDq+dPuXLWAp54tDo4VbSjQqKVgJHc7jDNpuwx/oc
	 Eg0QAfBKkug/fyOPVDFwv9N77fEekCQhSv3372IfNuUS32QHrfsLp6uIJXNBc7Cxp/
	 6VXIaQbXEjjLcaDVxR1z0okNT/ZE2XyotFdIEGM17V8j/Sp5mudaP94NnoAHSIdAy1
	 yDK8jWmGRIgSA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 15:18:23 +0100
Message-Id: <DG4JHKY0Y19S.24TZ7TAX5ISD@kernel.org>
Subject: Re: [PATCH 3/6] rust: io: provide Mmio relaxed ops through a
 wrapper type
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, "Lyude Paul" <lyude@redhat.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
 <20260202-io-v1-3-9bb2177d23be@nvidia.com>
 <DG4J98HVOUEX.I7XOB7LPB49L@garyguo.net>
In-Reply-To: <DG4J98HVOUEX.I7XOB7LPB49L@garyguo.net>

On Mon Feb 2, 2026 at 3:07 PM CET, Gary Guo wrote:
> I think ultimately choice of order to use for each I/O access is local to=
 the
> specific access, not a global property.
>
> I know you can just do `RelaxedMmio::from(io).access()` for each single a=
ccess
> too, but it feels quite verbose.

mmio.relaxed().access() would work as well.

> I guess one alternative design is explicit order on the access, e.g.
>
>     io.read32(Relaxed)
>
> Or
>
>     io.read32(Full)
>
> however this is verbose in some other ways... I'd like to hear how Boqun =
thinks
> on this one.

This apprach would be misleading for a lot of other I/O backends. For insta=
nce,
the I2C bus has no relaxed ordering.
