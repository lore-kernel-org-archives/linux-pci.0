Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0089.outbound.protection.outlook.com ([104.47.32.89]:18368
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751108AbeAEAJd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jan 2018 19:09:33 -0500
Subject: Re: [PATCH 29/37] PCI: Add pci_enable_atomic_ops_to_root
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jay Cornwall <Jay.Cornwall@amd.com>, oded.gabbay@gmail.com,
        amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Ram Amrani <Ram.Amrani@cavium.com>,
        Doug Ledford <dledford@redhat.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <1512792555-26042-1-git-send-email-Felix.Kuehling@amd.com>
 <1512792555-26042-30-git-send-email-Felix.Kuehling@amd.com>
 <20171212232707.GF53955@bhelgaas-glaptop.roam.corp.google.com>
 <564f4514-58a6-08b0-81c3-175238a9e828@amd.com>
 <20180104234035.GK189897@bhelgaas-glaptop.roam.corp.google.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <bc32c18f-9a6a-379f-bd04-6acba440c9d8@amd.com>
Date: Thu, 4 Jan 2018 19:09:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180104234035.GK189897@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

I figured it out. The difference between the functions is whether they
use struct pci_bus * or struct pci_dev * as cursor. I found that the
functions are in fact equivalent. The last loop iteration in
pci_enable_atomic_ops_to_root is equivalent to the code after the loop
in qedr_pci_set_atomic. Both handle the root port.

I think my confusion was based on an incorrect assumption that
bridge->bus->self is the same as bridge. But brigde->bus is in fact the
parent bus.

I sent out an updated patch that addresses your comments to the previous
version. This should be general enough that it can replace
qedr_pci_set_atomic.

Regards,
  Felix


On 2018-01-04 06:40 PM, Bjorn Helgaas wrote:
> On Tue, Jan 02, 2018 at 06:41:17PM -0500, Felix Kuehling wrote:
>> On 2017-12-12 06:27 PM, Bjorn Helgaas wrote:
>>> [+cc Ram, Michal, Ariel, Doug, Jason]
>>>
>>> The [29/37] in the subject makes it look like this is part of a larger
>>> series, but I can't find the rest of it on linux-pci or linux-kernel.
>>>
>>> I don't want to merge a new interface unless there's an in-tree user
>>> of it.  I assume the rest of the series includes a user.
>>>
>>> On Fri, Dec 08, 2017 at 11:09:07PM -0500, Felix Kuehling wrote:
>> [snip]
>>>> + * all upstream bridges support AtomicOp routing, egress blocking is disabled
>>>> + * on all upstream ports, and the root port supports 32-bit, 64-bit and/or
>>>> + * 128-bit AtomicOp completion, or negative otherwise.
>>>> + */
>>>> +int pci_enable_atomic_ops_to_root(struct pci_dev *dev)
>>>> +{
>>>> +	struct pci_bus *bus = dev->bus;
>>>> +
>>>> +	if (!pci_is_pcie(dev))
>>>> +		return -EINVAL;
>>>> +
>>>> +	switch (pci_pcie_type(dev)) {
>>>> +	/*
>>>> +	 * PCIe 3.0, 6.15 specifies that endpoints and root ports are permitted
>>>> +	 * to implement AtomicOp requester capabilities.
>>>> +	 */
>>>> +	case PCI_EXP_TYPE_ENDPOINT:
>>>> +	case PCI_EXP_TYPE_LEG_END:
>>>> +	case PCI_EXP_TYPE_RC_END:
>>>> +		break;
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	while (bus->parent) {
>>>> +		struct pci_dev *bridge = bus->self;
>>>> +		u32 cap;
>>>> +
>>>> +		pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
>>>> +
>>>> +		switch (pci_pcie_type(bridge)) {
>>>> +		/*
>>>> +		 * Upstream, downstream and root ports may implement AtomicOp
>>>> +		 * routing capabilities. AtomicOp routing via a root port is
>>>> +		 * not considered.
>>>> +		 */
>>>> +		case PCI_EXP_TYPE_UPSTREAM:
>>>> +		case PCI_EXP_TYPE_DOWNSTREAM:
>>>> +			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
>>>> +				return -EINVAL;
>>>> +			break;
>>>> +
>>>> +		/*
>>>> +		 * Root ports are permitted to implement AtomicOp completion
>>>> +		 * capabilities.
>>>> +		 */
>>>> +		case PCI_EXP_TYPE_ROOT_PORT:
>>>> +			if (!(cap & (PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
>>>> +				     PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
>>>> +				     PCI_EXP_DEVCAP2_ATOMIC_COMP128)))
>>>> +				return -EINVAL;
>>>> +			break;
>>>> +		}
>>> IIUC, you want to enable an endpoint, e.g., an AMD Fiji-class GPU, to
>>> initiate AtomicOps that target system memory.  This interface
>>> (pci_enable_atomic_ops_to_root()) doesn't specify what size operations
>>> the driver wants to do.  If the GPU requests a 128-bit op and the Root
>>> Port doesn't support it, I think we'll see an Unsupported Request
>>> error.
>>>
>>> Do you need to extend this interface so the driver can specify what
>>> sizes it wants?
>>>
>>> The existing code in qedr_pci_set_atomic() is very similar.  We should
>>> make this new interface work for both places, then actually use it in
>>> qedr_pci_set_atomic().
>> Hi Bjorn, Doug, Ram,
>>
>> I just discussed this with Jay, and he noticed that qedr_pci_set_atomic
>> seems to use a different criteria to find the completer for atomic
>> requests. Jay's function expects the root port to have a parent, which
>> was the case on the systems he tested. But Ram's function looks for a
>> bridge without a parent and checks completion capabilities on that. Jay
>> believes that to be a root complex, not a root port.
> By "Ram's function", I guess you mean qedr_pci_set_atomic()?
>
> That starts with a PCIe device ("pdev"; it assumes but does not check
> that this is a PCIe device), and traverses through all the bridges
> leading to it.  Usually this will be:
>
>   endpoint -> root port
>   endpoint -> switch downstream port -> switch upstream port -> root port
>
> Or there may be additional switches in the middle.  The code is
> actually not quite correct because it is legal to have this:
>
>   endpoint -> PCI-to-PCIe bridge -> conventional PCI bridge -> ...
>
> and qedr_pci_set_atomic() will traverse up through the conventional
> part of the hierarchy, where there is no PCI_EXP_DEVCAP2.
>
> In general, a Root Port is the root of a PCIe hierarchy and there is
> no parent device.  E.g., on my laptop:
>
>   00:1c.0 Intel Root Port (bridge to [bus 02])
>   00:1c.2 Intel Root Port (bridge to [bus 04])
>
> What sort of parent do you expect?  As I mentioned, it's legal to have
> a PCI/PCI-X to PCIe bridge inside a conventional PCI hierarchy, but
> that's a little unusual.
>
>> According to the spec, "Root ports are permitted to implement AtomicOp
>> completion capabilities." It talks about a root port, not a root complex.
>>
>> Can you help us understand, which interpretation is correct? And how to
>> correctly identify the root port for checking completion capabilities?
> If you start with a PCIe device and traverse upstream, you should
> eventually reach a Root Port or a PCI/PCI-X to PCIe bridge.
>
>> Are there valid topologies where a root port does not have a parent?
> I don't understand this because Root Ports normally do not have
> parents.
>
> PCIe devices other than Root Ports normally have a Root Port (or
> PCI/PCI-X to PCIe bridge) at the root of the PCIe hierarchy, but there
> are definitely exceptions.
>
> For example, there some systems where the Root Port is not visible to
> Linux, e.g.,
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ee8bdfb6568d
> On systems like that, I don't think you can safely use AtomicOps.
>
> Bjorn
