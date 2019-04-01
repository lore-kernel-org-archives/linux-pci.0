Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6315FC43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 11:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359FF20870
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 11:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfDALM6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:12:58 -0400
Received: from foss.arm.com ([217.140.101.70]:32786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDALM6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Apr 2019 07:12:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6928A78;
        Mon,  1 Apr 2019 04:12:57 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CC9B3F557;
        Mon,  1 Apr 2019 04:12:57 -0700 (PDT)
Date:   Mon, 1 Apr 2019 12:12:52 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5] PCI: qcom: Use default config space read function
Message-ID: <20190401111252.GA32099@e107981-ln.cambridge.arm.com>
References: <9c5a7620-e9ed-82d6-0708-34fe33e39030@linaro.org>
 <29d33e81-fe8d-7fd9-843d-cc53ea6c9586@free.fr>
 <a53911a5-198a-5073-59cf-a61ba067bfd8@free.fr>
 <eb1d808e-00aa-5411-be03-2a1a8c8d655a@mm-sol.com>
 <8cd24928-54d0-c320-b53f-08332d434477@free.fr>
 <f142da4d-303a-89f3-ba5a-b6800d613e15@free.fr>
 <df27f753-9464-02c0-b621-d5d7b54a3403@mm-sol.com>
 <66ae38dc-1c0c-5a76-be23-fb87db90b327@free.fr>
 <20190329163808.GB8768@e107981-ln.cambridge.arm.com>
 <891b4d8a-f353-993e-62d1-1c1d3c749b4c@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <891b4d8a-f353-993e-62d1-1c1d3c749b4c@free.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 01, 2019 at 12:39:33PM +0200, Marc Gonzalez wrote:
> On 29/03/2019 17:38, Lorenzo Pieralisi wrote:
> 
> > On Mon, Mar 25, 2019 at 04:42:55PM +0100, Marc Gonzalez wrote:
> >
> >> Move the device class fudge to a proper fixup function, and remove
> >> qcom_pcie_rd_own_conf() which has become useless.
> >>
> >> NB: dw_pcie_setup_rc() already did the right thing, but it's broken
> >> on older qcom chips, such as 8064.
> >>
> >> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> >> ---
> >> Changes from v4 to v5: Apply fixup to all qcom chips, the same way it was before
> >> (thus the code remains functionally equivalent)
> >> Drop Srinivas' Tested-by tag because of the change
> >> ---
> >>  drivers/pci/controller/dwc/pcie-qcom.c | 23 ++++++-----------------
> >>  1 file changed, 6 insertions(+), 17 deletions(-)
> > 
> > Applied to pci/dwc for v5.2, thanks.
> 
> Thanks!
> 
> Do you push to linux-next? (The patch is not in next-20190401)

Bjorn will push it into linux-next in due course.

Thanks,
Lorenzo
