Return-Path: <SRS0=CFX0=DJ=gmail.com=oded.gabbay@kernel.org>
Return-Path: <SRS0=CFX0=DJ=gmail.com=oded.gabbay@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171212234243.GD16603@ziepe.ca>
References: <1512792555-26042-1-git-send-email-Felix.Kuehling@amd.com>
 <1512792555-26042-30-git-send-email-Felix.Kuehling@amd.com>
 <20171212232707.GF53955@bhelgaas-glaptop.roam.corp.google.com> <20171212234243.GD16603@ziepe.ca>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Wed, 13 Dec 2017 09:22:04 +0200
Message-ID: <CAFCwf11aDNWx1+Ldatg0ODXMGmReG7fZM24s6mxEnwjF-zv8Qw@mail.gmail.com>
Subject: Re: [PATCH 29/37] PCI: Add pci_enable_atomic_ops_to_root
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Felix Kuehling <Felix.Kuehling@amd.com>,
	amd-gfx list <amd-gfx@lists.freedesktop.org>, Jay Cornwall <Jay.Cornwall@amd.com>,
	linux-pci@vger.kernel.org, Ram Amrani <Ram.Amrani@cavium.com>,
	Doug Ledford <dledford@redhat.com>, Michal Kalderon <Michal.Kalderon@cavium.com>,
	Ariel Elior <Ariel.Elior@cavium.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 13, 2017 at 1:42 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Tue, Dec 12, 2017 at 05:27:07PM -0600, Bjorn Helgaas wrote:
>> [+cc Ram, Michal, Ariel, Doug, Jason]
>>
>> The [29/37] in the subject makes it look like this is part of a larger
>> series, but I can't find the rest of it on linux-pci or linux-kernel.
>
> Didn't find the cover letter, but the AMD patchworks captured the series..
>
> https://patchwork.freedesktop.org/project/amd-xorg-ddx/patches/

Hi,
This patchset is mainly for the amdkfd driver, which is used for
running HSA Framework on AMD's APUs and in the near future, dGPUs.
This driver has been in the kernel since 3.19.
PCIe atomics were not required for APUs because there GPU part is
integrated with the CPU and they have atomic accesses between them.

For enabling HSA on dGPUs (such as Fiji, Vega, Polaris) which connect
through PCIe, we need to have PCIe atomics support.
The patchset starts to upstream the dGPU support and one of the
pre-requisites is the patch in discussion.

>
>> I don't want to merge a new interface unless there's an in-tree user
>> of it.  I assume the rest of the series includes a user.
>
> Looks like it.
So, yes, there is a user in the kernel and there is an entire
open-source userspace framework around it, called ROCm
(https://github.com/RadeonOpenCompute/ROCm)

Oded

>
> I would also guess we will see users in drivers/infiniband emerge as
> CPU coherent atomics are also a topic our hardware drivers will be
> interested in. But I am not aware of any pending patches.
>
> Jason
