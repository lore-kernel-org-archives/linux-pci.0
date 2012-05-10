Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53029 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756648Ab2EJRRq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 May 2012 13:17:46 -0400
Received: by dady13 with SMTP id y13so1954978dad.19
        for <linux-pci@vger.kernel.org>; Thu, 10 May 2012 10:17:45 -0700 (PDT)
Message-ID: <4FABF832.1060708@gmail.com>
Date: Fri, 11 May 2012 01:17:38 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Amos Kong <akong@redhat.com>
CC: mst@redhat.com, linux-pci@vger.kernel.org, seabios@seabios.org,
	qemu-devel@nongnu.org, jbarnes@virtuousgeek.org, rjw@sisk.pl,
	alex.williamson@redhat.com, kevin@koconnor.net
Subject: Re: [RESEND PATCH v3] hotplug: add device per func in ACPI DSDT tables
References: <20111214010645.GA2044@morn.localdomain> <20120509072452.14872.92530.stgit@t>
In-Reply-To: <20120509072452.14872.92530.stgit@t>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/09/2012 03:24 PM, Amos Kong wrote:

> ---
>  src/ssdt-pcihp.dsl |   17 
>  src/ssdt-pcihp.hex | 8869 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 8781 insertions(+), 105 deletions(-)
> 
> diff --git a/src/ssdt-pcihp.dsl b/src/ssdt-pcihp.dsl
> index 4b435b8..2a3c326 100644
> --- a/src/ssdt-pcihp.dsl
> +++ b/src/ssdt-pcihp.dsl
> @@ -17,14 +17,23 @@ DefinitionBlock ("ssdt-pcihp.aml", "SSDT", 0x01, "BXPC", "BXSSDTPCIHP", 0x1)
>          // at runtime, if the slot is detected to not support hotplug.
>          // Extract the offset of the address dword and the
>          // _EJ0 name to allow this patching.
> -#define hotplug_slot(slot)                              \
> -        Device (S##slot) {                              \
> +#define hotplug_func(slot, fn)                          \
> +        Device (S##slot##fn) {                          \
>             ACPI_EXTRACT_NAME_DWORD_CONST aml_adr_dword  \
> -           Name (_ADR, 0x##slot##0000)                  \
> +           Name (_ADR, 0x##slot##000##fn)               \
>             ACPI_EXTRACT_METHOD_STRING aml_ej0_name      \
>             Method (_EJ0, 1) { Return(PCEJ(0x##slot)) }  \
>             Name (_SUN, 0x##slot)                        \
>          }
It would be perfect if the Device object could also support _PS0 and _STA
methods. Could we re-add the slot back after hot-removing it from the guest
OS with this ACPI implementation? Say execute following scripts from guest OS.
echo 0 > /sys/bus/pci/slot/xx/power
echo 1 > /sys/bus/pci/slot/xx/power

> +#define hotplug_slot(slot)     \
> +        hotplug_func(slot, 0)  \
> +        hotplug_func(slot, 1)  \
> +        hotplug_func(slot, 2)  \
> +        hotplug_func(slot, 3)  \
> +        hotplug_func(slot, 4)  \
> +        hotplug_func(slot, 5)  \
> +        hotplug_func(slot, 6)  \
> +        hotplug_func(slot, 7)
>  
>          hotplug_slot(01)
>          hotplug_slot(02)
> @@ -59,7 +68,7 @@ DefinitionBlock ("ssdt-pcihp.aml", "SSDT", 0x01, "BXPC", "BXSSDTPCIHP", 0x1)
>          hotplug_slot(1f)
>  
>  #define gen_pci_hotplug(slot)   \
> -            If (LEqual(Arg0, 0x##slot)) { Notify(S##slot, Arg1) }
> +            If (LEqual(Arg0, 0x##slot)) { Notify(S##slot##0, Arg1) }
>  
>          Method(PCNT, 2) {
>              gen_pci_hotplug(01)
