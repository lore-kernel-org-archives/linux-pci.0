Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D466DC77B76
	for <linux-pci@archiver.kernel.org>; Fri, 21 Apr 2023 13:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjDUN5L (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Apr 2023 09:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjDUN5I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 09:57:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CA512CBF;
        Fri, 21 Apr 2023 06:57:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87EA564795;
        Fri, 21 Apr 2023 13:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D917C433EF;
        Fri, 21 Apr 2023 13:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682085424;
        bh=e4U8UcCnuQe9qK5zrQRyCA8GFdhXfIe3xEtkGJiQxgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mID2DOQkeE9+tzSJk3PVT4RBMNVo7lFp7VIZX/FuC4iNbqmjjTXPl2sU6wxI2UCRT
         JX4rYQOSF6ut0b8ebtHEXW7Ba3xrn41soyWesonkUOA/fiP0DoEgGTEy6gO6WOsKHm
         lf9d6PXX6I9dlZcYWgWD2kyuzEgFizmIWq+P/cz+I9dsiAW7kBerOPaqhYtZ/onKXd
         DPm1+CUh2Np9yQYnx9cnQ3BNA0+gtT8agPvLXwG35JG55X016snV1I3XdurRtgLzJJ
         PgCyGaOVUgEcYYULB0dmvK16lZYO/+CJosIIVn/8UxZIKswr1Le749/jQRv6oEDyBD
         9dDhVU6o8iQnA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     kw@linux.com, mani@kernel.org, kishon@kernel.org,
        bhelgaas@google.com,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Frank Li <Frank.Li@nxp.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v12] PCI: endpoint: functions/pci-epf-test: Fix dma_chan direction
Date:   Fri, 21 Apr 2023 15:56:57 +0200
Message-Id: <168208540072.95607.10228594188538839512.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412063447.2841177-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230412063447.2841177-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 12 Apr 2023 15:34:47 +0900, Yoshihiro Shimoda wrote:
> In the pci_epf_test_init_dma_chan(), epf_test->dma_chan_rx
> is assigned from dma_request_channel() with DMA_DEV_TO_MEM as
> filter.dma_mask. However, in the pci_epf_test_data_transfer(),
> if the dir is DMA_DEV_TO_MEM, it should use epf->dma_chan_rx,
> but it used epf_test->dma_chan_tx. So, fix it. Otherwise,
> results of pcitest with enabled DMA will be "NOT OKAY" on eDMA
> environment.
> 
> [...]

Applied to controller/endpoint, thanks!

[1/1] PCI: endpoint: functions/pci-epf-test: Fix dma_chan direction
      https://git.kernel.org/pci/pci/c/604de32d55a2

Thanks,
Lorenzo
