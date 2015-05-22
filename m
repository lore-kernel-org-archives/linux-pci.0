Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:42882 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756101AbbEVBlV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2015 21:41:21 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2] ACPI / PCI: remove stale list_head in struct acpi_prt_entry
Date: Fri, 22 May 2015 04:06:43 +0200
Message-ID: <46214942.PaRfZ23MiM@vostro.rjw.lan>
In-Reply-To: <1432222166-9198-1-git-send-email-hanjun.guo@linaro.org>
References: <1432222166-9198-1-git-send-email-hanjun.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, May 21, 2015 11:29:26 PM Hanjun Guo wrote:
> list_head "list" in struct acpi_prt_entry was used to connect
> _PRT entries for PCI irq, but after commit 181380b702ee ("PCI/ACPI:
> Don't cache _PRT, and don't associate them with bus numbers"),
> the list head for _PRT entries was removed, but left "list" in
> struct acpi_prt_entry which is useless and stale, remove it now.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Yinghai Lu <yinghai@kernel.org>
> CC: Yijing Wang <wangyijing@huawei.com>
> ---
> 
> v2:
> use the canonical commit reference format as Bjorn suggested.

Queued up for 4.2, thanks!

>  drivers/acpi/pci_irq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index b1def41..03e4b6c 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -44,7 +44,6 @@
>  ACPI_MODULE_NAME("pci_irq");
>  
>  struct acpi_prt_entry {
> -	struct list_head	list;
>  	struct acpi_pci_id	id;
>  	u8			pin;
>  	acpi_handle		link;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
