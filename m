Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:62439 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753614Ab3HWBHD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 22 Aug 2013 21:07:03 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so10894pbc.3
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2013 18:07:02 -0700 (PDT)
Date: Fri, 23 Aug 2013 09:06:52 +0800
From: Shaohua Li <shli@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wolfgang Denk <wd@denx.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: VIA chipset with Root Port under a bridge
Message-ID: <20130823010652.GA1539@kernel.org>
References: <CAErSpo53GpzdinvmQNX=DfJSsTUOzKng6LT1jrDSM8aU1ZUJiA@mail.gmail.com>
 <CAErSpo49W9iYWUfVRCALr9Nkvuzs38MwzNUAXLgr91BRiRFtFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo49W9iYWUfVRCALr9Nkvuzs38MwzNUAXLgr91BRiRFtFQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 22, 2013 at 03:49:24PM -0600, Bjorn Helgaas wrote:
> [replace Shaohua's dead Intel address with @kernel.org address; please
> reply to this, not the original]
> 
> On Thu, Aug 22, 2013 at 3:47 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > Shaohua, your commit 8e822df700 references a VIA chipset with a Root
> > Port under a bridge, and that commit adds a special case to disable
> > ASPM for that situation.
> >
> > I know this is pretty old (the commit is from 2009), but do you have
> > any more details about that system?  A pointer to the original problem
> > report, lspci output, dmesg output, etc.?
> >
> > I'm concerned because other parts of PCI make assumptions about Root
> > Port topology, e.g., in MPS configuration, and we might need to make
> > similar changes elsewhere.

I tried to search this in my mail archive, but no success, sorry. Suppose
Wolfgang reported it, but I can't remember any more details. Maybe check VIA
datasheet?

Thanks,
Shaohua
