Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:55154
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756921Ab3KYTDj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Nov 2013 14:03:39 -0500
From: Rajat Jain <rajatjain@juniper.net>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Rajat Jain <rajatjain.linux@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux hotplug mailing <linux-hotplug@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Tom Nguyen <tom.l.nguyen@intel.com>,
	Kristen Accardi <kristen.c.accardi@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Guenter Roeck <groeck@juniper.net>
Subject: RE: [PATCH] pciehp: Acknowledge the spurious "cmd completed" event.
Date: Mon, 25 Nov 2013 19:03:11 +0000
Message-ID: <18997e8c20fb4bdd8a72e4c01b3fd308@BLUPR05MB118.namprd05.prod.outlook.com>
References: <52797238.8070304@gmail.com> <20131106002505.GC3359@google.com>
 <CADTPrLRmCjcKDeapFNk5vT3SfwSqSgVvd=u2p7BjgihXzsyfmg@mail.gmail.com>
 <CADTPrLQpaCDo_YCC2=MmT1iCrWRPqzDpnqQZrE8OMjRMc6WYmQ@mail.gmail.com>
 <20131108012352.GE2955@google.com>
 <CADTPrLTYOXsGovL8HJ7=+K30OWVeSdMKTma_UuMV8ZRFB6CkYA@mail.gmail.com>
 <CAErSpo7MH=+Jk-ujBoHquk2e+no1cqEV6p=R1E6LGvcLSJQyKw@mail.gmail.com>
 <CADTPrLRJD0er1kijjm2SEE6wUA9eQaz+OOd67E3MpHLu6k-R6Q@mail.gmail.com>
 <20131123005102.GA14690@google.com>
 <a3dc3d613f274e4d993d6a7612f1dde6@BLUPR05MB118.namprd05.prod.outlook.com>
 <CAErSpo7J8UZpYSaAPavJrR8iOt368expOuF-s_M7x+jW7drnWw@mail.gmail.com>
In-Reply-To: <CAErSpo7J8UZpYSaAPavJrR8iOt368expOuF-s_M7x+jW7drnWw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

> > On a different note, I feel there is still a need to apply my original
> patch. There is still an open problem in case of spurious interrupts (or
> in any case where the condition "if (slot_status & PCI_EXP_SLTSTA_CC)"
> becomes true in pcie_write_cmd()). That is because once that happens, we
> never clear that interrupt, and no further hotplug interrupts shall be
> received unless we do that.
> 
> I agree this is an issue and we should address it somehow.  My
> hesitation is just that I'd prefer to do some more aggressive
> restructuring rather than apply a point fix.  For example:

OK, I'll attempt to fix it that way when I get time.

> 
> - We currently look at PCI_EXP_SLTSTA_CC in pcie_isr(), pcie_poll_cmd(),
> and pcie_write_cmd().  I think it would be better to look at it only in
> pcie_isr().
> 
> - I don't think pcie_poll_cmd() should exist at all; we should poll by
> calling pcie_isr() instead.
> 
> - We need pcie_write_cmd(), but I think the way it waits is backwards.
>  Currently we issue the command, then wait for it to complete.  I think
> we should issue the command, note the current time, and return without
> waiting.  The *next* time we need to issue a command, we can wait for
> completion of the previous one (or timeout) if necessary.
> 
> But maybe we need the point fix in the interim, especially if anybody
> can actually produce the scenario you mention.

Ok.

Thanks,

Rajat

