Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D19C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 14:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0EB20684
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 14:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0EB20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbeKWB0o (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:26:44 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59127 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbeKWB0o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Nov 2018 20:26:44 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5AB8A20741; Thu, 22 Nov 2018 15:47:02 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 24ED1206D8;
        Thu, 22 Nov 2018 15:46:52 +0100 (CET)
Date:   Thu, 22 Nov 2018 15:46:51 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: armada8k: add support for gpio controlled reset
 signal
Message-ID: <20181122154651.223c62d9@windsurf>
In-Reply-To: <20181122154523.5aa652d4@windsurf>
References: <405efb21a4600efad10413fcf4c72aacce180125.1538570983.git.baruch@tkos.co.il>
        <20181122154523.5aa652d4@windsurf>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Thu, 22 Nov 2018 15:45:23 +0100, Thomas Petazzoni wrote:

> This should be:
> 
> 	if (!IS_ERR(pcie->reset_gpio))
> 
> Indeed, in the case of an error, pcie->reset_gpio will be non-NULL,
> with the error encoded as a ERR_PTR().

Meh, scrap that. If pcie->reset_gpio was an error, probe() has failed.
So by the time we are in armada8k_pcie_host_init(), pcie->reset_gpio is
either NULL or a valid GPIO. So my comment was stupid.

Since the newline thing is way too minor to require a new iteration:

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks, and sorry for the noise.

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
