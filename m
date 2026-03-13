Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B042836B5;
	Fri, 13 Mar 2026 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773400863; cv=none; b=NZmAF7kYxNArhkFiR9IGGE+mEZ9pBM1Hb8pVl+akHXDT1UGSTng58fTie4Ep1mcZI7e3VL/0c6PrD8z6tl4Ws7IRqKrTwMJc+5LO90OotSe51QkxvPMyMakO9fcX2cMiRzzp7bf5+9vdI4KsnPf3uytjqkX5Ukf3R4NTxfXNSM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773400863; c=relaxed/simple;
	bh=iThDtlWFRXyqELPZgOTDTFG9GPUgz6TLe2DwswpTBng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oITDCbtFbD2C2Q8D5nmEMEto3XBbsyyCa31aG3YWqaw4+f/9QF1s+SZSEpo9Bb0g3ik/OMa9M/XTdbZe0m9pF71JGLz7a26wHM7A8gAriCSZYKJKq0fUJGmdKApsclWqsYZ4K1wQBDwyfMgjneYQdwFAl0NxkYSWhzIsVywT84g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Do+K6n/K; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Do+K6n/K"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C4FCEC4270A;
	Fri, 13 Mar 2026 11:21:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 91EB46002C;
	Fri, 13 Mar 2026 11:20:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0812210369E37;
	Fri, 13 Mar 2026 12:20:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773400854; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TViEBJxH/6t08moT1Cupd+GoZoxMid++9M6KSZfI+c8=;
	b=Do+K6n/KnMT6sRzJjxkeDTXj5gTe6Hx27Z4GI42adJKl10t0UbUB71h1hkyXitEwWH6T2i
	ltPrtpPGlMRvMhlKdD86qjGAeIZiwe4BSbPsxfLCAtDLLn+QW5HhBnSacBq7w+rkUIZ0J1
	BNvT7C0jWhklauOjM3AmXTLanlZcFUFy0LLfL80GGk3rI4FrO46yzHOgH6gOlCPWimIWuu
	bnfxU3ILpTwq5ezxehZ4D3Vzr3CkDosx+2OTafb29osULMFwoJZ2G901V6rpsJr7Jh4Xeb
	Bvtu0CHib7D6D9nhSPgx5/0hloz3s/0DI814tsG5pLaTxNMnMFKKCQ+0Ohk+mg==
Date: Fri, 13 Mar 2026 12:20:27 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Andrew Lunn <andrew@lunn.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kalle Niemi <kaleposti@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Andi Shyti
 <andi.shyti@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Peter Rosin <peda@axentia.se>, Arnd Bergmann <arnd@arndb.de>, Saravana
 Kannan <saravanak@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Charles
 Keepax <ckeepax@opensource.cirrus.com>, Richard Fitzgerald
 <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, Linus
 Walleij <linusw@kernel.org>, Mark Brown <broonie@kernel.org>, Len Brown
 <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
 <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Shawn Guo <shawnguo@kernel.org>,
 Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
 patches@opensource.cirrus.com, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Saravana Kannan
 <saravanak@google.com>, Bartosz Golaszewski
 <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 02/28] driver core: Rename get_dev_from_fwnode()
 wrapper to get_device_from_fwnode()
Message-ID: <20260313122027.498ff15f@bootlin.com>
In-Reply-To: <CAPDyKFpX3A3r4s72PNjBz5QaZUsq1xaGhn5vXwegue7Tyh_Zew@mail.gmail.com>
References: <20260227135428.783983-1-herve.codina@bootlin.com>
	<20260227135428.783983-3-herve.codina@bootlin.com>
	<CAMuHMdVVsEB-xb8Jz4ujBam2NxtxAOb7byYa3VR_eHsbTD5rXw@mail.gmail.com>
	<2026031242-debug-aviation-19b8@gregkh>
	<CAPDyKFpX3A3r4s72PNjBz5QaZUsq1xaGhn5vXwegue7Tyh_Zew@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Greg, Ulf,

On Fri, 13 Mar 2026 10:43:33 +0100
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On Thu, 12 Mar 2026 at 16:27, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Mar 10, 2026 at 04:03:42PM +0100, Geert Uytterhoeven wrote:  
> > > Hi Hervé,
> > >
> > > On Fri, 27 Feb 2026 at 14:55, Herve Codina <herve.codina@bootlin.com> wrote:  
> > > > get_dev_from_fwnode() calls get_device() and so it acquires a reference
> > > > on the device returned.
> > > >
> > > > In order to be more obvious that this wrapper is a get_device() variant,
> > > > rename it to get_device_from_fwnode().
> > > >
> > > > Suggested-by: Mark Brown <broonie@kernel.org>
> > > > Link: https://lore.kernel.org/lkml/CAGETcx97QjnjVR8Z5g0ndLHpK96hLd4aYSV=iEkKPNbNOccYmA@mail.gmail.com/
> > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Reviewed-by: Saravana Kannan <saravanak@google.com>
> > > > Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > > > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>  
> > >
> > > FTR, one more user of get_dev_from_fwnode() appeared in commit
> > > 9035073d0ef1de81 ("reset: convert reset core to using firmware nodes")
> > > in reset/next.  
> >
> > Ick, that's going to make this hard to land anywhere.  This is a rough
> > series, perhaps it should be split up to make it easier somehow?
> >
> > thanks,
> >
> > greg k-h  
> 
> I fully agree with the above. Renaming the function isn't necessary
> for the $subject series.
> 
> I suggest we simply drop this patch from the series - and if the
> renaming really makes sense in the end, we can deal with that
> separately later on.
> 
> So withdrawing my ack from this one.
> 
> Kind regards
> Uffe

Also agree on my side. I will fully remove this function renaming part from
this series in its next iteration.

Best regards,
Hervé

