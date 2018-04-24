Return-Path: <SRS0=utyB=HN=gmail.com=alexander.duyck@kernel.org>
Return-Path: <SRS0=utyB=HN=gmail.com=alexander.duyck@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180424215150.GB72698@bhelgaas-glaptop.roam.corp.google.com>
References: <20180420162633.46077.49012.stgit@ahduyck-green-test.jf.intel.com>
 <20180421203437.GW28657@bhelgaas-glaptop.roam.corp.google.com>
 <CAKgT0Ufcq6aQW5zPzBUePO4R_BCa2B_aZ8U2=meOQeOvshZ=Mw@mail.gmail.com> <20180424215150.GB72698@bhelgaas-glaptop.roam.corp.google.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 24 Apr 2018 15:22:54 -0700
Message-ID: <CAKgT0UerDqXbUcyspazUyzv=zqPWgsvdh9gEtjanre1pib216A@mail.gmail.com>
Subject: Re: [pci PATCH v8 0/4] Add support for unmanaged SR-IOV
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
	kvm@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
	"Daly, Dan" <dan.daly@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>, netanel@amazon.com,
	Don Dutile <ddutile@redhat.com>, Maximilian Heyne <mheyne@amazon.de>,
	"Wang, Liang-min" <liang-min.wang@intel.com>, "Rustad, Mark D" <mark.d.rustad@intel.com>,
	David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>, dwmw@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 24, 2018 at 2:51 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Sat, Apr 21, 2018 at 05:22:27PM -0700, Alexander Duyck wrote:
>> On Sat, Apr 21, 2018 at 1:34 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>> > For example, I'm not sure what you mean by "devices where the PF is
>> > not capable of managing VF resources."
>> >
>> > It *sounds* like you're saying the hardware works differently on some
>> > devices, but I don't think that's what you mean.  I think you're
>> > saying something about which drivers are used for the PF and the VF.
>>
>> That is sort of what I am saying.
>>
>> So for example with ixgbe there is functionality which is controlled
>> in the MMIO space of the PF that affects the functionality of the VFs
>> that are generated on the device. The PF has to rearrange the
>> resources such as queues and interrupts on the device before it can
>> enable SR-IOV, and it could alter those later to limit what the VF is
>> capable of doing.
>>
>> The model I am dealing with via this patch set has a PF that is not
>> much different than the VFs other than the fact that it has some
>> extended configuration space bits in place for SR-IOV, ARI, ACS, and
>> whatever other bits are needed in order to support spawning isolated
>> VFs.
>
> OK, thanks for the explanation, I think I understand what's going on
> now, correct me if I'm mistaken.  I added a hint about "PF" for Randy,
> too.
>
> These are on pci/virtualization for v4.18.

I reviewed them and all of the changes to patches 1 & 2 both below,
and in the tree look good to me.

Thanks for taking care of all this.

- Alex

> commit 8effc395c209
> Author: Alexander Duyck <alexander.h.duyck@intel.com>
> Date:   Sat Apr 21 15:23:09 2018 -0500
>
>     PCI/IOV: Add pci_sriov_configure_simple()
>
>     SR-IOV (Single Root I/O Virtualization) is an optional PCIe capability (see
>     PCIe r4.0, sec 9).  A PCIe Function with the SR-IOV capability is referred
>     to as a PF (Physical Function).  If SR-IOV is enabled on the PF, several
>     VFs (Virtual Functions) may be created.  The VFs can be individually
>     assigned to virtual machines, which allows them to share a single hardware
>     device while being isolated from each other.
>
>     Some SR-IOV devices have resources such as queues and interrupts that must
>     be set up in the PF before enabling the VFs, so they require a PF driver to
>     do that.
>
>     Other SR-IOV devices don't require any PF setup before enabling VFs.  Add a
>     pci_sriov_configure_simple() interface so PF drivers for such devices can
>     use it without repeating the VF-enabling code.
>
>     Tested-by: Mark Rustad <mark.d.rustad@intel.com>
>     Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>     [bhelgaas: changelog, comment]
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Greg Rose <gvrose8192@gmail.com>
>     Reviewed-by: Christoph Hellwig <hch@lst.de>:wq
>
> commit a8ccf8a66663
> Author: Alexander Duyck <alexander.h.duyck@intel.com>
> Date:   Tue Apr 24 16:47:16 2018 -0500
>
>     PCI/IOV: Add pci-pf-stub driver for PFs that only enable VFs
>
>     Some SR-IOV PF devices provide no functionality other than acting as a
>     means of enabling VFs.  For these devices, we want to enable the VFs and
>     assign them to guest virtual machines, but there's no need to have a driver
>     for the PF itself.
>
>     Add a new pci-pf-stub driver to claim those PF devices and provide the
>     generic VF enable functionality.  An administrator can use the sysfs
>     "sriov_numvfs" file to enable VFs, then assign them to guests.
>
>     For now I only have one example ID provided by Amazon in terms of devices
>     that require this functionality.  The general idea is that in the future we
>     will see other devices added as vendors come up with devices where the PF
>     is more or less just a lightweight shim used to allocate VFs.
>
>     Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>     [bhelgaas: changelog]
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Greg Rose <gvrose8192@gmail.com>
>     Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> commit 115ddc491922
> Author: Alexander Duyck <alexander.h.duyck@intel.com>
> Date:   Tue Apr 24 16:47:22 2018 -0500
>
>     net: ena: Use pci_sriov_configure_simple() to enable VFs
>
>     Instead of implementing our own version of a SR-IOV configuration stub in
>     the ena driver, use the existing pci_sriov_configure_simple() function.
>
>     Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Greg Rose <gvrose8192@gmail.com>
>     Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> commit 74d986abc20b
> Author: Alexander Duyck <alexander.h.duyck@intel.com>
> Date:   Tue Apr 24 16:47:27 2018 -0500
>
>     nvme-pci: Use pci_sriov_configure_simple() to enable VFs
>
>     Instead of implementing our own version of a SR-IOV configuration stub in
>     the nvme driver, use the existing pci_sriov_configure_simple() function.
>
>     Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Christoph Hellwig <hch@lst.de>
