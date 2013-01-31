Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:56217 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751604Ab3AaK7A (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2013 05:59:00 -0500
Message-ID: <1359629934.1345.109.camel@x61.thuisdomein>
Subject: Re: pciehp: errors on resume
From: Paul Bolle <pebolle@tiscali.nl>
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: Oliver Neukum <oneukum@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Date: Thu, 31 Jan 2013 11:58:54 +0100
In-Reply-To: <510A1376.4020601@cn.fujitsu.com>
References: <1359377173.1345.25.camel@x61.thuisdomein>
	   <51072F83.7040102@cn.fujitsu.com>
	  <1359455732.1345.46.camel@x61.thuisdomein>
	  <51088EAE.5050200@cn.fujitsu.com>
	 <1359534681.1345.74.camel@x61.thuisdomein>
	 <510A1376.4020601@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2013-01-31 at 14:47 +0800, Gu Zheng wrote:
> On 01/30/2013 04:31 PM, Paul Bolle wrote:
> > 2) Regarding the errors I see at resume: it seems that if a device
> > already exists when board_added() is called, this almost certainly means
> > we're resuming with the same device we suspended with. So there's no
> > reason to send errors to the log.
> 
> No, It's hard to detect whether the existed device is the one you want to resume.
> Maybe the existed device was added during suspend, and the one you really want to
> resume was removed. 

Because the domain, bus, slot, and function being equal doesn't mean
it's the same device? (I had to look up those names in man 8 lspci, I'm
unfamiliar with all this.)

Could an additional test on vendor ID and device ID help. Ie, if
board_added() and friends notice a device already exists and the
previous an current device have identical IDs, would we then know all
that's needed to not bother to scare people with errors?


Paul Bolle

