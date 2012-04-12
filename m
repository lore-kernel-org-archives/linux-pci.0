Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6580 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934354Ab2DLPTp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 12 Apr 2012 11:19:45 -0400
Message-ID: <4F86F28E.8020807@redhat.com>
Date: Thu, 12 Apr 2012 11:19:42 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: "Hao, Xudong" <xudong.hao@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V4] Quirk for IVB graphics FLR errata
References: <403610A45A2B5242BD291EDAE8B37D300FD0DA33@SHSMSX102.ccr.corp.intel.com> <4F8594FD.8020109@redhat.com> <20120412040630.GC6557@parisc-linux.org>
In-Reply-To: <20120412040630.GC6557@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/12/2012 12:06 AM, Matthew Wilcox wrote:
> On Wed, Apr 11, 2012 at 10:28:13AM -0400, Don Dutile wrote:
>>> +	cycles_t cyc_op_timeout = tsc_khz*op_timeout*1000;
>> Don't we know how to do a 10sec timeout w/o tying it to tsc_khz?
>
> Right, this code should of course be using jiffies and msleep.
>
>> -->  other arch compile problem source???
>
> Well, this device is part of the x86 CPU.  It's never going to be found
> as part of any other architecture.  Why force other architectures to
> carry this quirk around?
>
>

Well, the trend to include more IO into chipsets tied to an arch
will probably increase over time, so such conditional quirks will
increase as well.
Sounds like the quirk tables need an arch-hook (linked list) to check
& traverse.  Then such code can go into arch/<arch>/pci/quirks.c .

I was under the impression Linux prefers not to have ifdef <arch> in
common code modules, and to split it out under arch/<> .


