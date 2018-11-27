Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC7BC43610
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 22:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE692086B
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 22:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1XCQIpwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE692086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbeK1Jyg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:54:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:42724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeK1Jyf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Nov 2018 04:54:35 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D21420989;
        Tue, 27 Nov 2018 22:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543359309;
        bh=5I01f3I19d+mKn8+UxVIckzu9Onl6qivkEdHbcayYrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1XCQIpwGeoV+kHjdcfmMX0HI4uhTqPwmmZFsj40WZcwPz8Rhdm6yYE7ZzYwTdFbra
         1ChnU3XfHx9bw96z0R1/1EOywHp/7XDzqF7o2YsyBx1Iqsa7atkDG+y3xJ+jS6kYvo
         YV8lLMWXB7ST2lluNAVo0Zkvm8ToIESGnNcqbWgU=
Date:   Tue, 27 Nov 2018 16:55:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Tho Vu <tho.vu.wh@rvc.renesas.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [RFC][PATCH] PCI: Avoid PCI device removing/rescanning through
 sysfs triggers a deadlock
Message-ID: <20181127225506.GA168199@google.com>
References: <20181105232500.19146-1-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105232500.19146-1-marek.vasut+renesas@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Bart, Tejun]

On Tue, Nov 06, 2018 at 12:25:00AM +0100, Marek Vasut wrote:
> From: Tho Vu <tho.vu.wh@rvc.renesas.com>
> 
> This patch fixes deadlock warning in removing/rescanning through sysfs
> when CONFIG_PROVE_LOCKING is enabled.
> 
> The issue can be reproduced by these steps:
> 1. Enable CONFIG_PROVE_LOCKING via defconfig or menuconfig
> 2. Insert Ethernet card into PCIe CH0 and start up.
>    After kernel starting up, execute the following command.
>    echo 1 > /sys/class/pci_bus/0000\:00/device/0000\:00\:00.0/remove
> 3. Rescan PCI device by this command
>    echo 1 > /sys/class/pci_bus/0000\:00/rescan
> 
> The deadlock warnings will occur.
> ============================================
> WARNING: possible recursive locking detected
> 4.14.70-ltsi-yocto-standard #27 Not tainted
> --------------------------------------------
> sh/3402 is trying to acquire lock:
>  (kn->count#78){++++}, at: kernfs_remove_by_name_ns+0x50/0xa8
> 
> but task is already holding lock:
>  (kn->count#78){++++}, at: kernfs_remove_self+0xe0/0x130
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(kn->count#78);
>   lock(kn->count#78);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 4 locks held by sh/3402:
>  #0:  (sb_writers#4){.+.+}, at: vfs_write+0x198/0x1b0
>  #1:  (&of->mutex){+.+.}, at: kernfs_fop_write+0x108/0x210
>  #2:  (kn->count#78){++++}, at: kernfs_remove_self+0xe0/0x130
>  #3:  (pci_rescan_remove_lock){+.+.}, at: pci_lock_rescan_remove+0x1c/0x28
> 
> stack backtrace:
> CPU: 3 PID: 3402 Comm: sh Not tainted 4.14.70-ltsi-yocto-standard #27
> Hardware name: Renesas Salvator-X 2nd version board based on r8a7795
> ES3.0+ with 8GiB (4 x 2 GiB) (DT)
> Call trace:
> dump_backtrace+0x0/0x3d8
> show_stack+0x14/0x20
> dump_stack+0xbc/0xf4
> __lock_acquire+0x930/0x18a8
> lock_acquire+0x48/0x68
> __kernfs_remove+0x280/0x2f8
> kernfs_remove_by_name_ns+0x50/0xa8
> remove_files.isra.0+0x38/0x78
> sysfs_remove_group+0x4c/0xa0
> sysfs_remove_groups+0x38/0x60
> device_remove_attrs+0x54/0x78
> device_del+0x1ac/0x308
> pci_remove_bus_device+0x78/0xf8
> pci_remove_bus_device+0x34/0xf8
> pci_stop_and_remove_bus_device_locked+0x24/0x38
> remove_store+0x6c/0x78
> dev_attr_store+0x18/0x28
> sysfs_kf_write+0x4c/0x78
> kernfs_fop_write+0x138/0x210
> __vfs_write+0x18/0x118
> vfs_write+0xa4/0x1b0
> SyS_write+0x48/0xb0

Indent quoted material.  I use two spaces.

> This warning occurs due to a self-deletion attribute using in the sysfs
> PCI device directory. This kind of attribute is really tricky,
> it does not allow pci framework drop this attribute until all active
> .show() and .store() callbacks have finished unless
> sysfs_break_active_protection() is called.
> Hence this patch avoids writing into this attribute triggers a deadlock.

Wrap paragraph correctly or, if this is supposed to be two paragraphs,
insert a blank line between them.

Use "PCI" (not "pci") consistently in English text.

> Referrence commit 5b55b24cec4c ("scsi: core: Avoid that SCSI device
> removal through sysfs triggers a deadlock")
> of scsi driver

s/Referrence/Reference/

5b55b24cec4c doesn't exist.  I suppose maybe you mean 0ee223b2e1f6
("scsi: core: Avoid that SCSI device removal through sysfs triggers a
deadlock")?

Wrap paragraph correctly.

Use "SCSI" (not "scsi") consistently in English text.

> Signed-off-by: Tho Vu <tho.vu.wh@rvc.renesas.com>

Missing your Signed-off-by (as Geert pointed out).

> ---
>  drivers/pci/pci-sysfs.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 9ecfe13157c0..d522bd8368d9 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -470,12 +470,22 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
>  			    const char *buf, size_t count)
>  {
>  	unsigned long val;
> +	struct kernfs_node *kn;
> +
> +	kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);

I'm awfully wary of interfaces with only a single user.  That suggests
that there's something very special about this path, and I doubt it's
*that* special.  I grant you that sysfs_break_active_protection() is
very new (added by 2afc9166f79b ("scsi: sysfs: Introduce
sysfs_{un,}break_active_protection()")).

> +	WARN_ON_ONCE(!kn);

I don't see the point of the WARN_ON_ONCE() (also pointed out already by
Geert).

>  	if (kstrtoul(buf, 0, &val) < 0)
>  		return -EINVAL;

This looks wrong because you may return -EINVAL without calling
sysfs_unbreak_active_protection().

There's no point in calling sysfs_break_active_protection() if either
kstrtoul() fails or val is zero, i.e., you could do:

  if (kstrtoul(..., &val) < 0)
    return -EINVAL;

  if (!val)
    return count;

  sysfs_break_active_protection(...);
  device_remove_file(...);
  pci_stop_and_remove_bus_device_locked(...);
  sysfs_unbreak_active_protection(...);

> -	if (val && device_remove_file_self(dev, attr))
> +	if (val) {
> +		device_remove_file(dev, attr);
>  		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));

We need some story about why we should use device_remove_file()
instead of device_remove_file_self().

We also need an explanation for why other callers of
device_remove_file_self() don't need similar changes.  They *look*
similar to this case, so we need to look at nvme_sysfs_delete(),
dcssblk_shared_store(), vfio remove_store(), s390 recover_store(),
etc, and explain why they are correct and this one is incorrect.  Or,
if they're all wrong, we need to fix them all.

Is there a way we can avoid this self-deletion situation by doing the
deletion via a workqueue item that is scheduled by remove_store() but
not executed in its context?

> +	}
> +
> +	if (kn)
> +		sysfs_unbreak_active_protection(kn);
> +
>  	return count;
>  }
>  static struct device_attribute dev_remove_attr = __ATTR(remove,
> @@ -487,11 +497,15 @@ static ssize_t dev_bus_rescan_store(struct device *dev,
>  				    const char *buf, size_t count)
>  {
>  	unsigned long val;
> +	struct kernfs_node *kn;
>  	struct pci_bus *bus = to_pci_bus(dev);
>  
>  	if (kstrtoul(buf, 0, &val) < 0)
>  		return -EINVAL;
>  
> +	kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
> +	WARN_ON_ONCE(!kn);
> +
>  	if (val) {
>  		pci_lock_rescan_remove();
>  		if (!pci_is_root_bus(bus) && list_empty(&bus->devices))
> @@ -500,6 +514,10 @@ static ssize_t dev_bus_rescan_store(struct device *dev,
>  			pci_rescan_bus(bus);
>  		pci_unlock_rescan_remove();
>  	}
> +
> +	if (kn)
> +		sysfs_unbreak_active_protection(kn);

What's the purpose of this dev_bus_rescan_store() change?  There's no
remove here, and the changelog doesn't mention this path.

>  	return count;
>  }
>  static DEVICE_ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, dev_bus_rescan_store);
> -- 
> 2.18.0
> 
