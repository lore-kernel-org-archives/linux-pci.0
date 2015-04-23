Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:35921 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423AbbDWW7v (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Apr 2015 18:59:51 -0400
Received: by wgen6 with SMTP id n6so33488510wge.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2015 15:59:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+55aFwC+sH+62b4rDuy5PWAPEc9Xr3tWcCAQXOED+2Jk9C65A@mail.gmail.com>
References: <alpine.DEB.2.00.1504200432000.1232@skynet.skynet.ie>
	<CA+55aFyVMfTBB0oz_yx8+eQOEJnzGtCsYSj9QuhEpdZ9BHdq5A@mail.gmail.com>
	<20150423213015.GA7888@google.com>
	<CAPeXnHsrQrkeJ3QQ6ds6yhY0C31DKqnR2uHSm9rcXdGEHBDDAg@mail.gmail.com>
	<CA+55aFwC+sH+62b4rDuy5PWAPEc9Xr3tWcCAQXOED+2Jk9C65A@mail.gmail.com>
Date: Thu, 23 Apr 2015 15:59:50 -0700
Message-ID: <CAPeXnHv8nmaC8S96pP6oV_y4CvFSoFNWBt0CfB4M9gdTowGJyA@mail.gmail.com>
Subject: Re: git pull] drm for v4.1-rc1
From: Matthew Garrett <matthew.garrett@coreos.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dave Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Matthew Garrett <mjg59@coreos.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 23, 2015 at 3:47 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> I'm not sure why we want that IORESOURCE_ROM_SHADOW thing at all, but
> yes, if what this is all about is the magic video ROM at 0xc0000, then

It's used in the PCI layer to say "Read from 0xc0000 rather than the
ROM BAR" and then ends up as a shorthand for "Was this the boot video
device" in various places because we're bad at software.

> There is no way to see that from the PCI device state, because as
> mentioned, quite often the "ROM" is entirely fake, and is not just
> some shadowed copy of a real underlying hardware ROM, but is
> fundamentally just a RAM image decompressed from some other source and
> then marked read-only.

If only - nvidias used to rewrite their image at runtime.

-- 
Matthew Garrett | matthew.garrett@coreos.com
