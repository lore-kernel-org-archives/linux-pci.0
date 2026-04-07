Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DA0347BBD;
	Tue,  7 Apr 2026 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584998; cv=none; b=REQKc/pVWZ9YeaCyzCuKjAdEgoCj0/XMS4GXMCYThWha9X3uj9sF7iUrkeF4y0CSaXq06hCKkBHr9CmLmfNhAxL1gCqQ+OqPtnkIppKPSIPVw9uhkA/2YzABNfyGgYBiooVIIapcqedmMLFhTrSxjhhgIZ/5OLicExrtulCh9gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584998; c=relaxed/simple;
	bh=3uwoWXiaWvykl7yJaZ1MybGYtDm95i7JzUU39F5We00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEHksvFuA4r9SCEjXDHlsUYEoJnIEAqdqmLS297L0FbV5Dpqqqyierm5/dwFmgG+E9Hnwia05mgobYKNOMZHCqawUF/7v9HKBTr0N3/FqZ8zQsA2Fn2zQ2Eq/3D+YncymDVjrhmLOIVwk4uyeuVilNUWMfAWbuK4Wp87cVFOCwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiT1saIf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiT1saIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841E3C116C6;
	Tue,  7 Apr 2026 18:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775584997;
	bh=3uwoWXiaWvykl7yJaZ1MybGYtDm95i7JzUU39F5We00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SiT1saIfY9Ab6kOYEQ3WpRgDO5HxJo85XldRjkKTNqDhL5ApF489HMB3tKOAFklkP
	 LukelZtxIDrjgTFvEEqKrHYqfkq0b5v3CSo9Q+e4crsWHHIIYvwLgYCI+hXLAD+GIj
	 bHQeOmzjU0DNTobFFcy4Fr/81U6KFEtsKf3dfPulQwK4yRVpTR6kENGphWMN+0W1wP
	 CCQe9sQ1ZoFiL3F0cYpQwiMftmUycrzxrAhzdmocr2VVSBGVDMs5W8n9Pj2THQ/Ibm
	 /+Cg5LZRqpaP8rrYTz+SsYNq2eoQKGtc2pOOf6KycTknSvco09Y8TfuMiDmvhFkEfu
	 wJV6rdmOrLv+g==
Date: Tue, 7 Apr 2026 13:03:15 -0500
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kalle Niemi <kaleposti@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>, Arnd Bergmann <arnd@arndb.de>,
	Saravana Kannan <saravanak@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 00/27] lan966x pci device: Add support for SFPs
Message-ID: <20260407180315.GA3175985-robh@kernel.org>
References: <20260325143555.451852-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325143555.451852-1-herve.codina@bootlin.com>

On Wed, Mar 25, 2026 at 03:35:27PM +0100, Herve Codina wrote:
> Hi,
> 
> This series add support for SFPs ports available on the LAN966x PCI
> device. In order to have the SFPs supported, additional devices are
> needed such as clock controller and I2C.
> 
> As a reminder, the LAN966x PCI device driver use a device-tree overlay
> to describe devices available on the PCI board. Adding support for SFPs
> ports consists in adding more devices in the already existing
> device-tree overlay.
> 
> With those devices added, the device-tree overlay is more complex and
> some consumer/supplier relationship are needed in order to remove
> devices in correct order when the LAN966x PCI driver is removed.
> 
> Those links are typically provided by fw_devlink and we faced some
> issues with fw_devlink and overlays.
> 
> This series gives the big picture related to the SFPs support from
> fixing issues to adding new devices. Of course, it can be split if
> needed.
> 
> The first part of the series (patch 1 and 2 ) fixes fw_devlink when it
> is used with overlay. Those patches were previously sent by Saravana
> [0]. I rebased them on top of v7.0-rc1.
> 
> Also I added a call to driver_deferred_probe_trigger() in Saravana's
> patch (patch 2) to ensure that probes are retried after the modification
> performed on the dangling consumers. This allows to fix issues reported
> by Matti and Geert [2] with the previous iteration patches.
> 
> Those modification were not sufficient in our case and so, on top of
> that, patches 3 to 5 fix some more issues related to fw_devlink.
> 
> Patches 6 to 11 introduce and use fw_devlink_set_device() in already
> existing code.
> 
> Patches 12 and 13 are related also to fw_devlink but specific to PCI and
> the device-tree nodes created during enumeration.
> 
> Patches 14, 15 and 16 are related fw_devlink too but specific to I2C
> muxes. Patches purpose is to correctly set a link between an adapter
> supplier and its consumer. Indeed, an i2c mux adapter's parent is not
> the i2c mux supplier but the adapter the i2c mux is connected to. Adding
> a new link between the adapter supplier involved when i2c muxes are used
> avoid a freeze observed during device removal.
> 
> Patch 17 adds support for fw_delink on x86. fw_devlink is needed to have
> the consumer/supplier relationship between devices in order to ensure a
> correct device removal order. Adding fw_devlink support for x86 has been
> tried in the past but was reverted [1] because it broke some systems.
> Instead of enabling fw_devlink on *all* x86 system, enable it on *all*
> x86 except on those where it leads to issue.
> 
> Patches 18 and 19 allow to build clock and i2c controller used by the
> LAN966x PCI device when the LAN966x PCI device is enabled.
> 
> Patches 20 to 24 are specific to the LAN966x. They touch the current
> dtso, split it in dtsi/dtso files, rename the dtso and improve the
> driver to allow easier support for other boards.
> 
> The next patch (patch 25) update the LAN966x device-tree overlay itself
> to have the SPF ports and devices they depends on described.
> 
> The last two patches (patches 26 and 27) sort the existing drivers in
> the needed driver list available in the Kconfig help and add new drivers
> in this list keep the list up to date with the devices described in the
> device-tree overlay.
> 
> We believe some items from the above list can be merged separately, with
> no build dependencies. We expect:
> 
>  - Patches 1 to 5 to be taken by driver core maintainers

From a quick look, can't the first 2 DT patches be taken by me?

Rob
