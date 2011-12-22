Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 22 Dec 2011 17:02:27 -0500 (EST)
Message-Id: <20111222.170227.1906514601375643135.davem@davemloft.net>
To: bhelgaas@google.com
Cc: James.Bottomley@hansenpartnership.com, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	jbarnes@virtuousgeek.org
Subject: Re: [PATCH v2 00/29] Create PCI root buses with correct resources
From: David Miller <davem@davemloft.net>
In-Reply-To: <20111222.145629.505018474228371646.davem@davemloft.net>
References: <20111222.135911.584309149966835644.davem@davemloft.net>
	<20111222.141537.1513319029738355747.davem@davemloft.net>
	<20111222.145629.505018474228371646.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Miller <davem@davemloft.net>
Date: Thu, 22 Dec 2011 14:56:29 -0500 (EST)

> In my case arch_setup_msi_irqs() is failing simply because MSI has
> not been enabled on these PCI host bridges.  It should, and I'm
> trying to figure out if this is some strange interaction with the
> new resource code.

It wasn't a problem with the resource changes, it's a sparc64 problem
that only triggers on more recent systems.

The MSI SYSFS error handling is, of course, still needing to be fixed.
