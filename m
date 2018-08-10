Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:43796 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeHJR1O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Aug 2018 13:27:14 -0400
Date: Fri, 10 Aug 2018 07:56:55 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Martin Mares <mj@ucw.cz>
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
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: lspci: Display path to device
Message-ID: <20180810145655.GA16533@bombadil.infradead.org>
References: <20180717170204.30470-1-logang@deltatee.com>
 <20180717203900.GA1771@bombadil.infradead.org>
 <mj+md-20180810.091549.51451.nikam@ucw.cz>
 <mj+md-20180810.103017.64385.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
In-Reply-To: <mj+md-20180810.103017.64385.nikam@ucw.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 10, 2018 at 12:30:35PM +0200, Martin Mares wrote:
> Hello!
> 
> > ... the more I think about it, the more I am convinced that we want to
> > re-use the bus topology builder from ls-tree.c. I will give it a try,
> > stay tuned.
> 
> Please see the "topology" branch in pciutils.git.

Thanks.  I found two problems so far.

One is that using -P and -s together doesn't work because we haven't
scanned the entire topology.

$ ./lspci-mw -PF tests/fujitsu-p8010.lspci -s 1d:00.0
00:1e.0/03.0/00.0 Network controller: 3Com Corporation 3com 3CRWE154G72 [Office Connect Wireless LAN Adapter] (rev 01)
$ ./lspci-mm -PF tests/fujitsu-p8010.lspci -s 1d:00.0
1d:00.0 Network controller: 3Com Corporation 3com 3CRWE154G72 [Office Connect Wireless LAN Adapter] (rev 01)

The other is that even when not using -s, the topology isn't fully represented:

$ ./lspci-mm -PF tests/fujitsu-p8010.lspci |grep 3com
00:1e.0/00.0 Network controller: 3Com Corporation 3com 3CRWE154G72 [Office Connect Wireless LAN Adapter] (rev 01)

I've attached a compressed form of the fujitsu-p8010.lspci dump for your
testing.

--6TrnltStXW4iwmi0
Content-Type: application/x-xz
Content-Disposition: attachment; filename="fujitsu-p8010.lspci.xz"
Content-Transfer-Encoding: base64

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
GW0AAbUV1/MFAAX2JFCxxGf7AgAAAAAEWVo=

--6TrnltStXW4iwmi0--
