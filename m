Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1492706123-22913-1-git-send-email-haiyangz@exchange.microsoft.com>
References: <1492706123-22913-1-git-send-email-haiyangz@exchange.microsoft.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Apr 2017 13:33:13 -0500
Message-ID: <CAErSpo4iFS05Kk3Km54fFmpMf11XCoaPmGxSzqE3QuA5P=T6=Q@mail.gmail.com>
Subject: Re: [PATCH] pci-hyperv: Use only 16 bit integer for PCI domain
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, olaf@aepfle.de,
        vkuznets@redhat.com, driverdev-devel@linuxdriverproject.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 20, 2017 at 11:35 AM, Haiyang Zhang
<haiyangz@exchange.microsoft.com> wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
>
> This patch uses the lower 16 bits of the serial number as PCI
> domain, otherwise some drivers may not be able to handle it.

Can you give any more details about this?  Which drivers, for
instance?  Why do drivers care about the domain at all?  Can we or
should we make this more explicit and consistent in the PCI core,
e.g., pci_domain_nr() is currently defined to return "int"; maybe it
should be u32?  (Although I think "int" is the same size as "u32" on
all arches anyway).

> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index e73880c..b18dff3 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1334,9 +1334,11 @@ static void put_pcichild(struct hv_pci_dev *hpdev,
>          * can have shorter names than based on the bus instance UUID.
>          * Only the first device serial number is used for domain, so the
>          * domain number will not change after the first device is added.
> +        * The lower 16 bits of the serial number is used, otherwise some
> +        * drivers may not be able to handle it.
>          */
>         if (list_empty(&hbus->children))
> -               hbus->sysdata.domain = desc->ser;
> +               hbus->sysdata.domain = desc->ser & 0xFFFF;
>         list_add_tail(&hpdev->list_entry, &hbus->children);
>         spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>         return hpdev;
> --
> 1.7.1
>
