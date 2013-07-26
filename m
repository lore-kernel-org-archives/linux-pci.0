Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47554 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932179Ab3GZOF2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Jul 2013 10:05:28 -0400
Message-ID: <1374847288.9200.8.camel@pasglop>
Subject: Re: [PATCH] PCI: Add quirk for setting valid class for FSL PCI host
 bridge
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Chunhe Lan <Chunhe.Lan@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Sat, 27 Jul 2013 00:01:28 +1000
In-Reply-To: <CAErSpo4xftQjwKHsenuKuEvT10iOa+DuiYfSyJYLhp=ObcDZsQ@mail.gmail.com>
References: <1374823418-1550-1-git-send-email-Chunhe.Lan@freescale.com>
	 <CAErSpo4xftQjwKHsenuKuEvT10iOa+DuiYfSyJYLhp=ObcDZsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2013-07-26 at 07:07 -0600, Bjorn Helgaas wrote:
> 
> 1.  This looks an awful lot like quirk_fsl_pcie_head().
> quirk_fsl_pcie_head() is currently a HEADER quirk, but that runs
> *after* pci_setup_device(), where dev->class is used.  I suspect this
> should be an EARLY quirk instead.  But this quirk has a long history
> as a HEADER quirk, and I'm sure many people have tested it, so I don't
> know what's going on.
> 
> 2.  I assume the Freescale vendor ID might be used for devices other
> than bridges, so I doubt it would be correct to overwrite the class
> for *every* Freescale device as you're doing here.

That wouldn't be the first time we need a quirk like that, it looks like
HW folks love playing with the class codes in stupid ways.

I remember once trying to change the FSP header quirk to an early quirk
and breaking something else doing so ... At some point I ran out of time
debugging that stuff and put it on my TODO list ... you know the file
you open in O_APPEND mode :-) That was a year ago or so...

So yes, something is fishy here and in need of a better fix, and at this
stage I'd say FSL folks should sort it out. These things need to be
early quirks and if that breaks something we need to know what and why.

Also we tend to have them in arch/powerpc next to the relevant driver
code... that quirks.c file is just a mess and certainly not the right
place for something like that.

Cheers,
Ben.


