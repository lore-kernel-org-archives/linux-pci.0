Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43C3C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 14:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FA620684
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 14:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FA620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbeKWBZP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:25:15 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59061 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbeKWBZP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Nov 2018 20:25:15 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 258DE20741; Thu, 22 Nov 2018 15:45:34 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id DF5F9206D8;
        Thu, 22 Nov 2018 15:45:23 +0100 (CET)
Date:   Thu, 22 Nov 2018 15:45:23 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: armada8k: add support for gpio controlled reset
 signal
Message-ID: <20181122154523.5aa652d4@windsurf>
In-Reply-To: <405efb21a4600efad10413fcf4c72aacce180125.1538570983.git.baruch@tkos.co.il>
References: <405efb21a4600efad10413fcf4c72aacce180125.1538570983.git.baruch@tkos.co.il>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Baruch,

Sorry for the delayed review.

On Wed,  3 Oct 2018 15:49:43 +0300, Baruch Siach wrote:

>  #define PCIE_VENDOR_REGS_OFFSET		0x8000
> @@ -137,6 +139,12 @@ static int armada8k_pcie_host_init(struct pcie_port *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct armada8k_pcie *pcie = to_armada8k_pcie(pci);
>  
> +	if (pcie->reset_gpio) {

This should be:

	if (!IS_ERR(pcie->reset_gpio))

Indeed, in the case of an error, pcie->reset_gpio will be non-NULL,
with the error encoded as a ERR_PTR().

> +		/* assert and then deassert the reset signal */
> +		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> +		msleep(100);
> +		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> +	}
>	dw_pcie_setup_rc(pp);

An empty new line here would be good before the dw_pcie_setup_rc() call.

If you send a new iteration with those two issues fixed, you can
directly add my

  Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
