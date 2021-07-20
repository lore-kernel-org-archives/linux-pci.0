Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF19C07E95
	for <linux-pci@archiver.kernel.org>; Tue, 20 Jul 2021 07:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B4061165
	for <linux-pci@archiver.kernel.org>; Tue, 20 Jul 2021 07:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhGTHKQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Jul 2021 03:10:16 -0400
Received: from verein.lst.de ([213.95.11.211]:54106 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229825AbhGTHJu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jul 2021 03:09:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 638E16736F; Tue, 20 Jul 2021 09:50:25 +0200 (CEST)
Date:   Tue, 20 Jul 2021 09:50:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2] genirq/affinity: add helper of
 irq_affinity_calc_sets
Message-ID: <20210720075025.GA17565@lst.de>
References: <20210720044209.851141-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720044209.851141-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +int irq_affinity_calc_sets(unsigned int affvecs, struct irq_affinity *affd)
> +{
> +	/*
> +	 * Simple invocations do not provide a calc_sets() callback. Call
> +	 * the generic one.
> +	 */
> +	if (!affd->calc_sets)
> +		default_calc_sets(affd, affvecs);
> +	else
> +		affd->calc_sets(affd, affvecs);

Nit: avoid pointless negations:

	if (affd->calc_sets)
		affd->calc_sets(affd, affvecs);
	else
		default_calc_sets(affd, affvecs);

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
