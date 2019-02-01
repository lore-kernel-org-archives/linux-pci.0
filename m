Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71108C282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 16:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431D421726
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 16:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfBAQoE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:44:04 -0500
Received: from 8bytes.org ([81.169.241.247]:36746 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfBAQoE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Feb 2019 11:44:04 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 197B8273; Fri,  1 Feb 2019 17:44:02 +0100 (CET)
Date:   Fri, 1 Feb 2019 17:44:01 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/9] iommu/vt-d: Allow interrupts from the entire bus for
 aliased devices
Message-ID: <20190201164401.GT32526@8bytes.org>
References: <20190131185656.17972-1-logang@deltatee.com>
 <20190131185656.17972-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131185656.17972-2-logang@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 31, 2019 at 11:56:48AM -0700, Logan Gunthorpe wrote:
> @@ -394,6 +402,10 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
>  		set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
>  			     PCI_DEVID(PCI_BUS_NUM(data.alias),
>  				       dev->bus->number));
> +	else if (data.count >= 2 && data.busmatch_count == data.count)
> +		set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
> +			     PCI_DEVID(dev->bus->number,
> +				       dev->bus->number));

The dev->bus->number argument for the devfn parameter of PCI_DEVID is
not needed, right?

Also, this requires at least a comment to document that special case.


	Joerg
