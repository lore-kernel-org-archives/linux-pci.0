Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41054 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbaB1BUH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Feb 2014 20:20:07 -0500
Date: Thu, 27 Feb 2014 17:21:43 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jan Beulich <JBeulich@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: simplify populate_msi_sysfs()
Message-ID: <20140228012143.GA9311@kroah.com>
References: <530F0BD3020000780011FC25@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <530F0BD3020000780011FC25@nat28.tlf.novell.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 27, 2014 at 08:56:35AM +0000, Jan Beulich wrote:
> While originally this was a patch to fix the two memory leaks (which
> got preempted by the two commits that went in the day before I wanted
> to submit this fix), I think this can (and should) be done more
> efficiently:
> - swapping the order of the two allocations and storing the
>   msi_dev_attr-derived pointer right after allocation, allowing the
>   cleanup code to pick things up without extra effort
> - using kasprintf() instead of the kmalloc()/sprintf() pair
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Nice cleanup.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
