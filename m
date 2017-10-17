Return-Path: <SRS0=T556=BQ=linux.vnet.ibm.com=jjalvare@kernel.org>
Return-Path: <SRS0=T556=BQ=linux.vnet.ibm.com=jjalvare@kernel.org>
Subject: Re: [PATCH v3 2/2] pseries/eeh: Add Pseries pcibios_bus_add_device
To: Bjorn Helgaas <helgaas@kernel.org>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Steven Royer <seroyer@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, bhelgaas@google.com,
        benh@kernel.crashing.org, paulus@samba.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Juan J . Alvarez" <jjalvare@us.ibm.com>,
        Bodong Wang <bodong@mellanox.com>, Eli Cohen <eli@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
References: <20170922141928.49141-3-bryantly@linux.vnet.ibm.com>
 <20171011200524.GR25517@bhelgaas-glaptop.roam.corp.google.com>
 <87efq92ei6.fsf@concordia.ellerman.id.au>
 <20171012182932.GA653@bhelgaas-glaptop.roam.corp.google.com>
 <e77da565-e9e1-75e1-55ee-cfc9a8bf1424@linux.vnet.ibm.com>
 <20171013033456.GC25517@bhelgaas-glaptop.roam.corp.google.com>
 <88eab212351a662dda330071d9afe9dc@linux.vnet.ibm.com>
 <11c15c773aefcc0490e197051c2eaf41@linux.vnet.ibm.com>
 <20171013120558.1a129183@t450s.home>
 <24fdec01-8df4-f027-0b3c-0472a2d73946@linux.vnet.ibm.com>
 <20171017135123.GA5641@bhelgaas-glaptop.roam.corp.google.com>
From: Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Date: Tue, 17 Oct 2017 09:33:34 -0500
MIME-Version: 1.0
In-Reply-To: <20171017135123.GA5641@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <7e23c703-750b-b4f8-f252-0c872a40ae8a@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>


On 10/17/17 8:51 AM, Bjorn Helgaas wrote:
> This is where I get confused.  I guess the Linux that sets
> PCI_SRIOV_CTRL_VFE to enable the VFs can also perform config accesses
> to the VFs, since it can enumerate them and build pci_dev structs for
> them, right?

Correct, we are not changing anything related to how the VF gets initialized
in the kernel.
>
> And the Linux in the "Hosting Partition" is a guest that cannot see a
> VF until a management console attaches the VF to the Hosting
> Partition?  

Correct, this is how PHYP does normal adapter assignment.
> I'm not a VFIO or KVM expert but that sounds vaguely like
> what they would do when assigning a VF to a guest.
I do not know the specifics on VFIO and KVM. However, in this
case there is no KVM running on the Linux LPAR. PHYP owns all
the system resources.
>
>> So like existing way of enabling SRIOV we still rely on the PF driver to
>> enable VFs - but in this case the attachment phase is done via a user
>> action via a management console in our case (novalink or hmc) triggered
>> event that will essentially act like a hotplug.
>>
>> So in the fine details of that user triggered action the system
>> firmware will bind the VFs, allowing resources to be allocated to
>> the VF.  - Which essentially does all the attaching as we know it
>> today but is managed by PHYP not by the kernel.
> What exactly does "firmware binding the VFs" mean?  I guess this must
> mean assigning a VF to a partition, injecting a hotplug add event to
> that partition, and making the VF visible in config space?
Firmware basically adds a device node to the device tree as defined
in the (PAPR) Power Architecture Platform Requirements document.

Juan
