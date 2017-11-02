Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:38106 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754880AbdKBRXU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Nov 2017 13:23:20 -0400
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-pci@vger.kernel.org, tglx@linutronix.de,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
References: <20171004095007.19148-1-bigeasy@linutronix.de>
 <dfd717ac-a775-f30c-4d41-2da68e08ff54@deltatee.com>
 <20171005105100.2nf4ih2fgq6dax5g@linutronix.de>
 <0ae3975a-b1b1-fb8b-2f90-ff103da9d178@deltatee.com>
 <20171102150729.5hylh6yjpqyqurnk@linutronix.de>
 <7f4a4474-bea2-f6b0-037e-2f487cc3d6cd@deltatee.com>
 <20171102171736.rpdlemzw5jueuq5w@linutronix.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <31ed36b3-2328-8cc4-3aea-8c13a39e63bf@deltatee.com>
Date: Thu, 2 Nov 2017 11:23:16 -0600
MIME-Version: 1.0
In-Reply-To: <20171102171736.rpdlemzw5jueuq5w@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2] pci/switchtec: Don't use completion's wait queue
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/2/2017 11:17 AM, Sebastian Andrzej Siewior wrote:
>> Well, I think it would be sufficient to notice that the code you were
>> replacing used a READ_ONCE and you're putting it into a function that's a
>> bit more complicated. But I'd suggest you read [1] which essentially says
>> that all shared variables should be accessed with such a macro even if only
>> to document that it's a part of a thread synchronization protocol.
> 
> It used READ_ONCE in case the code would have been inlined within a loop
> which makes sense to some degree. It is not the case here. But hey I can
> add, no problem…

Well, you clearly didn't read the article I sent or even what I said. 
But your reasoning is a bit flawed seeing try_wait_for_completion() is 
not designed to be inlined and will never be inlined unless the kernel 
is compiled with link-time optimization which I don't think many people use.

Logan
