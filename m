Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:51879 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbaBRRlk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 18 Feb 2014 12:41:40 -0500
Date: Tue, 18 Feb 2014 10:41:25 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Liviu Dudau <liviu@dudau.co.uk>,
	linux-arm-kernel@lists.infradead.org,
	Will Deacon <will.deacon@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140218174125.GC29304@obsidianresearch.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <5805232.JrD2FybBlg@wuerfel>
 <20140214220047.GA5394@bart.dudau.co.uk>
 <2312919.pM61KLBcYY@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2312919.pM61KLBcYY@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 15, 2014 at 02:03:26PM +0100, Arnd Bergmann wrote:

> Can anyone with more experience on the subject than me (Bjorn,
> Russell, Jason, ...) think of a reason why we would not want to
> just use a new domain for every host bridge we find?

I personaly think we can safely move away from stuffing multiple host
bridges into a single domain for DT cases. The reasons for doing this
have long since been superseded.

Most importantly, I have a feeling keeping a 1:1 relationship between
domain and driver will making building a proper modular and hot
pluggable host driver infrastructure in the PCI core significantly
simpler. The domain object gives a nice natural place to put things in
sysfs, a natural place to keep function pointers and avoids all the
messy questions of what happens if probing overlaps bus numbers, how
do you number things, how do you hot plug downstream busses, etc.

Having a PCI core driver infrastructure that supports both 'as a
domain' and 'as a bunch of busses' seems much more complex, and I
can't really identify what is being gained by continuing to support
this.

As far as I know the host bridge stuffing is something that was
created before domains to solve the problem on embedded of multiple
PCI host bridges on a SOC/System Controller. I know I have used it
that way in the distant past (for MIPS).

However today PCI-SIG has a standard way to describe multi-port
root-complexes in config space, so we should not need to use the
multi-bus hack. SOCs with non-compliant HW that *really* need single
domain can get there: mvebu shows how to write a driver that provides
a software version of the missing hardware elements. Pushing mess like
this out of the core code seems like a good strategy.

The only reason I can think of to avoid using a domain is if Linux has
to interface with external firmware that uses bus:device.function
notation for coding information. (eg Intel-MP tables on x86 encode
interrupt routing use B:D.F) In this case Linux would need a way to
map between Linux B:D.F and the Firwmare B:D.F, or it would need to
use the Firmware B:D.F layout. But this argument does not apply to DT
systems as DT encodes the domain too. Presumably ACPI will be the
same.

Also, bear in mind we now already have multi-domain host drivers for
ARM, so the multi-platform kernels need to have this option turned on.

So the Liviu, I would say the API should be similar to what we see in
other OF enabled driver bases subsystems, call the core code with a
platform_device pointer and function_ops pointer and have the core
code create a domain, figure out the domain # from the DT (via
aliases?), and so on.

Jason
