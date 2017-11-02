Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:54650 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755757AbdKBPHc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2017 11:07:32 -0400
Date: Thu, 2 Nov 2017 16:07:29 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, tglx@linutronix.de,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Subject: Re: [PATCH v2] pci/switchtec: Don't use completion's wait queue
Message-ID: <20171102150729.5hylh6yjpqyqurnk@linutronix.de>
References: <20171004095007.19148-1-bigeasy@linutronix.de>
 <dfd717ac-a775-f30c-4d41-2da68e08ff54@deltatee.com>
 <20171005105100.2nf4ih2fgq6dax5g@linutronix.de>
 <0ae3975a-b1b1-fb8b-2f90-ff103da9d178@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <0ae3975a-b1b1-fb8b-2f90-ff103da9d178@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017-10-05 12:46:34 [-0600], Logan Gunthorpe wrote:
> I still don't want this merged as it makes the code less clear, but I tested
> it and it does not work.
> 
> On 05/10/17 04:51 AM, Sebastian Andrzej Siewior wrote:
> 
> > @@ -451,7 +452,7 @@ static void mrpc_complete_cmd(struct switchtec_dev *stdev)
> >   		      stuser->read_len);
> >   out:
> > -	complete_all(&stuser->comp);
> > +	wake_up_interruptible(&stuser->cmd_comp);
> 
> I think you forgot to set cmd_done here. Once I add that, it did start
> working correctly.

oh, makes sense.

> >   	list_del_init(&stuser->list);
> >   	stuser_put(stuser);
> >   	stdev->mrpc_busy = 0;
> > @@ -721,10 +722,11 @@ static ssize_t switchtec_dev_read(struct file *filp, char __user *data,
> >   	mutex_unlock(&stdev->mrpc_mutex);
> >   	if (filp->f_flags & O_NONBLOCK) {
> > -		if (!try_wait_for_completion(&stuser->comp))
> > +		if (!stuser->cmd_done)
> >   			return -EAGAIN;
> 
> I'd probably also suggest using READ_ONCE when reading cmd_done.

Why so? There is no way the compiler could have cached the value
somehow.

> Logan

Sebastian
