Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:57617 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932145AbbJHOig convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2015 10:38:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Krzysztof =?utf-8?B?SGHFgmFzYQ==?= <khalasa@piap.pl>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] ARM: cns3xxx: pci: avoid potential stack overflow
Date: Thu, 08 Oct 2015 16:38:31 +0200
Message-ID: <6292196.7OZzGKz28l@wuerfel>
In-Reply-To: <m3vbahy8wp.fsf@t19.piap.pl>
References: <2273145.0Ls8cProhs@wuerfel> <12713701.B4epxIQJNF@wuerfel> <m3vbahy8wp.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 08 October 2015 12:03:18 Krzysztof Hałasa wrote:
> Hi,
> 
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > With those two changes in place, we no longer need the fake
> > pci_sys_data/pci_bus structures for faking config space writes,
> > and the stack usage goes down as well.
> 
> >  arch/arm/mach-cns3xxx/pcie.c | 71 +++++++++++++++++++++++++++++----------------------------------------
> 
> I'm ATM unable to test this change, but will do that at some point.
> Meanwhile, I guess there is nothing I can say against this patch.
> Thanks.
> 
> Acked-by: Krzysztof Hałasa <khalasa@piap.pl>
> 

Thanks! I've queued it up in next/fixes-non-critical for linux-4.4
now, if you find something wrong later, we can revert or fix up.

There is no urgency for this one, especially since you still want to
test it, so no reason to put it in 4.3.

This was the last pre-2015 build warning for the ARM defconfigs
and allmodconfig, all remaining warnings are regressions or new
code, and I've submitted patches for those. Let's see if we can
get to a warning-free kernel build in 4.4.

	Arnd
