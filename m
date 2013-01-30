Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:6280 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751626Ab3A3DIh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Jan 2013 22:08:37 -0500
Message-ID: <51088EAE.5050200@cn.fujitsu.com>
Date: Wed, 30 Jan 2013 11:08:30 +0800
From: Gu Zheng <guz.fnst@cn.fujitsu.com>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>
CC: Oliver Neukum <oneukum@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: pciehp: errors on resume
References: <1359377173.1345.25.camel@x61.thuisdomein>  <51072F83.7040102@cn.fujitsu.com> <1359455732.1345.46.camel@x61.thuisdomein>
In-Reply-To: <1359455732.1345.46.camel@x61.thuisdomein>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/29/2013 06:35 PM, Paul Bolle wrote:

> Gu,
> 
> On Tue, 2013-01-29 at 10:10 +0800, Gu Zheng wrote:
>> I think cause of the issue you mentioned is the device already exists when we resume.
>> Because we do not really suspend/remove the device when suspend, the device still exists, so 
>> we try to add the device when resume will failed. The suspend routine does not match the resume,
>> it seems a bug here.
> 
> Thanks. So should the fix here be to actually suspend and remove this
> device? (Note that pciehp_suspend() is now basically a NOP.)
> 


Hi Paul,
	The resume routine should handle all possible situations here. As Rafael said, 
in some cases there's no way to tell the difference between "internal" and "external".
If this problem seriously disturbs you, you can avoid this feature. But the better way is
reporting a bug report on the bugzilla, it can call more developers to fix this issue.

Thanks,
Gu     

> 
> Paul Bolle
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


