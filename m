Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:59279 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbcGMRFb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2016 13:05:31 -0400
Date: Wed, 13 Jul 2016 19:04:59 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Andreas Noever <andreas.noever@gmail.com>
Cc: Xavier Gnata <xavier.gnata@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] thunderbolt: Add support for INTEL_FALCON_RIDGE_2C
 controller
Message-ID: <20160713170459.GA5840@wunner.de>
References: <5785474B.6070608@gmail.com>
 <20160712211324.GA5488@wunner.de>
 <CAMxnaaU1eMw5o9nJRmEgyw97oD25fRnjTcB_i+xAgc-V6m5HvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMxnaaU1eMw5o9nJRmEgyw97oD25fRnjTcB_i+xAgc-V6m5HvA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 13, 2016 at 12:17:33AM +0200, Andreas Noever wrote:
> Are thunderbolt controllers always installed directly below the root
> port? In theory there could be more bridges in between (a candidate
> for such a topology would be the mac pro which has 3 controllers).

Hm, good point. I failed to find lspci or dmesg output for a MacPro6,1
but I did find this diagram:
http://i.imgur.com/ItIqxDY.png

Turns out the 3 controllers are connected to a PCIe switch.
And according to the PCIe spec, a switch consists of an upstream
bridge and downstream bridges. So the parent of the Thunderbolt
upstream port would be a downstream port and not a root port. :-/


Another idea would be to detect if the parent of the Thunderbolt
upstream port has the VSEC 0x1234. This is only present on Thunderbolt
devices, so a host controller is identifiable by the non-presence of
that VSEC on its parent. Patch [01/13] of my runpm series adds a
convenient is_thunderbolt flag to detect the VSEC:
https://github.com/l1k/linux/commit/8148c395ef6e

Generally I think it would be beneficial to replace the PCI quirk
with code that lives in drivers/thunderbolt/. Here's an example what
I have in mind, this is based on top of the runpm series and ensures
that the NHI resumes before the hotplug ports by waking it directly
from the upstream bridge:
https://github.com/l1k/linux/commit/c596932608cd

An even better approach would probably be Rafael's "device links"
series which allows the PM core to take care of device dependencies
beyond the mere parent/child relationship:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1170039.html

Best regards,

Lukas
