Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <53BFDBC0.8000705@gmail.com>
Date: Fri, 11 Jul 2014 18:12:40 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
To: Ethan Zhao <ethan.zhao@oracle.com>, bhelgaas@google.com,
	konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
	david.vrabel@citrix.com, gleb@kernel.org, pbonzini@redhat.com,
	jeffrey.t.kirsher@intel.com, jesse.brandeburg@intel.com,
	bruce.w.allan@intel.com, carolyn.wyborny@intel.com,
	donald.c.skidmore@intel.com, gregory.v.rose@intel.com,
	alexander.h.duyck@intel.com, john.ronciak@intel.com,
	mitch.a.williams@intel.com, alex.williamson@redhat.com
CC: linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux.nics@intel.com, e1000-devel@lists.sourceforge.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ethan.kernel@gmail.com, vaughan.cao@oracle.com
Subject: Re: [PATCH 2/2 V3] PCI: implement VFs assignment reference counter
References: <1405081802-419-1-git-send-email-ethan.zhao@oracle.com> <1405081802-419-2-git-send-email-ethan.zhao@oracle.com>
In-Reply-To: <1405081802-419-2-git-send-email-ethan.zhao@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/11/2014 06:00 PM, Ethan Zhao wrote:
> Current implementation of helper function pci_vfs_assigned() is a
> little complex, to get sum of VFs that assigned to VM, access low
> level configuration space register and then loop in traversing
> device tree.

(...)

> @@ -650,6 +630,11 @@ EXPORT_SYMBOL_GPL(pci_vfs_assigned);
>   void pci_iov_assign_device(struct pci_dev *pdev)
>   {
>   	pdev->dev_flags |= PCI_DEV_FLAGS_ASSIGNED;
> +	if (pdev->is_virtfn && !pdev->is_physfn)
> +		if (pdev->physfn)
> +			if (pdev->physfn->sriov)

Why don't we make last two 'if' conditions into single 'if'

if (pdev->physfn && pdev->physfn->sriov)

> +				atomic_inc(&pdev->physfn->sriov->
> +					VFs_assigned_cnt);
>   }
>   EXPORT_SYMBOL_GPL(pci_iov_assign_device);
>   
> @@ -660,6 +645,11 @@ EXPORT_SYMBOL_GPL(pci_iov_assign_device);
>   void pci_iov_deassign_device(struct pci_dev *pdev)
>   {
>   	pdev->dev_flags &= ~PCI_DEV_FLAGS_ASSIGNED;
> +	if (pdev->is_virtfn && !pdev->is_physfn)
> +		if (pdev->physfn)
> +			if (pdev->physfn->sriov)

same...

> +				atomic_dec(&pdev->physfn->sriov->
> +					VFs_assigned_cnt);
>   }
>   EXPORT_SYMBOL_GPL(pci_iov_deassign_device);
>   
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 6bd0822..d17bda2 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -235,6 +235,7 @@ struct pci_sriov {
>   	u32 pgsz;		/* page size for BAR alignment */
>   	u8 link;		/* Function Dependency Link */
>   	u16 driver_max_VFs;	/* max num VFs driver supports */
> +	atomic_t VFs_assigned_cnt; /* counter of VFs assigned to VM */
>   	struct pci_dev *dev;	/* lowest numbered PF */
>   	struct pci_dev *self;	/* this PF */
>   	struct mutex lock;	/* lock for VF bus */

-- 
Regards,
Varka Bhadram.

