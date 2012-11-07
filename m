Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:45419 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab2KGKry convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Nov 2012 05:47:54 -0500
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 8D22D3EE0BD
	for <linux-pci@vger.kernel.org>; Wed,  7 Nov 2012 19:47:52 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 73C0445DE4D
	for <linux-pci@vger.kernel.org>; Wed,  7 Nov 2012 19:47:52 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5D82245DD74
	for <linux-pci@vger.kernel.org>; Wed,  7 Nov 2012 19:47:52 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 511E21DB803A
	for <linux-pci@vger.kernel.org>; Wed,  7 Nov 2012 19:47:52 +0900 (JST)
Received: from g01jpexchyt04.g01.fujitsu.local (g01jpexchyt04.g01.fujitsu.local [10.128.194.43])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 023D11DB8038
	for <linux-pci@vger.kernel.org>; Wed,  7 Nov 2012 19:47:52 +0900 (JST)
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
Date: Wed, 7 Nov 2012 10:47:50 +0000
Message-ID: <4A338DB2991D2A44B9A44B8718AECF650A51AFF0@G01JPEXMBYT03>
References: <1351667452-9952-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1351667452-9952-1-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yijing,

I have some comments. Sorry for the delay.

<snip.>

> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -773,23 +773,33 @@ static void pcie_shutdown_notification(struct controller *ctrl)
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

The name of the threads seems to be cut off.

$ ps aux | grep pciehp
root        125  0.0  0.0      0     0 ?        S<   18:54   0:00 [pciehpd_0000:00]
root        126  0.0  0.0      0     0 ?        S<   18:54   0:00 [pciehpd_0000:00]
root        127  0.0  0.0      0     0 ?        S<   18:54   0:00 [pciehpd_0000:0b]
root        128  0.0  0.0      0     0 ?        S<   18:54   0:00 [pciehpd_0000:0b]
root        129  0.0  0.0      0     0 ?        S<   18:54   0:00 [pciehpd_0000:0b]
root        130  0.0  0.0      0     0 ?        S<   18:54   0:00 [pciehpd_0000:0b]
root        131  0.0  0.0      0     0 ?        S<   18:55   0:00 [pciehpd_0000:1a]
root        132  0.0  0.0      0     0 ?        S<   18:55   0:00 [pciehpd_0000:1a]
root        133  0.0  0.0      0     0 ?        S<   18:55   0:00 [pciehpd_0000:1a]
root        134  0.0  0.0      0     0 ?        S<   18:55   0:00 [pciehpd_0000:1a]

How about using slot name for the thread name?

<snip.>

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

I think flush_workqueue() call is no longer required because
it is done in destroy_workqueue() code path.

Regards,
Kenji Kaneshige

