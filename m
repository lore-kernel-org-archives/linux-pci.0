Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 28 May 2015 13:09:23 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mingo@elte.hu, gnomes@lxorguk.ukuu.org.uk,
	gregkh@linuxfoundation.org, jkosina@suse.cz, bhelgaas@google.com,
	linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
	bp@suse.de, "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [PATCH] Documentation: extend use case for EXPORT_SYMBOL_GPL()
Message-ID: <20150528130923.42f34540@lwn.net>
In-Reply-To: <1432839361-10308-1-git-send-email-mcgrof@do-not-panic.com>
References: <1432839361-10308-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 28 May 2015 11:56:01 -0700
"Luis R. Rodriguez" <mcgrof@do-not-panic.com> wrote:

> +    Some maintainers and developers may however have a preference to
> +    require EXPORT_SYMBOL_GPL() when adding any new APIs or functionality.

As a nit, I would take out "have a preference to".

>From what I can tell, there are developers who think this position makes
little sense and, perhaps, risks diluting the value of EXPORT_SYMBOL_GPL()
by attaching it to everything.  My inclination, though, would be to accept
this change as documentation of clear existing practice; whether that
practice should change is, I think, a separate discussion.

jon
