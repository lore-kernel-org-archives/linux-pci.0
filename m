Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:35930 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbbE1UH4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2015 16:07:56 -0400
Date: Thu, 28 May 2015 21:07:49 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, mingo@elte.hu,
	gnomes@lxorguk.ukuu.org.uk, gregkh@linuxfoundation.org,
	jkosina@suse.cz, bhelgaas@google.com, linux-pci@vger.kernel.org,
	xen-devel@lists.xenproject.org, bp@suse.de,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [PATCH] Documentation: extend use case for EXPORT_SYMBOL_GPL()
Message-ID: <20150528200749.GD7232@ZenIV.linux.org.uk>
References: <1432839361-10308-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432839361-10308-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 28, 2015 at 11:56:01AM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> Current documentation over use case for EXPORT_SYMBOL_GPL()
> only acknowledges functions which are "an internal implementation
> issue, and not really an interface". In practice these days
> though we have some maintainers taking on preferences to require
> all new functionality go in with EXPORT_SYMBOL_GPL().
> 
> A maintainer asking developers to use EXPORT_SYMBOL_GPL()
> for new functionality tends to be a well accepted and understood
> position that maintainers can take and typically requires the
> maintainers educating contributing developers on their own
> positions and requirements.
> 
> Developers who submit code to maintainers not familiar with
> these preferences as optional for new functionality need explicit
> guidence though as existing documentation does not acknowledge
> this as a valid possibility. Without this being documented some
> maintainers are reluctant to accept new functionality with
> EXPORT_SYMBOL_GPL().
> 
> This extends the use case documentation for EXPORT_SYMBOL_GPL()
> to acknowledge acceptance for new functionality.
 
... while some of us consider that as pointless posturing and will refuse
to merge such exports regardless.  It's _NOT_ a universal default; please,
do not attempt to imply otherwise.  In particular, for fs/*.c I will not
accept that as valid grounds for use of EXPORT_SYMBOL_GPL.
