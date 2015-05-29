Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46232 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755260AbbE2Rkz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 May 2015 13:40:55 -0400
Date: Fri, 29 May 2015 19:40:51 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Christoph Hellwig <hch@infradead.org>, andi@firstfloor.org,
	rusty@rustcorp.com.au
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mingo@elte.hu, gnomes@lxorguk.ukuu.org.uk,
	gregkh@linuxfoundation.org, jkosina@suse.cz, bhelgaas@google.com,
	linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
	bp@suse.de
Subject: Re: [PATCH] Documentation: extend use case for EXPORT_SYMBOL_GPL()
Message-ID: <20150529174051.GC23057@wotan.suse.de>
References: <1432839361-10308-1-git-send-email-mcgrof@do-not-panic.com>
 <20150528200749.GD7232@ZenIV.linux.org.uk>
 <20150528211736.GV23057@wotan.suse.de>
 <20150528215618.GE7232@ZenIV.linux.org.uk>
 <20150528231044.GY23057@wotan.suse.de>
 <20150529050009.GA26034@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150529050009.GA26034@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 28, 2015 at 10:00:09PM -0700, Christoph Hellwig wrote:
> On Fri, May 29, 2015 at 01:10:44AM +0200, Luis R. Rodriguez wrote:
> > Great, thanks. This seems to be in alignment with those who have all along said
> > they've used EXPORT_SYMBOL() to mean what EXPORT_SYMBOL_GPL() users now use it
> > for. Nevertheless -- maintainers should know that some stubborn developers use
> > EXPORT_SYMBOL_GPL() for its technical merit should violators abuse those
> > symbols.
> 
> FYI, I think the naming here is really unfortunate.  If if was named
> EXPORT_SYMBOL_INTERNAL as just a kernel export for specific uses we'd
> be much better off in being able to explain what it actually does.

This can be decided and if so, a simple SmPL patch can deal with any merge
conflicts easily these days. But I am not sure if its worth to bother.

Probably not.

> Even better would e a system were we have specific export groups, e.g.
> symbols would be "core" "mm", "vfs", or "legacy_hack_for_drm" and any
> consumer would specificly declare which symbol they pull in.
> 
> This would have a couple advantages:
> 
>  - anyone adding an export needs to think hard into which category
>    it falls, and think again if exporting really makes sense
>  - it's reasy to review modules to see if they pull in anything
>    unexpected.

*Iff* we wanted this, Andy Kleen's old Module Namespaces [0] could be used for
this from what I gather.  I also recently thought that this would come in handy
for limiting the module tainting export for instance, when working on firmware
PKCS#7 firmware ignature support [1]. These both aligns with Andi's original
intent, which was:

  There are roughly two classes of exported symbols:

    - Generally usable, well designed, interfaces intended to be used by
      multiple modules (e.g. functions for drivers to register themselves or
      library functions)
    - Special purpose exports that are only really for a single module, but are
      not intended as a general interface. These interfaces are usually not
      really clean and reusable.

   The idea was to mark the later special purpose exports with the name of the
   module that is supposed to them. They wouldn't be available to everybody else
   and wouldn't become part of the general kernel module API.

Obviously I've been tracking possible use cases for it on the backports project
as it can help there as well as documented on the wiki [0].

[0] https://backports.wiki.kernel.org/index.php/Documentation/backports/hacking/todo#Module_namespaces
[1] https://lkml.org/lkml/2015/5/13/728

  Luis
