Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:45955 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932620Ab2JaJUw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2012 05:20:52 -0400
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 99AE73EE0AE
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 18:20:50 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 80F1745DE53
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 18:20:50 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 69BB245DE50
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 18:20:50 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 527F81DB8040
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 18:20:50 +0900 (JST)
Received: from g01jpexchyt05.g01.fujitsu.local (g01jpexchyt05.g01.fujitsu.local [10.128.194.44])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id BA7451DB8037
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 18:20:49 +0900 (JST)
From: "Kaneshige, Kenji" <kaneshige.kenji@jp.fujitsu.com>
To: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>, Rafael <rjw@sisk.pl>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	"Oliver Neukum" <oneukum@suse.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>
Subject: RE: [RFC][PATCH] PCI, pciehp: make every slot have its own
 workqueue to avoid deadlock
Date: Wed, 31 Oct 2012 09:20:48 +0000
Message-ID: <4A338DB2991D2A44B9A44B8718AECF650A4F5E56@G01JPEXMBYT03>
References: <1351667452-9952-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1351667452-9952-1-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Let me confirm the problem. My understanding of the problem is below.
Is my understanding correct?

- Your hardware has nested PCIe hotplug slots like below.

    --<slot A>--<Slot B>

- Hot-removal request (attention button event) comes to <slot A>
- Pciehp driver queue the hot-removal work
- This hot-removal work try to remove <slot B>
- To remove <slot B>, pciehp flush the pciehp_wq, but it never finishes
  because hot-removal work is in progress. ===> deadlock

Regards,
Kenji Kaneshige



> -----Original Message-----
> From: Yijing Wang [mailto:wangyijing@huawei.com]
> Sent: Wednesday, October 31, 2012 4:11 PM
> To: Bjorn Helgaas; Yinghai Lu; Kaneshige, Kenji/金重 憲治; Rafael; Rusty
> Russell; Mauro Carvalho Chehab; Oliver Neukum
> Cc: linux-pci@vger.kernel.org; Hanjun Guo; jiang.liu@huawei.com; Yijing
> Wang
> Subject: [RFC][PATCH] PCI, pciehp: make every slot have its own workqueue
> to avoid deadlock
> 
> Currently, pciehp use global pciehp_wq to handle hotplug event from
> hardware.
> Hot remove path will be blocked if a hotplug slot connected a IO-BOX(composed
> of PCIe
> Switch and some slots which support hotplug, eg.PLX8696). The hot removed
> work was queued
> into pciehp_wq. But in the hot-remove path, pciehp driver would flush
> pciehp_wq when
> the pcie port(support pciehp) was removed. In this case the hot-remove path
> blocked.
> This patch remove the global pciehp_wq and create a new workqueue for every
> slot to
> avoid above problem.
> 
> -+-[0000:40]-+-00.0-[0000:41]--
>  |           +-01.0-[0000:42]--+-00.0  Intel Corporation 82576 Gigabit
> Network Connection
>  |           |                 \-00.1  Intel Corporation 82576 Gigabit
> Network Connection
>  |           +-03.0-[0000:43]----00.0  LSI Logic / Symbios Logic
> SAS1064ET PCI-Express Fusion-MPT SAS
>  |           +-04.0-[0000:44]--
>  |           +-05.0-[0000:45]--
>  |
> +-07.0-[0000:46-4f]----00.0-[0000:47-4f]--+-04.0-[0000:48-49]----00.0-
> [0000:49]--
>  |           |(hotplug slot)
> +-08.0-[0000:4a]--
>  |           |
> +-09.0-[0000:4b]--
>  |           |
> +-10.0-[0000:4c]--
>  |           |
> +-11.0-[0000:4d]--
>  |           |
> +-14.0-[0000:4e]--
>  |           |
> \-15.0-[0000:4f]--+-00.0  Intel Corporation 82576 Gigabit Network
> Connection
>  |           |                                         (hotplug slot)
> \-00.1  Intel Corporation 82576 Gigabit Network Connection
> 
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/hotplug/pciehp.h      |    2 +-
>  drivers/pci/hotplug/pciehp_core.c |   11 ++---------
>  drivers/pci/hotplug/pciehp_ctrl.c |    8 ++++----
>  drivers/pci/hotplug/pciehp_hpc.c  |   14 ++++++++++++--
>  4 files changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 26ffd3e..2c113de 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -44,7 +44,6 @@ extern bool pciehp_poll_mode;
>  extern int pciehp_poll_time;
>  extern bool pciehp_debug;
>  extern bool pciehp_force;
> -extern struct workqueue_struct *pciehp_wq;
> 
>  #define dbg(format, arg...)
> 	\
>  do {
> 	\
> @@ -78,6 +77,7 @@ struct slot {
>  	struct hotplug_slot *hotplug_slot;
>  	struct delayed_work work;	/* work for button event */
>  	struct mutex lock;
> +	struct workqueue_struct *wq;
>  };
> 
>  struct event_info {
> diff --git a/drivers/pci/hotplug/pciehp_core.c
> b/drivers/pci/hotplug/pciehp_core.c
> index 916bf4f..0914211 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -42,7 +42,6 @@ bool pciehp_debug;
>  bool pciehp_poll_mode;
>  int pciehp_poll_time;
>  bool pciehp_force;
> -struct workqueue_struct *pciehp_wq;
> 
>  #define DRIVER_VERSION	"0.4"
>  #define DRIVER_AUTHOR	"Dan Zink <dan.zink@compaq.com>, Greg
> Kroah-Hartman <greg@kroah.com>, Dely Sy <dely.l.sy@intel.com>"
> @@ -340,18 +339,13 @@ static int __init pcied_init(void)
>  {
>  	int retval = 0;
> 
> -	pciehp_wq = alloc_workqueue("pciehp", 0, 0);
> -	if (!pciehp_wq)
> -		return -ENOMEM;
> -
>  	pciehp_firmware_init();
>  	retval = pcie_port_service_register(&hpdriver_portdrv);
>   	dbg("pcie_port_service_register = %d\n", retval);
>    	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
> - 	if (retval) {
> -		destroy_workqueue(pciehp_wq);
> +	if (retval)
>  		dbg("Failure to register service\n");
> -	}
> +
>  	return retval;
>  }
> 
> @@ -359,7 +353,6 @@ static void __exit pcied_cleanup(void)
>  {
>  	dbg("unload_pciehpd()\n");
>  	pcie_port_service_unregister(&hpdriver_portdrv);
> -	destroy_workqueue(pciehp_wq);
>  	info(DRIVER_DESC " version: " DRIVER_VERSION " unloaded\n");
>  }
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c
> b/drivers/pci/hotplug/pciehp_ctrl.c
> index 27f4429..38f0186 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -49,7 +49,7 @@ static int queue_interrupt_event(struct slot *p_slot,
> u32 event_type)
>  	info->p_slot = p_slot;
>  	INIT_WORK(&info->work, interrupt_event_handler);
> 
> -	queue_work(pciehp_wq, &info->work);
> +	queue_work(p_slot->wq, &info->work);
> 
>  	return 0;
>  }
> @@ -344,7 +344,7 @@ void pciehp_queue_pushbutton_work(struct work_struct
> *work)
>  		kfree(info);
>  		goto out;
>  	}
> -	queue_work(pciehp_wq, &info->work);
> +	queue_work(p_slot->wq, &info->work);
>   out:
>  	mutex_unlock(&p_slot->lock);
>  }
> @@ -377,7 +377,7 @@ static void handle_button_press_event(struct slot
> *p_slot)
>  		if (ATTN_LED(ctrl))
>  			pciehp_set_attention_status(p_slot, 0);
> 
> -		queue_delayed_work(pciehp_wq, &p_slot->work, 5*HZ);
> +		queue_delayed_work(p_slot->wq, &p_slot->work, 5*HZ);
>  		break;
>  	case BLINKINGOFF_STATE:
>  	case BLINKINGON_STATE:
> @@ -439,7 +439,7 @@ static void handle_surprise_event(struct slot *p_slot)
>  	else
>  		p_slot->state = POWERON_STATE;
> 
> -	queue_work(pciehp_wq, &info->work);
> +	queue_work(p_slot->wq, &info->work);
>  }
> 
>  static void interrupt_event_handler(struct work_struct *work)
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c
> b/drivers/pci/hotplug/pciehp_hpc.c
> index 13b2eaf..8e5e571 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -773,23 +773,33 @@ static void pcie_shutdown_notification(struct
> controller *ctrl)
>  static int pcie_init_slot(struct controller *ctrl)
>  {
>  	struct slot *slot;
> +	char name[32];
> 
>  	slot = kzalloc(sizeof(*slot), GFP_KERNEL);
>  	if (!slot)
>  		return -ENOMEM;
> -
> +
> +	snprintf(name, sizeof(name), "pciehpd_%s",
> +		pci_name(ctrl->pcie->port));
> +	slot->wq = create_singlethread_workqueue(name);
> +	if (!slot->wq)
> +		goto abort;
>  	slot->ctrl = ctrl;
>  	mutex_init(&slot->lock);
>  	INIT_DELAYED_WORK(&slot->work, pciehp_queue_pushbutton_work);
>  	ctrl->slot = slot;
>  	return 0;
> +abort:
> +	kfree(slot);
> +	return -1;
>  }
> 
>  static void pcie_cleanup_slot(struct controller *ctrl)
>  {
>  	struct slot *slot = ctrl->slot;
>  	cancel_delayed_work(&slot->work);
> -	flush_workqueue(pciehp_wq);
> +	flush_workqueue(slot->wq);
> +	destroy_workqueue(slot->wq);
>  	kfree(slot);
>  }
> 
> --
> 1.7.1
> 

