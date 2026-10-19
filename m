Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425856;
	b=WXv1lcgd0P6VsHaAVWJbShHQ6EO6e4ELyBih7Tb0CTOzxiOOZApaYZrt/pUTVPcxX+4t
	 xi2Hg//jS+SK8B30EnuxstgvXVdmZdufxr5NDqAmmrhh9dic64AimL1ZAq8Pz1CDZWewx
	 /k61kmUYGadX9qMBJwZV+s0JdX65BgWWx5DCFOnPmJotXWlVCNjei1tnkAhuC3XduXF6L
	 UJdXxslMplS3K0UZ6Gkxm1XQN/Ooo6bhi+gsgYiRBv2TlF9aT2sZYFE9yfB5Jex8QfatT
	 au/+v4HmwhunlDgyRKdm6bfIsnA8O+d9gb61xMBzO4sVsV6IkAn3Y8Yw3TRg0dnHqZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425856;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TUNWuektdIzC7o+9WnXBQtpoZew9HX0+zPfewsiEIew=;
	b=t/gX2Ms75kmF1hT2iFy0cF9K5xhEHQ5YD+7UikdYC2rFHa1IC2FdGrJjnfSyFGZUNl9V
	 KQZSQh7eglDouELcqKlSh1wL+yw2EYLT3ImoFIM9i4E2LX4skwF3dgAvciPNzTrFt1IHL
	 kWQsO9cIZBHsCjXwbH3t9qZeDDkxH5It9CDUY1yv3q0HY1FD72dRWmoRmIfEHsUMoUU88
	 SmyYAUSdhLynhvWr3kz2pbFOiMDl/NhNzMXQB1sbKHvcvXn+cw/uDU4tkNx5fWv5Abt8M
	 8WSFWkcru4H/rQPXhwr3qRR35IInybGerfMSxG1Jk1mjvqjH8Vfp3qbDb6cjXzsi8cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQneIS88;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BA26078849;
	Mon, 19 Oct 2026 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQneIS88
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0415E1F000C4;
	Mon, 19 Oct 2026 16:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425855;
	bh=TUNWuektdIzC7o+9WnXBQtpoZew9HX0+zPfewsiEIew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EQneIS88ZLIkHsqBm1CEugmJTv+L96Vj5NaYf+i3G8wb7keEz6G16kwNqjN1xQbjY
	 GfKEXI+xeBR38fIKhqsaaRg4Y0C/QysKAQRyM7Grvwh90Hv42NbIKz3INFrhpRsHnH
	 e19jaEjvXd6CAYeB8dYFav5qVjFex41V80xGD05p3gBzU8QJn7jVKk06ZpqneJCu0W
	 7th3mZuC6e9OV2bnQDOg0nqgN54ETnxwCPq1Nr1zIKYkFZsWAF74DjtoWi03IrW1+/
	 lkewlWDnMTnuF6t+bsF8aQc/i3buWgF0Xm2sE6Z4J4tmm4DYTBh+1lQDPYgvM2W/af
	 cTOMQxEx8ngKg==
Date: Mon, 19 Oct 2026 17:04:07 +0100
From: Lee Jones <lee@kernel.org>
To: Markus Probst <markus.probst@posteo.de>
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
Message-ID: <20261019160407.GG2663669@google.com>
References: <20261016-rust_leds-v27-0-2c296d8a8e5b@posteo.de>
 <20261016-rust_leds-v27-4-2c296d8a8e5b@posteo.de>
 <20261019143818.GC2663669@google.com>
 <236149b4c90323f412d6385c034a78908013e2d7.camel@posteo.de>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <236149b4c90323f412d6385c034a78908013e2d7.camel@posteo.de>

On Mon, 19 Oct 2026, Markus Probst wrote:

> On Mon, 2026-10-19 at 15:38 +0100, Lee Jones wrote:
> > On Fri, 16 Oct 2026, Markus Probst via B4 Relay wrote:
> > 
> > > From: Markus Probst <markus.probst@posteo.de>
> > > 
> > > Add self as maintainer.
> > > 
> > > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > > ---
> > >  MAINTAINERS | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index f53047aa8d3c..3ae821614cd8 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -14791,6 +14791,15 @@ F:	drivers/leds/
> > >  F:	include/dt-bindings/leds/
> > >  F:	include/linux/leds.h
> > >  
> > > +LED SUBSYSTEM [RUST]
> > > +M:	Markus Probst <markus.probst@posteo.de>
> > > +L:	linux-leds@vger.kernel.org
> > > +L:	rust-for-linux@vger.kernel.org
> > > +S:	Maintained
> > 
> > > +F:	drivers/leds/*.rs
> > 
> > -ENOENT
> 
> Yes, but why is this an issue?
> It will catch future rust led drivers.

Is this where drivers will go then?

I assumed the Rust parts would be self contained.

No worries either way.  Just setting expectations.

-- 
Lee Jones
