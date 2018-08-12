Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:59698 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeHLNJe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Aug 2018 09:09:34 -0400
Date: Sun, 12 Aug 2018 03:31:33 -0700
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
Message-ID: <20180812103133.GB2984@bombadil.infradead.org>
References: <20180717170204.30470-1-logang@deltatee.com>
 <20180717203900.GA1771@bombadil.infradead.org>
 <mj+md-20180810.091549.51451.nikam@ucw.cz>
 <mj+md-20180810.103017.64385.nikam@ucw.cz>
 <20180810145655.GA16533@bombadil.infradead.org>
 <mj+md-20180812.092635.39872.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <mj+md-20180812.092635.39872.nikam@ucw.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Aug 12, 2018 at 11:28:37AM +0200, Martin Mares wrote:
> Hello!
> 
> > One is that using -P and -s together doesn't work because we haven't
> > scanned the entire topology.
> 
> Fixed. When topology is required, we now scan all devices and apply the
> filters later.

Thanks!

> > The other is that even when not using -s, the topology isn't fully represented:
> > 
> > $ ./lspci-mm -PF tests/fujitsu-p8010.lspci |grep 3com
> > 00:1e.0/00.0 Network controller: 3Com Corporation 3com 3CRWE154G72 [Office Connect Wireless LAN Adapter] (rev 01)
> 
> Ah well, it seems that the tree mode never worked with CardBus bridges. Fixed.

Haha!  I can't believe we never noticed that in the last twenty years!
And we're fixing it even though PCI CardBus bridges are now completely
obsolete (my current laptop has no slots of that form factor; my previous
laptop has an ExpressCard slot; I had to go back to my previous-previous
laptop from 2008 to find sample hardware to test CardBus).

> After some pondering, I changed the format of the paths to include bus numbers
> in all steps. I think it is more intuitive.

I agree it's more intuitive, but it's not the format that Logan's code
is expecting, so it's not as useful for my purposes.  How about this?

$ ./lspci -PF tests/fujitsu-p8010.lspci -s 1d:00.0
00:1e.0/03.0/00.0 Network controller: 3Com Corporation 3com 3CRWE154G72 [Office Connect Wireless LAN Adapter] (rev 01)
$ ./lspci -PPF tests/fujitsu-p8010.lspci -s 1d:00.0
00:1e.0/1c:03.0/1d:00.0 Network controller: 3Com Corporation 3com 3CRWE154G72 [Office Connect Wireless LAN Adapter] (rev 01)

I pondered asking Logan to change his parser to include the bus number
as a solution, but then I remembered the entire point of this is to make
specifying a device robust against bus number assignmnet changes.  I suppose
we could have the parser accept and ignore the bus number ...

diff --git a/lspci.c b/lspci.c
index 75cb5b9..3dabbde 100644
--- a/lspci.c
+++ b/lspci.c
@@ -50,7 +50,8 @@ static char help_msg[] =
 "-xxxx\t\tShow hex-dump of the 4096-byte extended config space (root only)\n"
 "-b\t\tBus-centric view (addresses and IRQ's as seen by the bus)\n"
 "-D\t\tAlways show domain numbers\n"
-"-P\t\tDisplay bus path in addition to bus and device number\n"
+"-P\t\tDisplay bridge path in addition to bus and device number\n"
+"-PP\t\tDisplay bus path in addition to bus and device number\n"
 "\n"
 "Resolving of device ID's to names:\n"
 "-n\t\tShow numeric ID's\n"
@@ -264,7 +265,10 @@ show_slot_path(struct device *d)
       if (br && br->br_dev)
 	{
 	  show_slot_path(br->br_dev);
-	  printf("/%02x:%02x.%d", p->bus, p->dev, p->func);
+	  if (opt_path > 1)
+	    printf("/%02x:%02x.%d", p->bus, p->dev, p->func);
+	  else
+	    printf("/%02x.%d", p->dev, p->func);
 	  return;
 	}
     }
diff --git a/lspci.man b/lspci.man
index 78b5c96..55fadb1 100644
--- a/lspci.man
+++ b/lspci.man
@@ -98,6 +98,10 @@ have only domain 0.
 .TP
 .B -P
 Identify PCI devices by path through each bridge, instead of by bus number.
+.TP
+.B -PP
+Identify PCI devices by path through each bridge, showing the bus number as
+well as the device number.
 
 .SS Options to control resolving ID's to names
 .TP
