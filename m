Return-Path: <SRS0=EObT=XV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12746C352A9
	for <linux-pci@archiver.kernel.org>; Thu, 26 Sep 2019 21:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F3722468
	for <linux-pci@archiver.kernel.org>; Thu, 26 Sep 2019 21:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569534263;
	bh=95lnWYTghHkknIGrqA3CpYvmc6veRK2JhKnP5lh+Vbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=pP+y4DwOXTiyfBwLiTOFDdvWgbMLcbc+efS4Rr5DdjpDsnt8k518WL53cbiz6FXtQ
	 XU1FlvkoGCETrCVTHwc/OAuyzGCBKKaMb8+RABWXqbcU0CQtf81VRfvc35KBLFO833
	 boBVY8XmlWHAOu8Sffb+yYQ2GLXWpo7EKrBquBsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfIZVoX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 26 Sep 2019 17:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfIZVoX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Sep 2019 17:44:23 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47C51222C2;
        Thu, 26 Sep 2019 21:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569534262;
        bh=95lnWYTghHkknIGrqA3CpYvmc6veRK2JhKnP5lh+Vbw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=asCa1xXlo1wJ09Dg1cbDBdJWb9moKWdDUS8lyLWf4a0ruoSefX/7KzIvR3yVHno3S
         2UJxv5UhRRNoxkA3JBoud8shJ4WyCTQVsOEzzxANGT0vlUX8veUMBY7cm3O1fNoq8i
         YYoQlSFapDgdexfIGlEcbrKaO3vNhSPYlkyPF79g=
Date:   Thu, 26 Sep 2019 16:44:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Megha Dey <megha.dey@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pci@vger.kernel.org, maz@kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, hpa@zytor.com,
        alex.williamson@redhat.com, jgg@mellanox.com, ashok.raj@intel.com,
        megha.dey@intel.com, jacob.jun.pan@intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Subject: Re: [RFC V1 6/7] ims-msi: Add APIs to allocate/free IMS interrupts
Message-ID: <20190926214412.GA197619@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568338328-22458-7-git-send-email-megha.dey@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 12, 2019 at 06:32:07PM -0700, Megha Dey wrote:
> This patch introduces APIs to allocate and free IMS interrupts.

> +int __dev_ims_alloc_irqs(struct device *dev, int nvec,
> +			 struct dev_ims_ops *ops,
> +			 struct irq_affinity *affd)

Should be static?  The only reference is in this file.
