Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:40841 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965Ab2FPJYX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2012 05:24:23 -0400
Message-ID: <4FDC5084.6090504@huawei.com>
Date: Sat, 16 Jun 2012 17:23:16 +0800
From: Jiang Liu <jiang.liu@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	<linux-pci@vger.kernel.org>, Jiang Liu <liuj97@gmail.com>
Subject: Re: [PATCH v7 08/10] PCI, x86: add MMCFG information on demand
References: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com> <1338026043-3968-9-git-send-email-jiang.liu@huawei.com> <CAE9FiQVHBE7pvaC5aCk-7q_pU3mxSoo5JapQkjG80DcnW16ZxA@mail.gmail.com> <4FDB2192.5070709@huawei.com> <CAE9FiQVWhSZBcZM1DXJaN7rsj64YO=OjzOm6XkUqio5fZ5di+w@mail.gmail.com>
In-Reply-To: <CAE9FiQVWhSZBcZM1DXJaN7rsj64YO=OjzOm6XkUqio5fZ5di+w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012-6-16 0:51, Yinghai Lu wrote:
> 
> still have some problem:
> pci_mmcfg_check_reserved==>is_mmconf_reserved
> 
> will update cfg->end_bus.
Hi Yinghai,
	How about following patch for this issue? I guess we need to
keep current behavior at boot time for backward compatibility, right?

---
@@ -472,6 +472,14 @@ static int __devinit is_mmconf_reserved(check_reserved_t is_reserved,
                        break;
        }

+       /*
+        * For backward compatibility, we will adjust the MMCONFIG region
+        * at boot time if it's only partially reserved by firmware.
+        * For PCI host bridge hotplug at runtime, just reject it.
+        */
+       if (pci_mmcfg_running_state && old_size != size)
+               return 0;
+
        if (size < (16UL<<20) && size != old_size)
                return 0;

---

> 
> Thanks
> 
> Yinghai
> 
> .
> 


