Return-Path: <SRS0=8QV7=KY=dellteam.com=Alex_Gagniuc@kernel.org>
Return-Path: <SRS0=8QV7=KY=dellteam.com=Alex_Gagniuc@kernel.org>
Cc: <bhelgaas@google.com>, <keith.busch@intel.com>, <Austin.Bolen@dell.com>,
        <Shyam.Iyer@dell.com>, <fred@fredlawl.com>, <poza@codeaurora.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: <Alex_Gagniuc@Dellteam.com>
To: <helgaas@kernel.org>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
Date: Thu, 9 Aug 2018 16:46:32 +0000
Message-ID: <2cae6a5ac8324be18b8dcf3d7dfcc288@ausx13mps321.AMER.DELL.COM>
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
 <20180809141551.GH49411@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On 08/09/2018 09:16 AM, Bjorn Helgaas wrote:=0A=
> On Tue, Jul 17, 2018 at 10:31:23AM -0500, Alexandru Gagniuc wrote:=0A=
>> When we don't own AER, we shouldn't touch the AER error bits. This=0A=
>> happens unconditionally on device probe(). Clearing AER bits=0A=
>> willy-nilly might cause firmware to miss errors. Instead=0A=
>> these bits should get cleared by FFS, or via ACPI _HPX method.=0A=
>>=0A=
>> This race is mostly of theoretical significance, as it is not easy to=0A=
>> reasonably demonstrate it in testing.=0A=
>>=0A=
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>=0A=
>> ---=0A=
>>   drivers/pci/pcie/aer.c | 3 +++=0A=
>>   1 file changed, 3 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c=0A=
>> index a2e88386af28..18037a2a8231 100644=0A=
>> --- a/drivers/pci/pcie/aer.c=0A=
>> +++ b/drivers/pci/pcie/aer.c=0A=
>> @@ -383,6 +383,9 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev=
 *dev)=0A=
>>   	if (!pci_is_pcie(dev))=0A=
>>   		return -ENODEV;=0A=
>>   =0A=
>> +	if (pcie_aer_get_firmware_first(dev))=0A=
>> +		return -EIO;=0A=
> =0A=
> I like this patch.=0A=
> =0A=
> Do we need the same thing in the following places that also clear AER=0A=
> status bits or write AER control bits?=0A=
=0A=
In theory, every exported function would guard for this. I think the =0A=
idea a long long time ago was that the check happens during =0A=
initialization, and the others are not hit.=0A=
=0A=
>    enable_ecrc_checking()=0A=
>    disable_ecrc_checking()=0A=
=0A=
I don't immediately see how this would affect FFS, but the bits are part =
=0A=
of the AER capability structure. According to the FFS model, those would =
=0A=
be owned by FW, and we'd have to avoid touching them.=0A=
=0A=
>    pci_cleanup_aer_uncorrect_error_status()=0A=
=0A=
This probably should be guarded. It's only called from a few specific =0A=
drivers, so the impact is not as high as being called from the core.=0A=
=0A=
>    pci_aer_clear_fatal_status()=0A=
=0A=
This is only called when doing fatal_recovery, right?=0A=
For practical considerations this is not an issue today. The ACPI error =0A=
handling code currently crashes when it encounters any fatal error, so =0A=
we wouldn't hit this in the FFS case.=0A=
=0A=
If the ACPI code pulls its thinking appendage out of the other end of =0A=
the digestive tract, then we could be hitting this in the future. For =0A=
correctness, guarding makes sense.=0A=
=0A=
The PCIe standards contact I usually talk to about these PCIe subtleties =
=0A=
is currently on vacation. The number one issue was a FFS corner case =0A=
with OS clearing bits on probe. The other functions you mention are a =0A=
corner case of a corner case. The big fish is =0A=
pci_cleanup_aer_error_status_regs() on probe(), and it would be nice to =0A=
have that resolved.=0A=
=0A=
I'll sync up with Austin when he gets back to see about the other =0A=
functions though I suspect we'll end up fixing them as well.=0A=
=0A=
Alex=0A=
=0A=
>>   	pos =3D dev->aer_cap;=0A=
>>   	if (!pos)=0A=
>>   		return -EIO;=0A=
>> -- =0A=
>> 2.14.3=0A=
>>=0A=
> =0A=
=0A=
=0A=
