Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1BE3EBF29;
	Tue,  3 Feb 2026 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770116507; cv=none; b=eIxYdRVhMrIqsPwWCt270Mg2Wa749A2Bm+GOBXOm0oH/p/fR3Rg1WJ11M4j5evHTOE70Dv6ZQ0B1HBY79HbMddvptZHHZDUzsoBuJYnlJvs4wpuJGtHbT0+K62fayknShqlO0cyOabQHQXLAxfbajUv1loRjAY7BLrjtNLTmFLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770116507; c=relaxed/simple;
	bh=GxpkLSU3/SN94Y1LrIF/NsSI8rqnDYsojgY4sdRUp2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5V9AdwtAr7E7R8iS1024I7qtXOS/UF5y7hG8CkyI6UUEIeTs/3mkLmo7D2Ltr9oMLpGFtaEbrMdBhtpu2NW8dZCgdw2UAsCdtRiCOrmCv0Jyo6adNKJbF+NihJTVg7y92p/FzdQM9Yqmr3oSngwWrvNL+GPieP5Rq7ySXe3mvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnD+miHl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnD+miHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDDAC116D0;
	Tue,  3 Feb 2026 11:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770116507;
	bh=GxpkLSU3/SN94Y1LrIF/NsSI8rqnDYsojgY4sdRUp2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JnD+miHlZT1H1O7EyTAriS6D9q3++oVAdq5nasJG2G9lDCGirpsI+QAOzFpBKyw04
	 K9YTRelPpexx8rtE3OW2S9DvIF/8ItfzHa4R5++LHCKbKj3hV53Uiht+XOnQVpCspY
	 lHlpnu5f4whFXGXanWqsFW1VTkAAhA7cm+BTLCk4d0QQZfffgMjYOBaT6IehZ/SiSy
	 1Edxsw1WDgQMa2HDbCDXi2nNnDz1kdGBj0PXX0/TJAhPXRjgHz0KnT1V6miG14Oh0R
	 UO+V+Q75pKRVJzpLScYsi8XVp0mWYqYhGFphXiogzRjOrvkKFgsgFy3bWytJzUOrVL
	 H0IJKB/v8cQ2g==
Date: Tue, 3 Feb 2026 12:01:41 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Grimmauld <grimmauld@grimmauld.de>, mani@kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
Message-ID: <aYHVlS1nbCMMyF04@ryzen>
References: <20240809073610.2517-1-linux.amoon@gmail.com>
 <aXtpg0V_sifQEWHJ@grimm-nixos-ssd-2>
 <aXyHITrZ89Mmn8_J@ryzen>
 <CANAwSgTQ-cdyzd2WjHMYCY33p7um3CpjMeTzRO7vcd0fTF6X9Q@mail.gmail.com>
 <aYB0ctHF1ZeIIzbq@ryzen>
 <CANAwSgSR7AYCvMXSo5UskTF3LJToOnPV9JE4XBAUzrCbWGKD_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgSR7AYCvMXSo5UskTF3LJToOnPV9JE4XBAUzrCbWGKD_w@mail.gmail.com>

On Mon, Feb 02, 2026 at 11:35:48PM +0530, Anand Moon wrote:
> On Mon, 2 Feb 2026 at 15:25, Niklas Cassel <cassel@kernel.org> wrote:
> >
> > On Sat, Jan 31, 2026 at 03:08:42PM +0530, Anand Moon wrote:
> > > >
> > > I’ve attempted to reproduce the warning but was unable to trigger it locally.
> > >
> > > I have tested with the built-in module
> > > CONFIG_R8169=y
> > > CONFIG_R8169_LEDS=y
> > >
> > > As well as the module
> > > CONFIG_R8169=m
> > > CONFIG_R8169_LEDS=y
> > >
> >
> > I'm running with:
> > CONFIG_R8169=y
> > CONFIG_PHYLIB=y
> > CONFIG_REALTEK_PHY=y
> > CONFIG_REALTEK_PHY_HWMON=y
> >
> I feel CONFIG_R8169 should not be built into the kernel image.
> Since the driver is registered via module_pci_driver(rtl8169_pci_driver),
> it is intended to be loaded as a module. In addition, this driver
> requires external firmware
> during initialization, which could make a built‑in configuration problematic.
> Keeping it modular ensures proper firmware loading and avoids
> early‑boot failures.

For what it is worth, I strongly disagree that you should not be allowed
to build something as built-in just because the driver is registered using
module_pci_driver().

In order to use NFS root, and to avoid the hassle of using an initramfs,
having the driver as built-in is a logical option.
Anyway, this is currently working fine with my setup today, and is
unrelated to the phylib splat that I have reported in this thread.

I know that the R8169 driver tries to load a firmware blob, I used to have
an initramfs just to be able to load this firmware blob, but I found out
that the driver probes and works perfectly fine even without the loading
any firmware, therefore I no longer use an initramfs.
Again, this is working perfectly fine today, and the R8169 loading or not
loading any firmware is unrealated to the phylib splat.

(Just for clarity, I don't think that the phylib splat should stop this
patch from being accepted.)


Kind regards,
Niklas
