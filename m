Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:61642 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbaIOTEq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Sep 2014 15:04:46 -0400
Received: by mail-pd0-f182.google.com with SMTP id w10so6946746pde.41
        for <linux-pci@vger.kernel.org>; Mon, 15 Sep 2014 12:04:46 -0700 (PDT)
Date: Mon, 15 Sep 2014 13:03:19 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	David Henningsson <david.henningsson@canonical.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Richter <thor@math.tu-berlin.de>,
	gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH] Add pci=assign-busses quirk to Dell Latitude D505
Message-ID: <20140915190319.GA15350@google.com>
References: <20140913031818.GA25656@google.com>
 <1410732627-25445-1-git-send-email-andreas.noever@gmail.com>
 <20140915095305.GA7669@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140915095305.GA7669@richard>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 15, 2014 at 05:53:05PM +0800, Wei Yang wrote:
> On Mon, Sep 15, 2014 at 12:10:27AM +0200, Andreas Noever wrote:
> ...

> >@@ -840,8 +863,10 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
> >
> > 		if (max >= bus->busn_res.end) {
> > 			dev_warn(&dev->dev, "can't allocate child bus %02x from %pR\n",
> >-				 max, &bus->busn_res);
> >-			goto out;
> >+				 max + 1, &bus->busn_res);
> >+			/* Try to resize bus */
> >+			if (pci_grow_bus(bus, max + 1))
> >+				goto out;
> 
> On some platforms, like powerpc, we have some limitations of the bus number a
> bridge could have. Sometimes, we need the start bus number to be power 2
> aligned.

Huh.  I have to admit that I'm getting tired of all the powerpc-specific
PCI hacks.  It's hard enough to get this stuff working on hardware that
conforms to the spec, and scattering pcibios_*() hooks around makes the
code even harder to follow.

What would happen if powerpc used PCI_PROBE_ONLY?  Do you really depend on
the PCI core to configure anything for you, or does your firmware set
everything up the way it needs to be?

Changing bridge configuration seems like something we should avoid under
PCI_PROBE_ONLY (I haven't read Andreas' patch in detail, so I don't know if
that's how it works).  If PCI_PROBE_ONLY would work for powerpc, then we
wouldn't have an issue here.

Bjorn
