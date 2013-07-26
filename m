Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:56720 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758935Ab3GZRkA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jul 2013 13:40:00 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so4810199obb.22
        for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2013 10:40:00 -0700 (PDT)
Date: Fri, 26 Jul 2013 11:39:56 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: ethan zhao <ethan.zhao@oracle.com>
Cc: jbarnes@virtuousgeek.org, yinghai@kernel.org,
	linux-kernel@vger.kernel.org, ethan.kernel@gmail.com,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: MMCONFIG: cleanup and add address warning to
 pci_mmconfig_insert
Message-ID: <20130726173956.GA14078@google.com>
References: <51F23D0F.7090909@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <51F23D0F.7090909@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jiang, linux-pci, -cc bjorn.helgaas@hp.com (dead address)]

On Fri, Jul 26, 2013 at 05:10:39PM +0800, ethan zhao wrote:
> Cleanup the -EINVAL return value handling and add warning message
> for invalid
> start,end,addr parameters.
> 
> Signed-off-by: ethan.zhao <ethan.zhao@oracle.com>

This patch was corrupted, so I couldn't apply it directly.  See
Documentation/SubmittingPatches, sections 5-7.

> ---
>  arch/x86/pci/mmconfig-shared.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index 082e881..37f6c7f 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -700,8 +700,13 @@ int pci_mmconfig_insert(struct device *dev, u16
> seg, u8 start, u8 end,
>      if (!(pci_probe & PCI_PROBE_MMCONF) || pci_mmcfg_arch_init_failed)
>          return -ENODEV;
> 
> -    if (start > end)
> +    if (start > end || !addr) {
> +        dev_warn(dev, FW_WARN
> +                                 "Invalid address to add MMCONFIG"
> +                                 "start %02x end %02x addr %pR\n",
> +                                  start, end, addr);
>          return -EINVAL;
> +    }

I like the "!addr" cleanup.

Did you actually see this problem on a machine?

I expect this would be a BIOS bug, and one that should be found
early in development, long before a machine is released.
Therefore, I doubt that it's worth adding another printk for it.
If an end-user sees this problem, I think we'll already get a
generic message from check_segment().

I propose the patch below; what do you think?

> 
>      mutex_lock(&pci_mmcfg_lock);
>      cfg = pci_mmconfig_lookup(seg, start);
> @@ -716,11 +721,6 @@ int pci_mmconfig_insert(struct device *dev, u16
> seg, u8 start, u8 end,
>          return -EEXIST;
>      }
> 
> -    if (!addr) {
> -        mutex_unlock(&pci_mmcfg_lock);
> -        return -EINVAL;
> -    }
> -
>      rc = -EBUSY;
>      cfg = pci_mmconfig_alloc(seg, start, end, addr);
>      if (cfg == NULL) {



Author: ethan.zhao <ethan.zhao@oracle.com>
Date:   Fri Jul 26 11:21:24 2013 -0600

    x86/PCI: MMCONFIG: Check earlier for MMCONFIG region at address zero
    
    We can check for addr being zero earlier and thus avoid the mutex_unlock()
    cleanup path.
    
    [bhelgaas: changelog, drop printk]
    Signed-off-by: ethan.zhao <ethan.zhao@oracle.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Yinghai Lu <yinghai@kerne.org>

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 082e881..5596c7b 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -700,7 +700,7 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 	if (!(pci_probe & PCI_PROBE_MMCONF) || pci_mmcfg_arch_init_failed)
 		return -ENODEV;
 
-	if (start > end)
+	if (start > end || !addr)
 		return -EINVAL;
 
 	mutex_lock(&pci_mmcfg_lock);
@@ -716,11 +716,6 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 		return -EEXIST;
 	}
 
-	if (!addr) {
-		mutex_unlock(&pci_mmcfg_lock);
-		return -EINVAL;
-	}
-
 	rc = -EBUSY;
 	cfg = pci_mmconfig_alloc(seg, start, end, addr);
 	if (cfg == NULL) {
