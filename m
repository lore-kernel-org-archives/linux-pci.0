Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47273 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752748AbcGTMnJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2016 08:43:09 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v2 00/13] Runtime PM for Thunderbolt on Macs
Date: Wed, 20 Jul 2016 14:48:02 +0200
Message-ID: <23327309.oKKvvEl2AM@vostro.rjw.lan>
In-Reply-To: <20160720072359.GC8066@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de> <CAJZ5v0i4TJ_nFj4x2couZqPyrjWhig5fFRfG2LNCHfG=3h1CBg@mail.gmail.com> <20160720072359.GC8066@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, July 20, 2016 09:23:59 AM Lukas Wunner wrote:
> On Fri, Jul 08, 2016 at 03:28:12AM +0200, Rafael J. Wysocki wrote:
> > On Thu, Jul 7, 2016 at 5:02 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > > (1) Would it be possible to allow dev_pm_domain_set() for already
> > >     bound devices? (It would allow me to simplify this series
> > >     considerably.)
> > 
> > I don't think so, because setting a PM domain generally changes the
> > set of PM callbacks for the device and it may not be safe to call it
> > after the driver has been bound.
> 
> That sounds more like a locking problem than anything else.
> 
> If the system is awake and the device is active, it would seem safe
> to change its set of PM callbacks. Am I missing something?
> 
> How about checking in dev_pm_domain_set() if pm_runtime_active(dev)

Realistically, you'd need to disable runtime PM too or at least bump up
the usage count.

> and calling lock_system_sleep() / unlock_system_sleep() to ensure that?

That might work.

Thanks,
Rafael

