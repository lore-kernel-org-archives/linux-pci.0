Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:43908 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756278AbbCCPSY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2015 10:18:24 -0500
Received: by qcxr5 with SMTP id r5so30838214qcx.10
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2015 07:18:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1425356741-26789-3-git-send-email-jiang.liu@linux.intel.com>
References: <1425356741-26789-1-git-send-email-jiang.liu@linux.intel.com> <1425356741-26789-3-git-send-email-jiang.liu@linux.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 3 Mar 2015 09:18:03 -0600
Message-ID: <CAErSpo6MtTj+DM0dtm0QxUXGV=rC7a0Sygs03sU0617mWO-DpA@mail.gmail.com>
Subject: Re: [Debug 2/2] x86/PCI/ACPI: Relax ACPI resource descriptor checks
 to work around BIOS bugs
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Thomas Voegtle <tv@lio96.de>, Hudd <hedede.l@gmail.com>,
	Prakash Punnoor <prakash@punnoor.de>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Dave Airlie <airlied@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Len Brown <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lv Zheng <lv.zheng@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 2, 2015 at 10:25 PM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> Some BIOSes report incorrect length for ACPI address space descriptors,
> so relax the checks to avoid regressions.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

It'd be nice to have a DSDT archived and referenced in this changelog
for future reference.  This sounds similar to previous issues:

3162b6f0c5e1 ("PNPACPI: truncate _CRS windows with _LEN > _MAX - _MIN + 1")
d558b483d5a7 ("x86/PCI: truncate _CRS windows with _LEN > _MAX - _MIN + 1")
f238b414a74a ("PNPACPI: compute Address Space length rather than using _LEN")
48728e077480 ("x86/PCI: compute Address Space length rather than using _LEN")

I assume your work fixes both these paths and avoids the issues we fixed above.

> ---
>  drivers/acpi/resource.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index c723668e3e27..5589a6e2a023 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -42,8 +42,10 @@ static bool acpi_dev_resource_len_valid(u64 start, u64 end, u64 len, bool io)
>          * CHECKME: len might be required to check versus a minimum
>          * length as well. 1 for io is fine, but for memory it does
>          * not make any sense at all.
> +        * Note: some BIOSes report incorrect length for ACPI address space
> +        * descriptor, so remove check of 'reslen == len' to avoid regression.
>          */
> -       if (len && reslen && reslen == len && start <= end)
> +       if (len && reslen && start <= end)
>                 return true;
>
>         pr_debug("ACPI: invalid or unassigned resource %s [%016llx - %016llx] length [%016llx]\n",
> --
> 1.7.10.4
>
