Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59453 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965464AbcHEBAj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2016 21:00:39 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Dave Airlie <airlied@linux.ie>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Runtime resume bridges before bus rescans
Date: Fri, 05 Aug 2016 03:05:52 +0200
Message-ID: <1715354.XJRkSZIhcu@vostro.rjw.lan>
In-Reply-To: <CA+55aFxV68Bp0xCfDBzvUYZiLHiRW4FAUQ07ft_2SBuCF01bSw@mail.gmail.com>
References: <5356594.Wd8M8VygiD@vostro.rjw.lan> <CA+55aFxV68Bp0xCfDBzvUYZiLHiRW4FAUQ07ft_2SBuCF01bSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, August 04, 2016 08:53:14 PM Linus Torvalds wrote:
> On Thu, Aug 4, 2016 at 8:38 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If a PCI bridge (or PCIe port) that is runtime-suspended gets an
> > ACPI hotplug notification, such as a bus check, it has to be resumed
> > before re-scanning the devices below it, or those devices will not
> > be accessible and will be treated as hot-removed.
> 
> Just checking: do you want me to apply this as a patch, or are you
> adding it to your git tree and just cc'ing me as a FYI?

Please apply it directly if that's not a problem.

Thanks,
Rafael

