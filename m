Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38501 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755242AbeFYK5k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jun 2018 06:57:40 -0400
Received: by mail-qt0-f196.google.com with SMTP id c5-v6so697302qth.5
        for <linux-pci@vger.kernel.org>; Mon, 25 Jun 2018 03:57:39 -0700 (PDT)
From: Hari Vyas <hari.vyas@broadcom.com>
References: <1529921446-20452-1-git-send-email-hari.vyas@broadcom.com> <20180625103742.GA20292@wunner.de>
In-Reply-To: <20180625103742.GA20292@wunner.de>
MIME-Version: 1.0
Date: Mon, 25 Jun 2018 16:27:37 +0530
Message-ID: <3fa3c29e023abf67fa74d6e94a27645f@mail.gmail.com>
Subject: RE: [PATCH] PCI: Data corruption happening due to race condition
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lukas,
	This issue is happening  with multiple times device removal and
rescan from sysfs. Card is not removed physically.
	Is_added bit is set after device attach which probe nvme driver.
NVMe driver starts one workqueue and that one is calling pci_set_master()
to set is_busmaster bit.
	With multiple times device removal and rescan from sysfs,  race
condition is observed and is_added bit is over-written to 0 from workqueue
started by NVMe driver.

	Hope it clarifies concern.

Sequence 1:
pci_bus_add_device()
{
    device_attach();
   ...
    dev->is_added = 1;
}

Sequence 2:
nvme_probe()
{
...
INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
...
}
nvme_reset_work()--->nvme_pci_enable()-->pci_set_master()-->__pci_set_mast
er(true)-->dev->is_busmaster = enable

Regards,
Hari

-----Original Message-----
From: Lukas Wunner [mailto:lukas@wunner.de]
Sent: Monday, June 25, 2018 4:08 PM
To: Hari Vyas <hari.vyas@broadcom.com>
Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; ray.jui@broadcom.com
Subject: Re: [PATCH] PCI: Data corruption happening due to race condition

On Mon, Jun 25, 2018 at 03:40:46PM +0530, Hari Vyas wrote:
> When a pci device is detected, a variable is_added is set to
> 1 in pci device structure and proc, sys entries are created.
>
> When a pci device is removed, first is_added is checked for one and
> then device is detached with clearing of proc and sys entries and at
> end, is_added is set to 0.
>
> is_added and is_busmaster are bit fields in pci_dev structure sharing
> same memory location.
>
> A strange issue was observed with multiple times removal and rescan of
> a pcie nvme device using sysfs commands where is_added flag was
> observed as zero instead of one while removing device and proc,sys
> entries are not cleared.

Where exactly was is_added incorrectly observed as 0?  Normally addition
and removal of devices are serialized using pci_lock_rescan_remove(),
maybe this is missing somewhere?

Thanks,

Lukas
