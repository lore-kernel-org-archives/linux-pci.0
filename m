Return-Path: <xyjxie@linux.vnet.ibm.com>
Return-Path: <xyjxie@linux.vnet.ibm.com>
Subject: Re: [PATCH resend v2] Extending kernel option pci=resource_alignment
 to be able to specify PCI device/vendor IDs
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
References: <00e437fe05f54c6a9df12bf48cf28dc5@FE-MBX1012.de.bosch.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
        Bjorn Helgaas
 <helgaas@kernel.org>,
        "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Tue, 26 Jul 2016 18:11:06 +0800
MIME-Version: 1.0
In-Reply-To: <00e437fe05f54c6a9df12bf48cf28dc5@FE-MBX1012.de.bosch.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <75813d7d-cadd-828f-737e-4113da3427d9@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Mathias,


On 2016/7/25 14:05, Koehrer Mathias (ETAS/ESW5) wrote:
> Hi Gavin,
>
>> Mathias, The code change would conflict with Yongji's patch where the
>> wildcard introduced to identify PCI devices.
>>
>> https://patchwork.ozlabs.org/patch/642473/
> That's true, however it is also true the other way round. The first sending of my patch was
> 22-June 2016 and thus before Yongji's patch...
> See also the comment of Bjorn Helgaas on my patch (v1):
> http://marc.info/?l=linux-pci&m=146654644431550&w=2
>
> However it looks as if there are a couple of (conflicting) approaches for the issue with the alignment of PCI addresses flying around...
> My personal opinion is that the need to adapt the alignment of PCI addresses should be done on PCI device/vendor ids of relevant PCI devices and not on PCI addresses.
> The PCI addresses are likely to change e.g. by inserting another PCI board. The device/vendor id of the devices will not change.

Yes, your opinion is right. I think I will update my patches based on 
your change.

With your patch, seems like we can specify alignment for all PCI devices 
by using something like: pci=resource_alignment=4096@pci:0:0.
We'd better document it.

Thanks,
Yongji
