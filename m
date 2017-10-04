Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:52586 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751135AbdJDQNX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Oct 2017 12:13:23 -0400
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-pci@vger.kernel.org
Cc: tglx@linutronix.de, Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>
References: <20171004095007.19148-1-bigeasy@linutronix.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <dfd717ac-a775-f30c-4d41-2da68e08ff54@deltatee.com>
Date: Wed, 4 Oct 2017 10:13:15 -0600
MIME-Version: 1.0
In-Reply-To: <20171004095007.19148-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] pci/switchtec: Don't use completion's wait queue
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 04/10/17 03:50 AM, Sebastian Andrzej Siewior wrote:
> The poll callback is using completion's wait_queue_head_t member and
> puts it in poll_wait() so the poll() caller gets a wakeup after command
> completed. This does not work on RT because we don't have a
> wait_queue_head_t in our completion implementation. Nobody in tree does
> like that in tree so this is the only driver that breaks.

I'm sorry but this seems a bit crazy to me. Driver's can't poll on 
completions because an out of tree implementation changes them in a 
weird way??! Just because no one in-tree does it now doesn't make it 
invalid.

But at the very least, if we _absolutely_ have to patch this out, you 
shouldn't make it so convoluted. Just replace the struct completion with 
a wait queue and a done flag (which is what a completion is). Don't move 
the wait queue into switchtec_dev and don't use an unnecessary counter. 
And certainly don't think about merging it with another wait queue that 
has completely different wake events and waiters.

In any case, I haven't tested the patch, but I'm pretty sure it's not 
correct. There can be multiple switchtec_user's queued up and this patch 
will essentially complete them all once any one of them finishes and 
cmd_cnt increments.

So this patch gets a NAK from me.

Logan
