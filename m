Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:62442 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755091Ab3A2McT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 07:32:19 -0500
Message-ID: <1359462737.1345.58.camel@x61.thuisdomein>
Subject: Re: pciehp: errors on resume
From: Paul Bolle <pebolle@tiscali.nl>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Oliver Neukum <oneukum@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Date: Tue, 29 Jan 2013 13:32:17 +0100
In-Reply-To: <3774810.Obias7PJ4I@vostro.rjw.lan>
References: <1359377173.1345.25.camel@x61.thuisdomein>
	 <51072F83.7040102@cn.fujitsu.com>
	 <1359455732.1345.46.camel@x61.thuisdomein>
	 <3774810.Obias7PJ4I@vostro.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-01-29 at 12:35 +0100, Rafael J. Wysocki wrote:
> On Tuesday, January 29, 2013 11:35:32 AM Paul Bolle wrote:
> > Thanks. So should the fix here be to actually suspend and remove this
> > device? (Note that pciehp_suspend() is now basically a NOP.)
> 
> I think it wouldn't be useful to remove devices on all suspends, but then there
> are a few different situations that resume has to consider and handle correctly:
> 
> 1) Device has been removed while suspended.
> 2) Device was present before suspend and is still there.
> 3) Device has been added while suspended.

Obviously, I care about situation 2) here. (It would be quite a feat to
remove or add a wireless card while the laptop is suspended.)

Anyhow, is there any reason to not treat the fact that a device turns
out to be already there when board_added() is called as an occurrence of
situation 2)? In other words: is the only reason that a device already
exists when board_added() is called that it was there while suspending
and is still there while resuming?


Paul Bolle

