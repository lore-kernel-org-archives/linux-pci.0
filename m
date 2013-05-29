Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35468 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966734Ab3E2Utf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 May 2013 16:49:35 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so26760397iet.28
        for <linux-pci@vger.kernel.org>; Wed, 29 May 2013 13:49:35 -0700 (PDT)
Date: Wed, 29 May 2013 14:49:31 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <liuj97@gmail.com>
Subject: Re: [PATCH] PCI: fix trivial typo for PCI_EXP_LNKCAP_CLKPM
Message-ID: <20130529204931.GA26388@google.com>
References: <1369818112-33136-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369818112-33136-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 29, 2013 at 05:01:52PM +0800, Yijing Wang wrote:
> Fix trivial typo for PCI_EXP_LNKCAP_CLKPM comment.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  include/uapi/linux/pci_regs.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied to pci/misc for v3.11, thanks!

> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 864e324..c3cc01d 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -468,7 +468,7 @@
>  #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
>  #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
>  #define  PCI_EXP_LNKCAP_L1EL	0x00038000 /* L1 Exit Latency */
> -#define  PCI_EXP_LNKCAP_CLKPM	0x00040000 /* L1 Clock Power Management */
> +#define  PCI_EXP_LNKCAP_CLKPM	0x00040000 /* Clock Power Management */
>  #define  PCI_EXP_LNKCAP_SDERC	0x00080000 /* Surprise Down Error Reporting Capable */
>  #define  PCI_EXP_LNKCAP_DLLLARC	0x00100000 /* Data Link Layer Link Active Reporting Capable */
>  #define  PCI_EXP_LNKCAP_LBNC	0x00200000 /* Link Bandwidth Notification Capability */
> -- 
> 1.7.1
> 
> 
