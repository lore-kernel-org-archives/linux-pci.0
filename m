Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67080C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 14:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF982175B
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 14:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfDWO5X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:57:23 -0400
Received: from 8bytes.org ([81.169.241.247]:37152 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbfDWO5X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 10:57:23 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7EDB328C; Tue, 23 Apr 2019 16:57:21 +0200 (CEST)
Date:   Tue, 23 Apr 2019 16:57:21 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
Message-ID: <20190423145721.GH29810@8bytes.org>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
 <20190418234828.GG126710@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418234828.GG126710@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 18, 2019 at 06:48:28PM -0500, Bjorn Helgaas wrote:
> To make progress on this, I think we need an ack from Joerg for the
> dma-iommu.c part, an ack from Ray or Scott for the pcie-iproc.c part,
> and an ack from Robin for the thing as a whole.

I wait for Robin to review the dma-iommu change. If he is okay with it,
I am too.


	Joerg
