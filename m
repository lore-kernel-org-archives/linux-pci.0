Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56247 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759389Ab2AGEuC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2012 23:50:02 -0500
Received: by wgbdr10 with SMTP id dr10so73089wgb.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Jan 2012 20:50:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120106134915.705f5b47@jbarnes-desktop>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
 <1323247984-15281-3-git-send-email-yinghai@kernel.org> <20120106134915.705f5b47@jbarnes-desktop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Jan 2012 20:49:41 -0800
Message-ID: <CA+55aFwDSm=0qf3VmcocZa_jtkopxLpKxwtmXeNp4NJ3dyEQjA@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI: Try to assign required+option size at first
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Yinghai Lu <yinghai@kernel.org>, Ram Pai <linuxram@us.ibm.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 6, 2012 at 1:49 PM, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
>
> Overall in looking at all this again I regret not asking for more
> cleanups before it went in:
>  1) resource_list_x?  really?
>  2) why aren't we using list_head?

Ugh. It's an abomination based on the 'struct resource_list' that
exists in <linux/ioport.h>. Which also has just a "next" pointer.

But that should actually be entirely private to
drivers/pci/setup-bus.c, except it is *also* used by
drivers/pci/setup-res.c: pdev_sort_resources().

I suspect that it would be a good idea to clean this up by

 (a) moving that pdev_sort_resources() to setup-bus.c (only user) and
making it static, and removing the declaration for <linux/pci.h>

 (b) moving 'struct resource_list' to also be local to setup-bus.c

 (c) just extending the resource_list with the few extra firlds that
'struct resource_list_x' has now, and getting rid of the stupid _x
version.

 (d) make it use 'struct list_head'. This patch adds those
'remove_from_list()' helpers exactly because the code isn't using the
list_head, so it does the stupid "walk the singly linked list to find
the entry" and as far as I can tell, it does it *wrong* (first entry
case?).

All of those cleanups are independent of this particular patch,
though, so should not be mixed up with this. They all look entirely
mechanical, though. And getting rid of that totally broken
"remove_from_list()" would be good (but requires that you do the
list_head cleanup first).

I dunno. It doesn't look all that horrible apart from the fairly
cosmetic issues, though.

                      Linus
