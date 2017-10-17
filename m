Return-Path: <SRS0=T556=BQ=linux.vnet.ibm.com=jjalvare@kernel.org>
Return-Path: <SRS0=T556=BQ=linux.vnet.ibm.com=jjalvare@kernel.org>
Subject: Re: [PATCH v3 2/2] pseries/eeh: Add Pseries pcibios_bus_add_device
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Steven Royer <seroyer@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, bhelgaas@google.com,
        benh@kernel.crashing.org, paulus@samba.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Juan J . Alvarez" <jjalvare@us.ibm.com>,
        Bodong Wang <bodong@mellanox.com>, Eli Cohen <eli@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
References: <87efq92ei6.fsf@concordia.ellerman.id.au>
 <20171012182932.GA653@bhelgaas-glaptop.roam.corp.google.com>
 <e77da565-e9e1-75e1-55ee-cfc9a8bf1424@linux.vnet.ibm.com>
 <20171013033456.GC25517@bhelgaas-glaptop.roam.corp.google.com>
 <88eab212351a662dda330071d9afe9dc@linux.vnet.ibm.com>
 <11c15c773aefcc0490e197051c2eaf41@linux.vnet.ibm.com>
 <20171013120558.1a129183@t450s.home>
 <24fdec01-8df4-f027-0b3c-0472a2d73946@linux.vnet.ibm.com>
 <20171017135123.GA5641@bhelgaas-glaptop.roam.corp.google.com>
 <7e23c703-750b-b4f8-f252-0c872a40ae8a@linux.vnet.ibm.com>
 <20171017162621.GB5641@bhelgaas-glaptop.roam.corp.google.com>
From: Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Date: Tue, 17 Oct 2017 12:23:01 -0500
MIME-Version: 1.0
In-Reply-To: <20171017162621.GB5641@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <f8fbbd56-f165-0a17-a24a-2b021f7fa238@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

On 10/17/17 11:26 AM, Bjorn Helgaas wrote:
> To pop back up to the top of the stack, I think the main point of this
> patch is to keep from binding a driver to the VFs in the kernel that
> set PCI_SRIOV_CTRL_VFE.  This patch does that by setting
> pdev->match_driver to -1 in powerpc-specific code.
Correct, to add to your comment, we will only add to the PSeries platform
 (in PowerPC)  configure SR-IOV path.
> I think all systems, not just powerpc, want to prevent this VF driver
> binding, so I hope there's a generic solution that everybody can use.
The patch that we made this change dependent on:

https://patchwork.kernel.org/patch/9882915/

Is a generic form of not binding a pci device to a device driver
and can be used in another environment if needed.
>
>>>> So like existing way of enabling SRIOV we still rely on the PF driver to
>>>> enable VFs - but in this case the attachment phase is done via a user
>>>> action via a management console in our case (novalink or hmc) triggered
>>>> event that will essentially act like a hotplug.
>>>>
>>>> So in the fine details of that user triggered action the system
>>>> firmware will bind the VFs, allowing resources to be allocated to
>>>> the VF.  - Which essentially does all the attaching as we know it
>>>> today but is managed by PHYP not by the kernel.
>>> What exactly does "firmware binding the VFs" mean?  I guess this must
>>> mean assigning a VF to a partition, injecting a hotplug add event to
>>> that partition, and making the VF visible in config space?
>> Firmware basically adds a device node to the device tree as defined
>> in the (PAPR) Power Architecture Platform Requirements document.
> From the point of view of the kernel that consumes this device tree
> and owns the VF, I guess this looks like a hot-add.  
Correct, this is intended. We want to minimize change and only focus
on configure SR-IOV path in the PF on PSeries platform.
> It would be nice
> if this could be exposed to that kernel by having the firmware inject
> a normal PCIe hotplug interrupt, but I'm guessing it's not that
> simple.
I don't understand entirely your suggestion. However, in the case of
interrupts PHYP owns all the resources and will be associated accordingly
with a partitionable endpoint (PE).
> But if I understand correctly, this patch series isn't concerned with
> that kernel; it's concerned with the kernel that owns the PF and sets
> PCI_SRIOV_CTRL_VFE.
Correct, we will enable SR-IOV in the PF through the Linux kernel and map system resources
for the new VFs in powerpc platform specific kernel code. Furthermore, not binding
the device drivers for the VFs that get mapped within the configure SR-IOV path
is a requirement for this PSeries SR-IOV environment.

Juan J. Alvarez
