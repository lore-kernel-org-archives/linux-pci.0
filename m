Return-Path: <SRS0=MGTe=BR=linux.vnet.ibm.com=jjalvare@kernel.org>
Return-Path: <SRS0=MGTe=BR=linux.vnet.ibm.com=jjalvare@kernel.org>
Subject: Re: [PATCH v3 2/2] pseries/eeh: Add Pseries pcibios_bus_add_device
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
        seroyer@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Juan J . Alvarez" <jjalvare@us.ibm.com>
References: <20170922141928.49141-1-bryantly@linux.vnet.ibm.com>
 <20170922141928.49141-3-bryantly@linux.vnet.ibm.com>
 <20171011200524.GR25517@bhelgaas-glaptop.roam.corp.google.com>
 <87efq92ei6.fsf@concordia.ellerman.id.au>
 <20171012182932.GA653@bhelgaas-glaptop.roam.corp.google.com>
 <e77da565-e9e1-75e1-55ee-cfc9a8bf1424@linux.vnet.ibm.com>
 <87r2u2jvfb.fsf@concordia.ellerman.id.au>
 <3507ee2e-00ee-7bd0-36a3-292af5112734@linux.vnet.ibm.com>
 <e5bc893a-03f7-4ca7-4e46-938421dfc1c5@ozlabs.ru>
 <5b7b8e8f-2d16-875f-ef53-ccf593064a53@ozlabs.ru>
From: Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Date: Wed, 18 Oct 2017 08:20:29 -0500
MIME-Version: 1.0
In-Reply-To: <5b7b8e8f-2d16-875f-ef53-ccf593064a53@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Message-Id: <9893e011-d524-06b6-b041-3f1b24e5f03d@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

On 10/17/17 8:36 PM, Alexey Kardashevskiy wrote:
> PowerNV KVM guest is a pseries machine so this code will execute there.
>
The configure sriov path will fail and not enable sriov if resources are
not met. I.e. the IOV Bar is not set in PF IOV Resources, which in this
case gets assigned by firmware.

We have separated the calls to put PowerNV and PSeries as machine dependent
calls. Furthermore, we are adding device node properties in the device tree to identify if
this is an SR-IOV slot on Phyp Pseries platform. Verification will be in place to
distinguish between platforms that support SR-IOV in PSeries.
>> Which is the reason for
>> the separation of calls to the machine dependent stuff.
>>> We also use the pseries platform when running under KVM.
>>>
>>> cheers
>>>
>> If anyone plans to enable SR-IOV on Pseries platform, firmware must provide the
>> resources to enable the VFs and map them with system resources.
> This is what the PowerNV platform does.
Again, we have separated the machine dependent calls to different platforms. In our
case we don't use opal and our dependent on phyp to associate resources.
>
>> A new version
>> of the PAPR Document will be added to document these system resources.
> The guest simply gets yet another PCI device, how is IOV different here?
>
> In regard of EEH, the API does not change afaik, it is up to the hypervisor
> (KVM+QEMU) to handle IOV case correctly.

I don't understand your question entirely, can you rephrase?
