Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35433 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408AbcGHB2P (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2016 21:28:15 -0400
MIME-Version: 1.0
In-Reply-To: <20160707150243.GA3633@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de> <20160707150243.GA3633@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 Jul 2016 03:28:12 +0200
Message-ID: <CAJZ5v0i4TJ_nFj4x2couZqPyrjWhig5fFRfG2LNCHfG=3h1CBg@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Runtime PM for Thunderbolt on Macs
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 7, 2016 at 5:02 PM, Lukas Wunner <lukas@wunner.de> wrote:
> Dear Rafael,
>
> The honor of your presence is requested to the review of this series
> posted May 13.
>
> Bjorn has requested an ack from you on patches 9 and 10, so the series
> is essentially blocked until you find the time to comment. It would
> also be good if you could look at the PM-related patches 4, 5, 6 and 11.
> They're all fairly small. You do not have to bother about the larger
> thunderbolt patches at the end of the series:

Sorry for being the bottleneck here.

This has been in my todo list all the time, but I get pulled away from
it on a regular basis due to regressions and similar.

> [01/13]  https://patchwork.kernel.org/patch/9090411/
> [02/13]  https://patchwork.kernel.org/patch/9090421/
> [03/13]  https://patchwork.kernel.org/patch/9090451/
> [04/13]  https://patchwork.kernel.org/patch/9090471/
> [05/13]  https://patchwork.kernel.org/patch/9090491/
> [06/13]  https://patchwork.kernel.org/patch/9090511/
> [07/13]  https://patchwork.kernel.org/patch/9090531/
> [08/13]  https://patchwork.kernel.org/patch/9090541/
> [09/13]  https://patchwork.kernel.org/patch/9090621/
> [10/13]  https://patchwork.kernel.org/patch/9090641/
> [11/13]  https://patchwork.kernel.org/patch/9090651/
> [12/13]  https://patchwork.kernel.org/patch/9090571/
> [13/13]  https://patchwork.kernel.org/patch/9090591/
>
> There are also still unanswered questions about the architecture
> I've chosen in this series: I'm attaching to the upstream bridge
> of the Thunderbolt controller as a port service to be able to
> power it down when nothing is plugged in. This architecture is
> a workaround for the fact that dev_pm_domain_set() cannot be
> called after a device is bound to a driver.
>
> I've explained this in detail in an e-mail to you on June 17:
> http://www.spinics.net/lists/linux-pci/msg52120.html

I've read this, but I still don't quite understand the problem to be
honest.  I'll have another look.

> Near the end of that e-mail are two questions:
> (1) Would it be possible to allow dev_pm_domain_set() for already
>     bound devices? (It would allow me to simplify this series
>     considerably.)

I don't think so, because setting a PM domain generally changes the
set of PM callbacks for the device and it may not be safe to call it
after the driver has been bound.

> (2) How should the PCI core deal with devices that can be suspended
>     to D3cold but not by the platform? Is it correct to solve this
>     with dev_pm_domain_set()? (As is currently done for Optimus GPUs.)
>     Is it also okay to suspend/resume them in the driver runtime PM
>     callbacks? (This requires patch [09/13] of my series to work
>     properly.)
>
> Your help answering those questions and/or reviewing this series
> is greatly appreciated.
>
> Thank you!

Well, honestly, you may be underestimating the amount of time needed
for me to understand the problem you're trying to solve.

Thanks,
Rafael
