Return-Path: <SRS0=3l7c=EN=davemloft.net=davem@kernel.org>
Return-Path: <SRS0=3l7c=EN=davemloft.net=davem@kernel.org>
Date: Thu, 18 Jan 2018 09:11:58 -0500 (EST)
Message-Id: <20180118.091158.142992647744220505.davem@davemloft.net>
To: helgaas@kernel.org
Cc: hch@lst.de, bhelgaas@google.com, mchehab@kernel.org,
 kong.lai@tundra.com, linux-pci@vger.kernel.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] tsi108_eth: use dma API properly
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180118000818.GD53542@bhelgaas-glaptop.roam.corp.google.com>
References: <20180110180322.30186-1-hch@lst.de>
	<20180110180322.30186-4-hch@lst.de>
	<20180118000818.GD53542@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 17 Jan 2018 18:08:18 -0600

> [+cc David, FYI, I plan to merge this via PCI along with the rest of
> Christoph's series]

No problem.
