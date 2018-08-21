Return-Path: <SRS0=4L79=LE=davemloft.net=davem@kernel.org>
Return-Path: <SRS0=4L79=LE=davemloft.net=davem@kernel.org>
Date: Tue, 21 Aug 2018 12:31:08 -0700 (PDT)
Message-Id: <20180821.123108.89921430801253333.davem@davemloft.net>
To: hkallweit1@gmail.com
Cc: helgaas@kernel.org, jian-hong@endlessm.com, nic_swsd@realtek.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com,
 linux-pci@vger.kernel.org, marc.zyngier@arm.com, tglx@linutronix.de,
 hch@lst.de
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
From: David Miller <davem@davemloft.net>
In-Reply-To: <9d7d960a-6c55-dc4b-7969-f5cf46bff0ce@gmail.com>
References: <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
	<20180820184438.GA154536@bhelgaas-glaptop.roam.corp.google.com>
	<9d7d960a-6c55-dc4b-7969-f5cf46bff0ce@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-pci.vger.kernel.org>

From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Mon, 20 Aug 2018 22:46:48 +0200

> I'm in contact with Realtek and according to them few chip versions
> seem to clear MSI-X table entries on resume from suspend. Checking
> with them how this could be fixed / worked around.
> Worst case we may have to disable MSI-X in general.

I worry that if the chip does this, and somehow MSI-X is enabled and
an interrupt is generated, the chip will write to the cleared out
MSI-X address.  This will either write garbage into memory or cause
a bus error and require PCI error recovery.

It also looks like your test patch doesn't fix things for people who
have tested it.

Hmmm...
