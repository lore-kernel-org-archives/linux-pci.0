Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:33198 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256Ab3DVHmW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 03:42:22 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <qiudayu@linux.vnet.ibm.com>;
	Mon, 22 Apr 2013 17:40:02 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 66BF32BB0059
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 17:42:16 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r3M7g97n33358036
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 17:42:10 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r3M7gErT024728
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 17:42:15 +1000
Message-ID: <5174E9C3.6080203@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 15:41:55 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linux-pci@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] PowerNV/PCI: Fix NULL PCI controller
References: <1366611236-1811-1-git-send-email-qiudayu@linux.vnet.ibm.com> <1366612577.2723.21.camel@pasglop>
In-Reply-To: <1366612577.2723.21.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

于 2013/4/22 14:36, Benjamin Herrenschmidt 写道:
> On Mon, 2013-04-22 at 02:13 -0400, Mike Qiu wrote:
>> In pnv_pci_read_config() or pnv_pci_write_config(), we never check if
>> the PCI controller is valid before converting that into platform
>> dependent one, this is very dangerous.
>>
>> To avoid this potential risks, the patch check PCI controller first
>> before use it.
> I don't think there's any remote possibility of that happening, is
> there ?
Yes, I agree, I don't exactly mean that it maybe happen, but the code
try to check the pci_controller pointer and the way it try is useless,
because if this happens, the system will crash before check: try to access
the "NULL" pointer.

My patch just makes the code more stable and robust.

Anyway, I think it's better to remove the check code as it is useless, as it
will shows that this "NULL" pci_controller pointer may happen...

Thanks
Mike
> If it does, maybe it warrants a WARN_ON...
>
> Ben.
>
>> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/platforms/powernv/pci.c |    8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>> index b8b8e0b..e7b7f1a 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -286,11 +286,11 @@ static int pnv_pci_read_config(struct pci_bus *bus,
>>   			       int where, int size, u32 *val)
>>   {
>>   	struct pci_controller *hose = pci_bus_to_host(bus);
>> -	struct pnv_phb *phb = hose->private_data;
>> +	struct pnv_phb *phb = hose ? hose->private_data : NULL;
>>   	u32 bdfn = (((uint64_t)bus->number) << 8) | devfn;
>>   	s64 rc;
>>   
>> -	if (hose == NULL)
>> +	if (!phb)
>>   		return PCIBIOS_DEVICE_NOT_FOUND;
>>   
>>   	switch (size) {
>> @@ -330,10 +330,10 @@ static int pnv_pci_write_config(struct pci_bus *bus,
>>   				int where, int size, u32 val)
>>   {
>>   	struct pci_controller *hose = pci_bus_to_host(bus);
>> -	struct pnv_phb *phb = hose->private_data;
>> +	struct pnv_phb *phb = hose ? hose->private_data : NULL;
>>   	u32 bdfn = (((uint64_t)bus->number) << 8) | devfn;
>>   
>> -	if (hose == NULL)
>> +	if (!phb)
>>   		return PCIBIOS_DEVICE_NOT_FOUND;
>>   
>>   	cfg_dbg("pnv_pci_write_config bus: %x devfn: %x +%x/%x -> %08x\n",
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

