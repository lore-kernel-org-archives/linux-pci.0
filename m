Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1432216352-8016-1-git-send-email-hanjun.guo@linaro.org>
References: <1432216352-8016-1-git-send-email-hanjun.guo@linaro.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 21 May 2015 10:10:51 -0500
Message-ID: <CAErSpo6kFfXd9gFuL86qQWcVN6NYe11Ps+SoAefz1z2md8j_tA@mail.gmail.com>
Subject: Re: [PATCH] ACPI / PCI: remove stale list_head in struct acpi_prt_entry
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 21, 2015 at 8:52 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> list_head "list" in struct acpi_prt_entry was used to connect
> _PRT entries for PCI irq, but after commit 181380b7 (PCI/ACPI:
> Don't cache _PRT, and don't associate them with bus numbers),
> the list head for _PRT entries was removed, but left "list" in
> struct acpi_prt_entry which is useless and stale, remove it now.

Please use the canonical commit reference format, i.e.,

181380b702ee ("PCI/ACPI: Don't cache _PRT, and don't associate them
with bus numbers")

> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> CC: Yinghai Lu <yinghai@kernel.org>
> CC: Yijing Wang <wangyijing@huawei.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
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
> -       struct list_head        list;
>         struct acpi_pci_id      id;
>         u8                      pin;
>         acpi_handle             link;
> --
> 1.7.12.4
>
