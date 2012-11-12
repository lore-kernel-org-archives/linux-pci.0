Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:45146 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab2KLIvG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Nov 2012 03:51:06 -0500
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 87EC03EE0AE
	for <linux-pci@vger.kernel.org>; Mon, 12 Nov 2012 17:51:03 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 70CBE45DE4F
	for <linux-pci@vger.kernel.org>; Mon, 12 Nov 2012 17:51:03 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 4F24545DE4E
	for <linux-pci@vger.kernel.org>; Mon, 12 Nov 2012 17:51:03 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 425FC1DB8037
	for <linux-pci@vger.kernel.org>; Mon, 12 Nov 2012 17:51:03 +0900 (JST)
Received: from g01jpexchyt03.g01.fujitsu.local (g01jpexchyt03.g01.fujitsu.local [10.128.194.42])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id E6D381DB802F
	for <linux-pci@vger.kernel.org>; Mon, 12 Nov 2012 17:51:02 +0900 (JST)
From: "Kaneshige, Kenji" <kaneshige.kenji@jp.fujitsu.com>
To: Yijing Wang <wangyijing@huawei.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>, Rafael <rjw@sisk.pl>,
	Rusty Russell <rusty@rustcorp.com.au>,
	"Mauro Carvalho Chehab" <mchehab@redhat.com>,
	Oliver Neukum <oneukum@suse.de>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: RE: [PATCH -v2] PCI, pciehp: make every slot have its own workqueue
 to avoid deadlock
Date: Mon, 12 Nov 2012 08:51:01 +0000
Message-ID: <4A338DB2991D2A44B9A44B8718AECF650A51E779@G01JPEXMBYT03>
References: <1352450600-1956-1-git-send-email-wangyijing@huawei.com>
 <4A338DB2991D2A44B9A44B8718AECF650A51E58D@G01JPEXMBYT03>
 <50A0B2FB.6000901@huawei.com>
In-Reply-To: <50A0B2FB.6000901@huawei.com>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Yijing Wang [mailto:wangyijing@huawei.com]
> Sent: Monday, November 12, 2012 5:28 PM
> To: Kaneshige, Kenji/金重 憲治
> Cc: Bjorn Helgaas; Yinghai Lu; Rafael; Rusty Russell; Mauro Carvalho Chehab; Oliver Neukum; jiang.liu@huawei.com;
> linux-pci@vger.kernel.org; Hanjun Guo
> Subject: Re: [PATCH -v2] PCI, pciehp: make every slot have its own workqueue to avoid deadlock
> 
> On 2012/11/12 15:17, Kaneshige, Kenji wrote:
> >> @@ -94,6 +93,8 @@ static int init_slot(struct controller *ctrl)
> >>  	struct hotplug_slot_info *info = NULL;
> >>  	struct hotplug_slot_ops *ops = NULL;
> >>  	char name[SLOT_NAME_SIZE];
> >> +	char *buffer;
> >> +	int len;
> >>  	int retval = -ENOMEM;
> >>
> >>  	hotplug = kzalloc(sizeof(*hotplug), GFP_KERNEL);
> >> @@ -135,6 +136,19 @@ static int init_slot(struct controller *ctrl)
> >>  	if (retval)
> >>  		ctrl_err(ctrl,
> >>  			 "pci_hp_register failed with error %d\n", retval);
> >
> > I think it's natural to go to out: here if retval != 0.
> > I guess you intentionally didn't do that because you might want to do
> > workqueue cleanup in pciehp_release_ctrl() code path. But it is confusing
> > and hard to understand.
> 
> Hi Kaneshige,
> 
> You are right, go to out here is better.

Just in case, my proposal is the creating workqueue in pcie_init_slot()
as you did in your first patch.

> 
> > In the previous patch, you created the work queue in pcie_init_slot().
> > I think it's better. Maybe the reason you moved it from pcie_init_slot()
> > to init_slot() was that you needed the slot name by pci_hp_register().
> >
> > How about using physical slot number, which is same as pci slot name by
> > pci_hp_register() on the normal platform, for the workqueue name instead?
> >
> 
> I think use physical slot number is ok, so what about workqueue name like slot(physical slot number) format ?
> 
> root     45808  0.0  0.0      0     0 ?        S<   16:25   0:00 [slot(0)]

I think we need "pciehp" in the name. I prefer "pciehp-%u".

Regards,
Kenji Kaneshige

