Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC PATCH v3 3/5] PCI: Add host bridge attribute to indicate
 filtering of MSIs is supported
To: David Laight <David.Laight@ACULAB.COM>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <1452841574-2781-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1452841574-2781-4-git-send-email-xyjxie@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CCC6833@AcuExch.aculab.com>
Cc: "nikunj@linux.vnet.ibm.com" <nikunj@linux.vnet.ibm.com>,
	"zhong@linux.vnet.ibm.com" <zhong@linux.vnet.ibm.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
	"warrier@linux.vnet.ibm.com" <warrier@linux.vnet.ibm.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"paulus@samba.org" <paulus@samba.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <569F5636.30701@linux.vnet.ibm.com>
Date: Wed, 20 Jan 2016 17:41:10 +0800
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CCC6833@AcuExch.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/1/16 1:24, David Laight wrote:
> From: Yongji Xie
>> Sent: 15 January 2016 07:06
>>
>> MSI-X tables are not allowed to be mmapped in vfio-pci
>> driver in case that user get to touch this directly.
>> This will cause some performance issues when when PCI
>> adapters have critical registers in the same page as
>> the MSI-X table.
> ...
> If the driver wants to generate an incorrect MSI-X interrupt
> it can do so by requesting the device do a normal memory transfer
> to the target address area that raises MSI-X interrupts.

IOMMUs supporting interrupt remapping can prevent this case.

> So disabling writes to the MSI-X table (and pending bit array)
> areas only raises the bar very slightly.
> A device may also give the driver write access to the MSI-X
> table through other addresses.
>
> This seems to make disallowing the mapping of the MSI-X table
> rather pointless.

If we allow the mapping of the MSI-X table, it seems the guest
kernels of some architectures can write invalid data to MSI-X table
when device drivers initialize MSI-X interrupts.

Regards,
Yongji Xie

> I've also dumped out the MSI-X table (during development) to
> check that the values are being written there correctly.
>
> 	David
>
