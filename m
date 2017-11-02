Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:37716 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933921AbdKBQEC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Nov 2017 12:04:02 -0400
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-pci@vger.kernel.org, tglx@linutronix.de,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
References: <20171004095007.19148-1-bigeasy@linutronix.de>
 <dfd717ac-a775-f30c-4d41-2da68e08ff54@deltatee.com>
 <20171005105100.2nf4ih2fgq6dax5g@linutronix.de>
 <0ae3975a-b1b1-fb8b-2f90-ff103da9d178@deltatee.com>
 <20171102150729.5hylh6yjpqyqurnk@linutronix.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7f4a4474-bea2-f6b0-037e-2f487cc3d6cd@deltatee.com>
Date: Thu, 2 Nov 2017 10:03:53 -0600
MIME-Version: 1.0
In-Reply-To: <20171102150729.5hylh6yjpqyqurnk@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2] pci/switchtec: Don't use completion's wait queue
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/2/2017 9:07 AM, Sebastian Andrzej Siewior wrote:
> Why so? There is no way the compiler could have cached the value
> somehow.

Well, I think it would be sufficient to notice that the code you were 
replacing used a READ_ONCE and you're putting it into a function that's 
a bit more complicated. But I'd suggest you read [1] which essentially 
says that all shared variables should be accessed with such a macro even 
if only to document that it's a part of a thread synchronization protocol.

Logan


[1] https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE
