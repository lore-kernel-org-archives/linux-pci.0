Return-Path: <gwshan@linux.vnet.ibm.com>
Return-Path: <gwshan@linux.vnet.ibm.com>
Date: Fri, 11 Nov 2016 10:22:28 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Noa Osherovich <noaos@mellanox.com>
Cc: gwshan@linux.vnet.ibm.com, helgaas@kernel.org, linux-pci@vger.kernel.org,
        majd@mellanox.com, alex.williamson@redhat.com, amir@vadai.me
Subject: Re: [PATCH] PCI: Refine broken INTx masking for Mellanox devices
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1478011644-12080-1-git-send-email-noaos@mellanox.com>
 <20161109182232.GL14322@bhelgaas-glaptop.roam.corp.google.com>
 <20161110034640.GA5341@gwshan>
 <08e3aa80-1d13-7a6e-9133-87a149741993@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <08e3aa80-1d13-7a6e-9133-87a149741993@mellanox.com>
Message-Id: <20161110232228.GA6798@gwshan>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 10, 2016 at 05:56:50PM +0200, Noa Osherovich wrote:

.../...

>>>> As a result, the VFIO driver fails to start when more than one device
>>>> function is passed-through to a VM if both have the same INTx pin.
>>>>
>> I don't see how the issue is related to the patch. INTx pin can be shared
>> by multiple functions and it's not going to be changed by the patch. When
>> the functions aren't claimed for capability to mask INTx from device side,
>> the shared INTx (or hardware IRQ) has to be masked from host (IRQ controller)
>> side. It does affect multiple VMs who are sharing thise INTx pin. I'm not
>> sure if it's the problem you have?
>
>VFIO reads the broken_intx_masking field when it's used on the host (VFIO uses a
>variable named pci_2_3). During vfio_intx_set_signal it sets the irqflags
>variable to 0 if the pci_2_3 is 0. When the first function is assigned to the
>guest, everything is OK.
>When a second function with the same INT-x pin is assigned, VFIO checks that they
>can share the IRQ.
>The irqflags variable is then checked to see if IRQF_SHARED is set. If not, which
>is the case here, VFIO fails to request IRQ thus failing and the guest can't start.
>

Noa, Thanks for the explanation. It makes sense.

Thanks,
Gavin
