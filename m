Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FDF20C038;
	Sun,  1 Feb 2026 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769981626; cv=none; b=LgEsBswtf4mQmYmb7qOd4oX4uiDzbeSZmNln2T/L45X5Z8T3tK7IZKa+2BT/Mk4bQKCsaGWtX3GipnPEvQeo1SSUnQnJFydBwx0lddy88kmzSG2X2DlVCOwO5KVb2bdf7OjNWTOJnpz6/uu08sR93agaTCII4YHJK7jT43AJxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769981626; c=relaxed/simple;
	bh=PU6QNV9wYM2o7K22jxsGbICbwxchsZZUKB7FoCxUw54=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=PZQGKxHOgfwE++9Tw9pUbeEcF38TmSBHZ72uuW8JvyMxn9wRoe77hbFY4p+GbZPFgewLVi66aPA3TRtUJRGSCqQGgTu8Uv+TstEwNHhFR2ShVJFKS2YwB1b9V5d7PQXibuv4lfgX0wVvYE0gr+ShcH1N4w1O8xSOGgl63NUOZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4ck4QXP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4ck4QXP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4A0C4CEF7;
	Sun,  1 Feb 2026 21:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769981626;
	bh=PU6QNV9wYM2o7K22jxsGbICbwxchsZZUKB7FoCxUw54=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=X4ck4QXP9nUaCeaIarcHfLgK//0w2IzMTPptEbCD9lbT8bblAC+1J/8qgluWeQA2b
	 yEWo87E2HI7tcmqxaKOgEF7dxmxTiRmeI5n6C4n9qDLXDkr4FIyXlK3p2SA0i6Moop
	 6xtx1jCEE1qyUFFMJc/Kd8G+QblwznnMJgLaKCIl9U6FUhFgeqrtmCasKY/wIwuU1b
	 HnKj0IEMpllAM0xle/c2H0Gwt20lWGDXvMMRUn13e1wlpRLeVrQYjbXwwuaLbqtn63
	 Ar1pifwzVlx44RsI2DVrllPGycZGrftEgvxFEr67viva3/1IsSD3Hrow3Ggfed/0Ae
	 9imJsyHJ7RDng==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Feb 2026 22:33:41 +0100
Message-Id: <DG3Y4BGXT6BZ.X2LXWHL7HYBY@kernel.org>
Subject: Re: [PATCH] rust: io: move MIN_SIZE and io_addr_assert to
 IoKnownSize
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260130-io-min-size-v1-1-65a546e3104d@nvidia.com>
In-Reply-To: <20260130-io-min-size-v1-1-65a546e3104d@nvidia.com>

On Fri Jan 30, 2026 at 2:32 PM CET, Alexandre Courbot wrote:
> `MIN_SIZE` are `io_addr_assert` only ever used for IO types which
> implement `IoKnownSize` and do not make sense for types that don't.
>
> It looks like they should have been there since the beginning, so move
> them while the code is still fresh.
>
> Also update `IoKnownSize`'s documentation since it is not just a marker
> trait anymore.
>
> Fixes: 121d87b28e1d ("rust: io: separate generic I/O helpers from MMIO im=
plementation")
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

    [ Fix typo in commit message. - Danilo ]

Applied to driver-core-testing, thanks!
