Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64696 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311Ab2DWRaA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Apr 2012 13:30:00 -0400
Received: by lbom4 with SMTP id m4so5845589lbo.19
        for <linux-pci@vger.kernel.org>; Mon, 23 Apr 2012 10:29:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120416092610.GA28908@richard>
References: <1334223550-9514-1-git-send-email-weiyang@linux.vnet.ibm.com> <20120416092610.GA28908@richard>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 23 Apr 2012 11:29:38 -0600
Message-ID: <CAErSpo6ArLCi1CSxGJNw3g8J0WuDGp09W92tGVcpwFV3AVqr8A@mail.gmail.com>
Subject: Re: [PATCH] Optimize the resource overlap check
To: Richard Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 16, 2012 at 3:26 AM, Richard Yang
<weiyang@linux.vnet.ibm.com> wrote:
>
> In coalesce_windows() it tries to check whether the res1 and res2 overlap.
> This function do four comparisons, which could be done with one
> comparisons.
>
> Also make the resource_check_overlap() a common function for others.
>
> Signed-Off-By: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  arch/x86/pci/acpi.c    |   12 +-----------
>  include/linux/ioport.h |    7 +++++++
>  2 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 68c3c13..f2bb99e 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -181,13 +181,6 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
>        return AE_OK;
>  }
>
> -static bool resource_contains(struct resource *res, resource_size_t point)
> -{
> -       if (res->start <= point && point <= res->end)
> -               return true;
> -       return false;
> -}
> -
>  static void coalesce_windows(struct pci_root_info *info, unsigned long type)
>  {
>        int i, j;
> @@ -208,10 +201,7 @@ static void coalesce_windows(struct pci_root_info *info, unsigned long type)
>                         * our resources no longer match the ACPI _CRS, but
>                         * the kernel resource tree doesn't allow overlaps.
>                         */
> -                       if (resource_contains(res1, res2->start) ||
> -                           resource_contains(res1, res2->end) ||
> -                           resource_contains(res2, res1->start) ||
> -                           resource_contains(res2, res1->end)) {
> +                       if (resource_check_overlap(res1, res2)) {
>                                res1->start = min(res1->start, res2->start);
>                                res1->end = max(res1->end, res2->end);
>                                dev_info(&info->bridge->dev,
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index e9bb22c..374259b 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -198,5 +198,12 @@ extern int
>  walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
>                void *arg, int (*func)(unsigned long, unsigned long, void *));
>
> +static inline int resource_check_overlap(struct resource *r1,
> +                                         struct resource *r2)
> +{
> +       return (r1->start <= r2->end && r1->end >= r2->start);
> +}

I like the concept, but resource_check_overlap() is not a very good
name.  It returns a boolean, but the function name doesn't give any
clue about the sense.  "resource_overlaps()" or something similar
would be better.

Bjorn
