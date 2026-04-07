Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BAC3BC69C
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775585157; cv=none; b=AX6Li1VsyfwaofhGANNR4eM8BR1H5yUJfiLDD7nznmXVlaaSSlUfeHN0JnR+2tIIQdhotrpDhRgC0Rpr4gxBhbJKW7sbfOnh2xd0+zWhJDUNnquFR00lvOHKCMnBKEIX2qK383JCoaCtTwVkf968PotoN3AzS2ifX3GleUTIrHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775585157; c=relaxed/simple;
	bh=uFO0xP5YCzidCQEHhppwCpm47278XPfZ+3Ibhoo3yo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KubLDegj/FmdZP5/MFZ4s8xzeOvS/Lw2pSt6pXy6xtz1ROc5J24Q+YpTooMKPigBV6vHb+HTGwDCwfHdLPFoiY92Lq8fSXhCcIgfVHXO9kG6OSqM+REoRegsakv4clkmhfDBP6D1RcSaTSqV2IqdelxirYqY3whaGnB9U/E8m0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF6eAW86; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF6eAW86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B800C2BCAF
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 18:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775585157;
	bh=uFO0xP5YCzidCQEHhppwCpm47278XPfZ+3Ibhoo3yo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mF6eAW86xTzc4seINUXWCAkNT4/kMxvZtF4KEb0JcKoIl12ezSkyFWDM1W+5rDl3Q
	 XJ8672VFZrXnm7TqGPHK0byTAohbxmC05rGGoCa5OQeZkxCKtqK8y3kFRANQCTnsaS
	 0IrSLsQzXdTHpS86dudwRDXAXX4T7zFR3WA7hl5X4bp65VZ4JJMtPrF6ZDt2eYY9g9
	 uu0Qqj2utUleNsxZmfMWetl+2CUpuKjWOM20wZO3kDxmZJ9uvSgwTv0bLQl5jtIBbl
	 5z0l24bS7oDe8nvMEpJrgpZJ22T8ex3zhXQqSzVWvaSeMpt2S2U7O2tJqrrLsSIcXX
	 D/8icD4CRxLmQ==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66f74fa69ceso1226093a12.2
        for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 11:05:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAh8/PpYFOqySir+Got905awLVyGNjQ3GGf1QC2aCx71+SSPveH7Tv8bhdoZFftGQIa4e/PMPj5ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ8JtVjdzXkYNCelEAUaJB4l8qJH3pVZLhRQ8sKA5AcpvO51Bn
	fItAZVq3i19PaPXVCT9KbEiycV0P5EUsRqFDEFsCqP/SI4nVajORMJ5LWNAkieGyxTDkZcEq7UC
	Z0slh3rVvebUA4tGNH/FqB3Em0cov7Q==
X-Received: by 2002:a17:907:960f:b0:b9b:38d4:2cea with SMTP id
 a640c23a62f3a-b9c676c8812mr866811266b.23.1775585155532; Tue, 07 Apr 2026
 11:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com> <20260407180315.GA3175985-robh@kernel.org>
In-Reply-To: <20260407180315.GA3175985-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 7 Apr 2026 13:05:43 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+vuQba8kSfD7YvBADRMG2FVcWqTvJdsyAOZ3b2CPTUPA@mail.gmail.com>
X-Gm-Features: AQROBzDYXYYcVJxX1hhqK2Tcju9IchSU1-kXz0rhO9iaVymSVAahX9Zn0Xa7GiQ
Message-ID: <CAL_Jsq+vuQba8kSfD7YvBADRMG2FVcWqTvJdsyAOZ3b2CPTUPA@mail.gmail.com>
Subject: Re: [PATCH v6 00/27] lan966x pci device: Add support for SFPs
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Kalle Niemi <kaleposti@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 1:03=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Mar 25, 2026 at 03:35:27PM +0100, Herve Codina wrote:
> > Hi,
> >
> > This series add support for SFPs ports available on the LAN966x PCI
> > device. In order to have the SFPs supported, additional devices are
> > needed such as clock controller and I2C.
> >
> > As a reminder, the LAN966x PCI device driver use a device-tree overlay
> > to describe devices available on the PCI board. Adding support for SFPs
> > ports consists in adding more devices in the already existing
> > device-tree overlay.
> >
> > With those devices added, the device-tree overlay is more complex and
> > some consumer/supplier relationship are needed in order to remove
> > devices in correct order when the LAN966x PCI driver is removed.
> >
> > Those links are typically provided by fw_devlink and we faced some
> > issues with fw_devlink and overlays.
> >
> > This series gives the big picture related to the SFPs support from
> > fixing issues to adding new devices. Of course, it can be split if
> > needed.
> >
> > The first part of the series (patch 1 and 2 ) fixes fw_devlink when it
> > is used with overlay. Those patches were previously sent by Saravana
> > [0]. I rebased them on top of v7.0-rc1.
> >
> > Also I added a call to driver_deferred_probe_trigger() in Saravana's
> > patch (patch 2) to ensure that probes are retried after the modificatio=
n
> > performed on the dangling consumers. This allows to fix issues reported
> > by Matti and Geert [2] with the previous iteration patches.
> >
> > Those modification were not sufficient in our case and so, on top of
> > that, patches 3 to 5 fix some more issues related to fw_devlink.
> >
> > Patches 6 to 11 introduce and use fw_devlink_set_device() in already
> > existing code.
> >
> > Patches 12 and 13 are related also to fw_devlink but specific to PCI an=
d
> > the device-tree nodes created during enumeration.
> >
> > Patches 14, 15 and 16 are related fw_devlink too but specific to I2C
> > muxes. Patches purpose is to correctly set a link between an adapter
> > supplier and its consumer. Indeed, an i2c mux adapter's parent is not
> > the i2c mux supplier but the adapter the i2c mux is connected to. Addin=
g
> > a new link between the adapter supplier involved when i2c muxes are use=
d
> > avoid a freeze observed during device removal.
> >
> > Patch 17 adds support for fw_delink on x86. fw_devlink is needed to hav=
e
> > the consumer/supplier relationship between devices in order to ensure a
> > correct device removal order. Adding fw_devlink support for x86 has bee=
n
> > tried in the past but was reverted [1] because it broke some systems.
> > Instead of enabling fw_devlink on *all* x86 system, enable it on *all*
> > x86 except on those where it leads to issue.
> >
> > Patches 18 and 19 allow to build clock and i2c controller used by the
> > LAN966x PCI device when the LAN966x PCI device is enabled.
> >
> > Patches 20 to 24 are specific to the LAN966x. They touch the current
> > dtso, split it in dtsi/dtso files, rename the dtso and improve the
> > driver to allow easier support for other boards.
> >
> > The next patch (patch 25) update the LAN966x device-tree overlay itself
> > to have the SPF ports and devices they depends on described.
> >
> > The last two patches (patches 26 and 27) sort the existing drivers in
> > the needed driver list available in the Kconfig help and add new driver=
s
> > in this list keep the list up to date with the devices described in the
> > device-tree overlay.
> >
> > We believe some items from the above list can be merged separately, wit=
h
> > no build dependencies. We expect:
> >
> >  - Patches 1 to 5 to be taken by driver core maintainers
>
> From a quick look, can't the first 2 DT patches be taken by me?

Err, I guess patch 2 is really more driver core than DT.

Rob
