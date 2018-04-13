Return-Path: <SRS0=mtlz=HC=gmail.com=hkallweit1@kernel.org>
Return-Path: <SRS0=mtlz=HC=gmail.com=hkallweit1@kernel.org>
Subject: Re: [PATCH] PCI: Add two more values for PCIe Max_Read_Request_Size
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <90260d62-e136-44a3-a35b-19fac1bcfb20@gmail.com>
 <20180412225557.GB46420@bhelgaas-glaptop.roam.corp.google.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <e24bac5a-cf03-3579-2d44-6548a0998258@gmail.com>
Date: Fri, 13 Apr 2018 07:48:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180412225557.GB46420@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Am 13.04.2018 um 00:55 schrieb Bjorn Helgaas:
> Hello Heiner,
> 
> On Thu, Apr 12, 2018 at 11:08:04PM +0200, Heiner Kallweit wrote:
>> This patch adds missing values for the max read request size.
>> E.g. network driver r8169 uses a value of 4K.
> 
> Is there a r8169 patch that adds uses of PCI_EXP_DEVCTL_READRQ_4096B?
> If so, we should probably keep it together with this one since this
> one would have to be merged first.
> 
Not yet, so far r8169 uses the following to set a MRRS of 4K.

#define MAX_READ_REQUEST_SHIFT	12
0x5 << MAX_READ_REQUEST_SHIFT

I have to check when setting 4K MRRS was added, but it seems
that so far it's fine with all users.

Before submitting the r8169 patch I wanted to check for feedback
regarding use of the two additional MRRS values, so what you write
in the following is exactly the type of feedback I was looking for.

I will read through the linked discussion and then also submit the
r8169 patch.

Thanks, Heiner

> There's also a larger issue in that when Linux configures MPS and MRRS
> at enumeration-time, it makes some assumptions about how MRRS is set.
> If a driver like r8169 changes MRRS later, it may break those
> assumptions, which might lead to PCIe errors.
> 
> If a user boots with "pci=pcie_bus_perf", we use PCIE_BUS_PERFORMANCE
> mode, and in that case we may set MPS to something larger than some
> devices can support, and we rely on MRRS to avoid problems.
> 
> I don't really *like* that scheme because it makes assumptions like
> "drivers never change MRRS", but that's what we have right now.
> 
> So just be aware that if r8169 changes MRRS and users boot with
> "pci=pcie_bus_perf", there is the potential for PCIe bus errors.
> 
> There was some recent discussion about this; [1] is a good place to
> start.
> 
> [1] http://lkml.kernel.org/r/20180119205153.GB160618@bhelgaas-glaptop.roam.corp.google.com
> 
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  include/uapi/linux/pci_regs.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index 0c79eac5..699257fb 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -506,6 +506,8 @@
>>  #define  PCI_EXP_DEVCTL_READRQ_256B  0x1000 /* 256 Bytes */
>>  #define  PCI_EXP_DEVCTL_READRQ_512B  0x2000 /* 512 Bytes */
>>  #define  PCI_EXP_DEVCTL_READRQ_1024B 0x3000 /* 1024 Bytes */
>> +#define  PCI_EXP_DEVCTL_READRQ_2048B 0x4000 /* 2048 Bytes */
>> +#define  PCI_EXP_DEVCTL_READRQ_4096B 0x5000 /* 4096 Bytes */
>>  #define  PCI_EXP_DEVCTL_BCR_FLR 0x8000  /* Bridge Configuration Retry / FLR */
>>  #define PCI_EXP_DEVSTA		10	/* Device Status */
>>  #define  PCI_EXP_DEVSTA_CED	0x0001	/* Correctable Error Detected */
>> -- 
>> 2.17.0
>>
> 
