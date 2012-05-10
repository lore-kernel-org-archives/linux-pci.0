Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51570 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab2EJQur (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 May 2012 12:50:47 -0400
Received: by dady13 with SMTP id y13so1926973dad.19
        for <linux-pci@vger.kernel.org>; Thu, 10 May 2012 09:50:47 -0700 (PDT)
Message-ID: <4FABF1DD.7090101@gmail.com>
Date: Fri, 11 May 2012 00:50:37 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: Amos Kong <akong@redhat.com>, mst@redhat.com,
	linux-pci@vger.kernel.org, seabios@seabios.org,
	qemu-devel@nongnu.org, jbarnes@virtuousgeek.org, rjw@sisk.pl,
	kevin@koconnor.net
Subject: Re: [RESEND PATCH v3] hotplug: add device per func in ACPI DSDT tables
References: <20111214010645.GA2044@morn.localdomain>  <20120509072452.14872.92530.stgit@t> <1336571221.12477.136.camel@bling.home>
In-Reply-To: <1336571221.12477.136.camel@bling.home>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/09/2012 09:47 PM, Alex Williamson wrote:
>> ---
>>  src/ssdt-pcihp.dsl |   17 
>>  src/ssdt-pcihp.hex | 8869 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 8781 insertions(+), 105 deletions(-)
>>
>> diff --git a/src/ssdt-pcihp.dsl b/src/ssdt-pcihp.dsl
>> index 4b435b8..2a3c326 100644
>> --- a/src/ssdt-pcihp.dsl
>> +++ b/src/ssdt-pcihp.dsl
>> @@ -17,14 +17,23 @@ DefinitionBlock ("ssdt-pcihp.aml", "SSDT", 0x01, "BXPC", "BXSSDTPCIHP", 0x1)
>>          // at runtime, if the slot is detected to not support hotplug.
>>          // Extract the offset of the address dword and the
>>          // _EJ0 name to allow this patching.
>> -#define hotplug_slot(slot)                              \
>> -        Device (S##slot) {                              \
>> +#define hotplug_func(slot, fn)                          \
>> +        Device (S##slot##fn) {                          \
>>             ACPI_EXTRACT_NAME_DWORD_CONST aml_adr_dword  \
>> -           Name (_ADR, 0x##slot##0000)                  \
> 
> I would have guessed it to be sufficient to change _ADR to
> 0x##slot##ffff, does that not work?  Thanks,
> 
> Alex
Currently Linux acpiphp driver doesn't support that yet.

--gerry

