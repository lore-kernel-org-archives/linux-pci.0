Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936906AbdEYTnz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 May 2017 15:43:55 -0400
Date: Thu, 25 May 2017 14:43:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v4] PCI: use IDA to manage domain number if not getting
 it from DT
Message-ID: <20170525194353.GA3390@bhelgaas-glaptop.roam.corp.google.com>
References: <1495611455-41952-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495611455-41952-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 24, 2017 at 03:37:35PM +0800, Shawn Lin wrote:
> If not getting domain number from DT, the domain number will
> keep increasing once doing unbind/bind RC drivers. This could
> introduce pointless tree view of lspci as shows below:
> 
> -+-[0001:00]---00.0-[01]----00.0
>   \-[0000:00]-
> 
> The more test we do, the lengthier it would be. The more serious
> issue is that if attaching two hierarchies for two different domains
> belonging to two root bridges, so when doing unbind/bind test for one
> of them and keep the other, then the domain number would finally
> overflow and make the two hierarchies of devices share the some domain
> number but actually they shouldn't. So it looks like we need to invent
> a new indexing ID mechanism to manage domain number. This patch
> introduces idr to achieve our purpose.
> 
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v4:
> - make domain_nr depends on CONFIG_PCI_DOMAINS instead of
> CONFIG_PCI_DOMAINS_GENERIC.(reported by Kbuild Robot)

I'm confused about why you posted this v4.  It addresses a kbuild
issue, but not any of the questions from my review of v3, so reviewing
v4 would be a waste of my time.

But since we're here, my naive suggestion:

>> 1) If we're using ACPI, every host bridge must have a _SEG method,
>> and it supplies the domain.  We ignore any bridge without _SEG.
>>
>> 2) If we're using DT, every host bridge must supply
>> "linux,pci-domain", and it supplies the domain.  We ignore any
>> bridge without "linux,pci-domain".
>>
>> 3) Otherwise, we always use IDA.

was *too* simplistic.  _SEG is optional.  If it's missing we default
to domain 0.

The point is that we can't mix the IDA with either the ACPI or DT
info.  I think for ACPI it should be easy: if _SEG exists, we use
that.  If _SEG doesn't exist, the spec says we that bridge is in
domain 0.  So I think we should never use IDA if we're using ACPI.

For DT, I think we can't use IDA if *any* bridge uses
"linux,pci-domain", because there's no way to allocate a specified
domain from the IDA.

Of course, we see the bridges one at a time, so we don't know ahead of
time whether any uses "linux,pci-domain".  I think that means we have
to decide when we see the very first host bridge which strategy to
use.  If the first host bridge has "linux,pci-domain", we use that,
and if future host bridges don't supply "linux,pci-domain", we
probably have to ignore the whole bridge.

If the first host bridge doesn't have "linux,pci-domain", we use IDA,
and we probably have to ignore any future bridges that *do* have
"linux,pci-domain".

So it seems like "linux,pci-domain" is basically an all-or-none
proposition.

Bjorn
