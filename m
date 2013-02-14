Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:53067 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933798Ab3BNRkZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Feb 2013 12:40:25 -0500
Received: by mail-ob0-f171.google.com with SMTP id x4so2708640obh.30
        for <linux-pci@vger.kernel.org>; Thu, 14 Feb 2013 09:40:25 -0800 (PST)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 14 Feb 2013 10:40:04 -0700
Message-ID: <CAErSpo5PFn9gDgKWHoGpiSEE9862WbTDm7VVtxMxX05zK7b6kw@mail.gmail.com>
Subject: Re: [Bug 53811] [REGRESSION]: acpiphp broken on Lenovo X220 from 3.6 onwards
To: allurgroceries@gmail.com
Cc: Zheng Yan <zheng.z.yan@intel.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Zheng, Rafael, linux-pci]

On Wed, Feb 13, 2013 at 11:55 PM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=53811
>
>            Summary: acpiphp broken on Lenovo X220 from 3.6 onwards

> Distribution: Debian Sid AMD64
> Hardware: Lenovo X220, i5-2520M, 8GB
>
> Hotplugging the expresscard no longer works after 3.5.
>
> Bisected to commit 71a83bd727cc31c5fe960c3758cb396267ff710e
>
> "PCI/PM: add runtime PM support to PCIe port"
>
> "Because runtime suspend is broken for some chipsets, a black list is used to
> disable runtime PM support for these chipsets."
>
> I'm not sure how the blacklist is supposed to look, so I reversed the test and
> the problem is gone. Here's a diff against 3.7.7:
>
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index ebb3e5f..b427aad 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -225,7 +225,7 @@ static int __devinit pcie_portdrv_probe(struct pci_dev
> *dev,
>       * it by default.
>       */
>      dev->d3cold_allowed = false;
> -    if (!pci_match_id(port_runtime_pm_black_list, dev))
> +    if (pci_match_id(port_runtime_pm_black_list, dev))
>          pm_runtime_put_noidle(&dev->dev);
>
>      return 0;

Thanks for the report.  Can you please attach complete dmesg logs from
kernels with your patch (showing a working hotplug) and without your
patch (showing the failing hotplug)?
