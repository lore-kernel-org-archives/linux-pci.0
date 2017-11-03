Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:59209 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdKCQT5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2017 12:19:57 -0400
Date: Fri, 3 Nov 2017 17:19:55 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, tglx@linutronix.de,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Subject: Re: [PATCH v3] pci/switchtec: Don't use completion's wait queue
Message-ID: <20171103161954.557idpkckag7j7j5@linutronix.de>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <83b6c876-6595-5b2c-e82c-2f75f559c20b@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017-11-03 10:06:19 [-0600], Logan Gunthorpe wrote:
> 
> Sorry, but in fairness I did have the same feedback to your first patch
> which you never addressed. This patch would have to be part of a well

never addressed? After the first patch you asked for a different
approach which you got. Followed by the READ_ONCE() you asked for. So I
am not aware of anything I skipped.

Anyway, I keep this in my RT tree. Thank you for your time.

> Logan

Sebastian
