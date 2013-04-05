Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:36806 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755627Ab3DEPi5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Apr 2013 11:38:57 -0400
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <brking@linux.vnet.ibm.com>;
	Fri, 5 Apr 2013 11:38:56 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 20F28C90050
	for <linux-pci@vger.kernel.org>; Fri,  5 Apr 2013 11:38:47 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r35Fck3i323638
	for <linux-pci@vger.kernel.org>; Fri, 5 Apr 2013 11:38:46 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r35FcjtW013011
	for <linux-pci@vger.kernel.org>; Fri, 5 Apr 2013 11:38:46 -0400
Message-ID: <515EEFFE.6050206@linux.vnet.ibm.com>
Date: Fri, 05 Apr 2013 10:38:38 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
CC: linux-pci@vger.kernel.org, klebers@linux.vnet.ibm.com,
	lucaskt@linux.vnet.ibm.com, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] powerpc: Set default VGA device
References: <201304042158.r34LwGPg010714@d03av02.boulder.ibm.com> <20130405065238.GC5082@concordia>
In-Reply-To: <20130405065238.GC5082@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/05/2013 01:52 AM, Michael Ellerman wrote:
> Hi Brian,
> 
> 
> On Thu, Apr 04, 2013 at 04:58:17PM -0500, Brian King wrote:
>>
>> Add a PCI quirk for VGA devices on Power to set the default VGA device.
>> Ensures a default VGA is always set if a graphics adapter is present,
>> even if firmware did not initialize it. If more than one graphics
>> adapter is present, ensure the one initialized by firmware is set
>> as the default VGA device. This ensures that X autoconfiguration
>> will work.
> 
> So a few things:
> 
>  - You are doing this on all power systems, not just pseries which is I
>    assume what you're testing on - that seems OK to me, but just
>    checking.

Correct. I've only tested on pseries, but figured it would make sense for
this to be more generic. I'm happy to make this pseries specific if that
is preferred.

>  - What is the "initialized by firmware" test? Just that IO & MEM are
>    enabled?

Correct. This is what the x86 code does. Alternatively, its possible
there is a chosen attribute in the device tree we could look at.

>  - You potentially override an existing default, is that a problem? Can
>    the user set the default? (no AFAICS).

I couldn't find anywhere that this could be set by the user and wanted to
be able to handle both the case of a single adapter that wasn't initialized
by firmware as well as the multi adapter case where only one of the adapters was
initialized by firmware. I could have made this smarter so that we only
override the default if the previous default was not initialized by firmware,
but opted for the simpler patch.

>  - The x86 code is slightly different, they don't override an existing
>    default, why do we?

I wanted to be able to handle the case of a single graphics adapter installed in a system
that has not been initialized by firmware, since I have a system like this. This generally
isn't something that x86 would need to do since all graphics adapters should have x86 boot
code in them, but very few current graphics adapters have fcode in them today.

Thanks,

Brian


-- 
Brian King
Power Linux I/O
IBM Linux Technology Center


