Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C44F3EBF10;
	Mon, 23 Feb 2026 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884559; cv=none; b=fdzhEdEFaTX59uEBrMkyt2n7XzSAk5dEje36874UW5iMtnwSlNcACSIUiUDKpcNoRBI3sba41IyJuIwkmECFP3vKDeqCtvz0R72Ibfkb2Rrlh9elaVXgQFLWeEx9II/IhTXX/UYqQ/2I/U1mvv3yLjKJUGiCYcdoZKWOZVloXDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884559; c=relaxed/simple;
	bh=zr3Y8yqJVgEdr+hQ0q1X13W/KujOld7x5GHXIuEHsWg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=jUnGw5WkjCL/4mN5GdSI4VAeWNn3898PtMXax/Cd/dnuKtQwFOT8xY0/gJf6+EzVPwTUB4/Mog++A5vXxjd2clYrIuH0p/ArZ+elsknkK81y0lJ4h6mzD1fFb6Ou0XipJH2vv+LnGdoYiIXTFSSKpXS7Slq02qtiLkN5MNgT++A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7KtfBEe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7KtfBEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F254C116C6;
	Mon, 23 Feb 2026 22:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771884558;
	bh=zr3Y8yqJVgEdr+hQ0q1X13W/KujOld7x5GHXIuEHsWg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=N7KtfBEe6yNcb317qPvIYOryCS3eQx34Vy++MQynn+eTwwS/Vw9e+PF1IAsU8XcW/
	 LFibUSQEjMu1EMu4OPj5y5F8Um6H+4yqGNonfkH6joEz8BJz05vU6iglGpAQkyaB/x
	 mYiNXt2kUh61+91QJNSAixFcSHtTZz6dYl7VbC6eLbKFcYPf56QThbbayq42p55MOm
	 AwbTfaOm1VlBPkGiGmJ+qpZVt5HrxTSBKaNHy68grB9sUGNaXY8rGiBOd2TWV6nkNT
	 /Yh3cCXJhJaHfmgGmVZho7dl0ErGj+u7genMmRbhNH/aQLkwG9Vh/6VZLAP6YXXp5d
	 YkczP06Knqlmg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Feb 2026 23:09:13 +0100
Message-Id: <DGMONIIUVYQF.24L7V1YR9S2X7@kernel.org>
Subject: Re: [PATCH] rust: io: macro_export io_define_read!() and
 io_define_write!()
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
To: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <zhiw@nvidia.com>, <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260216131534.65008-1-dakr@kernel.org>
In-Reply-To: <20260216131534.65008-1-dakr@kernel.org>

On Mon Feb 16, 2026 at 2:14 PM CET, Danilo Krummrich wrote:
> Currently, the define_read!() and define_write!() I/O macros are crate
> public. The only user outside of the I/O module is PCI (for the
> configurations space I/O backend). Consequently, when CONFIG_PCI=3Dn this
> causes a compile time warning [1].
>
> In order to fix this, rename the macros to io_define_read!() and
> io_define_write!() and use #[macro_export] to export them.
>
> This is better than making the crate public visibility conditional, as
> eventually subsystems will have their own crate.
>
> Also, I/O backends are valid to be implemented by drivers as well. For
> instance, there are devices (such as GPUs) that run firmware which
> allows to program other devices only accessible through the primary
> device through indirect I/O.
>
> Since the macros are now public, also add the corresponding
> documentation.
>
> Fixes: 121d87b28e1d ("rust: io: separate generic I/O helpers from MMIO im=
plementation")
> Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Closes: https://lore.kernel.org/driver-core/CANiq72khOYkt6t5zwMvSiyZvWWHM=
ZuNCMERXu=3D7K=3D_5tT-8Pgg@mail.gmail.com/ [1]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to driver-core-linus, thanks!
