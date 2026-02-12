Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D59935502A;
	Thu, 12 Feb 2026 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770907938; cv=none; b=P6fhKJH+iSrHXFRk9tlEhyz+Iaiv+JoJ/kTP6aczIU0PnXz7yoWCaForsbs1//TLJheUDJktdtgiqLIMXsLzP23Lt6ragI4PsITE4vjJRWTAypX5Jjzr4IVS/GNJDIC5KLOrDuNYcLaQyu0fa9j8KtKj8gAm8IkyQNtJVs/q7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770907938; c=relaxed/simple;
	bh=FprYWKygNJPq7PUAUklRaIb91RAGAYHV0c2MwoLzPPY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=T+N+E2CLIDFaPnnyPpfr8zqm3lY4dqSgTuuWWumDW6L0ADmX2T3NO2t3x0eLKKaMrE9afPUD+ykJYqC9a9YtNLVKNE5tB5vsBmn1UjfbczGRAsKsQwv8W02CpvwIytkDKSN4k6/ogvfCrUIgRMdM34DrAQGTAGipDAbVMFI+YzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWaZ1C/v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWaZ1C/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4574C4CEF7;
	Thu, 12 Feb 2026 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770907938;
	bh=FprYWKygNJPq7PUAUklRaIb91RAGAYHV0c2MwoLzPPY=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=lWaZ1C/vbSTcO7PTz/qZ6kKfSx8ssuN+x0Cd1KAL7TlRCVPafdwuXSo3ZlG8UnGgN
	 DS8jTLX17IfdYQRjEeWimPd72mo5wIeybsfQ3jlTcrLBAkGfv2FyMQtjJXTun9yabk
	 R0z5g+1q20YLMTNPYlZWO3Jap4d14Zi5azQFl1oBIAwm3tJSq0zk3PYG4vFi2H/iDn
	 Ydf9v66GbGjEDpP2uU9TQIJP112CzKSKnZUSxhaQJVBJ0pWa8H7D7MUaCfwcrs8Z4/
	 mDNY1hxGGScKeLjZ477iqmgS0kacriIvQsa75tnz1dbUdCVF60sFQbPxXNtTWTLMIE
	 pqB+x7089Xagg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Feb 2026 15:52:12 +0100
Message-Id: <DGD2GXAFO99J.1Y3BA26PBVTAC@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, <lyude@redhat.com>, "Alice
 Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/6] rust: io: turn IoCapable into a functional trait
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
 <20260206-io-v2-1-71dea20a06e6@nvidia.com>
 <97fc6c36933522eaf75f34f8fcd445715432fde4.camel@redhat.com>
 <DGCYWK1UF76I.A565AK23DZXS@nvidia.com>
 <DGD1LDCXJZR6.32S0Z7EHGYDUN@garyguo.net>
In-Reply-To: <DGD1LDCXJZR6.32S0Z7EHGYDUN@garyguo.net>

On Thu Feb 12, 2026 at 3:11 PM CET, Gary Guo wrote:
> They can, but the `Io` trait just passes the wrong address to the `IoCapa=
ble`
> trait, and nothing horrible can happen without doing things unsafely insi=
de
> `IoCapable` impl, which is controlled by the user who implements `Io`. It=
 looks
> to me that unsafe code is still needed to do bogus things.

I think what you mean is that the invariant of `addr` and `maxsize` being v=
alid
is on the implementing type of `Io`, e.g. `MmioRaw` and `Mmio`. The same ap=
plies
to IoKnownSize::MIN_SIZE.

To me this seems like a valid way of arguing.
