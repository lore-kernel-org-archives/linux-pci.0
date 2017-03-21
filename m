Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 21 Mar 2017 11:24:45 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bodong Wang <bodong@mellanox.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        saeedm@mellanox.com, Eli Cohen <eli@mellanox.com>
Subject: Re: [PATCH] pci/sriov: Add an option to probe VFs or not before
 enabling SR-IOV
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1490022874-54718-1-git-send-email-bodong@mellanox.com>
 <20170320230706.GA12252@gwshan>
 <7bfcfdcd-e0a8-f1e9-f112-fa35fdb845d7@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7bfcfdcd-e0a8-f1e9-f112-fa35fdb845d7@mellanox.com>
Message-Id: <20170321002445.GA24862@gwshan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 20, 2017 at 06:34:23PM -0500, Bodong Wang wrote:
>On 3/20/2017 6:07 PM, Gavin Shan wrote:
>>On Mon, Mar 20, 2017 at 05:14:34PM +0200, bodong@mellanox.com wrote:
>>>From: Bodong Wang <bodong@mellanox.com>
>>>
>>>Sometimes it is not desirable to probe the virtual functions after
>>>SRIOV is enabled. This can save host side resource usage by VF
>>>instances which would be eventually probed to VMs.
>>>
>>>Added a new PCI sysfs interface "sriov_probe_vfs" to control that
>>>from PF, all current callers still retain the same functionality.
>>>To modify it, echo 0/n/N (disable probe) or 1/y/Y (enable probe) to
>>>
>>>/sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_probe_vfs
>>>
>>>Note that, the choice must be made before enabling VFs. The change
>>>will not take effect if VFs are already enabled. Simply, one can set
>>>sriov_numvfs to 0, choose whether to probe or not, and then resume
>>>sriov_numvfs.
>>>
>>Bodong, I'm not sure if there is a requirement to load driver for the
>>specified number of VFs? That indicates no driver will be loaded for
>>other VFs. If so, this interface might serve the purpose as well.
>Gavin, thanks for the review. That is indeed an interesting suggestion.
>Theoretically,  we can change that probe_vfs from boolean to integer. And use
>it as a counter to probe the first N VFs(if N < total_vfs).  Let's see if
>there are any objections.

Ok.

>>+#ifdef CONFIG_PCI_IOV
>>+	if (!pci_dev->is_virtfn ||
>>+	    (pci_dev->is_virtfn && pci_dev->physfn->sriov->probe_vfs)) {
>>+#endif
>>+		error = __pci_device_probe(drv, pci_dev);
>>+		if (error) {
>>+			pcibios_free_irq(pci_dev);
>>+			pci_dev_put(pci_dev);
>>+		}
>>+#ifdef CONFIG_PCI_IOV
>>	}
>>+#endif
>>
>>I think it's reasonable to have a inline function for this check:
>It's doable, but what's the benefit?
>>
>>#ifdef CONFIG_PCI_IOV
>>static inline bool pci_device_can_probe(struct pci_dev *pdev)
>>{
>>	return (!pdev->is_virtfn || pdev->physfn->sriov->probe_vfs);
>should be return (!pdev->is_virtfn || (pci_dev->is_virtfn &&
>pci_dev->physfn->sriov->probe_vfs));
>
>We want to probe that device if 1) it's a PF 2) it'a VF and probe_vfs is set
>>}
>>#else
>>static inline bool pci_device_can_probe(struct pci_dev *pdev)
>>{
>>	return true;
>>}
>This function will be a waste if CONFIG_PCI_IOV is not defined.
>>#endif

It makes the code a bit clean. Nope, the proposed conditional
expression is elaborate. Yeah, the purpose is exactly same as
you said: probe driver for non-VF or VFs that were allowed.

     (!pdev->is_virtfn || pdev->physfn->sriov->probe_vfs);

When pdev->is_virtfn is flase, "pdev->physfn->sriov->probe_vfs"
doesn't take effect. Otherwise, it means pdev->is_virtfn is true
indirectly and going to check "pdev->physfn->sriov->probe_vfs".
So it needn't check pdev->is_virtfn explicitly in later case,
but it isn't wrong :)

Thanks,
Gavin
