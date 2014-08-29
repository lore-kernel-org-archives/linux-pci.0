Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:42498 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbaH2OWh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Aug 2014 10:22:37 -0400
Received: by mail-qa0-f47.google.com with SMTP id x12so2175941qac.6
        for <linux-pci@vger.kernel.org>; Fri, 29 Aug 2014 07:22:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1409303414-5196-1-git-send-email-david.henningsson@canonical.com>
References: <1409303414-5196-1-git-send-email-david.henningsson@canonical.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 29 Aug 2014 08:22:16 -0600
Message-ID: <CAErSpo5v82xeYGqsiWXpfQdr8kF9x+1K4gjYremfCh3fNQ8Unw@mail.gmail.com>
Subject: Re: [PATCH] Add pci=assign-busses quirk to Dell Latitude D505
To: David Henningsson <david.henningsson@canonical.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 29, 2014 at 3:10 AM, David Henningsson
<david.henningsson@canonical.com> wrote:
> Under a 3.16 based kernel (Ubuntu 3.16.0-031600-lowlatency),
> CardBus is not working unless pci=assign-buses is added to the
> kernel boot parameters.
>
> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
> ---
>  arch/x86/pci/common.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> It was working OOTB on a 3.2 based kernel (Ubuntu 3.2.0-67-generic),
> and I have not thoroughly bisected what made it stop working.
> Still I'm suggesting to just a quirk to make it work regardless of
> kernel - it's a ~8 year old laptop, so being a bit lazy about it is
> probably okay, I hope. :-)

Please open a bugzilla and attach complete "lspci -vv" output and
dmesg logs from the working 3.2 kernel and a non-working current
kernel.

The quirk might be OK, but it would be better if we could make a
generic fix that would work on more machines than just this one.

>
> Extract from dmidecode:
>
> Handle 0x0100, DMI type 1, 25 bytes
> System Information
>         Manufacturer: Dell Inc.
>         Product Name: Latitude D505
>
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 059a76c..1849e39 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -262,6 +262,14 @@ static const struct dmi_system_id pciprobe_dmi_table[] = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "SX20S"),
>                 },
>         },
> +       {
> +               .callback = assign_all_busses,
> +               .ident = "Dell Latitude D505 Laptop",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D505"),
> +               },
> +       },
>  #endif         /* __i386__ */
>         {
>                 .callback = set_bf_sort,
> --
> 1.9.1
>
