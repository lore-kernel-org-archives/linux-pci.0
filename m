Return-Path: <SRS0=axdC=5B=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6532CC0044D
	for <linux-pci@archiver.kernel.org>; Mon, 16 Mar 2020 21:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FD1206C0
	for <linux-pci@archiver.kernel.org>; Mon, 16 Mar 2020 21:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732648AbgCPVyC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:54:02 -0400
Received: from ale.deltatee.com ([207.54.116.67]:52766 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732636AbgCPVyC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Mar 2020 17:54:02 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jDxgE-0004oM-6R; Mon, 16 Mar 2020 15:53:51 -0600
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20200313174701.148376-1-bigeasy@linutronix.de>
 <20200313174701.148376-4-bigeasy@linutronix.de>
 <4d3a997d-ced4-3dbe-d766-0b1e9fc35b29@deltatee.com>
 <87v9n4ccvp.fsf@nanos.tec.linutronix.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <39f2bd27-1a4a-f7ad-5d54-7fe133390cd0@deltatee.com>
Date:   Mon, 16 Mar 2020 15:53:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87v9n4ccvp.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, bhelgaas@google.com, kurt.schwemmer@microsemi.com, torvalds@linux-foundation.org, rostedt@goodmis.org, joel@joelfernandes.org, paulmck@kernel.org, will@kernel.org, mingo@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org, bigeasy@linutronix.de, tglx@linutronix.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 3/9] pci/switchtec: Don't abuse completion wait queue for
 poll
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-03-16 1:34 p.m., Thomas Gleixner wrote:
> Logan Gunthorpe <logang@deltatee.com> writes:
>> On 2020-03-13 11:46 a.m., Sebastian Andrzej Siewior wrote:
>>>  1) It cannot work with EPOLLEXCLUSIVE
>>
>> Why? You don't explain this.
> 
> man epoll_ctt(2)
> 
> EPOLLEXCLUSIVE (since Linux 4.5)
> 
>   Sets an exclusive wakeup mode for the epoll file descriptor that is
>   being attached to the target file descriptor, fd.  When a wakeup event
>   occurs and multiple epoll file descriptors are attached to the same
>   target file using EPOLLEXCLUSIVE, one or more of the epoll file
>   descriptors will receive an event with epoll_wait(2).
> 
> As this uses complete_all() there is no distinction possible, because
> complete_all() wakes up everything.
> 
>> And I don't see how this patch would change anything to do with the
>> call to poll_wait(). All you've done is open-code the completion.
> 
> wake_up_interruptible(x) resolves to: 
> 
>      __wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
> 
> which wakes exactly 1 exclusive waiter.
> 
> Also the other way round is just working because the waker side uses
> complete_all(). Why? Because completion internally defaults to exclusive
> mode and complete() wakes exactly one exlusive waiter.
> 
> There is a conceptual difference and while it works for that particular
> purpose to some extent it's not suitable as a general wait notification
> construct.

Ok, I now understand this point. That's exceedingly subtle.

I certainly would not agree that this qualifies as "seriously broken",
and I'm not even sure I'd agree that this actually violates the
semantics of poll() seeing the man page clearly states that with
EPOLLEXCLUSIVE set, "one or more" pollers will be woken up. So waking up
all of them is still allowed. Ensuring fewer pollers wake up is just an
optimization to avoid the thundering herd problem which users of this
interface are very unlikely to ever have (I can confidently tell you
that none have this problem now).

If we do want to say that all poll_wait() users *must* respect
EPOLLEXCLUSIVE, we should at least have some documentation saying that
combining poll_wait() with wake_up_all() (or similar) is not allowed. A
*very* quick check finds there's at least a few drivers doing this:

  drivers/char/ipmi/ipmb_dev_int.c
  drivers/dma-buf/sync_file.c
  drivers/gpu/vga/vgaarb.c

(That's just looking at the drivers tree, up to "G".)

Finally, since we seem to back to more reasonable discussion, I will
make this point: it's fairly common for wait queue users to directly use
the spinlock from within wait_queue_head_t without an interface (even
completion.c does it). How are developers supposed to know when an
interface is required and when it's not? Sometimes using
"implementation" details interface-free is standard practice, but other
times it's "yuck" and will illicit ire from other developers? Is it
valid to use completion.wait.lock? Where's the line?

Logan


