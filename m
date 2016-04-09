Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:34747 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755018AbcDIR7o (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 9 Apr 2016 13:59:44 -0400
Date: Sat, 9 Apr 2016 10:59:42 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: stable@vger.kernel.org, linux-pci@vger.kernel.org,
	Rob Groner <rgroner@rtd.com>, jiang.liu@linux.intel.com,
	tglx@linutronix.de
Subject: Re: Revert "PCI, x86: Implement pcibios_alloc_irq() and
 pcibios_free_irq()"
Message-ID: <20160409175942.GA19520@kroah.com>
References: <20160331152058.GB15801@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160331152058.GB15801@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 31, 2016 at 10:20:58AM -0500, Bjorn Helgaas wrote:
> Please cherry pick the following commit from Linus' tree:
> 
>   6c777e8799a9 ("Revert "PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()"")
> 
> to the v4.3.x and v4.4.x stable trees.

It doesn't apply at all to 4.4.x, can you provide a backported version?

thanks,

greg k-h
