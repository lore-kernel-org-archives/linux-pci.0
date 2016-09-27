Return-Path: <gwshan@linux.vnet.ibm.com>
Return-Path: <gwshan@linux.vnet.ibm.com>
Date: Wed, 28 Sep 2016 09:37:49 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
        bhelgaas@google.com, linux-pci@vger.kernel.org, clsoto@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI: Add parameter @mmio_force_on to
 pci_update_resource()
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1474242810-11530-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20160927192003.GA14642@localhost>
 <1475012732.2857.293.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475012732.2857.293.camel@au1.ibm.com>
Message-Id: <20160927233749.GA19797@gwshan>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 28, 2016 at 07:45:32AM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2016-09-27 at 14:20 -0500, Bjorn Helgaas wrote:
>> On Mon, Sep 19, 2016 at 09:53:30AM +1000, Gavin Shan wrote:
>> > In pci_update_resource(), the PCI device's memory decoding (0x2 in
>> > PCI_COMMAND) is disabled when 64-bits memory BAR is updated if the
>> > PCI device's memory space wasn't asked to be always on by @pdev->
>> > mmio_always_on. The PF's memory decoding might be disabled when
>> > updating its IOV BARs in the following path. Actually, the PF's
>> > memory decoding shouldn't be disabled in this scenario as the PF
>> > has been started to provide services:
>> 
>> The reason we disable memory decoding while updating a 64-bit BAR is
>> because we can't do the update atomically, and a half-updated BAR might
>> conflict with other devices.
>> 
>> You need to explain what is special about these SR-IOV BARs that makes it
>> safe to update them non-atomically while decoding is enabled.
>
>The IOV BAR won't decode until SR-IOV is enabled right ? Gavin, I don't
>think we update it "live", so it should be safe...
>

Yeah, it's safe to update it with memory decoding on. As the function call
flow I listed in the changelog (as below), nobody should access the IOV BAR
when pci_update_resource() is called. However, the PF's memory BARs might
be accessed that time and it's not safe to disable PF's memory decoding.

   sriov_numvfs_store
   pdev->driver->sriov_configure
   mlx5_core_sriov_configure
   pci_enable_sriov
   sriov_enable
   pcibios_sriov_enable
   pnv_pci_sriov_enable
   pnv_pci_vf_resource_shift
   pci_update_resource

Thanks,
Gavin
