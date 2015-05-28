Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43005 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbbE1TSr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 28 May 2015 15:18:47 -0400
Date: Thu, 28 May 2015 21:18:44 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mingo@elte.hu, gnomes@lxorguk.ukuu.org.uk,
	gregkh@linuxfoundation.org, jkosina@suse.cz, bhelgaas@google.com,
	linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
	bp@suse.de
Subject: Re: [PATCH] Documentation: extend use case for EXPORT_SYMBOL_GPL()
Message-ID: <20150528191844.GU23057@wotan.suse.de>
References: <1432839361-10308-1-git-send-email-mcgrof@do-not-panic.com>
 <20150528130923.42f34540@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150528130923.42f34540@lwn.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 28, 2015 at 01:09:23PM -0600, Jonathan Corbet wrote:
> On Thu, 28 May 2015 11:56:01 -0700
> "Luis R. Rodriguez" <mcgrof@do-not-panic.com> wrote:
> 
> > +    Some maintainers and developers may however have a preference to
> > +    require EXPORT_SYMBOL_GPL() when adding any new APIs or functionality.
> 
> As a nit, I would take out "have a preference to".

Fine by me, do you need a new submission on my part of can you amend yourself?

> From what I can tell, there are developers who think this position makes
> little sense and, perhaps, risks diluting the value of EXPORT_SYMBOL_GPL()
> by attaching it to everything.  My inclination, though, would be to accept
> this change as documentation of clear existing practice; whether that
> practice should change is, I think, a separate discussion.

Great, thanks.

  Luis
