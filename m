Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DB4375F88;
	Thu, 12 Mar 2026 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329239; cv=none; b=VhY9aUeSXBmsNXFmR+5Q4zRrPnR90RKGGV+EAmLkhpyOwQ+2kGcnztzwHdahjArPovFekJrHGjly6w4eEQqoAxRRIq0jYYZtPy+0Rmm/elToZSg8aNY4Qq6F45TeHhcLD5Gzfgzb3eayc4UfAjxyu22HrEa5rlnxvIBrVAendV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329239; c=relaxed/simple;
	bh=3gNgYTTVULTKANJUJ/9Pi3V8zjzLXODn4zDu8DouePU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDnkaJjtI7/uS6gnJpKts2PayWJr/Jx0EowyggnWArpZf46fFcYPV11cYFLPrSDvKlRylbUAwoD90tiNPOZ15PZE5A30IjuAlQTHgw1pe6qWtZ82f0q65EbY/IpIDSxTJXudc0sPhVvyt/r+Z0JO4RtQ/JkWuwowOtuvf1kQ4DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kM8HjATG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kM8HjATG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAE7C4CEF7;
	Thu, 12 Mar 2026 15:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773329239;
	bh=3gNgYTTVULTKANJUJ/9Pi3V8zjzLXODn4zDu8DouePU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kM8HjATG79tRKUGkuqfgkwFddma+9QRl1vjcNBOKPetSajqw1znNWVuws9HsU0mq/
	 DHMjUSFr0wmKflSkf5i/6IO5CBWS3kHWFN/QrdZwXyWaOZbpLFdbaZBac7Tt/w/ov8
	 pz30LFNoTFHMP1XgPK2joLFiKrlfolOA88SuJ2QA=
Date: Thu, 12 Mar 2026 16:27:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Herve Codina <herve.codina@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Niemi <kaleposti@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Saravana Kannan <saravanak@google.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 02/28] driver core: Rename get_dev_from_fwnode()
 wrapper to get_device_from_fwnode()
Message-ID: <2026031242-debug-aviation-19b8@gregkh>
References: <20260227135428.783983-1-herve.codina@bootlin.com>
 <20260227135428.783983-3-herve.codina@bootlin.com>
 <CAMuHMdVVsEB-xb8Jz4ujBam2NxtxAOb7byYa3VR_eHsbTD5rXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVVsEB-xb8Jz4ujBam2NxtxAOb7byYa3VR_eHsbTD5rXw@mail.gmail.com>

On Tue, Mar 10, 2026 at 04:03:42PM +0100, Geert Uytterhoeven wrote:
> Hi Hervé,
> 
> On Fri, 27 Feb 2026 at 14:55, Herve Codina <herve.codina@bootlin.com> wrote:
> > get_dev_from_fwnode() calls get_device() and so it acquires a reference
> > on the device returned.
> >
> > In order to be more obvious that this wrapper is a get_device() variant,
> > rename it to get_device_from_fwnode().
> >
> > Suggested-by: Mark Brown <broonie@kernel.org>
> > Link: https://lore.kernel.org/lkml/CAGETcx97QjnjVR8Z5g0ndLHpK96hLd4aYSV=iEkKPNbNOccYmA@mail.gmail.com/
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Saravana Kannan <saravanak@google.com>
> > Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> FTR, one more user of get_dev_from_fwnode() appeared in commit
> 9035073d0ef1de81 ("reset: convert reset core to using firmware nodes")
> in reset/next.

Ick, that's going to make this hard to land anywhere.  This is a rough
series, perhaps it should be split up to make it easier somehow?

thanks,

greg k-h
