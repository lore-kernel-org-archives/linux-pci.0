Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:44910 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756065AbdKCQdG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Nov 2017 12:33:06 -0400
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
 <83b6c876-6595-5b2c-e82c-2f75f559c20b@deltatee.com>
 <20171103161954.557idpkckag7j7j5@linutronix.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ceab9bab-3c6d-4800-fa44-386e5fe9e71f@deltatee.com>
Date: Fri, 3 Nov 2017 10:33:04 -0600
MIME-Version: 1.0
In-Reply-To: <20171103161954.557idpkckag7j7j5@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v3] pci/switchtec: Don't use completion's wait queue
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 03/11/17 10:19 AM, Sebastian Andrzej Siewior wrote:
> never addressed? After the first patch you asked for a different
> approach which you got. Followed by the READ_ONCE() you asked for. So I
> am not aware of anything I skipped.

Quoting myself along the way:

v1: "I'm sorry but this seems a bit crazy to me. Driver's can't poll on 
completions because an out of tree implementation changes them in a 
weird way??! Just because no one in-tree does it now doesn't make it 
invalid."

v2: "I still don't want this merged as it makes the code less clear, but 
I tested it and it does not work."

v3: "However, this whole concept still gets a NAK from me. I think it 
makes the code less clear for no obvious reason."

I feel like I was pretty clear from the beginning. These are the 
comments that you never addressed. Just because you picked up on the 
minor issues and fixed them doesn't mean you can ignore the other feedback.

Logan
