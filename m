Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:49324 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024Ab3ETHDB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 May 2013 03:03:01 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so13219419iej.30
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2013 00:03:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130519203156.GO11137@titan.lakedaemon.net>
References: <1368719725-21265-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1368719725-21265-3-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130519203156.GO11137@titan.lakedaemon.net>
Date: Mon, 20 May 2013 09:03:00 +0200
Message-ID: <CACRpkdamm9vh_bXenJigwTYmN=n_SsEp+GQqAe9rdm8PRxPsqw@mail.gmail.com>
Subject: Re: [PATCHv10 2/9] of/pci: Provide support for parsing PCI DT ranges property
From: Linus Walleij <linus.walleij@linaro.org>
To: Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Tawfik Bayouk <tawfik@marvell.com>, linux-pci@vger.kernel.org,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Rob Herring <rob.herring@calxeda.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Maen Suleiman <maen@marvell.com>,
	Andrew Murray <Andrew.Murray@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 19, 2013 at 10:31 PM, Jason Cooper <jason@lakedaemon.net> wrote:

> patches 2, 3, and 4 applied to mvebu/of_pci to facilitate others
> (LinusW) basing their work off of it.

Thanks, is this going to be pulled into ARM SoC soon-ish?

I think Arnd may need this for some PCI work too.

Yours,
Linus Walleij
