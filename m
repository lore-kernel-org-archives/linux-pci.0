Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:39148 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932547AbdKBUCZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Nov 2017 16:02:25 -0400
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
 <31ed36b3-2328-8cc4-3aea-8c13a39e63bf@deltatee.com>
 <20171102180548.f6sc2edxbvw7qeu7@linutronix.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2b025b79-b625-dab0-5b68-c77ca0c2bd74@deltatee.com>
Date: Thu, 2 Nov 2017 14:02:23 -0600
MIME-Version: 1.0
In-Reply-To: <20171102180548.f6sc2edxbvw7qeu7@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2] pci/switchtec: Don't use completion's wait queue
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 02/11/17 12:05 PM, Sebastian Andrzej Siewior wrote:
> On 2017-11-02 11:23:16 [-0600], Logan Gunthorpe wrote:
>>
>> Well, you clearly didn't read the article I sent or even what I said. But
> 
> I did, I just didn't manage to make the link.
> The futex example looks like compiler optimisation which should not have
> happen and would be ideal for READ_ONCE, yes. But this is not the case
> here and this is what I pointed out.

And you still missed what I said and the entire point of the article.

> See 7c34e3180a01 ("sched/completion: Add lock-free checking of the
> blocking case")

Sounds questionable. I don't see how that function could be inlined, 
even then.

Logan
