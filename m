Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD775C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 23:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E82921848
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 23:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548803823;
	bh=rC05lbY2ugpJqmYqsEOwgR3A9ioV4a/OnjPLKw1b5Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wU6QUaHo9bZGFv7SBGCEOISX3IeStilNivMh0bShH1E5qih+VlQa3PVenFLVuzgOF
	 kdhYz0zi7YiBndSzPe+gWQlfDu0mq0w/nDhGd+h9f9iYjE9HKo82eLSWAVCAEafPJ3
	 VovgVVFqcBVv7o0LgiGInpnPvsxs3/X1Lq7uayvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfA2XRC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:17:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728208AbfA2XRC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 18:17:02 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57B3820882;
        Tue, 29 Jan 2019 23:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548803821;
        bh=rC05lbY2ugpJqmYqsEOwgR3A9ioV4a/OnjPLKw1b5Mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFp0u/tF2QwBBw+KpzZGhGw65gPdlXbdtKj5ncUHMufC4dPO7mw1HsYRtsQbCCi1f
         INIHv9NAI3slfXJZWqMizs4/6ogSp4LkUkdKhJp09LgeeKReeJvtp+dgEqo/DB9LHq
         X52vzONpMtHOMvTj6rIchUJWa66kFCGK9+twRsbA=
Date:   Tue, 29 Jan 2019 17:16:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: ibmphp_hpc: turn semaphores into completions or
 mutexes
Message-ID: <20190129231658.GH91506@google.com>
References: <20181210214955.1826522-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210214955.1826522-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 10, 2018 at 10:49:10PM +0100, Arnd Bergmann wrote:
> The sem_exit variable is conceptually a completion, so it should
> be called that.
> 
> Similarly, the semOperations semaphore is a simple mutex, and
> can be changed into that, respectively.
> 
> With both converted, the ibmphp_hpc_initvars() function is no longer
> used and can be removed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to pci/hotplug for v5.1, thanks!

> ---
>  drivers/pci/hotplug/ibmphp.h      |  1 -
>  drivers/pci/hotplug/ibmphp_core.c |  2 --
>  drivers/pci/hotplug/ibmphp_hpc.c  | 47 +++++++++----------------------
>  3 files changed, 14 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/ibmphp.h b/drivers/pci/hotplug/ibmphp.h
> index b89f850c3a4e..e90a4ebf6550 100644
> --- a/drivers/pci/hotplug/ibmphp.h
> +++ b/drivers/pci/hotplug/ibmphp.h
> @@ -378,7 +378,6 @@ int ibmphp_add_pfmem_from_mem(struct resource_node *);
>  struct bus_node *ibmphp_find_res_bus(u8);
>  void ibmphp_print_test(void);	/* for debugging purposes */
>  
> -void ibmphp_hpc_initvars(void);
>  int ibmphp_hpc_readslot(struct slot *, u8, u8 *);
>  int ibmphp_hpc_writeslot(struct slot *, u8);
>  void ibmphp_lock_operations(void);
> diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
> index 5752b57198e3..e04b17d81e38 100644
> --- a/drivers/pci/hotplug/ibmphp_core.c
> +++ b/drivers/pci/hotplug/ibmphp_core.c
> @@ -1312,8 +1312,6 @@ static int __init ibmphp_init(void)
>  
>  	ibmphp_debug = debug;
>  
> -	ibmphp_hpc_initvars();
> -
>  	for (i = 0; i < 16; i++)
>  		irqs[i] = 0;
>  
> diff --git a/drivers/pci/hotplug/ibmphp_hpc.c b/drivers/pci/hotplug/ibmphp_hpc.c
> index 752c384cbd4c..508a62a6b5f9 100644
> --- a/drivers/pci/hotplug/ibmphp_hpc.c
> +++ b/drivers/pci/hotplug/ibmphp_hpc.c
> @@ -15,13 +15,13 @@
>  
>  #include <linux/wait.h>
>  #include <linux/time.h>
> +#include <linux/completion.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/init.h>
>  #include <linux/mutex.h>
>  #include <linux/sched.h>
> -#include <linux/semaphore.h>
>  #include <linux/kthread.h>
>  #include "ibmphp.h"
>  
> @@ -88,10 +88,10 @@ static int to_debug = 0;
>  //----------------------------------------------------------------------------
>  // global variables
>  //----------------------------------------------------------------------------
> -static struct mutex sem_hpcaccess;	// lock access to HPC
> -static struct semaphore semOperations;	// lock all operations and
> +static DEFINE_MUTEX(sem_hpcaccess);	// lock access to HPC
> +static DEFINE_MUTEX(operations_mutex);	// lock all operations and
>  					// access to data structures
> -static struct semaphore sem_exit;	// make sure polling thread goes away
> +static DECLARE_COMPLETION(exit_complete); // make sure polling thread goes away
>  static struct task_struct *ibmphp_poll_thread;
>  //----------------------------------------------------------------------------
>  // local function prototypes
> @@ -109,23 +109,6 @@ static int hpc_wait_ctlr_notworking(int, struct controller *, void __iomem *, u8
>  //----------------------------------------------------------------------------
>  
>  
> -/*----------------------------------------------------------------------
> -* Name:    ibmphp_hpc_initvars
> -*
> -* Action:  initialize semaphores and variables
> -*---------------------------------------------------------------------*/
> -void __init ibmphp_hpc_initvars(void)
> -{
> -	debug("%s - Entry\n", __func__);
> -
> -	mutex_init(&sem_hpcaccess);
> -	sema_init(&semOperations, 1);
> -	sema_init(&sem_exit, 0);
> -	to_debug = 0;
> -
> -	debug("%s - Exit\n", __func__);
> -}
> -
>  /*----------------------------------------------------------------------
>  * Name:    i2c_ctrl_read
>  *
> @@ -780,7 +763,7 @@ void free_hpc_access(void)
>  *---------------------------------------------------------------------*/
>  void ibmphp_lock_operations(void)
>  {
> -	down(&semOperations);
> +	mutex_lock(&operations_mutex);
>  	to_debug = 1;
>  }
>  
> @@ -790,7 +773,7 @@ void ibmphp_lock_operations(void)
>  void ibmphp_unlock_operations(void)
>  {
>  	debug("%s - Entry\n", __func__);
> -	up(&semOperations);
> +	mutex_unlock(&operations_mutex);
>  	to_debug = 0;
>  	debug("%s - Exit\n", __func__);
>  }
> @@ -816,7 +799,7 @@ static int poll_hpc(void *data)
>  
>  	while (!kthread_should_stop()) {
>  		/* try to get the lock to do some kind of hardware access */
> -		down(&semOperations);
> +		mutex_lock(&operations_mutex);
>  
>  		switch (poll_state) {
>  		case POLL_LATCH_REGISTER:
> @@ -871,13 +854,13 @@ static int poll_hpc(void *data)
>  			break;
>  		case POLL_SLEEP:
>  			/* don't sleep with a lock on the hardware */
> -			up(&semOperations);
> +			mutex_unlock(&operations_mutex);
>  			msleep(POLL_INTERVAL_SEC * 1000);
>  
>  			if (kthread_should_stop())
>  				goto out_sleep;
>  
> -			down(&semOperations);
> +			mutex_lock(&operations_mutex);
>  
>  			if (poll_count >= POLL_LATCH_CNT) {
>  				poll_count = 0;
> @@ -887,12 +870,12 @@ static int poll_hpc(void *data)
>  			break;
>  		}
>  		/* give up the hardware semaphore */
> -		up(&semOperations);
> +		mutex_unlock(&operations_mutex);
>  		/* sleep for a short time just for good measure */
>  out_sleep:
>  		msleep(100);
>  	}
> -	up(&sem_exit);
> +	complete(&exit_complete);
>  	debug("%s - Exit\n", __func__);
>  	return 0;
>  }
> @@ -1060,9 +1043,9 @@ void __exit ibmphp_hpc_stop_poll_thread(void)
>  	debug("after locking operations\n");
>  
>  	// wait for poll thread to exit
> -	debug("before sem_exit down\n");
> -	down(&sem_exit);
> -	debug("after sem_exit down\n");
> +	debug("before exit_complete down\n");
> +	wait_for_completion(&exit_complete);
> +	debug("after exit_completion down\n");
>  
>  	// cleanup
>  	debug("before free_hpc_access\n");
> @@ -1070,8 +1053,6 @@ void __exit ibmphp_hpc_stop_poll_thread(void)
>  	debug("after free_hpc_access\n");
>  	ibmphp_unlock_operations();
>  	debug("after unlock operations\n");
> -	up(&sem_exit);
> -	debug("after sem exit up\n");
>  
>  	debug("%s - Exit\n", __func__);
>  }
> -- 
> 2.20.0
> 
