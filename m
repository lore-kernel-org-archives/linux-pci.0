Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42871 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751001AbdBFLuj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2017 06:50:39 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: Yinghai Lu <yinghai@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: pciehp is broken from 4.10-rc1
Date: Mon, 06 Feb 2017 12:45:52 +0100
Message-ID: <1560858.iXZjR0AeNd@aspire.rjw.lan>
In-Reply-To: <20170204233443.GA234@wunner.de>
References: <CAE9FiQVCMCa7iVyuwp9z6VrY0cE7V_xghuXip28Ft52=8QmTWw@mail.gmail.com> <CAE9FiQUuFJHMScyFgnHbs5r-SzTiRiBZ2JcpUYJhg0ft75-OBQ@mail.gmail.com> <20170204233443.GA234@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday, February 05, 2017 12:34:43 AM Lukas Wunner wrote:
> On Sat, Feb 04, 2017 at 01:44:34PM -0800, Yinghai Lu wrote:
> > On Sat, Feb 4, 2017 at 10:56 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > > On Sat, Feb 04, 2017 at 09:12:54AM +0100, Lukas Wunner wrote:
> > > Section 6.7.3.4 of the PCIe Base spec seems to support the theory above,
> > > so here's a tentative patch.
> > >
> > >
> > > -- >8 --
> > > Subject: [PATCH] PCI: pciehp: Don't enable PME on runtime suspend
> > 
> > it works:
> 
> Thanks a lot for the report and for testing the patch!
> 
> 
> @Rafael:
> Bjorn usually wants you to ack PM-related patches.  Looking at the
> patch again I'm now thinking it might be cleaner to move the check
> for is_hotplug_bridge into pci_dev_run_wake().  Thoughts?

Yes, pci_dev_run_wake() would be a better place.

Thanks,
Rafael
