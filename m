Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951934B1286;
	Thu, 24 Sep 2026 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271130; cv=none; b=Vfe64Q4r1NP5FpgF1VwJq9Q+CGUkIdkRwapE/NCrxxt7nXeaBPs8FtMTtupRrbe+bVkHgJBJplCPNKLoXDjehDm6gXoyqwE/y1EaE7KBlraceuyNp9L9b5jzJRglxLGs0U9FMPq9qwBptEXTwxJ6PVJ+4TYumLbN6+/ZOt27YYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271130; c=relaxed/simple;
	bh=RFJwjEodphSHzjmEP7vSRAPmphkucy/rNjsLiMIWmR0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=IYkNJiSsdUcCbxFU6AvrFe/+Hcsyy97lNqVjsk3FeCmGhgtdMU80qCkVKx91g2cUSbjpbvWbVrsAyTzOYIE4Z1gNYNbvopGcejwXGJHvmd97yxe4PLqKUdgu3dJ4dtOllvNjpOYa1XkZ4fNWuHS+gMUmD3q7RbGF2BftcSZXaMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omwzz/1u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omwzz/1u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19A51F00893;
	Thu, 24 Sep 2026 17:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271129;
	bh=v0nG8DkbejkMnWyKvqLXvEl7ezaHXzKTPDdCNzRFtAM=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=omwzz/1uekkhm8Ug0Rv7hVE3dm6tPpHX+gNRYxySeolYcm3i++uWlKLeBP9SGF+5K
	 fJ8OmWW3g5p63uxjsupup41XWpX9eym56Lywu0Ylv/FLUcWPbZehHXEfT5LFNKu7g6
	 z1MYLhnKcZct/uggUJjndh9KlqiKngHUOi/vv/nok14L96+sexmAfcV5BjFVoUJqP8
	 76gyC/jgPa0YnY0K7nanVT2NEvqPo+Cu6uCGTlpYvEEqE0a1ejiW9gvpYB5WPvavIv
	 6CB08UYIbsYmCs5lE6zrNBZK+sJfshgzwU/qIKf8vFY6LYaqyQ6UU1cldM8D9vbLP+
	 Kg4NmkfxaKCGg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 19:32:03 +0200
Message-Id: <DLNQ5C9BTIAJ.1XEWLZ13TU1VF@kernel.org>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Lyude Paul" <lyude@redhat.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Maurice Hieronymus" <mhi@mailbox.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 2/5] rust: pci: rework device enabling API
References: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
 <20260812-b4-rust-pci-edu-driver-v3-2-5d0b5594e52b@mailbox.org>
In-Reply-To: <20260812-b4-rust-pci-edu-driver-v3-2-5d0b5594e52b@mailbox.org>

On Wed Aug 12, 2026 at 9:52 PM CEST, Maurice Hieronymus wrote:
> @@ -75,7 +77,7 @@ fn probe<'bound>(
>          pin_init::pin_init_scope(move || {
>              dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
> =20
> -            pdev.enable_device_mem()?;
> +            let enable =3D pdev.enable_device()?;
>              pdev.set_master();

I think we could implement set_master() for pci::DeviceEnableGuard instead,=
 so
it can't be called out of order.

Can you please do this in a separate patch?
