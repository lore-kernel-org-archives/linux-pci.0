Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:2698 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561AbaEUOVz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 21 May 2014 10:21:55 -0400
Message-ID: <1400682110.28000.22.camel@smile.fi.intel.com>
Subject: Re: [PATCH] pci: convert dev_printk(KERN_DEBUG...) to dev_dbg(...)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Wed, 21 May 2014 17:21:50 +0300
In-Reply-To: <CAErSpo4=qu6+oYMngEuc+Pr5nNWw4K2PFcsa20g8-eYwSbHt+w@mail.gmail.com>
References: <1400599773-8252-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <CAErSpo4=qu6+oYMngEuc+Pr5nNWw4K2PFcsa20g8-eYwSbHt+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2014-05-20 at 10:44 -0600, Bjorn Helgaas wrote:
> On Tue, May 20, 2014 at 9:29 AM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > This patch does the conversion of all entries of dev_printk() calls to more
> > shorter form.
> 
> dev_dbg() is not a direct replacement for dev_printk(KERN_DEBUG).

I offten forget about this fact. Thanks for reminding.

> Output from the latter always appears in dmesg, while the former
> depends on CONFIG_DEBUG, CONFIG_DYNAMIC_DEBUG, etc.
> 
> It may be appropriate to change some of these, but we need to look at
> each case to see whether it's OK for the output to be optional.  I
> want most of the resource management stuff to always be there, because
> we have frequent problems with it, and I don't want to have to ask
> folks to build special kernels or boot with special options to get the
> output we need to debug them.  Maybe that means some of these should
> be KERN_INFO (and use dev_info()) rather than KERN_DEBUG.

That sounds convenient. I prefer to see clearly info messages and debug
messages.

> The changelog should mention the change in behavior between
> dev_printk(KERN_DEBUG) and dev_dbg(), and it should include an example
> of what users need to do to enable the output they always used to get.
>  I looked at Documentation/dynamic-debug-howto.txt, and it is, well,
> let's just say it looks very expressive and flexible, but I wouldn't
> expect a random user to figure out what to do.

I would do this if we agree what the changes should be done: my version,
or someone who has experience in PCI  (like you?) could go through all
those messages and sort out which are debug and which are info.


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

