Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: weiyj_lk@163.com
Cc: Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] ACPI / hotplug / PCI: Fix sparse non static symbol warning
Date: Mon, 21 Jul 2014 01:46:53 +0200
Message-ID: <4215141.Y6mWN4rKBn@vostro.rjw.lan>
In-Reply-To: <1405834483-7832-1-git-send-email-weiyj_lk@163.com>
References: <1405834483-7832-1-git-send-email-weiyj_lk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday, July 20, 2014 01:34:43 PM weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fixes the following sparse warning:
> 
> drivers/pci/hotplug/acpiphp_glue.c:923:6: warning:
>  symbol 'acpiphp_drop_bridge' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Queued up for 3.17, thanks!

> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 24a43d4..70741c8 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -920,7 +920,7 @@ void acpiphp_enumerate_slots(struct pci_bus *bus)
>  	kfree(bridge);
>  }
>  
> -void acpiphp_drop_bridge(struct acpiphp_bridge *bridge)
> +static void acpiphp_drop_bridge(struct acpiphp_bridge *bridge)
>  {
>  	if (pci_is_root_bus(bridge->pci_bus)) {
>  		struct acpiphp_root_context *root_context;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
