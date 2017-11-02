Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:39466 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932173AbdKBUxV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Nov 2017 16:53:21 -0400
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
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b41e83ae-a687-3118-16cb-5ee92e70fc2b@deltatee.com>
Date: Thu, 2 Nov 2017 14:53:19 -0600
MIME-Version: 1.0
In-Reply-To: <20171102171955.lvnvqnwl4qwhlmdk@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v3] pci/switchtec: Don't use completion's wait queue
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hey,

Note: This patch should have been v4.

I tested it and it now works.

However, this whole concept still gets a NAK from me. I think it makes 
the code less clear for no obvious reason.

I feel if RT needs to change the completions they should make two 
versions waitable and non-waitable and use them where appropriate. I'd 
much rather not push the completion logic into the driver layer.

Logan

On 02/11/17 11:19 AM, Sebastian Andrzej Siewior wrote:
> The poll callback is using completion's wait_queue_head_t member and
> puts it in poll_wait() so the poll() caller gets a wakeup after command
> completed. This does not work on RT because we don't have a
> wait_queue_head_t in our completion implementation. Nobody in tree does
> like that in tree so this is the only driver that breaks.
> 
> Instead of using the completion here is waitqueue with a status flag as
> suggested by Logan.
> 
> I don't have the HW so I have no idea if it works as expected, so please
> test it.
> 
> Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v2…v3: add a READ_ONCE while accessing ->cmd_done
> 
>   drivers/pci/switch/switchtec.c |   22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
> 
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -306,10 +306,11 @@ struct switchtec_user {
>   
>   	enum mrpc_state state;
>   
> -	struct completion comp;
> +	wait_queue_head_t cmd_comp;
>   	struct kref kref;
>   	struct list_head list;
>   
> +	bool cmd_done;
>   	u32 cmd;
>   	u32 status;
>   	u32 return_code;
> @@ -331,7 +332,7 @@ static struct switchtec_user *stuser_cre
>   	stuser->stdev = stdev;
>   	kref_init(&stuser->kref);
>   	INIT_LIST_HEAD(&stuser->list);
> -	init_completion(&stuser->comp);
> +	init_waitqueue_head(&stuser->cmd_comp);
>   	stuser->event_cnt = atomic_read(&stdev->event_cnt);
>   
>   	dev_dbg(&stdev->dev, "%s: %p\n", __func__, stuser);
> @@ -414,7 +415,7 @@ static int mrpc_queue_cmd(struct switcht
>   	kref_get(&stuser->kref);
>   	stuser->read_len = sizeof(stuser->data);
>   	stuser_set_state(stuser, MRPC_QUEUED);
> -	init_completion(&stuser->comp);
> +	stuser->cmd_done = false;
>   	list_add_tail(&stuser->list, &stdev->mrpc_queue);
>   
>   	mrpc_cmd_submit(stdev);
> @@ -451,7 +452,8 @@ static void mrpc_complete_cmd(struct swi
>   		      stuser->read_len);
>   
>   out:
> -	complete_all(&stuser->comp);
> +	stuser->cmd_done = true;
> +	wake_up_interruptible(&stuser->cmd_comp);
>   	list_del_init(&stuser->list);
>   	stuser_put(stuser);
>   	stdev->mrpc_busy = 0;
> @@ -721,10 +723,11 @@ static ssize_t switchtec_dev_read(struct
>   	mutex_unlock(&stdev->mrpc_mutex);
>   
>   	if (filp->f_flags & O_NONBLOCK) {
> -		if (!try_wait_for_completion(&stuser->comp))
> +		if (!READ_ONCE(stuser->cmd_done))
>   			return -EAGAIN;
>   	} else {
> -		rc = wait_for_completion_interruptible(&stuser->comp);
> +		rc = wait_event_interruptible(stuser->cmd_comp,
> +					      stuser->cmd_done);
>   		if (rc < 0)
>   			return rc;
>   	}
> @@ -772,7 +775,7 @@ static unsigned int switchtec_dev_poll(s
>   	struct switchtec_dev *stdev = stuser->stdev;
>   	int ret = 0;
>   
> -	poll_wait(filp, &stuser->comp.wait, wait);
> +	poll_wait(filp, &stuser->cmd_comp, wait);
>   	poll_wait(filp, &stdev->event_wq, wait);
>   
>   	if (lock_mutex_and_test_alive(stdev))
> @@ -780,7 +783,7 @@ static unsigned int switchtec_dev_poll(s
>   
>   	mutex_unlock(&stdev->mrpc_mutex);
>   
> -	if (try_wait_for_completion(&stuser->comp))
> +	if (READ_ONCE(stuser->cmd_done))
>   		ret |= POLLIN | POLLRDNORM;
>   
>   	if (stuser->event_cnt != atomic_read(&stdev->event_cnt))
> @@ -1255,7 +1258,8 @@ static void stdev_kill(struct switchtec_
>   
>   	/* Wake up and kill any users waiting on an MRPC request */
>   	list_for_each_entry_safe(stuser, tmpuser, &stdev->mrpc_queue, list) {
> -		complete_all(&stuser->comp);
> +		stuser->cmd_done = true;
> +		wake_up_interruptible(&stuser->cmd_comp);
>   		list_del_init(&stuser->list);
>   		stuser_put(stuser);
>   	}
> 
