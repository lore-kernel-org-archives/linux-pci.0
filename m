Return-Path: <SRS0=JCzE=IO=ucw.cz=mj+f-270518+helgaas=kernel.org@kernel.org>
Return-Path: <SRS0=JCzE=IO=ucw.cz=mj+f-270518+helgaas=kernel.org@kernel.org>
Date: Sun, 27 May 2018 13:55:32 +0200
From: Martin Mares <mj@ucw.cz>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rajat Jain <rajatja@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] lspci: Indicate if the OS / kernel go out-of-sync on BAR
Message-ID: <mj+md-20180527.115322.70863.nikam@ucw.cz>
References: <20180516013333.135259-1-rajatja@google.com>
 <20180524223751.GC15320@bhelgaas-glaptop.roam.corp.google.com>
 <CACK8Z6E6g=+T04qDUXhQrhHr1y5O05yHbjTuLM7oxnn1XJpBmw@mail.gmail.com>
 <20180525183049.GB63280@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180525183049.GB63280@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hello!

> I don't disagree; that does sound like it could be useful.  I just
> don't know the best way to accomplish it.  Seems like you'd have to do
> something in resource_show() to re-read the BAR and validate the
> cache.  I don't know what you do if you find that it's invalid.

I also do not see how to do it in a reasonably simple way.

I checked lspci and it turned out that it already add a "[virtual]"
marker in cases when the BAR is zero (which was this case -- am I right?)
and the kernel reports a non-zero address.

However, it turned out that the check is never triggered on I/O regions,
because the BAR contains a non-zero type bit.

I have modified the check to take into account just the address part
of the BAR. You can check it in the master branch.

				Martin
