Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F9F3F6C2A;
	Mon, 19 Oct 2026 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420707; cv=none; b=p4r8Otlzf+fXlU+ZnJuYHf2I8yjFuY9W0r3Hvd9HH/EcLiR1s1BXFh7hsAMHPZlURxtLpJBnoSwcFHULqCB9iJx9TNdhQifYby/y1SWWBNAQwj+6tIU7SFTVLevBfMOo0i4cPtHa0sMk6nytwfXwQlVo6q+v7nKoYblzb82fDV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420707; c=relaxed/simple;
	bh=pHJlbD3Ykp2G88/CF0vGqRav+C6+3IShaO4hFoibKnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jrikr1SNMjCvahsk0b379qA6eNtBZi8GdhlmOX3kAvbLxRAXq2L0EMLPrV/miMB0+5UU2NFQ/3Jv1hSkJZBa3rfRGPtUauu7dlmDlnWEyffwOaHpRoQkxJROHUPGdxFGUxcpx/EW012kn06UJiwgm2/arRHenUPo1EW4j/JT/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcFPj6E5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcFPj6E5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0215B1F000C4;
	Mon, 19 Oct 2026 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792420706;
	bh=cSw3rB9j4ieCHmN9DAvqPBD6YAyw3QQsbuD/BlbA+qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TcFPj6E5z8IKZKoF/fAfIbssooW1/5mcfycivDqwo0qyf1vHg3RCoYa0OfDzYoS7q
	 XX3ndW6GQVrHfG6mwMLBqmxmTdhyhLiQ6hc47bXCx7t/4G/B2gCINJow8cxCgbupRe
	 lDieAO7m2ovhr6Pi3X+GHdO8J11ApRxIryaSpg4A/NP6CgNDfpX3YCpqGhq8A2gq8i
	 wD7SLTE++a6gyrGmk8wLsQoTOWlJQqcboBQ8VZ0Lxpc2utyFyygV5AOCnuzLXz/RP0
	 2i6GCuH5eSpxQdQPgWRwowKh+l8eeDyXwL3V1Ds4Qtfj3jUHHqScY5hgfIfQn4dRe2
	 HmU7jlc76NjTQ==
Date: Mon, 19 Oct 2026 15:38:18 +0100
From: Lee Jones <lee@kernel.org>
To: markus.probst@posteo.de
Cc: Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Ira Weiny <iweiny@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v27 4/4] MAINTAINERS: rust: leds: Add rust abstraction
 entry
Message-ID: <20261019143818.GC2663669@google.com>
References: <20261016-rust_leds-v27-0-2c296d8a8e5b@posteo.de>
 <20261016-rust_leds-v27-4-2c296d8a8e5b@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016-rust_leds-v27-4-2c296d8a8e5b@posteo.de>

On Fri, 16 Oct 2026, Markus Probst via B4 Relay wrote:

> From: Markus Probst <markus.probst@posteo.de>
> 
> Add self as maintainer.
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f53047aa8d3c..3ae821614cd8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14791,6 +14791,15 @@ F:	drivers/leds/
>  F:	include/dt-bindings/leds/
>  F:	include/linux/leds.h
>  
> +LED SUBSYSTEM [RUST]
> +M:	Markus Probst <markus.probst@posteo.de>
> +L:	linux-leds@vger.kernel.org
> +L:	rust-for-linux@vger.kernel.org
> +S:	Maintained

> +F:	drivers/leds/*.rs

-ENOENT

> +F:	rust/kernel/led.rs
> +F:	rust/kernel/led/
> +
>  LEGO MINDSTORMS EV3
>  R:	David Lechner <david@lechnology.com>
>  S:	Maintained
> 
> -- 
> 2.55.0
> 
> 

-- 
Lee Jones
