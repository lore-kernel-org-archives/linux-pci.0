Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:60102 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755186Ab3EaVlP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2013 17:41:15 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so304647oag.34
        for <linux-pci@vger.kernel.org>; Fri, 31 May 2013 14:41:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369974092-11450-2-git-send-email-jiang.liu@huawei.com>
References: <1369974092-11450-1-git-send-email-jiang.liu@huawei.com> <1369974092-11450-2-git-send-email-jiang.liu@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 31 May 2013 15:40:54 -0600
Message-ID: <CAErSpo70u7oM07jcGA+E1MUHA4OWiJ1gQ8SuS7YCRuvGMxeaqA@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI, ACPI: Don't glue ACPI dev with pci VFs
To: Jiang Liu <liuj97@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Yinghai Lu <yinghai@kernel.org>, Xudong Hao <xudong.hao@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael]

On Thu, May 30, 2013 at 10:21 PM, Jiang Liu <liuj97@gmail.com> wrote:
> From: Yinghai Lu <yinghai@kernel.org>
>
> When sriov is enabled, VF could just start after PF in pci tree.
> like c1:00.0 will be PF, and c1:00.1 and after will be VF.
>
> acpi do have dev with same ADR. that will make them get glued
> wrongly.
>
> Skip that if it is virtfn.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> ---
>  drivers/pci/pci-acpi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index e4b1fb2..720f3a2 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -321,6 +321,10 @@ static int acpi_pci_find_device(struct device *dev, acpi_handle *handle)
>         u64     addr;
>
>         pci_dev = to_pci_dev(dev);
> +       /* don't mix vf with real pci device */
> +       if (pci_dev->is_virtfn)
> +               return -ENODEV;

Rafael, can you review this?  I don't understand the implications of
this change.

And I don't know exactly what problem this would fix, so I don't know
if it's stable material or not.  Yinghai did propose it as v3.10
material in https://lkml.kernel.org/r/1368498506-25857-1-git-send-email-yinghai@kernel.org,
but I don't know why.

Bjorn

>         /* Please ref to ACPI spec for the syntax of _ADR */
>         addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
>         *handle = acpi_get_child(DEVICE_ACPI_HANDLE(dev->parent), addr);
> --
> 1.8.1.2
>
