Return-Path: <SRS0=CmBN=TB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DDFC43219
	for <linux-pci@archiver.kernel.org>; Wed,  1 May 2019 20:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E2D2089E
	for <linux-pci@archiver.kernel.org>; Wed,  1 May 2019 20:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556742603;
	bh=FFlQNDcccWY3yLhO/2pA8tJnKdcjTJ2P5Agp451sZmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nKP6ilHdI+tlDt8JsevGurry8xv7ggeNs//AXnm6LnzKWTVzpBbGjE2SvwZWyx35H
	 9jCWVzoYJ1zcMfJP0lh2LyaE7PhfxKSjvk5RT84+nFOfo3IUENTMU8r9xVSVhUPA4K
	 Zf2l5XLEaNRO49zEO5jbcgZzTZW0xUASnQQ5juFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfEAUaC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 1 May 2019 16:30:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfEAUaC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 May 2019 16:30:02 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4761920656;
        Wed,  1 May 2019 20:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556742601;
        bh=FFlQNDcccWY3yLhO/2pA8tJnKdcjTJ2P5Agp451sZmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xn0EE/TMU2NjvjhfJSPEdZ1eCtgKVWC7tcAkjCJ0+tUDrVdRj43iGaRqYIHzFE7vl
         c/ySR1MYAKu9T6+dTYe/xCB4140GW8LGyKue+dgtNyMGfKUWw4J8PvzzwEkNfSerBz
         roeYfRd8MQ5ZYEBmM2c4r+aaSpyHh11pF+oQUSBw=
Date:   Wed, 1 May 2019 15:30:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     mr.nuke.me@gmail.com, linux-pci@vger.kernel.org,
        austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/LINK: Account for BW notification in vector
 calculation
Message-ID: <20190501203000.GA47079@google.com>
References: <155597243666.19387.1205950870601742062.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155597243666.19387.1205950870601742062.stgit@gimli.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 22, 2019 at 04:43:30PM -0600, Alex Williamson wrote:
> On systems that don't support any PCIe services other than bandwidth
> notification, pcie_message_numbers() can return zero vectors, causing
> the vector reallocation in pcie_port_enable_irq_vec() to retry with
> zero, which fails, resulting in fallback to INTx (which might be
> broken) for the bandwidth notification service.  This can resolve
> spurious interrupt faults due to this service on some systems.
> 
> Fixes: e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth notification")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Applied for (hopefully) v5.1, thanks!

>  drivers/pci/pcie/portdrv_core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 7d04f9d087a6..1b330129089f 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -55,7 +55,8 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
>  	 * 7.8.2, 7.10.10, 7.31.2.
>  	 */
>  
> -	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
> +	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
> +		    PCIE_PORT_SERVICE_BWNOTIF)) {
>  		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
>  		*pme = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
>  		nvec = *pme + 1;
> 
