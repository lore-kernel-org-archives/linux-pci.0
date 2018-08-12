Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:49726 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbeHLN3Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Aug 2018 09:29:25 -0400
Date: Sun, 12 Aug 2018 12:51:46 +0200
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
Message-ID: <mj+md-20180812.105055.30846.nikam@ucw.cz>
References: <20180717170204.30470-1-logang@deltatee.com>
 <20180717203900.GA1771@bombadil.infradead.org>
 <mj+md-20180810.091549.51451.nikam@ucw.cz>
 <mj+md-20180810.103017.64385.nikam@ucw.cz>
 <20180810145655.GA16533@bombadil.infradead.org>
 <mj+md-20180812.092635.39872.nikam@ucw.cz>
 <20180812103133.GB2984@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180812103133.GB2984@bombadil.infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> I agree it's more intuitive, but it's not the format that Logan's code
> is expecting, so it's not as useful for my purposes.  How about this?
> 
> $ ./lspci -PF tests/fujitsu-p8010.lspci -s 1d:00.0
> 00:1e.0/03.0/00.0 Network controller: 3Com Corporation 3com 3CRWE154G72 [Office Connect Wireless LAN Adapter] (rev 01)
> $ ./lspci -PPF tests/fujitsu-p8010.lspci -s 1d:00.0
> 00:1e.0/1c:03.0/1d:00.0 Network controller: 3Com Corporation 3com 3CRWE154G72 [Office Connect Wireless LAN Adapter] (rev 01)

Yes, this looks fine.

It is merged to master now and I will push a new release out of the door soon.

			Thanks!
					Martin
