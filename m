Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62818 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756655Ab2ERPrW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 May 2012 11:47:22 -0400
Received: by pbbrp8 with SMTP id rp8so4106957pbb.19
        for <linux-pci@vger.kernel.org>; Fri, 18 May 2012 08:47:22 -0700 (PDT)
Date: Fri, 18 May 2012 08:47:15 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Shyam Iyer <Shyam_Iyer@Dell.com>, ddutile@redhat.com
Subject: Re: [PATCH] pci, Add AER_panic sysfs file
Message-ID: <20120518154715.GA21043@kroah.com>
References: <20120518045130.GA3281@kroah.com>
 <1337350606-32648-1-git-send-email-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337350606-32648-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 18, 2012 at 10:16:46AM -0400, Prarit Bhargava wrote:
> Bjorn, ... [v2] with missing Doc file.
> 
> P.
> 
> ----8<----
> 
> Consider the following case
> 
> 		[ RP ]
> 		  |
> 		  |
> 	+---------+-----------+
> 	|	  |	      |
>        [H1]      [H2]        [X1]
> 
> where RP is a PCIE Root Port, H1 and H2 are devices with drivers that support
> PCIE AER driver error handling (ie, they have pci_error_handlers defined in
> the driver), and X1 is a device with a driver that does not support PCIE
> AER driver error handling.

Why can't we provide "default" error handlers that recover from such
errors?

> If the Root Port takes an error what currently happens is that the
> bus resets and H1 & H2 call their slot_reset functions.  X1 does nothing.
> 
> In some cases a user may not wish the system to continue because X1 is
> an unhardened driver.

Please define "unhardened".  Why aren't all drivers "hardened"?

> In these cases, the system should not do a bus reset, but rather the
> system should panic to avoid any further possible data corruption.

Really?  You really want to panic the whole system and shut down and
potentially loose everything?  That does not sound like a good idea at
all to me, is there really no way to recover from this?

greg k-h
