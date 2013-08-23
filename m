Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:34220 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756204Ab3HWVSx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Aug 2013 17:18:53 -0400
To: Shaohua Li <shli@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: VIA chipset with Root Port under a bridge
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <20130823010652.GA1539@kernel.org>
References: <CAErSpo53GpzdinvmQNX=DfJSsTUOzKng6LT1jrDSM8aU1ZUJiA@mail.gmail.com> <CAErSpo49W9iYWUfVRCALr9Nkvuzs38MwzNUAXLgr91BRiRFtFQ@mail.gmail.com> <20130823010652.GA1539@kernel.org>
Date: Fri, 23 Aug 2013 23:18:47 +0200
Message-Id: <20130823211847.590EF380AE5@gemini.denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Shaohua Li,

In message <20130823010652.GA1539@kernel.org> you wrote:
> On Thu, Aug 22, 2013 at 03:49:24PM -0600, Bjorn Helgaas wrote:
> > [replace Shaohua's dead Intel address with @kernel.org address; please
> > reply to this, not the original]
> > 
> > On Thu, Aug 22, 2013 at 3:47 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > > Shaohua, your commit 8e822df700 references a VIA chipset with a Root
> > > Port under a bridge, and that commit adds a special case to disable
> > > ASPM for that situation.
> > >
> > > I know this is pretty old (the commit is from 2009), but do you have
> > > any more details about that system?  A pointer to the original problem
> > > report, lspci output, dmesg output, etc.?
> > >
> > > I'm concerned because other parts of PCI make assumptions about Root
> > > Port topology, e.g., in MPS configuration, and we might need to make
> > > similar changes elsewhere.
> 
> I tried to search this in my mail archive, but no success, sorry. Suppose
> Wolfgang reported it, but I can't remember any more details. Maybe check VIA
> datasheet?

Yes, I reported this.  I think I will find all the details in my mail
archives, but I'm currently on vacation with limited access only.
I'll dig this out when I'm back in September.  Please feel free to
send me a reminder if I should not report back within the next two
weeks.

Sorry for the delay.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
An optimist believes we live in the best world possible; a  pessimist
fears this is true.
