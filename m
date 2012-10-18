Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51748 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450Ab2JRDzb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2012 23:55:31 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so6865941wgb.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Oct 2012 20:55:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1350526971-9427-1-git-send-email-tangchen@cn.fujitsu.com>
References: <1350526971-9427-1-git-send-email-tangchen@cn.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 17 Oct 2012 21:55:09 -0600
Message-ID: <CAErSpo6ehw1JHMyE27MuX2VR89+1zC48QJe9Udih88N-W-73Wg@mail.gmail.com>
Subject: Re: [PATCH] Add PNP0A08 into acpi_pci_roots array.
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: lenb@kernel.org, yinghai@kernel.org, jiang.liu@huawei.com,
	izumi.taku@jp.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 17, 2012 at 8:22 PM, Tang Chen <tangchen@cn.fujitsu.com> wrote:
> acpi_pci_roots array doesn't include PNP0A08, which is PCI Express
> Root Bridge.

You need to explain why this change is necessary.  PNP0A08 devices
will have a PNP0A03 _CID, so the driver already claims PNP0A08 devices
because the _CID matches.

> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
> ---
>  drivers/acpi/pci_root.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 037b59c..dedc4d6 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -56,6 +56,7 @@ static int acpi_pci_root_start(struct acpi_device *device);
>
>  static const struct acpi_device_id root_device_ids[] = {
>         {"PNP0A03", 0},
> +       {"PNP0A08", 0},
>         {"", 0},
>  };
>  MODULE_DEVICE_TABLE(acpi, root_device_ids);
> --
> 1.7.1
>
