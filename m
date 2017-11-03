Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:44792 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751736AbdKCQGY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Nov 2017 12:06:24 -0400
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-pci@vger.kernel.org, tglx@linutronix.de,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
References: <20171004095007.19148-1-bigeasy@linutronix.de>
 <dfd717ac-a775-f30c-4d41-2da68e08ff54@deltatee.com>
 <20171005105100.2nf4ih2fgq6dax5g@linutronix.de>
 <0ae3975a-b1b1-fb8b-2f90-ff103da9d178@deltatee.com>
 <20171102150729.5hylh6yjpqyqurnk@linutronix.de>
 <7f4a4474-bea2-f6b0-037e-2f487cc3d6cd@deltatee.com>
 <20171102171955.lvnvqnwl4qwhlmdk@linutronix.de>
 <b41e83ae-a687-3118-16cb-5ee92e70fc2b@deltatee.com>
 <20171103082227.zzbeee54pd2bf72u@linutronix.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <83b6c876-6595-5b2c-e82c-2f75f559c20b@deltatee.com>
Date: Fri, 3 Nov 2017 10:06:19 -0600
MIME-Version: 1.0
In-Reply-To: <20171103082227.zzbeee54pd2bf72u@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v3] pci/switchtec: Don't use completion's wait queue
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 03/11/17 02:22 AM, Sebastian Andrzej Siewior wrote:
> On 2017-11-02 14:53:19 [-0600], Logan Gunthorpe wrote:
> Thank you for letting me go all that way…

Sorry, but in fairness I did have the same feedback to your first patch 
which you never addressed. This patch would have to be part of a well 
justified patch-set changing how completions works. But, even then, I'd 
rather see a better solution that still allows at least some type of 
completion to be polled.

> You should not touch the inside of an implementation.

This is really only sometimes true[1]. But I feel it's a moot point: had 
I created a poll_on_completion() accessor function, you'd still be in 
the same situation. Frankly, I'm shocked no one else in the kernel is 
polling on a completion, it seems like something that would be common.

Logan


[1]"So it is essential that data types are not overly abstracted, but 
that all details of the implementation are visible so that the 
programmer can make optimal choices when using them."
  -- https://lwn.net/Articles/336255/
