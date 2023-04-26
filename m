Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EC1C7618E
	for <linux-pci@archiver.kernel.org>; Wed, 26 Apr 2023 08:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239678AbjDZINe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Apr 2023 04:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239499AbjDZINd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Apr 2023 04:13:33 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA81510F8;
        Wed, 26 Apr 2023 01:13:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vh2QehR_1682496808;
Received: from localhost(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0Vh2QehR_1682496808)
          by smtp.aliyun-inc.com;
          Wed, 26 Apr 2023 16:13:29 +0800
Date:   Wed, 26 Apr 2023 16:13:27 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     lukas@wunner.de, sdonthineni@nvidia.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wllenyj@linux.alibaba.com, wutu.xq2@linux.alibaba.com,
        gerry@linux.alibaba.com
Subject: Re: [PATCH] PCI: Mark NVIDIA T4 GPUs to avoid bus reset
Message-ID: <20230426081327.GA24855@L-PF27918B-1352.localdomain>
Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <388bc353a5f88edb502ec04c0dc53ab62a526020.1680090885.git.wuzongyong@linux.alibaba.com>
 <2dcebea53a6eb9bd212ec6d8974af2e5e0333ef6.1681129861.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dcebea53a6eb9bd212ec6d8974af2e5e0333ef6.1681129861.git.wuzongyong@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 10, 2023 at 08:34:11PM +0800, Wu Zongyong wrote:
> NVIDIA T4 GPUs do not work with SBR. This problem is found when the T4
> card is direct attached to a Root Port only. So avoid bus reset by
> marking T4 GPUs PCI_DEV_FLAGS_NO_BUS_RESET.
> 
> Fixes: 4c207e7121fa ("PCI: Mark some NVIDIA GPUs to avoid bus reset")
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 44cab813bf95..be86b93b9e38 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3618,7 +3618,7 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
>   */
>  static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
>  {
> -	if ((dev->device & 0xffc0) == 0x2340)
> +	if ((dev->device & 0xffc0) == 0x2340 || dev->device == 0x1eb8)
>  		quirk_no_bus_reset(dev);
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> -- 
> 2.34.3
Any further comments about this patch? 
