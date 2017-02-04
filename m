Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:46109 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbdBDXc4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Feb 2017 18:32:56 -0500
Date: Sun, 5 Feb 2017 00:34:43 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: pciehp is broken from 4.10-rc1
Message-ID: <20170204233443.GA234@wunner.de>
References: <CAE9FiQVCMCa7iVyuwp9z6VrY0cE7V_xghuXip28Ft52=8QmTWw@mail.gmail.com>
 <20170203055200.GA29413@wunner.de>
 <CAE9FiQWs0H9vqEo2ZYnWWBW0Ao-hx4WYHQ69cyR32nFQ9yV9rw@mail.gmail.com>
 <20170204081254.GA29595@wunner.de>
 <20170204185607.GA29957@wunner.de>
 <CAE9FiQUuFJHMScyFgnHbs5r-SzTiRiBZ2JcpUYJhg0ft75-OBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQUuFJHMScyFgnHbs5r-SzTiRiBZ2JcpUYJhg0ft75-OBQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 04, 2017 at 01:44:34PM -0800, Yinghai Lu wrote:
> On Sat, Feb 4, 2017 at 10:56 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Sat, Feb 04, 2017 at 09:12:54AM +0100, Lukas Wunner wrote:
> > Section 6.7.3.4 of the PCIe Base spec seems to support the theory above,
> > so here's a tentative patch.
> >
> >
> > -- >8 --
> > Subject: [PATCH] PCI: pciehp: Don't enable PME on runtime suspend
> 
> it works:

Thanks a lot for the report and for testing the patch!


@Rafael:
Bjorn usually wants you to ack PM-related patches.  Looking at the
patch again I'm now thinking it might be cleaner to move the check
for is_hotplug_bridge into pci_dev_run_wake().  Thoughts?

Thanks,

Lukas
