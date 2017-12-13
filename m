Return-Path: <SRS0=3w/w=DJ=Oracle.COM=Govinda.Tatti@kernel.org>
Return-Path: <SRS0=3w/w=DJ=Oracle.COM=Govinda.Tatti@kernel.org>
Subject: Re: [Xen-devel] [PATCH V3 1/2] Drivers/PCI: Export pcie_has_flr()
 interface
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: jgross@suse.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        JBeulich@suse.com, bhelgaas@google.com, xen-devel@lists.xenproject.org,
        boris.ostrovsky@Oracle.COM, roger.pau@citrix.com
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-2-Govinda.Tatti@Oracle.COM>
 <20171208202424.GC12367@bhelgaas-glaptop.roam.corp.google.com>
 <426eeeab-0dcd-8de3-9c5f-a166acf2c130@Oracle.COM>
 <20171212005919.GB30595@bhelgaas-glaptop.roam.corp.google.com>
From: Govinda Tatti <Govinda.Tatti@Oracle.COM>
Message-ID: <49956aaf-5fd5-939d-5fc7-231ffdb98b70@Oracle.COM>
Date: Wed, 13 Dec 2017 14:46:57 -0600
MIME-Version: 1.0
In-Reply-To: <20171212005919.GB30595@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>


>>>> -static bool pcie_has_flr(struct pci_dev *dev)
>>>> +bool pcie_has_flr(struct pci_dev *dev)
>>>>   {
>>>>   	u32 cap;
>>>> @@ -3882,6 +3882,7 @@ static bool pcie_has_flr(struct pci_dev *dev)
>>>>   	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
>>>>   	return cap & PCI_EXP_DEVCAP_FLR;
>>>>   }
>>>> +EXPORT_SYMBOL_GPL(pcie_has_flr);
>>> I'd rather change pcie_flr() so you could *always* call it, and it
>>> would return 0, -ENOTTY, or whatever, based on whether FLR is
>>> supported.  Is that feasible?
>> Sure, I will add pcie_has_flr() logic inside pcie_flr() and return
>> appropriate
>> values as suggested by you. Do we still want to retain pcie_has_flr() and
>> its usage inside pci.c?.Otherwise, I will remove it and do required cleanup.
> If you can restructure the code and remove pcie_has_flr() while
> retaining the existing behavior of its callers, that would be great.
I checked the current usage of pcie_has_flr() and pcie_flr(). I have a 
couple
of questions or need some clarification.

1. pcie_has_flr() usage inside pci_probe_reset_function().

    This function is only calling pcie_has_flr() but not pcie_flr().
    Rest of the code is trying to do specific type of reset except 
pcie_flr().

         rc = pci_dev_specific_reset(dev, 1);
         if (rc != -ENOTTY)
                 return rc;
         if (pcie_has_flr(dev))
                 return 0;
         rc = pci_af_flr(dev, 1);
         if (rc != -ENOTTY)
                 return rc;

    In other-words, I can remove usage of pcie_has_flr() in all other places
    in pci.c except in above function.

2. W.r.t pcie_flr(), I am planning to return error code. Currently, the 
following
    file/modules are calling this function. My plan is to add a check 
for return
    code and print a WANRING message if return code is NON-ZERO. I hope 
this is
    sufficient for this patch.

    drivers/crypto/qat/qat_common/adf_aer.c
    drivers/infiniband/hw/hfi1/chip.c (2 places)
    drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
    drivers/net/ethernet/intel/ixgbe/ixgbe_main.c (2 places)
    drivers/pci/quirks.c (2 places)

Cheers
GOVINDA
