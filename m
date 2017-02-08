Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752929AbdBHRgt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Feb 2017 12:36:49 -0500
Date: Wed, 8 Feb 2017 11:25:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pciehp is broken from 4.10-rc1
Message-ID: <20170208172545.GA27298@bhelgaas-glaptop.roam.corp.google.com>
References: <20170203055200.GA29413@wunner.de>
 <CAE9FiQWs0H9vqEo2ZYnWWBW0Ao-hx4WYHQ69cyR32nFQ9yV9rw@mail.gmail.com>
 <20170204081254.GA29595@wunner.de>
 <20170204185607.GA29957@wunner.de>
 <CAE9FiQUuFJHMScyFgnHbs5r-SzTiRiBZ2JcpUYJhg0ft75-OBQ@mail.gmail.com>
 <20170204233443.GA234@wunner.de>
 <CAE9FiQW5SQsQfRCz9sor4kufogTRVpHXekPHSi8MSi46mvXGLQ@mail.gmail.com>
 <20170205073454.GA253@wunner.de>
 <20170206103706.GE19313@lahna.fi.intel.com>
 <20170206213528.GD679@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170206213528.GD679@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 06, 2017 at 10:35:28PM +0100, Lukas Wunner wrote:
> On Mon, Feb 06, 2017 at 12:37:06PM +0200, Mika Westerberg wrote:
> > On Sun, Feb 05, 2017 at 08:34:54AM +0100, Lukas Wunner wrote:
> > > @Mika, Rafael: Are you aware of Skylake machines with unreliable link
> > > training, or perhaps errata of Skylake chips related to link training
> > > on hotplug ports?
> > 
> > According to the 100-series (the chipset used with Skylake) errata
> > below, I don't see any mentions related to PCIe link training issues.
> > 
> > http://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/100-series-chipset-spec-update.pdf
> 
> Yinghai Lu responded off-list that the hardware in question is an
> unreleased / secret Intel product, so this particular issue cannot
> be expected to be documented publicly at this point.
> 
> Of course this raises the question whether issues with unreleased
> products can at all be considered valid regressions, given that the
> final product may not regress.  It seems like a novelty to me that
> patches would get reverted for something like this, but we'll see.

I assume the hardware will eventually be released, and I assume the
hardware will not be changed because of this issue.  I would like to
avoid the situation of having v4.9 but not v4.10 work on this
hardware.
