Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40321 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755302AbcBEQBl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Feb 2016 11:01:41 -0500
Subject: Re: dra7xx driver status
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20160204204534.GC7031@localhost> <56B421E1.9090005@ti.com>
 <20160205155215.GA29306@localhost>
CC: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>,
	<linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <56B4C74D.9010408@ti.com>
Date: Fri, 5 Feb 2016 21:31:17 +0530
MIME-Version: 1.0
In-Reply-To: <20160205155215.GA29306@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Friday 05 February 2016 09:22 PM, Bjorn Helgaas wrote:
> On Fri, Feb 05, 2016 at 09:45:29AM +0530, Kishon Vijay Abraham I wrote:
>> Hi Bjorn,
>>
>> On Friday 05 February 2016 02:15 AM, Bjorn Helgaas wrote:
>>> Hi Kishon,
>>>
>>> What's the state of dra7xx?  In my tree, it's still marked with
>>> CONFIG_BROKEN.  Last I heard there was a reset issue that needed to
>>> be worked out, but I don't know whether that's been done yet.
>>
>> I've posted pdata-quirks mechanism to do the reset (which will get PCIe
>> working). Tony had some comments and we are expecting feedback from Paul. I'll
>> ping him again in that thread.
> 
> Great, thanks, can you cc me as well?  I want to make sure we don't

you seem to be already copied in that thread. Check with $subject=[PATCH v3
3/3] pci: dra7xx: use pdata callbacks to perform reset.

Thanks
Kishon
> carry dra7xx around forever marked as broken.  I'd like to either
> make progress or remove it.
> 
> Bjorn
> 
