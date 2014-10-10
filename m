Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:35682 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbaJJBio (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Oct 2014 21:38:44 -0400
Message-ID: <5437389D.3050902@huawei.com>
Date: Fri, 10 Oct 2014 09:38:37 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: "Wei, Aaron" <Aaron.Wei@emc.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: A question about PCI device rescan
References: <643A135C3423C4499CDC6CEE6EC6559D014710C96D@MX25A.corp.emc.com>
In-Reply-To: <643A135C3423C4499CDC6CEE6EC6559D014710C96D@MX25A.corp.emc.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/10/9 18:50, Wei, Aaron wrote:
> Hi,
> 
> Could someone help explain why writing to "rescan" under "/sys/bus/pci/devices/.../rescan" will force a rescan of the device's parent bus instead of just re-discover all the devices behind this device (if the device is type-0, then nothing happens).
> 
> Is there any user space interface that could let user just rescan devices behind one specified type-1 device?

You can use pci_bus rescan which is placed under the pci_bus, i.e.

 \-[0000:00]-+-00.0  Intel Corporation 5520/5500/X58 I/O Hub to ESI Port
             +-01.0-[0000:01-02]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
             |                    \-00.1  Intel Corporation 82576 Gigabit Network Connection

If you want to rescan devices behind 00:01.0(root port),
echo 1 > /sys/bus/pci/devices/0000:00:01.0/pci_bus/0000:01/rescan

Then it will only rescan the subordinate pci bus.


> 
> Thanks,
> Aaron 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-- 
Thanks!
Yijing

