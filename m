Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:58427 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580Ab3A2L3Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Jan 2013 06:29:24 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Oliver Neukum <oneukum@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: pciehp: errors on resume
Date: Tue, 29 Jan 2013 12:35:32 +0100
Message-ID: <3774810.Obias7PJ4I@vostro.rjw.lan>
In-Reply-To: <1359455732.1345.46.camel@x61.thuisdomein>
References: <1359377173.1345.25.camel@x61.thuisdomein> <51072F83.7040102@cn.fujitsu.com> <1359455732.1345.46.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, January 29, 2013 11:35:32 AM Paul Bolle wrote:
> Gu,
> 
> On Tue, 2013-01-29 at 10:10 +0800, Gu Zheng wrote:
> > I think cause of the issue you mentioned is the device already exists when we resume.
> > Because we do not really suspend/remove the device when suspend, the device still exists, so 
> > we try to add the device when resume will failed. The suspend routine does not match the resume,
> > it seems a bug here.
> 
> Thanks. So should the fix here be to actually suspend and remove this
> device? (Note that pciehp_suspend() is now basically a NOP.)

I think it wouldn't be useful to remove devices on all suspends, but then there
are a few different situations that resume has to consider and handle correctly:

1) Device has been removed while suspended.
2) Device was present before suspend and is still there.
3) Device has been added while suspended.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
