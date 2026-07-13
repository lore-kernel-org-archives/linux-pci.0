Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8D435C19F;
	Mon, 13 Jul 2026 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783982793; cv=none; b=tEAa3sX1WvpiqZT4ITtGieByjBRl/z2fJ4fDV1A4onRDFfW/x3uDmG+LPLfL6ULFfLe+Jk0cTN7Sk3Gu/U/0HRtXy2qQ2LNZOD5/nk6JVhLKmOYy1XpCjD5iMc9q/+sCnqEVpVDsjgwn3mm0AsUp5A0IFhLP9HqIuK8vO2EusUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783982793; c=relaxed/simple;
	bh=ki0rf5KXacbCrzLLJ68G/ZKvopgBN+PE/LQidwi3tPE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=Tc4gaUhL6M1kp2U6ACbV4Y3rphs/c9jtCnpvfN0cdhFreR57bY10nFLUBO3gPA08kBhMz8LSaGOIWqZl5LybbfV2dZ9tvqCGaJGGN2uXuw3m08MhPixes+t+61JOX00z6WpqGDgyhoZtGBSkgOKQ0kTAGpzaAqeoLjkgBdlhzzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDPceOJt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDPceOJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EFD1F000E9;
	Mon, 13 Jul 2026 22:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783982791;
	bh=v/c9cJvLiRUh0chD13eoJnb/QVSK0PEeoY/ZOsgieZg=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=IDPceOJti8yjJTBHFR/PJstHcpy5h9nOpUFSwcTgPBT3+IeSs0qigOxd/Utj7ob/r
	 616LSjIgzvakV7IRTDokAowfnRuKuyFD2ARi0jsLG1Qaq3QlQcsYqRUp1TRom5MIWz
	 2znZQMzmZ3oZvtG1loeTGp57R4o6Dk1VQUFK9xP636/aeuem84FHzqwVc55gucAUeL
	 hk/hgly4VxBVThEtB2B8QpRaq/PijFbG5KVzNtd/zfEAYm16zQC927QhbxsrIfVtXF
	 1D/Y7O854UGxSn5pgCyRYMF5CMn6owa2l/GSTrDG+2QQNlKfJ60UtpqQPVprgTm363
	 KQoips+yb76pw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 00:46:22 +0200
Message-Id: <DJXT48G5GZAJ.346BAPDEQ53FT@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Michal Wilczynski" <m.wilczynski@samsung.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>, "Laura Nao" <laura.nao@collabora.com>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v6 00/20] rust: I/O type generalization and projection
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260711161035.370023-2-dakr@kernel.org>
In-Reply-To: <20260711161035.370023-2-dakr@kernel.org>

On Sat Jul 11, 2026 at 6:10 PM CEST, Danilo Krummrich wrote:
> On Mon, 06 Jul 2026 13:44:13 +0100, Gary Guo wrote:
>> [PATCH v6 00/20] rust: I/O type generalization and projection
>
> Applied, thanks!
>
>   Branch: topic/rust_io-7.2-rc1
>   Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/drive=
r-core.git
>
> [1/20] rust: io: add dynamically-sized `Region` type
>       commit: 426c92ca1bdd
>
>       [ Add brief explanation on MIN_ALIGN. - Danilo ]
>
> [2/20] rust: io: add missing safety requirement in `IoCapable` methods
>       commit: 65f6abf9fa81
> [3/20] rust: io: restrict untyped IO access and `register!` to `Region`
>       commit: 6461c5776bf0
> [4/20] rust: io: implement `Io` on reference types instead
>       commit: 46b1b54139c3
> [5/20] rust: io: generalize `MmioRaw` to pointer to arbitrary type
>       commit: 9734e905119c
> [6/20] rust: io: rename `Mmio` to `MmioOwned`
>       commit: 691c75967d44
> [7/20] rust: io: implement `Mmio` as view type
>       commit: 9f64c84af008
> [8/20] rust: pci: io: make `ConfigSpace` a view
>       commit: 6e5f28968d7b
> [9/20] rust: io: use view types instead of addresses for `Io`
>       commit: e0454ec1220c
> [10/20] pwm: th1520: remove unnecessary `deref`
>       commit: 0adc93b85374
> [11/20] rust: io: remove `MmioOwned`
>       commit: bed01ca9e9cf
> [12/20] rust: io: move `Io` methods to extension trait
>       commit: 9b36c13cbd4f
>
>       [ Add comment explaining the purpose of the Io blanket implementati=
on.
>         - Danilo ]
>
> [13/20] rust: io: add projection macro and methods
>       commit: 1f989555fe5c
> [14/20] rust: io: add I/O backend for system memory with volatile access
>       commit: 2fabff780785
> [15/20] rust: io: implement a view type for `Coherent`
>       commit: 1d409d1e7a87
> [16/20] rust: io: add `read_val` and `write_val` functions on `Io`
>       commit: 89814c42c19e
> [17/20] gpu: nova-core: use I/O projection for cleaner encapsulation
>       commit: 0722567f5085
> [18/20] rust: dma: drop `dma_read!` and `dma_write!` API
>       commit: 6ff7d69b7e6e
> [19/20] rust: io: add copying methods
>       commit: e7219e53c525
> [20/20] rust: io: implement `IoSysMap`
>       commit: 11a4784f902e
>
> The patches are in the topic/rust_io-7.2-rc1 topic branch and will be mer=
ged
> into the corresponding target branch soon.

Now in driver-core-next and drm-rust-next, thanks!
