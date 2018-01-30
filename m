Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751603AbeA3OHT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 09:07:19 -0500
Date: Tue, 30 Jan 2018 07:07:18 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org, mj@ucw.cz
Subject: Re: [PATCH] Fix Vector table and PBA addresses print output
Message-ID: <20180130070718.335deb52@w520.home>
In-Reply-To: <998ca55d1a2b9a7f6912dcff69bc57d31b690fb0.1517308416.git.gustavo.pimentel@synopsys.com>
References: <998ca55d1a2b9a7f6912dcff69bc57d31b690fb0.1517308416.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 30 Jan 2018 10:34:08 +0000
Gustavo Pimentel <gustavo.pimentel@synopsys.com> wrote:

> Lack of 3-bit rotation to the right was leading to erroneous display of the
> vector table and PBA.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  ls-caps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/ls-caps.c b/ls-caps.c
> index 507771a..cd13a37 100644
> --- a/ls-caps.c
> +++ b/ls-caps.c
> @@ -1104,10 +1104,10 @@ cap_msix(struct device *d, int where, int cap)
>  
>    off = get_conf_long(d, where + PCI_MSIX_TABLE);
>    printf("\t\tVector table: BAR=%d offset=%08x\n",
> -	 off & PCI_MSIX_BIR, off & ~PCI_MSIX_BIR);
> +	 off & PCI_MSIX_BIR, (off & ~PCI_MSIX_BIR) >> 3);
>    off = get_conf_long(d, where + PCI_MSIX_PBA);
>    printf("\t\tPBA: BAR=%d offset=%08x\n",
> -	 off & PCI_MSIX_BIR, off & ~PCI_MSIX_BIR);
> +	 off & PCI_MSIX_BIR, (off & ~PCI_MSIX_BIR) >> 3);
>  }
>  
>  static void


The code is correct as is, the register contains bits 31:3 of the
offset.  The spec states (PCI rev 3.0, 6.8.2.4, 6.8.2.5):

  The lower 3 Table BIR bits are masked off (set to zero) by software
  to form a 32-bit QWORD -aligned offset.

  The lower 3 PBA BIR bits are masked off (set to zero) by software to
  form a 32-bit QWORD-aligned offset.

Shifting is incorrect, the mask operation fills the lower 3 bits.
Thanks,

Alex
