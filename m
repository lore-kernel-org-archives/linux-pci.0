Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63883 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898Ab3ETRI6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 May 2013 13:08:58 -0400
Date: Mon, 20 May 2013 13:08:16 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Rob Herring <rob.herring@calxeda.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Maen Suleiman <maen@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Murray <Andrew.Murray@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCHv10 2/9] of/pci: Provide support for parsing PCI DT
 ranges property
Message-ID: <20130520170816.GU31290@titan.lakedaemon.net>
References: <1368719725-21265-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1368719725-21265-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130519203156.GO11137@titan.lakedaemon.net>
 <CACRpkdamm9vh_bXenJigwTYmN=n_SsEp+GQqAe9rdm8PRxPsqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkdamm9vh_bXenJigwTYmN=n_SsEp+GQqAe9rdm8PRxPsqw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 20, 2013 at 09:03:00AM +0200, Linus Walleij wrote:
> On Sun, May 19, 2013 at 10:31 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> 
> > patches 2, 3, and 4 applied to mvebu/of_pci to facilitate others
> > (LinusW) basing their work off of it.
> 
> Thanks, is this going to be pulled into ARM SoC soon-ish?
> 
> I think Arnd may need this for some PCI work too.

I was half expecting -rc2 to drop yesterday.  Since it didn't, I'll go
ahead and send another round of PRs, including this one.  Probably today
or tomorrow.

thx,

Jason.
