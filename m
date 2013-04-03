Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:39475 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758007Ab3DCQb7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2013 12:31:59 -0400
Received: by mail-ia0-f179.google.com with SMTP id x24so1433681iak.38
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2013 09:31:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130403142712.160be55e@skate>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130403142712.160be55e@skate>
Date: Wed, 3 Apr 2013 18:31:58 +0200
Message-ID: <CACRpkdYbxXqP_KdcfUFCU4ZyNLn3SmLYcio5QgPqE=zLP7FV2w@mail.gmail.com>
Subject: Re: [PATCHv7 00/17] PCIe support for the Armada 370 and Armada XP SoCs
From: Linus Walleij <linus.walleij@linaro.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Rob Herring <rob.herring@calxeda.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Maen Suleiman <maen@marvell.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Mitch Bradley <wmb@firmworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 3, 2013 at 2:27 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> Bjorn, Rob, Grant, Russell,
>
> Through this e-mail, I'd like to send you a kind reminder about this
> patch series. The latest version has been sent a week ago, and there
> has been only minor changes requested since v4 sent early March, i.e a
> month ago. Therefore, I would hope for this series to enter 3.10.
>
> But this patch set is touching areas you are the maintainer for, so I
> would appreciate if you could do a formal review and give your comments
> or your Ack. I would especially appreciate if you do so in the very
> near future, so that if there are comments, I'll have the time to fix
> them and resubmit and updated version in time.
>
> Here are the patches, classified by maintainer area:

FYI I have applied patches 1 thru 3 and converted my PCI DT series
for the Integrator to use the new infrastructure, so you can add
Tested-by: Linus Walleij <linus.walleij@linaro.org>
on these if you wish. (Working fine.)

The Integrator PCI DT work is dependent on these patches so I
also have a strong interest to have them merged somewhere so I
can submit my series against them...

Yours,
Linus Walleij
