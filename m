Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 28 May 2015 22:56:19 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mingo@elte.hu, gnomes@lxorguk.ukuu.org.uk,
	gregkh@linuxfoundation.org, jkosina@suse.cz, bhelgaas@google.com,
	linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
	bp@suse.de
Subject: Re: [PATCH] Documentation: extend use case for EXPORT_SYMBOL_GPL()
Message-ID: <20150528215618.GE7232@ZenIV.linux.org.uk>
References: <1432839361-10308-1-git-send-email-mcgrof@do-not-panic.com>
 <20150528200749.GD7232@ZenIV.linux.org.uk>
 <20150528211736.GV23057@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150528211736.GV23057@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 28, 2015 at 11:17:36PM +0200, Luis R. Rodriguez wrote:
> > ... while some of us consider that as pointless posturing and will refuse
> > to merge such exports regardless.
> 
> Can you elaborate why, for those maintainers not aware of such positions?

*shrug*

Either one states that all modules are derivative works of the kernel,
period (in which case attaching _GPL to specific exports is completely
pointless), or it's a claim that this specific export is something
special on its own, which is a fairly strong claim, completely unfounded
more often than not.  In the worst cases it's the former being misrepresented
as the latter.  That only serves to weaken our position in case of copyright
violations, IMO.  When obviously BS claims like "encoding and decoding
of UIDs between the numeric values as seen by userland and stored on
filesystem and opaque pointers as used by the userns stuff is so special
that its use alone is sufficient to change whether the code is derivative
of the kernel or not" are thrown around, we end up with weaker protection,
not stronger one.  If something like _that_ makes the difference between
derived and non-derived, the former can't be worth much...
