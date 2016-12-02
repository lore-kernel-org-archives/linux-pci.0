Return-Path: <SRS0=IEsV=XR=huawei.com=guohanjun@kernel.org>
Return-Path: <SRS0=IEsV=XR=huawei.com=guohanjun@kernel.org>
Subject: Re: [PATCH v10 00/12] PCI: ARM64 ECAM quirks
To: Dongdong Liu <liudongdong3@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <d3f1a4ca-99e6-f0a5-d20b-d2753058d93d@huawei.com>
 <8f4a67d4-549a-34e9-8ef7-ec99961d60e5@huawei.com>
 <20161201163105.GB19681@bhelgaas-glaptop.roam.corp.google.com>
 <42eec2b2-6ced-25a1-95d3-3b22e3b71bec@huawei.com>
CC: <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        "Christopher
 Covington" <cov@codeaurora.org>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <58412DAF.1090001@huawei.com>
Date: Fri, 2 Dec 2016 16:15:43 +0800
MIME-Version: 1.0
In-Reply-To: <42eec2b2-6ced-25a1-95d3-3b22e3b71bec@huawei.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On 2016/12/2 11:46, Dongdong Liu wrote:
> Hi Bjorn
>
> 在 2016/12/2 0:31, Bjorn Helgaas 写道:
>> On Thu, Dec 01, 2016 at 10:04:48PM +0800, Dongdong Liu wrote:
>>> ...
>>> Aftet fixing the compile errors. I tested on HiSilicon D03 board. It works ok.
>>> The dmesg is as below
>>
>> Thanks very much for testing this!  A few comments below.
>>
>>> root@(none)$ dmesg
>>> [    0.000000] Booting Linux on physical CPU 0x10000
>>> [    0.000000] Linux version 4.9.0-rc1-gaf05ef2-dirty (l00290354@linux-ioko) (gcc version 4.9.3 20150211 (prerelease) (20150316) ) #257 SMP PREEMPT Thu Dec 1 22:13:05 CST 2016
>>> [    0.000000] Boot CPU: AArch64 Processor [411fd071]
>>> [    0.000000] earlycon: hisilpcuart0 at MMIO 0x00000000a01b0000 (options '0,0x2f8')
>>> [    0.000000] bootconsole [hisilpcuart0] enabled
>>> [    0.000000] efi: Getting EFI parameters from FDT:
>>> [    0.000000] efi: EFI v2.60 by EDK II
>>> [    0.000000] efi:  SMBIOS=0x3f110000  SMBIOS 3.0=0x39ce0000  ACPI=0x39db0000  ACPI 2.0=0x39db0014  MEMATTR=0x3c945018
>>
>> On x86 we normally have info about the machine and BIOS, e.g.,
>>
>>   DMI: LENOVO 20FCS12V03/20FCS12V03, BIOS N1FET40W (1.14 ) 04/18/2016
>>
>> I think this comes from dmi_present(), and it looks like we should
>> call that via arm64_dmi_init().  Any idea why we don't see that info?
>> Is it just missing from the SMBIOS table?  I think it's useful to
>> have for debugging problems.
>
> I need to ask my colleagues about this, then reply.

git grep -w "DMI:"
drivers/firmware/dmi_scan.c:                      printk(KERN_DEBUG "DMI: %s\n", dmi_ids_string);
drivers/firmware/dmi_scan.c:                      pr_debug("DMI: %s\n", dmi_ids_string);

It's a pr_debug information, seems we didn't enable the debug print?

Thanks
Hanjun
