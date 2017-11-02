Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:55747 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933552AbdKBSFv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2017 14:05:51 -0400
Date: Thu, 2 Nov 2017 19:05:49 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, tglx@linutronix.de,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Subject: Re: [PATCH v2] pci/switchtec: Don't use completion's wait queue
Message-ID: <20171102180548.f6sc2edxbvw7qeu7@linutronix.de>
References: <20171004095007.19148-1-bigeasy@linutronix.de>
 <dfd717ac-a775-f30c-4d41-2da68e08ff54@deltatee.com>
 <20171005105100.2nf4ih2fgq6dax5g@linutronix.de>
 <0ae3975a-b1b1-fb8b-2f90-ff103da9d178@deltatee.com>
 <20171102150729.5hylh6yjpqyqurnk@linutronix.de>
 <7f4a4474-bea2-f6b0-037e-2f487cc3d6cd@deltatee.com>
 <20171102171736.rpdlemzw5jueuq5w@linutronix.de>
 <31ed36b3-2328-8cc4-3aea-8c13a39e63bf@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <31ed36b3-2328-8cc4-3aea-8c13a39e63bf@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017-11-02 11:23:16 [-0600], Logan Gunthorpe wrote:
> 
> Well, you clearly didn't read the article I sent or even what I said. But

I did, I just didn't manage to make the link.
The futex example looks like compiler optimisation which should not have
happen and would be ideal for READ_ONCE, yes. But this is not the case
here and this is what I pointed out.
And the ps2 example, well it did not check condition after the wait so
it was not obvious if the condition (for which it was waiting) was true or not.
So if you want this thing to be catched by tools, I don't know how this bug

|	int rc = -1;
|	...
|	wait_event_timeout(ps2dev->wait, !(READ_ONCE(ps2dev->flags) & PS2_FLAG_CMD), timeout);
|	for (i = 0; i < receive; i++)
|		resp[i] = ps2dev->cmdbuf[(receive - 1) - i];
|	if (READ_ONCE(ps2dev->cmdcnt))
|		goto out;
|	rc = 0;
|out:
|	return rc;

could have spotted by anything but a human.

> your reasoning is a bit flawed seeing try_wait_for_completion() is not
> designed to be inlined and will never be inlined unless the kernel is
> compiled with link-time optimization which I don't think many people use.

See 7c34e3180a01 ("sched/completion: Add lock-free checking of the
blocking case")

> Logan

Sebastian
