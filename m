Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448253;
	b=dHUcSX7L6zyTmUg2qtp7TK8lYqEoZerjUWf3nhKzHTz0i3PCy0P2iLd1dr2+yEKHWg4I
	 0rtzp7ATJP87kwzmZK+Xe54fGrLrIgneu+NEcsWdnH747CVjiadNBDYf8+WhDA3bu1x8+
	 1adMQJMa52qKwQuNAEWehtSG7Me0n5h8ZcOq3USf1Qym9U+vEiu6BjXOgpkMj7Txj33gl
	 k0WhYouLg4E2YV0KN6KAkF0pCeKM+k5EpaNbsOJqUlB70rU1FEhgbM5nGMvOQ6fOK9uL/
	 M5ZPmfIGC2VK+DkxGhS/VyuRpe37MYxCWPv1Fj+5IKpgtTpvaYB56APmWiIu9BNFTag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448253;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5ZYy7ctc7utUoIVhnyDGifPpeprYczBSsfkhk/+gwZs=;
	b=KH8QhELBX/f1cX2hwzOfW9R2hfRoJfXBeZtEFC43IU/iumV3TmIFYExuNxvX2akoMVSB
	 T698GZ8157lDG3Pe0MrRcsCH8tWmXpaLabRXyYSr1msQpWMp4PcAFwQ0jRkNvRIWrynNE
	 LxRADsVMLcvHmRYg+qe7JXgdWiQBCXtxEEyLzQUatCYrZA7D4xcgCR5fXWqe3x8N4WixM
	 PG9BWQD6/jhVTgD+DQqVZg3KgGz3yFzfSsYuDfa1FZNElK65CaKbWffk+gK2aCT7P4XJN
	 yNdW3Rszi4wgzJK9D0sgOD3Q91ckOKjVLvV1fTXePi8vlI20O0odyerD6QJuosXc3gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N7EhVmQS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6E3606A88E;
	Thu, 12 Nov 2026 01:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N7EhVmQS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B855A1F00A05;
	Thu, 12 Nov 2026 01:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448253;
	bh=5ZYy7ctc7utUoIVhnyDGifPpeprYczBSsfkhk/+gwZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N7EhVmQSaYXYi85isumOgVusEFVRh7hwRMPi7KX4YI5bXir0N6C9Z7DcoHc2Na9QQ
	 kKEDr6p177/6y93P848ruzaYb4r3gckLtJRxZZ2hjqwQ3WlQMzk0MkXqmCXW8y17DZ
	 AQBKU7bMh9FRUyDR63mjcYxrgyONB5gg9XlJI1RAC5oyklde/6JEZQp/BcTmaczOLH
	 Ik10ihXe/1ZmcuUwH2XBWtGoUuKLg5l+AiCRtT92tmiJOg6gCvEfpS9B/FedmnWWYC
	 L3OsRUkjhlGW44vT4wP9EmD4jZDcziqPvhyJt509zVkI13cqlCXePZ2Slevil3tDKz
	 Un04PHga+YYbA==
Message-ID: <sashiko-outbox-210101@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] rust: usb: remove the disconnect() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261112005455.1224352-7-dakr@kernel.org>
References: <20261112005455.1224352-1-dakr@kernel.org>
 <20261112005455.1224352-7-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:50:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] rust: usb: missing Sync impl for Interface<Bound> breaks
  Driver::Data
--

commit 92376533106fabfcec7a799d05c1ddbb68a85c37
Author: Danilo Krummrich <dakr@kernel.org>

rust: usb: remove the disconnect() callback

This commit removes the usb::Driver::disconnect() callback and updates
the trait documentation and USB sample driver to perform device teardown
in Drop or PinnedDrop instead.

> diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
> index 993760ff332b8..2126378abc959 100644
> --- a/rust/kernel/usb.rs
> +++ b/rust/kernel/usb.rs

[ ... ]

> @@ -291,6 +271,10 @@ pub trait Driver {
>      type IdInfo: 'static;
> =20
>      /// The type of the driver's bus device private data.
> +    ///
> +    /// Device teardown should be performed in [`Drop`] or [`PinnedDrop`=
](pin_init::PinnedDrop)
> +    /// for this type. The `'bound` lifetime allows the data to retain d=
evice resources and an
> +    /// [`Interface<device::Bound>`] reference for use during teardown.
>      type Data<'bound>: Send + 'bound;

[Severity: Medium]
Can a driver store &'bound Interface<device::Bound> in Driver::Data<'bound>
when Interface<device::Bound> does not implement Sync?

Interface<Ctx> wraps Opaque<bindings::usb_interface> and only implements
Sync for the default Interface<device::Normal> parameter (whereas Sync for
device::Bound was implemented on the private usb::Device type instead).
Because Interface<device::Bound> is !Sync, &'bound Interface<device::Bound>
is !Send and fails to satisfy the Data<'bound>: Send bound at compile time.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112005455.1224=
352-1-dakr@kernel.org?part=3D6
