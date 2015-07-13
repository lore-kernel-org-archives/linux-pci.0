Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33101 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284AbbGMPLm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Jul 2015 11:11:42 -0400
Date: Mon, 13 Jul 2015 18:11:38 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	"Chen, Gong" <gong.chen@linux.intel.com>,
	Guenter Roeck <groeck@juniper.net>,
	=?us-ascii?B?PT9VVEYtOD9xP1JhZmE9QzU9ODI9MjBNaT1DNT04MmVja2k/PQ==?=
	<zajec5@gmail.com>, linux-api@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci_regs: reintroduce PCI_MSIX_FLAGS_BIRMASK
Message-ID: <20150713181025-mutt-send-email-mst@redhat.com>
References: <1435745608-21217-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435745608-21217-1-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 01, 2015 at 12:14:10PM +0200, Michael S. Tsirkin wrote:
> This partially reverts commit 09a2c73ddfc7f173237fc7209a65b34dd5bcb5ed.
>     PCI: Remove unused PCI_MSIX_FLAGS_BIRMASK definition
> 
> That commit dropped a symbol from an exported header claiming "no one
> uses it". This isn't how Linux normally approaches userspace API though,
> and in fact QEMU build fails if trying to use updated headers from linux
> 3.12 and up.
> 
> Sure, userspace can be fixed to use the new symbol, but the cost
> of keeping the old one around is fairly low, too.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Ping. Can this be included upstream please?

> ---
>  include/uapi/linux/pci_regs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index efe3443..66644ac 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -319,6 +319,7 @@
>  #define PCI_MSIX_PBA		8	/* Pending Bit Array offset */
>  #define  PCI_MSIX_PBA_BIR	0x00000007 /* BAR index */
>  #define  PCI_MSIX_PBA_OFFSET	0xfffffff8 /* Offset into specified BAR */
> +#define  PCI_MSIX_FLAGS_BIRMASK	PCI_MSIX_PBA_BIR /* deprecated */
>  #define PCI_CAP_MSIX_SIZEOF	12	/* size of MSIX registers */
>  
>  /* MSI-X Table entry format */
> -- 
> MST
