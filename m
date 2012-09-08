Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44635 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439Ab2IHRvX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 8 Sep 2012 13:51:23 -0400
Received: by lbbgj3 with SMTP id gj3so442763lbb.19
        for <linux-pci@vger.kernel.org>; Sat, 08 Sep 2012 10:51:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120908000430.GF13739@n2100.arm.linux.org.uk>
References: <50201E1D.5060200@wwwdotorg.org> <20120813174003.GA2527@avionic-0098.mockup.avionic-design.de>
 <50294BCA.1070807@wwwdotorg.org> <CAErSpo7og1XgOSv_mFCQ=hP7pq0j3gXWh2QFL2wBJjz7kcAq=g@mail.gmail.com>
 <502AA96B.2050709@wwwdotorg.org> <20120814195834.GA10431@avionic-0098.mockup.avionic-design.de>
 <CAErSpo4Bm_Ryx=OK+svjqAwD4N8v0vrheLVdc-N1ijx8i_-N3w@mail.gmail.com>
 <502AD82F.3080702@wwwdotorg.org> <502AE485.8060307@wwwdotorg.org>
 <504A848B.1090703@wwwdotorg.org> <20120908000430.GF13739@n2100.arm.linux.org.uk>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 8 Sep 2012 11:51:00 -0600
Message-ID: <CAErSpo42AME4nJqdVk9cC2EcTfu96r+yxmmOB=hXNi6jh-c+XA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 7, 2012 at 6:04 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Sep 07, 2012 at 05:34:35PM -0600, Stephen Warren wrote:
>> I guess it's a pretty basic premise of the current PCI code that all the
>> PCI scanning happens well before any device drivers are registered,
>> which in turn means that device_add() doesn't trigger the device's
>> probe() until much later, after all the fixups and resource assignments
>> are done?
>
> Are you saying that the PCI layer is again screwed up after all my
> hard work several years ago to ensure that PCI devices are properly
> setup _before_ they're made available to the PCI drivers then?  That
> was around the time I was looking at Cardbus stuff, ensuring that that
> worked with the same guarantees.
>
> Not amused.
>
> What is wrong with the "probe devices, apply fixups, setup resources,
> apply more fixups, publish" process that it's had to be yet again
> broken?

It seems that there are some bugs in the PCI layer, no doubt
introduced after all your hard work.  We'll do our best to fix them.

The particular issue of pci_fixup_irqs() has been on my list for a
while, and we talked about it at the recent PCI mini-summit.  It's
clearly broken that we do this with for_each_pci_dev() once at
boot-time because that does nothing for hot-added devices.  It's also
broken that it is called after device_add() because the core shouldn't
touch the device after it's available to drivers.

This should get fixed reasonably soon, probably not in v3.6, but
hopefully in v3.7.  It's not completely trivial because many arches
have the same problem, and we need to fix all of them.

Bjorn
