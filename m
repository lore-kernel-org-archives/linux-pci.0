Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:58477 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751382Ab3A3IbX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2013 03:31:23 -0500
Message-ID: <1359534681.1345.74.camel@x61.thuisdomein>
Subject: Re: pciehp: errors on resume
From: Paul Bolle <pebolle@tiscali.nl>
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: Oliver Neukum <oneukum@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Date: Wed, 30 Jan 2013 09:31:21 +0100
In-Reply-To: <51088EAE.5050200@cn.fujitsu.com>
References: <1359377173.1345.25.camel@x61.thuisdomein>
	  <51072F83.7040102@cn.fujitsu.com>
	 <1359455732.1345.46.camel@x61.thuisdomein>
	 <51088EAE.5050200@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2013-01-30 at 11:08 +0800, Gu Zheng wrote:
> On 01/29/2013 06:35 PM, Paul Bolle wrote:
> > So should the fix here be to actually suspend and remove this
> > device? (Note that pciehp_suspend() is now basically a NOP.)
> 	The resume routine should handle all possible situations here. As Rafael said, 
> in some cases there's no way to tell the difference between "internal" and "external".
> If this problem seriously disturbs you, you can avoid this feature.

0) Actually, before v3.7 I was unaware of pciehp. And if these errors
hadn't shown up I would still be. I'm only using pciehp because Fedora
17 has CONFIG_HOTPLUG_PCI_PCIE enabled in its kernel config. 

>  But the better way is
> reporting a bug report on the bugzilla, it can call more developers to fix this issue.

1) Fine with me, though my experience is that kernel bugs should first
be discussed on the appropriate mailinglist.

2) Regarding the errors I see at resume: it seems that if a device
already exists when board_added() is called, this almost certainly means
we're resuming with the same device we suspended with. So there's no
reason to send errors to the log.

Is there any other way that a device could already exist when
board_added() is called?


Paul Bolle

