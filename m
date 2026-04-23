Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED4E3DEAE4;
	Thu, 23 Apr 2026 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933728; cv=none; b=YCb5IJrxvmsUgH+lePmA8H8cggM2BjBdeTOtTSSC7ojuJqt7WHtqgz3fwvbBmXQMcu9K20qdfE0Ny/m7jZ+S9U4nU9nLOFNBHcO1bb+dFBlTCG9+PbXd2cSPOGx/eFf3Q/bu0tg5YGquHfkh3rgOCHiXLnjYOvB225qnwpJF3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933728; c=relaxed/simple;
	bh=qbmvRxNwjPJySkdRlLxR16VTUeX6pN7MhszSZBGGJgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3tUTt9qSDMJaZSePrLeWPO5cHTCK6kviLMSarFalOXb8j2mo3mY4AiizQgdqh9SgrRfWiLVbyBL1E1aBDZoGJ0zEnZmSNraVl9eciqhzlCNTmrpE66wMkt6Gt1cv7PdLfDxLjfypRWEcUweYQ2t+OiY/1tMXGyw6xSGg96H/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RHSMPu0z; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RHSMPu0z"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BE1824E42AC9;
	Thu, 23 Apr 2026 08:42:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 81637604EB;
	Thu, 23 Apr 2026 08:42:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E551910460B49;
	Thu, 23 Apr 2026 10:41:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776933721; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hpnJk/yJbY+uVhKNecCDBid6JdXHXsFWMSbXliiAR00=;
	b=RHSMPu0z0hSdt3mn4ffe5+6hUm/ZCjtCUZUKE3rWKy/r3VhfZhbKf1a9Ulxwtthkq/Wtgh
	ronPMyU1B2CxZw6JMN3u3wI3DLWBsdkToYIBM80eaHi7YgAeDyH1Z2ue1q/847GcERxQOk
	g0JXmw3tYv6IvZXdp7pb5HMp5Kl7KsJKyYniqOHUilIBM3mmL0cJgDls1/VLPGNufaZTfw
	v2x1SEkJspkHM37hhCeIXdZLX8dFFZdF2oY0Y3ytw9DTXzpHCHxarn2MoEkQvoK+911wsc
	ELgVc4CKa9SO2hHeYBProWT6SvtWBufgTUp8YNP4tGFwdFM5Ild9qV3eo9YpxA==
Date: Thu, 23 Apr 2026 10:41:39 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Doug Anderson <dianders@chromium.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Kalle Niemi <kaleposti@gmail.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Andi
 Shyti <andi.shyti@kernel.org>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, Arnd
 Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Charles Keepax
 <ckeepax@opensource.cirrus.com>, Richard Fitzgerald
 <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, Linus
 Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark
 Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>, Daniel Scally
 <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Shawn Guo
 <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
 linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 02/27] of: dynamic: Fix overlayed devices not probing
 because of fw_devlink
Message-ID: <20260423104139.0246ca0a@bootlin.com>
In-Reply-To: <CAMuHMdUDCQrQ2Z9D7-ZOKiuDznDJVf2R_b_8P9+Xhk4RiJ3vdw@mail.gmail.com>
References: <20260325143555.451852-1-herve.codina@bootlin.com>
	<20260325143555.451852-3-herve.codina@bootlin.com>
	<CAMuHMdU7x7LWFkD9xiq+wyOqnn0bdzr+JLfvbBexoiWyv8kftA@mail.gmail.com>
	<CAD=FV=UK3NQKQN7FXyG4nGdDKO=LQYhnL4ZweomQ_4R9-EAYag@mail.gmail.com>
	<aekg_IELc65BFrWp@ashevche-desk.local>
	<CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
	<CAMuHMdUDCQrQ2Z9D7-ZOKiuDznDJVf2R_b_8P9+Xhk4RiJ3vdw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Geert, Doug,

On Thu, 23 Apr 2026 08:53:33 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Doug,
> 
> On Wed, 22 Apr 2026 at 21:40, Doug Anderson <dianders@chromium.org> wrote:
> > On Wed, Apr 22, 2026 at 12:27 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:  
> > > On Wed, Apr 22, 2026 at 11:51:36AM -0700, Doug Anderson wrote:  
> > > > On Wed, Apr 22, 2026 at 10:44 AM Geert Uytterhoeven
> > > > <geert@linux-m68k.org> wrote:  
> > > > > On Wed, 25 Mar 2026 at 15:36, Herve Codina <herve.codina@bootlin.com> wrote:  
> > >
> > > ...
> > >  
> > > > > > +               if (fwnode->flags & FWNODE_FLAG_NOT_DEVICE)  
> > > > >
> > > > > After commit f72e77c33e4b5657 ("device property: Make modifications
> > > > > of fwnode "flags" thread safe"), this must be changed to:
> > > > >
> > > > >     if (fwnode_test_flag(fwnode, FWNODE_FLAG_NOT_DEVICE))
> > > > >
> > > > > With this change my DT overlays are working again.
> > > > >
> > > > > I guess keeping the FWNODE_FLAG_* names, but changing their values
> > > > > from bit masks to bit numbers was probably not such a good idea,
> > > > > as it fails to catch missing conversions...  
> > > >
> > > > Crud, I should have thought about that. :( Do you think it's worth it
> > > > to do a rename at this point to catch future problems?  
> 
> I am afraid it is too late (it is already in Linus' tree), and would
> add only more to the confusion.  We just have to take care when this
> patch (and 01/27) is backported to stable.  Fortunately the reverse
> is caught, as the fwnode_*_flag() helpers did not exist before.
> 
> > > You can try locally with allyesconfig / allmodconfig and see the outcome.
> > > If there are missed cases, and their amount reasonably low, I won't bother
> > > in this case.  
> >
> > I believe I caught all of them at the time of my CL, but the problem
> > is in-flight stuff, right? I think the problem Geert is pointing out
> > isn't something I missed in my original patch but rather an
> > interaction between my patch and this in-flight patch.  
> 
> There are no unconverted cases in upstream or linux-next
> (I checked yesterday, and rechecked this morning).
> 

Thanks for having pointed out this modification.
It will save some debug hours on my side when I test the next iteration. 

For this in-flight series, I will use new accessors introduced in
f72e77c33e4b5657 ("device property: Make modifications of fwnode "flags"
thread safe")

Best regards,
Hervé

