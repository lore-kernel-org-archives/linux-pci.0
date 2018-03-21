Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from zimbra1.kalray.eu ([92.103.151.219]:39410 "EHLO
        zimbra1.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeCUQK7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Mar 2018 12:10:59 -0400
Date: Wed, 21 Mar 2018 17:10:56 +0100 (CET)
From: Marta Rybczynska <mrybczyn@kalray.eu>
To: Keith Busch <keith.busch@intel.com>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@fb.com, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Pierre-Yves Kerbrat <pkerbrat@kalray.eu>
Message-ID: <1220434088.5871933.1521648656789.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20180321160238.GF12909@localhost.localdomain>
References: <744877924.5841545.1521630049567.JavaMail.zimbra@kalray.eu> <20180321115037.GA26083@ming.t460p> <464125757.5843583.1521634231341.JavaMail.zimbra@kalray.eu> <20180321154807.GD22254@ming.t460p> <20180321160238.GF12909@localhost.localdomain>
Subject: Re: [RFC PATCH] nvme: avoid race-conditions when enabling devices
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Wed, Mar 21, 2018 at 11:48:09PM +0800, Ming Lei wrote:
>> On Wed, Mar 21, 2018 at 01:10:31PM +0100, Marta Rybczynska wrote:
>> > > On Wed, Mar 21, 2018 at 12:00:49PM +0100, Marta Rybczynska wrote:
>> > >> NVMe driver uses threads for the work at device reset, including enabling
>> > >> the PCIe device. When multiple NVMe devices are initialized, their reset
>> > >> works may be scheduled in parallel. Then pci_enable_device_mem can be
>> > >> called in parallel on multiple cores.
>> > >> 
>> > >> This causes a loop of enabling of all upstream bridges in
>> > >> pci_enable_bridge(). pci_enable_bridge() causes multiple operations
>> > >> including __pci_set_master and architecture-specific functions that
>> > >> call ones like and pci_enable_resources(). Both __pci_set_master()
>> > >> and pci_enable_resources() read PCI_COMMAND field in the PCIe space
>> > >> and change it. This is done as read/modify/write.
>> > >> 
>> > >> Imagine that the PCIe tree looks like:
>> > >> A - B - switch -  C - D
>> > >>                \- E - F
>> > >> 
>> > >> D and F are two NVMe disks and all devices from B are not enabled and bus
>> > >> mastering is not set. If their reset work are scheduled in parallel the two
>> > >> modifications of PCI_COMMAND may happen in parallel without locking and the
>> > >> system may end up with the part of PCIe tree not enabled.
>> > > 
>> > > Then looks serialized reset should be used, and I did see the commit
>> > > 79c48ccf2fe ("nvme-pci: serialize pci resets") fixes issue of 'failed
>> > > to mark controller state' in reset stress test.
>> > > 
>> > > But that commit only covers case of PCI reset from sysfs attribute, and
>> > > maybe other cases need to be dealt with in similar way too.
>> > > 
>> > 
>> > It seems to me that the serialized reset works for multiple resets of the
>> > same device, doesn't it? Our problem is linked to resets of different devices
>> > that share the same PCIe tree.
>> 
>> Given reset shouldn't be a frequent action, it might be fine to serialize all
>> reset from different devices.
> 
> The driver was much simpler when we had serialized resets in line with
> probe, but that had a bigger problems with certain init systems when
> you put enough nvme devices in your server, making them unbootable.
> 
> Would it be okay to serialize just the pci_enable_device across all
> other tasks messing with the PCI topology?
> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index cef5ce851a92..e0a2f6c0f1cf 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2094,8 +2094,11 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>	int result = -ENOMEM;
>	struct pci_dev *pdev = to_pci_dev(dev->dev);
> 
> -	if (pci_enable_device_mem(pdev))
> -		return result;
> +	pci_lock_rescan_remove();
> +	result = pci_enable_device_mem(pdev);
> +	pci_unlock_rescan_remove();
> +	if (result)
> +		return -ENODEV;
> 
>	pci_set_master(pdev);
> 

The problem may happen also with other device doing its probe and nvme running its
workqueue (and we probably have seen it in practice too). We were thinking about a lock
in the pci generic code too, that's why I've put the linux-pci@ list in copy.

Marta
