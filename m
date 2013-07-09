Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1373357261.1633.4.camel@x61.thuisdomein>
Subject: Re: [PATCH 2/2] PCI,pciehp: avoid add a device already exist during
 pciehp_resume
From: Paul Bolle <pebolle@tiscali.nl>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Rafael <rjw@sisk.pl>,
	Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com,
	Oliver Neukum <oneukum@suse.de>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>
Date: Tue, 09 Jul 2013 10:07:41 +0200
In-Reply-To: <1373356564-21668-1-git-send-email-wangyijing@huawei.com>
References: <1373356564-21668-1-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-07-09 at 15:56 +0800, Yijing Wang wrote:
> Currently, pciehp_resume will call pciehp_enable_slot() to add
> device if there is a device in the slot. But if the device was
> present before suspend, it's no necessary to add again. Now in
> such case, there is some uncomfortable message like
> 
>     pciehp 0000:00:1c.1:pcie04: Device 0000:03:00.0 already exists at 0000:03:00, cannot hot-add
> 	pciehp 0000:00:1c.1:pcie04: Cannot add device at 0000:03:00
> 
> This problem was reported by Paul Bolle <pebolle@tiscali.nl>
> The discussion link: http://comments.gmane.org/gmane.linux.kernel.pci/19876
> 
> We can use PCIe Device Serial Number to identify the device if
> device support DSN.
> 
> currently:
> 1. slot is empty before suspend, insert card during suspend.
> 	In this case, is safe, pciehp will add device by check adapter
> status register in pciehp_resume.
> 
> 2. slot is non empty before suspend, remove card during suspend.
> 	Also be safe, pciehp will remove device by check adapter
> status register in pciehp_resume.
> 
> 3. slot is non empty before suspend, remove card during suspend
> and insert a new card.
> 	Now pciehp just call pciehp_enable_slot() roughly. We should
> remove the old card firstly, then add the new card.
> 
> 4. slot is non empty before suspend, no action during suspend.
> 	We should do nothing in pciehp_resume, but we call
> pciehp_enable_slot(), so some uncomfortable messages show like above.
> In this case, we can improve it a little by add a guard
> if (!list_empty(bus->devices)).

Great!

I'm currently trying to bisect another problem, but hope to test this
patch (and the preceding patch it apparently needs) in a few days.
Please feel free to prod me if you think testing is needed but I'm
taking to long to report back.

Thanks!


Paul Bolle

