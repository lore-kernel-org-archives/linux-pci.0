Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:40828 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeDXPDl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Apr 2018 11:03:41 -0400
Subject: Re: [PATCH 0/2] PCI: Support to workaround bus level HW issues
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <b6439e86-2284-5b3c-3656-a0c3c2568317@oracle.com>
 <20180419120803.3d5791b4@w520.home>
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
Message-ID: <2c28ca4c-c216-79f5-2127-417fd28772e2@oracle.com>
Date: Tue, 24 Apr 2018 10:57:01 -0400
MIME-Version: 1.0
In-Reply-To: <20180419120803.3d5791b4@w520.home>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 04/19/2018 02:08 PM, Alex Williamson wrote:
> On Thu, 19 Apr 2018 13:36:00 -0400
> James Puthukattukaran <james.puthukattukaran@oracle.com> wrote:
> 
>> There are bugs in certain PCIe switches that cause access violations
>>  when an endpoint device is hotplugged. In particular, there's an issue
>> with
>> certain IDT switches that trigger a ACS violation when bringing up a newly
>> plugged PCIe endpoint device. This is a major issue for platforms
>> designed to
>> issue a fatal reset in the case of this event.
>>
>> The first patch provides a framework for intercepting and working around
>> issues with parent devices to the endpoint being brought up.
>>
>> The second patch provides the actual patch for the IDT switch issue using
>> that framework. The ACS feature is disabled in the IDT switch prior to
>> endpoint
>> device detection and then re-enabled subsequent to that.
> 
> I'm happy with the logic of the patch, but:
> 
>  - Patches are lined wrapped
>  - There are white space issues (space indenting and extra returns)
>  - 'return(foo(bar));' has too many parens, using 'return foo(bar);'
>  - Comment style, see Documentation/process/coding-style.rst for
>    preferred multi-line inline comment style.  (I see mixed comment
>    style in quirks.c, but probe.c is pretty consistent)
>  - Please don't fixup style issues in patch 1/2 in patch 2/2
> 
> scripts/checkpatch.pl can find some of these for you.  Thanks,
> 
> 

Alex - 
I believe I resolved the issues you pointed out wrt style. I sent out a fresh set of patches.
Again, appreciate your time!
regards
James
