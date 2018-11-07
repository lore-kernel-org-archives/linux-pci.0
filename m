Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B36C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 23:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DFA20883
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 23:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDVlyMS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DFA20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeKHJPm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 04:15:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbeKHJPm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Nov 2018 04:15:42 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5746C20882;
        Wed,  7 Nov 2018 23:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541634179;
        bh=Z8YQ3I2qLt+41BXs33mAuHv0KaiQsmjD2qPWvfRS8tQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SDVlyMS5KczWmAeUglJGxVaDMRfs2U9Sg06uVAwgd4GYC8KyKIutEIXntxq5m69XT
         VI1Ma8+Le4aCz8n6aPM1a0Y6nPJ++HZE1PgGJJS9NU2KS/rpYPA6+Up7uPeVNe1QsW
         IkafT7+N8qKrbrUU2yWbxNLXcrMkQbAWeDE9Xm4U=
Date:   Wed, 7 Nov 2018 17:42:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     linux-pci@vger.kernel.org, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20181107234257.GC41183@google.com>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918221501.13112-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 18, 2018 at 05:15:00PM -0500, Alexandru Gagniuc wrote:
> When a PCI device is gone, we don't want to send IO to it if we can
> avoid it. We expose functionality via the irq_chip structure. As
> users of that structure may not know about the underlying PCI device,
> it's our responsibility to guard against removed devices.
> 
> .irq_write_msi_msg() is already guarded inside __pci_write_msi_msg().
> .irq_mask/unmask() are not. Guard them for completeness.
> 
> For example, surprise removal of a PCIe device triggers teardown. This
> touches the irq_chips ops some point to disable the interrupts. I/O
> generated here can crash the system on firmware-first machines.
> Not triggering the IO in the first place greatly reduces the
> possibility of the problem occurring.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

Applied to pci/misc for v4.21, thanks!

> ---
>  drivers/pci/msi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index f2ef896464b3..f31058fd2260 100644
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
> 2.17.1
> 
