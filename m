Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:48917 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755681AbaBTRf2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 20 Feb 2014 12:35:28 -0500
Date: Thu, 20 Feb 2014 10:35:18 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"Longchamp, Valentin" <Valentin.Longchamp@keymile.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: pci-mvebu driver on km_kirkwood
Message-ID: <20140220173518.GA19893@obsidianresearch.com>
References: <51DD9A8C.10608@keymile.com>
 <20130711163220.2b3adf38@skate>
 <53039894.10905@keymile.com>
 <20140218212751.07c2aeb5@skate>
 <53046D98.6020801@keymile.com>
 <20140219102658.76eec91e@skate>
 <53047BBB.6040108@keymile.com>
 <20140219143749.65ff3155@skate>
 <CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com>
 <20140220095518.7ca36f0a@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140220095518.7ca36f0a@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 20, 2014 at 09:55:18AM +0100, Thomas Petazzoni wrote:

> Does that make sense? Keep in mind that I'm still not completely
> familiar with the PCI terminology, so maybe the above explanation does
> not use the right terms.

Stated another way, the Marvel PCI-E to PCI-E bridge config space has
a quirk that requires the window BARs to be aligned on their size and
sized to a power of 2.

The first requirement is already being handled by hooking through
ARM's 'align_resource' callback.

One avenue would be to have mvebu_pcie_align_resource return a struct
resource and manipulate the size as well. Assuming the PCI core will
accommodate that.

Jason
