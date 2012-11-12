Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:60510 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab2KLHRZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Nov 2012 02:17:25 -0500
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 1EB8C3EE0BC
	for <linux-pci@vger.kernel.org>; Mon, 12 Nov 2012 16:17:24 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 04C2E45DE54
	for <linux-pci@vger.kernel.org>; Mon, 12 Nov 2012 16:17:24 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id DF4F645DE50
	for <linux-pci@vger.kernel.org>; Mon, 12 Nov 2012 16:17:23 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id CDB701DB803F
	for <linux-pci@vger.kernel.org>; Mon, 12 Nov 2012 16:17:23 +0900 (JST)
Received: from g01jpexchyt01.g01.fujitsu.local (g01jpexchyt01.g01.fujitsu.local [10.128.194.40])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 80F8D1DB8038
	for <linux-pci@vger.kernel.org>; Mon, 12 Nov 2012 16:17:23 +0900 (JST)
From: "Kaneshige, Kenji" <kaneshige.kenji@jp.fujitsu.com>
To: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>, Rafael <rjw@sisk.pl>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	"Oliver Neukum" <oneukum@suse.de>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: RE: [PATCH -v2] PCI, pciehp: make every slot have its own workqueue
 to avoid deadlock
Date: Mon, 12 Nov 2012 07:17:21 +0000
Message-ID: <4A338DB2991D2A44B9A44B8718AECF650A51E58D@G01JPEXMBYT03>
References: <1352450600-1956-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1352450600-1956-1-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> @@ -94,6 +93,8 @@ static int init_slot(struct controller *ctrl)
>  	struct hotplug_slot_info *info = NULL;
>  	struct hotplug_slot_ops *ops = NULL;
>  	char name[SLOT_NAME_SIZE];
> +	char *buffer;
> +	int len;
>  	int retval = -ENOMEM;
> 
>  	hotplug = kzalloc(sizeof(*hotplug), GFP_KERNEL);
> @@ -135,6 +136,19 @@ static int init_slot(struct controller *ctrl)
>  	if (retval)
>  		ctrl_err(ctrl,
>  			 "pci_hp_register failed with error %d\n", retval);

I think it's natural to go to out: here if retval != 0.
I guess you intentionally didn't do that because you might want to do
workqueue cleanup in pciehp_release_ctrl() code path. But it is confusing
and hard to understand.

In the previous patch, you created the work queue in pcie_init_slot().
I think it's better. Maybe the reason you moved it from pcie_init_slot()
to init_slot() was that you needed the slot name by pci_hp_register().

How about using physical slot number, which is same as pci slot name by
pci_hp_register() on the normal platform, for the workqueue name instead?

> +
> +	len = strlen(slot_name(slot)) + 16;
> +	buffer = kzalloc(len, GFP_KERNEL);
> +	if (!buffer) {
> +		retval = -ENOMEM;
> +		goto out;
> +	}
> +	snprintf(buffer, len, "pciehp_slot(%s)", slot_name(slot));
> +	slot->wq = create_singlethread_workqueue(buffer);
> +	if (!slot->wq)
> +		retval = -ENOMEM;
> +
> +	kfree(buffer);
>  out:
>  	if (retval) {
>  		kfree(ops);

Regards,
Kenji Kaneshige

