Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f178.google.com ([209.85.210.178]:37323 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761077Ab3DBLg1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Apr 2013 07:36:27 -0400
Received: by mail-ia0-f178.google.com with SMTP id r13so225494iar.37
        for <linux-pci@vger.kernel.org>; Tue, 02 Apr 2013 04:36:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
Date: Tue, 2 Apr 2013 13:36:26 +0200
Message-ID: <CACRpkdb77h+7FCjEbc3Jy9+3M5KdCEk3ktsuTHOT1W6AKToJZw@mail.gmail.com>
Subject: Re: [PATCHv7 00/17] PCIe support for the Armada 370 and Armada XP SoCs
From: Linus Walleij <linus.walleij@linaro.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Rob Herring <rob.herring@calxeda.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Maen Suleiman <maen@marvell.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Mitch Bradley <wmb@firmworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 27, 2013 at 3:40 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> As we are approaching 3.10, I would now like to get formal Acked-by,
> or disagreements from the following maintainers/developers :
>
>  * Grant Likely, as the OF maintainer, for patches 1, 2 and 3
>
>    [PATCH v5 01/17] of/pci: Provide support for parsing PCI DT ranges
>    [PATCH v5 02/17] of/pci: Add of_pci_get_devfn() function
>    [PATCH v5 03/17] of/pci: Add of_pci_parse_bus_range() function

I think Rob Herring can help out in reviewing this, as comaintainer
of devicetree stuff.

Yours,
Linus Walleij
