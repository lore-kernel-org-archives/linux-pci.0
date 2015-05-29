Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 28 May 2015 22:00:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mingo@elte.hu, gnomes@lxorguk.ukuu.org.uk,
	gregkh@linuxfoundation.org, jkosina@suse.cz, bhelgaas@google.com,
	linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
	bp@suse.de
Subject: Re: [PATCH] Documentation: extend use case for EXPORT_SYMBOL_GPL()
Message-ID: <20150529050009.GA26034@infradead.org>
References: <1432839361-10308-1-git-send-email-mcgrof@do-not-panic.com>
 <20150528200749.GD7232@ZenIV.linux.org.uk>
 <20150528211736.GV23057@wotan.suse.de>
 <20150528215618.GE7232@ZenIV.linux.org.uk>
 <20150528231044.GY23057@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150528231044.GY23057@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 29, 2015 at 01:10:44AM +0200, Luis R. Rodriguez wrote:
> Great, thanks. This seems to be in alignment with those who have all along said
> they've used EXPORT_SYMBOL() to mean what EXPORT_SYMBOL_GPL() users now use it
> for. Nevertheless -- maintainers should know that some stubborn developers use
> EXPORT_SYMBOL_GPL() for its technical merit should violators abuse those
> symbols.

FYI, I think the naming here is really unfortunate.  If if was named
EXPORT_SYMBOL_INTERNAL as just a kernel export for specific uses we'd
be much better off in being able to explain what it actually does.

Even better would e a system were we have specific export groups, e.g.
symbols would be "core" "mm", "vfs", or "legacy_hack_for_drm" and any
consumer would specificly declare which symbol they pull in.

This would have a couple advantages:

 - anyone adding an export needs to think hard into which category
   it falls, and think again if exporting really makes sense
 - it's reasy to review modules to see if they pull in anything
   unexpected.
