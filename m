Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:18895
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753230AbdCTXh2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Mar 2017 19:37:28 -0400
Subject: Re: [PATCH] pci/sriov: Add an option to probe VFs or not before
 enabling SR-IOV
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1490022874-54718-1-git-send-email-bodong@mellanox.com>
 <20170320230706.GA12252@gwshan>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <saeedm@mellanox.com>,
        Eli Cohen <eli@mellanox.com>
From: Bodong Wang <bodong@mellanox.com>
Message-ID: <7bfcfdcd-e0a8-f1e9-f112-fa35fdb845d7@mellanox.com>
Date: Mon, 20 Mar 2017 18:34:23 -0500
MIME-Version: 1.0
In-Reply-To: <20170320230706.GA12252@gwshan>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/20/2017 6:07 PM, Gavin Shan wrote:
> On Mon, Mar 20, 2017 at 05:14:34PM +0200, bodong@mellanox.com wrote:
>> From: Bodong Wang <bodong@mellanox.com>
>>
>> Sometimes it is not desirable to probe the virtual functions after
>> SRIOV is enabled. This can save host side resource usage by VF
>> instances which would be eventually probed to VMs.
>>
>> Added a new PCI sysfs interface "sriov_probe_vfs" to control that
> >from PF, all current callers still retain the same functionality.
>> To modify it, echo 0/n/N (disable probe) or 1/y/Y (enable probe) to
>>
>> /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_probe_vfs
>>
>> Note that, the choice must be made before enabling VFs. The change
>> will not take effect if VFs are already enabled. Simply, one can set
>> sriov_numvfs to 0, choose whether to probe or not, and then resume
>> sriov_numvfs.
>>
> Bodong, I'm not sure if there is a requirement to load driver for the
> specified number of VFs? That indicates no driver will be loaded for
> other VFs. If so, this interface might serve the purpose as well.
Gavin, thanks for the review. That is indeed an interesting suggestion. 
Theoretically,  we can change that probe_vfs from boolean to integer. 
And use it as a counter to probe the first N VFs(if N < total_vfs).  
Let's see if there are any objections.
>
>
> +#ifdef CONFIG_PCI_IOV
> +	if (!pci_dev->is_virtfn ||
> +	    (pci_dev->is_virtfn && pci_dev->physfn->sriov->probe_vfs)) {
> +#endif
> +		error = __pci_device_probe(drv, pci_dev);
> +		if (error) {
> +			pcibios_free_irq(pci_dev);
> +			pci_dev_put(pci_dev);
> +		}
> +#ifdef CONFIG_PCI_IOV
> 	}
> +#endif
>
> I think it's reasonable to have a inline function for this check:
It's doable, but what's the benefit?
>
> #ifdef CONFIG_PCI_IOV
> static inline bool pci_device_can_probe(struct pci_dev *pdev)
> {
> 	return (!pdev->is_virtfn || pdev->physfn->sriov->probe_vfs);
should be return (!pdev->is_virtfn || (pci_dev->is_virtfn && 
pci_dev->physfn->sriov->probe_vfs));

We want to probe that device if 1) it's a PF 2) it'a VF and probe_vfs is set
> }
> #else
> static inline bool pci_device_can_probe(struct pci_dev *pdev)
> {
> 	return true;
> }
This function will be a waste if CONFIG_PCI_IOV is not defined.
> #endif

> Thanks,
> Gavin
>
