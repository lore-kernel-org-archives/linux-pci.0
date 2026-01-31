Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9950A2FB983
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769826355; cv=none; b=EecSEqy21FqkYPhptiAy3xFKmp7Nfyr7+tIn2mQT7hXtBH/b/Qko43bdINaLRNXirpWaLcvD77SMNZg623gexNLQxTFnXKJ3HKnAAAZR3omOZAB0ArngPB1kCRkOlKf0HrBFEHZE4FyJp988bLLWv4VODwJ5LQc/2XHFX8qdKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769826355; c=relaxed/simple;
	bh=AlRrt1++X8RQvr+5pBWD/usm0305T4/ENaeNzHqdSdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j6vkBTvhqJAU+AKt7Ea3qyEWuRjOdL452N0cnlTojE032TTKGJdQfKrHH5trRseHH/lwoVpvQIw0o3/BU17RcjxL2LHSJ1VofuuEYtsCqHUS6ZN2T8PALfAV73mg90HHZiWehXDohWQGRtaO7AD7PVFeBvn/rNttdMdOc/D6cwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=NwBzp9MA; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="NwBzp9MA"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id B1A08240027
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 03:25:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1769826345; bh=AlRrt1++X8RQvr+5pBWD/usm0305T4/ENaeNzHqdSdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=NwBzp9MAFBT1FCNrRaTOfsvPKUbhYcMRNzqNJ3FECDDAX1eZFg668oFczqsJeibVw
	 09yWupybUQT0jFlDTYfrJy5QV8FL3Eo029nCpcst4ASX34AEeZgSQU03Bu5rESl1oV
	 QvV4hSfG9toYvXkupoDnBFzIi2fEL9nm6PirkcvJU1EN/Cu8ttRBTIVW1Tfi2BKBc9
	 iJKrg8GbPgaN204uC5zE626bjXs7gVeyIsH3a6zqdKIIe7VNekhdLXflsz7X3P3CCl
	 yEi3BfiO7WQ/X1SY88GBtIpz/fpnJxN0eXIZ9AEiHY66EGAt6veV7iDCaXvr/BLkyu
	 /6gjQNMw4OAlA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4f2xYz0cjTz6tsf;
	Sat, 31 Jan 2026 03:25:43 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Zijing Zhang <zijing.zhang@ry.rs>
Cc: dakr@kernel.org,  ojeda@kernel.org,  bhelgaas@google.com,
  kwilczynski@kernel.org,  boqun.feng@gmail.com,  gary@garyguo.net,
  bjorn3_gh@protonmail.com,  lossin@kernel.org,  a.hindborg@kernel.org,
  aliceryhl@google.com,  tmgross@umich.edu,  linux-pci@vger.kernel.org,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] rust: pci: add config space accessors (and a
 small in-tree user)
In-Reply-To: <20260131021803.1146484-1-zijing.zhang@ry.rs>
References: <87sebmzk0i.fsf@posteo.net>
	<20260131021803.1146484-1-zijing.zhang@ry.rs>
Date: Sat, 31 Jan 2026 02:25:45 +0000
Message-ID: <87h5s2zffe.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Zijing Zhang <zijing.zhang@ry.rs> writes:

> Hi Charalampos,
>
> Thanks a lot for the review and for testing the RFC series (and for the T=
ested-by).
> Much appreciated.
>
> It turns out I missed that PCI config space support for Rust has already =
landed via
> Zhi Wang=E2=80=99s series:
> https://lore.kernel.org/rust-for-linux/20260121202212.4438-1-zhiw@nvidia.=
com/
>
> So my RFC is redundant and I=E2=80=99ll stop pushing it to avoid wasting =
reviewers=E2=80=99 time.
> Sorry for the noise.

Mistakes happen, I also missed it myself.

Cheers,
C. Mitrodimas

>
> However, Gary pointed out a real usability/doc issue in the current API: =
while
> `ConfigSpaceKind`/`ConfigSpaceSize` are re-exported from `kernel::pci`, t=
he
> `ConfigSpace` struct itself is not, which makes it hard to name the retur=
ned type
> from `Device::config_space*()` and also affects rustdoc.
>
> I=E2=80=99ll send a small follow-up patch to re-export `ConfigSpace` from=
 `kernel::pci`
> shortly.
>
> Thanks again,
> Zijing
