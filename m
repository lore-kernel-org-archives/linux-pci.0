Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35451 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932409AbbJVWOA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 22 Oct 2015 18:14:00 -0400
Date: Thu, 22 Oct 2015 17:13:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, lftan.linux@gmail.com,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v11 2/6] pci: add Altera PCI vendor ID
Message-ID: <20151022221355.GJ21237@localhost>
References: <1445506051-21688-1-git-send-email-lftan@altera.com>
 <1445506051-21688-3-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445506051-21688-3-git-send-email-lftan@altera.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 22, 2015 at 05:27:27PM +0800, Ley Foon Tan wrote:
> Signed-off-by: Ley Foon Tan <lftan@altera.com>
> ---
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index d9ba49c..08e4462 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1550,6 +1550,8 @@
>  #define PCI_DEVICE_ID_SERVERWORKS_CSB6LPC 0x0227
>  #define PCI_DEVICE_ID_SERVERWORKS_HT1100LD 0x0408
>  
> +#define PCI_VENDOR_ID_ALTERA		0x1172
> +

This doesn't seem to be used anywhere, so I'll drop this patch.

>  #define PCI_VENDOR_ID_SBE		0x1176
>  #define PCI_DEVICE_ID_SBE_WANXL100	0x0301
>  #define PCI_DEVICE_ID_SBE_WANXL200	0x0302
> -- 
> 1.8.2.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
