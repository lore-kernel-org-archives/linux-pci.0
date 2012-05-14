Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51605 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753519Ab2ENG2e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 May 2012 02:28:34 -0400
Message-ID: <4FB0A6F6.9050504@ladisch.de>
Date: Mon, 14 May 2012 08:32:22 +0200
From: Clemens Ladisch <clemens@ladisch.de>
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Ram Pai <linuxram@us.ibm.com>, Yinghai Lu <yinghai@kernel.org>
CC: linux1394-devel@lists.sourceforge.net,
	Rob Allen <ra-kernel@hotmail.co.uk>,
	bugzilla-daemon@bugzilla.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [Bug 43244] New: firewire_ohci prevents boot
References: <bug-43244-4803@https.bugzilla.kernel.org/> <20120513221357.7574ae79@stein>
In-Reply-To: <20120513221357.7574ae79@stein>
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Stefan Richter wrote:
> On May 13 bugzilla-daemon@bugzilla.kernel.org wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=43244
>>
>> firewire_ohci: Failed to set Link Power Status
>>
>> Afterwards, the machine is completely dead (ignoring Magic SysRq), requiring
>> holding the power button to get anywhere.
>>
>> Blacklisting firewire_ohci allows the kernel to boot okay.
>>
>> Having experimented with Ubuntu's mainline kernel builds, it seem to have been
>> introduced between 3.1.0-rc2 (working) and 3.1.0-rc3.
>
> 0a:09.0 CardBus bridge: O2 Micro, Inc. OZ711MP1/MS1 MemoryCardBus Controller (rev 21)
> 0a:09.1 CardBus bridge: O2 Micro, Inc. OZ711MP1/MS1 MemoryCardBus Controller (rev 21)
> 0a:09.4 FireWire (IEEE 1394): O2 Micro, Inc. Firewire (IEEE 1394) (rev 02) (prog-if 10 [OHCI])
>
> $ git shortlog v3.1-rc2..v3.1-rc3 drivers/firewire/
>
> Stefan Richter (3):
>       firewire: cdev: fix 32 bit userland on 64 bit kernel compat corner cases
>       firewire: ohci: fix DMA unmapping in an error path
>       firewire: core: handle ack_busy when fetching the Config ROM
>
> None of that code is in the path that is taken up to and after "failed to
> set Link Power Status".  Hence the bug was most certainly not introduced
> by these but
>   - either outside v3.1-rc2..v3.1-rc3, and the bisection went wrong
>     due to a false negative,
>   - or inside v3.1-rc2..v3.1-rc3 but due to some changes to the kernel
>     or to the kernel configuration that are not directly related to
>     firewire.

These integrated chips tend to have incestuous relationships between their
PCI functions; it's possible that some CardBus change broke things.

And indeed:

$ git shortlog v3.1-rc2..v3.1-rc3 drivers/pci/
...
Ram Pai (3):
      PCI : ability to relocate assigned pci-resources
      PCI: make cardbus-bridge resources optional
      PCI: code and comments cleanup

Yinghai Lu (2):
      PCI: honor child buses add_size in hot plug configuration
      PCI: make SRIOV resources optional


I'm not sure how resource-related changes can result in something that looks
like a power management issue, but maybe the chip doesn't allow register
accesses after its resources are moved, or something like that.  Any ideas?


Regards,
Clemens
