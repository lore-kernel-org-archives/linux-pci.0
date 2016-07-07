Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:51925 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbcGGO6S (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2016 10:58:18 -0400
Date: Thu, 7 Jul 2016 17:02:43 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v2 00/13] Runtime PM for Thunderbolt on Macs
Message-ID: <20160707150243.GA3633@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1463134231.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Rafael,

The honor of your presence is requested to the review of this series
posted May 13.

Bjorn has requested an ack from you on patches 9 and 10, so the series
is essentially blocked until you find the time to comment. It would
also be good if you could look at the PM-related patches 4, 5, 6 and 11.
They're all fairly small. You do not have to bother about the larger
thunderbolt patches at the end of the series:

[01/13]  https://patchwork.kernel.org/patch/9090411/
[02/13]  https://patchwork.kernel.org/patch/9090421/
[03/13]  https://patchwork.kernel.org/patch/9090451/
[04/13]  https://patchwork.kernel.org/patch/9090471/
[05/13]  https://patchwork.kernel.org/patch/9090491/
[06/13]  https://patchwork.kernel.org/patch/9090511/
[07/13]  https://patchwork.kernel.org/patch/9090531/
[08/13]  https://patchwork.kernel.org/patch/9090541/
[09/13]  https://patchwork.kernel.org/patch/9090621/
[10/13]  https://patchwork.kernel.org/patch/9090641/
[11/13]  https://patchwork.kernel.org/patch/9090651/
[12/13]  https://patchwork.kernel.org/patch/9090571/
[13/13]  https://patchwork.kernel.org/patch/9090591/

There are also still unanswered questions about the architecture
I've chosen in this series: I'm attaching to the upstream bridge
of the Thunderbolt controller as a port service to be able to
power it down when nothing is plugged in. This architecture is
a workaround for the fact that dev_pm_domain_set() cannot be
called after a device is bound to a driver.

I've explained this in detail in an e-mail to you on June 17:
http://www.spinics.net/lists/linux-pci/msg52120.html

Near the end of that e-mail are two questions:
(1) Would it be possible to allow dev_pm_domain_set() for already
    bound devices? (It would allow me to simplify this series
    considerably.)
(2) How should the PCI core deal with devices that can be suspended
    to D3cold but not by the platform? Is it correct to solve this
    with dev_pm_domain_set()? (As is currently done for Optimus GPUs.)
    Is it also okay to suspend/resume them in the driver runtime PM
    callbacks? (This requires patch [09/13] of my series to work
    properly.)

Your help answering those questions and/or reviewing this series
is greatly appreciated.

Thank you!

Lukas
