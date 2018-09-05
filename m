Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbeIEV0b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 17:26:31 -0400
Date: Wed, 5 Sep 2018 11:55:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] Revert "PCI: Add ACS quirk for Intel 300 series"
Message-ID: <20180905165526.GK107892@bhelgaas-glaptop.roam.corp.google.com>
References: <20180905110954.61990-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180905110954.61990-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 05, 2018 at 02:09:54PM +0300, Mika Westerberg wrote:
> This reverts commit f154a718e6cc0d834f5ac4dc4c3b174e65f3659e.
> 
> It turns out that errata "PCH PCIe* Controller Root Port (ACSCTLR)
> Appear As Read Only" has been fixed in 300 series chipsets even if the
> datasheet [1] claims otherwise. To make ACS working properly on 300
> series root ports, revert the faulty commit.

So just to confirm, f154a718e6cc ("PCI: Add ACS quirk for Intel 300
series") was done based on the faulty datasheet, right?

If somebody actually reported a problem with a 300 series chipset, and
f154a718e6cc resolved it, we wouldn't want to revert it.  But I don't see
anything like that in the f154a718e6cc changelog, so I assume it was just
based on the faulty datasheet.

> [1] https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/300-series-c240-series-chipset-pch-spec-update.pdf
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/quirks.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ef7143a274e0..6bc27b7fd452 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4355,11 +4355,6 @@ static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags)
>   *
>   * 0x9d10-0x9d1b PCI Express Root port #{1-12}
>   *
> - * The 300 series chipset suffers from the same bug so include those root
> - * ports here as well.
> - *
> - * 0xa32c-0xa343 PCI Express Root port #{0-24}
> - *
>   * [1] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-2.html
>   * [2] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-1.html
>   * [3] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-spec-update.html
> @@ -4377,7 +4372,6 @@ static bool pci_quirk_intel_spt_pch_acs_match(struct pci_dev *dev)
>  	case 0xa110 ... 0xa11f: case 0xa167 ... 0xa16a: /* Sunrise Point */
>  	case 0xa290 ... 0xa29f: case 0xa2e7 ... 0xa2ee: /* Union Point */
>  	case 0x9d10 ... 0x9d1b: /* 7th & 8th Gen Mobile */
> -	case 0xa32c ... 0xa343:				/* 300 series */
>  		return true;
>  	}
>  
> -- 
> 2.18.0
> 
