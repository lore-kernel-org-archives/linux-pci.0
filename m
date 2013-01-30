Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:35686 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753194Ab3A3DsB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Jan 2013 22:48:01 -0500
Message-ID: <510897EA.4080605@cn.fujitsu.com>
Date: Wed, 30 Jan 2013 11:47:54 +0800
From: Gu Zheng <guz.fnst@cn.fujitsu.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Paul Bolle <pebolle@tiscali.nl>, Oliver Neukum <oneukum@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: pciehp: errors on resume
References: <1359377173.1345.25.camel@x61.thuisdomein> <51072F83.7040102@cn.fujitsu.com> <1359455732.1345.46.camel@x61.thuisdomein> <3774810.Obias7PJ4I@vostro.rjw.lan>
In-Reply-To: <3774810.Obias7PJ4I@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/29/2013 07:35 PM, Rafael J. Wysocki wrote:

> On Tuesday, January 29, 2013 11:35:32 AM Paul Bolle wrote:
>> Gu,
>>
>> On Tue, 2013-01-29 at 10:10 +0800, Gu Zheng wrote:
>>> I think cause of the issue you mentioned is the device already exists when we resume.
>>> Because we do not really suspend/remove the device when suspend, the device still exists, so 
>>> we try to add the device when resume will failed. The suspend routine does not match the resume,
>>> it seems a bug here.
>>
>> Thanks. So should the fix here be to actually suspend and remove this
>> device? (Note that pciehp_suspend() is now basically a NOP.)
> 
> I think it wouldn't be useful to remove devices on all suspends, but then there
> are a few different situations that resume has to consider and handle correctly:
> 
> 1) Device has been removed while suspended.
> 2) Device was present before suspend and is still there.
> 3) Device has been added while suspended.
> 

Hi Rafael,
	Though removing devices on all suspends does not seem useful, I do not think
let the pciehp_suspend() be a NOP and the resume handle all the conditions is a good way.
Do the current pciehp driver's suspend and resume routines follow the pcie specification?
And, what's the difficulty to detect and handle the different situations that you mentioned
above?

Thanks,
Gu

> Thanks,
> Rafael
> 
> 


