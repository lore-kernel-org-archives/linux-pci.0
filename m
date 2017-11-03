Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:57319 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbdKCIWb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2017 04:22:31 -0400
Date: Fri, 3 Nov 2017 09:22:28 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, tglx@linutronix.de,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Subject: Re: [PATCH v3] pci/switchtec: Don't use completion's wait queue
Message-ID: <20171103082227.zzbeee54pd2bf72u@linutronix.de>
References: <20171004095007.19148-1-bigeasy@linutronix.de>
 <dfd717ac-a775-f30c-4d41-2da68e08ff54@deltatee.com>
 <20171005105100.2nf4ih2fgq6dax5g@linutronix.de>
 <0ae3975a-b1b1-fb8b-2f90-ff103da9d178@deltatee.com>
 <20171102150729.5hylh6yjpqyqurnk@linutronix.de>
 <7f4a4474-bea2-f6b0-037e-2f487cc3d6cd@deltatee.com>
 <20171102171955.lvnvqnwl4qwhlmdk@linutronix.de>
 <b41e83ae-a687-3118-16cb-5ee92e70fc2b@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <b41e83ae-a687-3118-16cb-5ee92e70fc2b@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017-11-02 14:53:19 [-0600], Logan Gunthorpe wrote:
> Hey,
Hey Logan,

> Note: This patch should have been v4.
> 
> I tested it and it now works.

good.

> However, this whole concept still gets a NAK from me. I think it makes the
> code less clear for no obvious reason.

Thank you for letting me go all that way…

> I feel if RT needs to change the completions they should make two versions
> waitable and non-waitable and use them where appropriate. I'd much rather
> not push the completion logic into the driver layer.

You should not touch the inside of an implementation.

> Logan

Sebastian
