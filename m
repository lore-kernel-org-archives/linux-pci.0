Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:63243 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab3CAVxu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Mar 2013 16:53:50 -0500
Received: by mail-pa0-f45.google.com with SMTP id kl14so2070213pab.18
        for <linux-pci@vger.kernel.org>; Fri, 01 Mar 2013 13:53:49 -0800 (PST)
Date: Fri, 1 Mar 2013 13:53:46 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Pete Zievers <pjz@att.net>
Cc: linux-pci@vger.kernel.org
Subject: Re: PCI rescan
Message-ID: <20130301215346.GA3103@kroah.com>
References: <5130BF39.60403@att.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5130BF39.60403@att.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 01, 2013 at 08:46:17AM -0600, Pete Zievers wrote:
>  Hi-
> 
> Right now I am using 64-bit Red Hat Fedora 16.  The kernel version
> is 3.1.0-7.fc16.x86_64.
> 
> I'm interested in an API that will achieve from within C-language
> code compiled using gcc what can be accomplished from the shell with
> the following invocation:
> 
> echo 1 > /sys/bus/pci/devices/<device designator>/remove
> echo 1 > /sys/bus/pci/rescan
> 
> I find that at the shell level the above works great for me but is
> slow.  I need it to work perhaps an order of magnitude faster for
> what I'm attempting.

PCI device removal and recanning is not a fast process, what is "slow"
about doing it in this manner?  All of the delay is in the kernel here,
not in your userspace code.

What is wrong with doing the above "writing of values" in C code?

confused,

greg k-h
