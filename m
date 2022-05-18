Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEE9C433EF
	for <linux-pci@archiver.kernel.org>; Wed, 18 May 2022 13:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbiERNYJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 18 May 2022 09:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbiERNYH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 09:24:07 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A98A14AF58;
        Wed, 18 May 2022 06:24:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D137268AFE; Wed, 18 May 2022 15:23:58 +0200 (CEST)
Date:   Wed, 18 May 2022 15:23:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
        hch@lst.de, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, svarbanov@mm-sol.com,
        bjorn.andersson@linaro.org, axboe@fb.com,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
        linux-pm@vger.kernel.org, rafael@kernel.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>
Subject: Re: [PATCH v2 3/3] PCI: qcom: Add system PM support
Message-ID: <20220518132358.GA26902@lst.de>
References: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org> <20220518131913.26974-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518131913.26974-4-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 18, 2022 at 06:49:13PM +0530, Manivannan Sadhasivam wrote:
> From: Prasad Malisetty <quic_pmaliset@quicinc.com>
> 
> Add suspend and resume callbacks to handle system suspend and resume in
> the Qcom PCIe controller driver. When the system suspends, PME turnoff
> message will be sent to the device and the RC driver will wait for the
> device to enter L23 Ready state. After that, the PHY will be powered down
> and clocks/regulators will be disabled.

So what about just not doing this stupid power disabling to start
with?  Unlike x86 where we do not have choice due to the BIOS, we
apparently do here.  And disabling power is the wrong thing to do at
least for SSDs as it massively increases the wear on the NAND.
