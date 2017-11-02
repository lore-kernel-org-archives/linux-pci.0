Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:56279 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932173AbdKBUxJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2017 16:53:09 -0400
Date: Thu, 2 Nov 2017 21:53:06 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, tglx@linutronix.de,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Subject: Re: [PATCH v2] pci/switchtec: Don't use completion's wait queue
Message-ID: <20171102205306.bk6ykgmdn7gh37mq@linutronix.de>
References: <20171004095007.19148-1-bigeasy@linutronix.de>
 <dfd717ac-a775-f30c-4d41-2da68e08ff54@deltatee.com>
 <20171005105100.2nf4ih2fgq6dax5g@linutronix.de>
 <0ae3975a-b1b1-fb8b-2f90-ff103da9d178@deltatee.com>
 <20171102150729.5hylh6yjpqyqurnk@linutronix.de>
 <7f4a4474-bea2-f6b0-037e-2f487cc3d6cd@deltatee.com>
 <20171102171736.rpdlemzw5jueuq5w@linutronix.de>
 <31ed36b3-2328-8cc4-3aea-8c13a39e63bf@deltatee.com>
 <20171102180548.f6sc2edxbvw7qeu7@linutronix.de>
 <2b025b79-b625-dab0-5b68-c77ca0c2bd74@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <2b025b79-b625-dab0-5b68-c77ca0c2bd74@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017-11-02 14:02:23 [-0600], Logan Gunthorpe wrote:
> And you still missed what I said and the entire point of the article.

I'm sorry.

> > See 7c34e3180a01 ("sched/completion: Add lock-free checking of the
> > blocking case")
> 
> Sounds questionable. I don't see how that function could be inlined, even
> then.

It would have made sense if that function would be used also within the
file where it was declared but it is not the case.
So you see the questionable way the READ_ONCE got in there and now you
may understand that I did not see much of big loss if it wasn't there
after the rewrite/change.

> Logan

Sebastian
