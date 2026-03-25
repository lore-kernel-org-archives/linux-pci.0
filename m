Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4244342CB0;
	Wed, 25 Mar 2026 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469450; cv=none; b=mPxxdlgWuGmJ+rDC17OIowaPvXXIv/NLVLypEbhOQfVNrPTqZxvX0cH1aKp9EwJISlvW13QqxbvU4Lqhni+JTb7JWfiIY6ZSSnxtU7uwL4gEnKKPX88lnSqTi4FKxZgCdxGx1VgmNSxKZFxrkvaAVDAz/flIVwZ7ebphIX/VU4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469450; c=relaxed/simple;
	bh=ujRd5LjK5mcsQ8mmgXBul5fE27uXDx8ALFuMg04ypL4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZwC8aBsqWcMHGHiP5dgGjKMtEMkNPISEMpoZooVl4TiJ169aubEU/FndkIvuhr+cea5YrmPWUYultpbmn9VDzbRCT9/ql4zuLlY5tHMsT8ESrAfZL/PVI6G9aYEbS/7LdiN0+Sen3Ub25S8b0TwzYit+Ib+lbumbsCRr6se+knM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFmztkEm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFmztkEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0804AC4CEF7;
	Wed, 25 Mar 2026 20:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774469450;
	bh=ujRd5LjK5mcsQ8mmgXBul5fE27uXDx8ALFuMg04ypL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pFmztkEmcFWpgL3kWBx9QwNbkpZBMlusvqoTnjSjBDNyrUVednVv9U0iCioGOuEMX
	 ohHhvIxQdFYFtSfzQiNpjjyH6hlMHyxfnqAivGCkXB2s9xdf075XPyFm501ilrNH8B
	 xihJ0JDUVVnu5B78Ln4s8O2PCl6USk7Wa+Tp1KrHj2/mBZZSoX029j56ss3nWDkKIB
	 hpPNwkJrV8lkjf8pY4CyfKODg13UDaJCOOC8BTTyPcKqfdrH9dKOEPW/q3jeGRM2sX
	 Ui34HaTivXjTnedeG17USNY6sfInAxwD/PAHKZOKDuLQbEwJgz5d6m6qvH68WFTKin
	 J7Gx9gxuZ5DvQ==
Date: Wed, 25 Mar 2026 15:10:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Subject: Re: [PATCH v6 11/27] PCI: of: Use fw_devlink_set_device()
Message-ID: <20260325201048.GA1291425@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325143555.451852-12-herve.codina@bootlin.com>

On Wed, Mar 25, 2026 at 03:35:38PM +0100, Herve Codina wrote:
> The code set directly fwnode.dev field.
> 
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 9f8eb5df279e..5fb7f501fd35 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -803,7 +803,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
>  	 * bus. Avoid any new device creation.
>  	 */
>  	of_node_set_flag(np, OF_POPULATED);
> -	np->fwnode.dev = &bridge->dev;
> +	fw_devlink_set_device(&np->fwnode, &bridge->dev);
>  	fwnode_dev_initialized(&np->fwnode, true);
>  
>  	ret = of_changeset_apply(cset);
> -- 
> 2.53.0
> 
