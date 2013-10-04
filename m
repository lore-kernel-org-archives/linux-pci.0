Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33685 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326Ab3JDRj4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2013 13:39:56 -0400
Received: by mail-ie0-f179.google.com with SMTP id e14so9407102iej.24
        for <linux-pci@vger.kernel.org>; Fri, 04 Oct 2013 10:39:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1378974000-13168-1-git-send-email-wangyijing@huawei.com>
References: <1378974000-13168-1-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 4 Oct 2013 11:39:36 -0600
Message-ID: <CAErSpo5VjnPiscS5it3NLx9fC7dTaxbOZ-NwGeWSP3svZarBAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: remove unused "deprecated" macro PCI_MSIX_FLAGS_BIRMASK
To: Yijing Wang <wangyijing@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 12, 2013 at 2:20 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> PCI_MSIX_FLAGS_BIRMASK has been replaced by PCI_MSIX_TABLE_BIR
> for better readability. Now no one uses it, remove it.
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Applied, thanks!

> ---
>  include/uapi/linux/pci_regs.h |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index baa7852..f050914 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -319,7 +319,6 @@
>  #define PCI_MSIX_PBA           8       /* Pending Bit Array offset */
>  #define  PCI_MSIX_PBA_BIR      0x00000007 /* BAR index */
>  #define  PCI_MSIX_PBA_OFFSET   0xfffffff8 /* Offset into specified BAR */
> -#define  PCI_MSIX_FLAGS_BIRMASK        (7 << 0)   /* deprecated */
>  #define PCI_CAP_MSIX_SIZEOF    12      /* size of MSIX registers */
>
>  /* MSI-X entry's format */
> --
> 1.7.1
>
>
