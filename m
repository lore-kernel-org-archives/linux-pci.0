Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:59229 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755883AbdKCQj0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2017 12:39:26 -0400
Date: Fri, 3 Nov 2017 17:39:24 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, tglx@linutronix.de,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Subject: Re: [PATCH v3] pci/switchtec: Don't use completion's wait queue
Message-ID: <20171103163924.7rtdkkst3yl7ghcm@linutronix.de>
References: <20171005105100.2nf4ih2fgq6dax5g@linutronix.de>
 <0ae3975a-b1b1-fb8b-2f90-ff103da9d178@deltatee.com>
 <20171102150729.5hylh6yjpqyqurnk@linutronix.de>
 <7f4a4474-bea2-f6b0-037e-2f487cc3d6cd@deltatee.com>
 <20171102171955.lvnvqnwl4qwhlmdk@linutronix.de>
 <b41e83ae-a687-3118-16cb-5ee92e70fc2b@deltatee.com>
 <20171103082227.zzbeee54pd2bf72u@linutronix.de>
 <83b6c876-6595-5b2c-e82c-2f75f559c20b@deltatee.com>
 <20171103161954.557idpkckag7j7j5@linutronix.de>
 <ceab9bab-3c6d-4800-fa44-386e5fe9e71f@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <ceab9bab-3c6d-4800-fa44-386e5fe9e71f@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017-11-03 10:33:04 [-0600], Logan Gunthorpe wrote:
> Quoting myself along the way:
> 
> v1: "I'm sorry but this seems a bit crazy to me. Driver's can't poll on
> completions because an out of tree implementation changes them in a weird
> way??! Just because no one in-tree does it now doesn't make it invalid."

You forgot:
On 2017-10-04 10:13:15 [-0600], Logan Gunthorpe wrote:
> But at the very least, if we _absolutely_ have to patch this out, you
> shouldn't make it so convoluted. Just replace the struct completion with a

:)

> v2: "I still don't want this merged as it makes the code less clear, but I
> tested it and it does not work."

and you provided the missing bit that was missing.

> v3: "However, this whole concept still gets a NAK from me. I think it makes
> the code less clear for no obvious reason."
> 
> I feel like I was pretty clear from the beginning. These are the comments
> that you never addressed. Just because you picked up on the minor issues and
> fixed them doesn't mean you can ignore the other feedback.

and this piece is needed to get it working on RT. In longer term we
would want completions based on simple waitqueues upstream, too.

> Logan

Sebastian
