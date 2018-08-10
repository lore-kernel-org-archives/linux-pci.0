Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:56050 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727288AbeHJMKx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Aug 2018 08:10:53 -0400
Date: Fri, 10 Aug 2018 11:35:01 +0200
From: Martin Mares <mj@ucw.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: lspci: Display path to device
Message-ID: <mj+md-20180810.091549.51451.nikam@ucw.cz>
References: <20180717170204.30470-1-logang@deltatee.com>
 <20180717203900.GA1771@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180717203900.GA1771@bombadil.infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> I don't like telling the user to grovel around lspci -t by hand.  It's
> not many lines of code to add a new -P option to lspci to show the path
> to each device instead of bus:dev.fn

I like the feature, but I have a couple of minor objections to the
implementation:

> -static char options[] = "nvbxs:d:ti:mgp:qkMDQ" GENERIC_OPTIONS ;
> +static char options[] = "nvbxs:d:tPi:mgp:qkMDQ" GENERIC_OPTIONS ;

Please update the help_msg, too.

> +static void
> +show_slot_path(struct pci_dev *p)
> +{
> +  struct pci_dev *d = NULL;
> +
> +  if (opt_path && p->bus)
> +    {
> +      for (d = p->access->devices; d; d = d->next) {
> +	if (d->hdrtype == -1)
> +	  d->hdrtype = pci_read_byte(d, PCI_HEADER_TYPE) & 0x7f;

Please do not modify the hdrtype field, it is private to libpci.

Instead, always read the PCI_HEADER_TYPE register. It will be fast since
lspci caches configuration space accesses.

> +	if (d->hdrtype != PCI_HEADER_TYPE_BRIDGE &&
> +	    d->hdrtype != PCI_HEADER_TYPE_CARDBUS)
> +	  continue;
> +	if (pci_read_byte(d, PCI_SECONDARY_BUS) > p->bus)
> +	  continue;
> +	if (pci_read_byte(d, PCI_SUBORDINATE_BUS) < p->bus)
> +	  continue;

Beware, cardbus bridges use different registers for secondary and subordinate bus.

... the more I think about it, the more I am convinced that we want to
re-use the bus topology builder from ls-tree.c. I will give it a try,
stay tuned.

				Martin
