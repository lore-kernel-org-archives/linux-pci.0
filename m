Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1432839361-10308-1-git-send-email-mcgrof@do-not-panic.com>
References: <1432839361-10308-1-git-send-email-mcgrof@do-not-panic.com>
Date: Thu, 28 May 2015 20:30:47 -0500
Message-ID: <CAOS_Y6QaKAbSc101_mReezB1GsoafkvJGXFZ0MUpW2vk3o__ng@mail.gmail.com>
Subject: Re: [PATCH] Documentation: extend use case for EXPORT_SYMBOL_GPL()
From: Rob Landley <rob@landley.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>, Alan <gnomes@lxorguk.ukuu.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Kosina <jkosina@suse.cz>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
	bp@suse.de, "Luis R. Rodriguez" <mcgrof@suse.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 28, 2015 at 1:56 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>
> Current documentation over use case for EXPORT_SYMBOL_GPL()
> only acknowledges functions which are "an internal implementation
> issue, and not really an interface".

I.E. a statement of intent that this symbol is not intended as a
stable API that external users can program to regardless of underlying
implementation, and thus should not be viewed as a barrier to "derived
work" status for copyright purposes.

(If you get a book out of the library and program to its APIs, you're
not a derived work of an implementation not contained in that book.)

> In practice these days
> though we have some maintainers taking on preferences to require
> all new functionality go in with EXPORT_SYMBOL_GPL().

Ah, so they're predicting that Oracle will win the new "Apple vs
Franklin" case extending copyright to render whole new areas of
software proprietary, I.E. that APIs will be declared copyrightable
putting Wine and Samba and such out of business, and probably LEON's
ability to clone Sparc, and so on.

https://lwn.net/Articles/646160/

(And of course that TPP, which is now fast-tracked, will let us impose
this upon the rest of the world without appeal.)

Clearly, you want us to be on the side of Oracle, because GPL is
Freedom by definition no matter what the side effects everywhere else.

Bravo.

Rob
