Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F4DC43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 20:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D57218D4
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 20:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553115158;
	bh=KhM59fq0xMcxfrPWegt3eJ/Pj0d60Y1W4KnA/CcsvYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jv3ScWBrHddt69YviuGzfZROg2/pjCDDY8LRaLLsp+0Uk/uXumxVCRH6jEH1uekT2
	 Z0XPDfmN5BjyTSE+LIz/3GHI+OHOxIcBSqPVOdqnbXDgkA+WvEYwrQDNiXa2loLDcZ
	 QP6oQrgUwmHDmjyS74a+oiP9g9luvnnbTWIJXeZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfCTUwh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfCTUwh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Mar 2019 16:52:37 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D69218C3;
        Wed, 20 Mar 2019 20:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553115155;
        bh=KhM59fq0xMcxfrPWegt3eJ/Pj0d60Y1W4KnA/CcsvYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyDrQ2lfJ8reyDeVFxG2UYbgulcfBgBQjpYvufZ2RV6cy+pjwJbUMsFoNTdVjApwN
         jDY9JaM8KVc79RTb5fJL8rQzvLsszooOxN0bvFh1eOrevnb3ePnut9xH7zaBmP/Y0G
         3fhjWZwYWmNEQFSpCIKQYz1zDaPa8Ncz0j6sPHVE=
Date:   Wed, 20 Mar 2019 15:52:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jon Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v3] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20190320205233.GE251185@google.com>
References: <20190222194808.15962-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222194808.15962-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jon, Jens, Christoph, Sagi, Linus, linux-nvme from related discussion]
[+cc Greg, Oliver, who responded to v2 of this patch]

On Fri, Feb 22, 2019 at 01:48:06PM -0600, Alexandru Gagniuc wrote:
> A SURPRISE removal of a hotplug PCIe device, caused by a Link Down
> event will execute an orderly removal of the driver, which normally
> includes releasing the IRQs with pci_free_irq(_vectors):
> 
>  * SURPRISE removal event causes Link Down
>  * pciehp_disable_slot()
>  * pci_device_remove()
>  * driver->remove()
>  * pci_free_irq(_vectors)()
>  * irq_chip->irq_mask()
>  * pci_msi_mask_irq()
> 
> Eventually, msi_set_mask_bit() will attempt to do MMIO over the dead
> link, usually resulting in an Unsupported Request error. This can
> confuse the firmware on FFS machines, and lead to a system crash.
> 
> Since the channel will have been marked "pci_channel_io_perm_failure"
> by the hotplug thread, we know we should avoid sending blind IO to a
> dead link.
> When the device is disconnected, bail out of MSI teardown.
> 
> If device removal and Link Down are independent events, there exists a
> race condition when the Link Down event occurs right after the
> pci_dev_is_disconnected() check. This is outside the scope of this patch.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

I had actually applied this to pci/msi with the intent of merging it
for v5.1, but by coincidence I noticed [1], where Jon was basically
solving another piece of the same problem, this time in nvme-pci.

AFAICT, the consensus there was that it would be better to find some
sort of platform solution instead of dealing with it in individual
drivers.  The PCI core isn't really a driver, but I think the same
argument applies to it: if we had a better way to recover from readl()
errors, that way would work equally well in nvme-pci and the PCI core.

It sounds like the problem has two parts: the PCI core part and the
individual driver part.  Solving only the first (eg, with this patch)
isn't enough by itself, and solving the second via some platform
solution would also solve the first.  If that's the case, I don't
think it's worth applying this one, but please correct me if I'm
wrong.

Bjorn

[1] https://lore.kernel.org/lkml/20190222010502.2434-1-jonathan.derrick@intel.com/T/#u

> ---
> Changes since v2:
>  * Updated commit message
> 
>  drivers/pci/msi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 4c0b47867258..6b6541ab264f 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -227,6 +227,9 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
>  {
>  	struct msi_desc *desc = irq_data_get_msi_desc(data);
>  
> +	if (pci_dev_is_disconnected(msi_desc_to_pci_dev(desc)))
> +		return;
> +
>  	if (desc->msi_attrib.is_msix) {
>  		msix_mask_irq(desc, flag);
>  		readl(desc->mask_base);		/* Flush write to device */
> -- 
> 2.19.2
> 
