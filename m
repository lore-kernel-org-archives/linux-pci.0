Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:42770 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbaAQR1A (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jan 2014 12:27:00 -0500
Received: by mail-ig0-f171.google.com with SMTP id uy17so2154803igb.4
        for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2014 09:26:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1389899441.8705.60.camel@bling.home>
References: <1389651988-27392-1-git-send-email-keith.busch@intel.com>
 <CAErSpo6W9-Gg55T_dO_F6KJ+RK9mWhDtZUHdW-Ke4NP-da7-uA@mail.gmail.com> <1389899441.8705.60.camel@bling.home>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 17 Jan 2014 10:26:39 -0700
Message-ID: <CAErSpo5BsWz02DotrnKSXWJ_z6vQk+BWz-Rof+0S8V=hASFskg@mail.gmail.com>
Subject: Re: [PATCHv2 0/2] PCI: driver function reset notification
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 16, 2014 at 12:10 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Thu, 2014-01-16 at 11:49 -0700, Bjorn Helgaas wrote:

>> In the general case, we don't know what the device *is* after a reset
>> because it could have loaded new firmware.  It could require more
>> resources or even a different driver.
>>
>> I know it would cause Alex heartburn to make reset look like hotplug.
>
> Yes it would.  I agree that it's theoretically possible for a device to
> undergo a metamorphosis to something new at reset, but in practice it
> just doesn't happen.

Maybe not in your world, but this definitely happens, and it
definitely causes hassles for people.  Some resort to hacks like
rebooting the whole system because we don't support this well.

I mentioned these before, so you may have seen them already:

    http://forums.xilinx.com/t5/PCI-Express/PC-is-hung-if-run-the-second-program-FPGA-by-JTAG/td-p/20871
    http://www.alteraforum.com/forum/archive/index.php/t-28477.html
    http://www.alteraforum.com/forum/showthread.php?t=35091
    https://github.com/NetFPGA/NetFPGA-public/wiki/Restore-PCIE-Configuration
    http://lkml.indiana.edu/hypermail/linux/kernel/1104.3/02544.html

My fear is that we're building a lot of stuff based on assumptions
about how things typically operate.  That works most of the time, but
it does fail on important corner cases that are spec-compliant but
atypical.  From the PCI subsystem point of view, that makes me uneasy.

Bjorn
