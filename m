Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34766 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbbKORHf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2015 12:07:35 -0500
MIME-Version: 1.0
In-Reply-To: <1447591056-3733-1-git-send-email-brutallesale@gmail.com>
References: <1447591056-3733-1-git-send-email-brutallesale@gmail.com>
Date: Sun, 15 Nov 2015 19:07:34 +0200
Message-ID: <CAHp75VfG_NALTAK1yeG1ZgLFghTCL3tVBJfs9-01_3xv5ygwEw@mail.gmail.com>
Subject: Re: [PATCH] drivers:pci:hotplug Fix space prohibited after function name
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Bogicevic Sasa <brutallesale@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, wangyijing@huawei.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Nov 15, 2015 at 2:37 PM, Bogicevic Sasa <brutallesale@gmail.com> wrote:
> This fixes warning that a space is prohibited after function name
>
> Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
> ---
>  drivers/pci/hotplug/pci_hotplug_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
> index 2bac1b9..d379d49 100644
> --- a/drivers/pci/hotplug/pci_hotplug_core.c
> +++ b/drivers/pci/hotplug/pci_hotplug_core.c
> @@ -226,7 +226,7 @@ static ssize_t test_write_file(struct pci_slot *pci_slot, const char *buf,
>         u32 test;
>         int retval = 0;
>
> -       ltest = simple_strtoul (buf, NULL, 10);
> +       ltest = simple_strtoul(buf, NULL, 10);
>         test = (u32)(ltest & 0xffffffff);

Looks like all above could be replaced by

int retval;

retval = kstrtou32(… &test);
if (retval)
 return retval;

>         dbg("test = %d\n", test);
>
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
