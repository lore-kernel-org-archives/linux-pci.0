Return-Path: <linux-arch-owner@vger.kernel.org>
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v3 07/17] x86/pci: add Hygon PCI vendor and northbridge
 support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
References: <cover.1533989492.git.puwen@hygon.cn>
 <0b8f3a7c5ba8b4f496f8f790e3dafa8d612ffc81.1533989492.git.puwen@hygon.cn>
 <20180813221436.GN113140@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <ec0ef867-3254-9e17-bf37-de697e9d0709@hygon.cn>
Date: Tue, 14 Aug 2018 12:56:51 +0800
MIME-Version: 1.0
In-Reply-To: <20180813221436.GN113140@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018/8/14 6:14, Bjorn Helgaas wrote:
> On Sat, Aug 11, 2018 at 09:27:42PM +0800, Pu Wen wrote:
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 2950223..d0e98a9 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -511,6 +511,8 @@
>>   #define PCI_DEVICE_ID_AMI_MEGARAID	0x9010
>>   #define PCI_DEVICE_ID_AMI_MEGARAID2	0x9060
>>   
>> +#define PCI_VENDOR_ID_HYGON		0x1d94
> 
> Please add this entry so pci_ids.h remains sorted by Vendor ID, then Device
> ID, as the comment at the top suggests.

Thanks for the suggestion. Will place PCI_VENDOR_ID_HYGON between 
PCI_VENDOR_ID_AMAZON(0x1d0f) and PCI_VENDOR_ID_TEKRAM(0x1de1) in next
patch set.

Pu Wen

> 
> With that changed,
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
> 
>>   #define PCI_VENDOR_ID_AMD		0x1022
>>   #define PCI_DEVICE_ID_AMD_K8_NB		0x1100
>>   #define PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP	0x1101
>> -- 
>> 2.7.4
>>
