Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC877C43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 11:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B982721903
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 11:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfBSLKh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:10:37 -0500
Received: from foss.arm.com ([217.140.101.70]:43750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfBSLKh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Feb 2019 06:10:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F23EA78;
        Tue, 19 Feb 2019 03:10:36 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4B313F720;
        Tue, 19 Feb 2019 03:10:29 -0800 (PST)
Date:   Tue, 19 Feb 2019 11:10:27 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Don't deassert reset GPIO during probe
Message-ID: <20190219111027.GB14696@e107981-ln.cambridge.arm.com>
References: <20190125232616.25714-1-bjorn.andersson@linaro.org>
 <20190213152352.GB417@e107981-ln.cambridge.arm.com>
 <20190219051602.GB13018@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219051602.GB13018@tuxbook-pro>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 18, 2019 at 09:16:03PM -0800, Bjorn Andersson wrote:
> On Wed 13 Feb 07:23 PST 2019, Lorenzo Pieralisi wrote:
> 
> > On Fri, Jan 25, 2019 at 03:26:16PM -0800, Bjorn Andersson wrote:
> > > Acquiring the reset GPIO low means that reset is being deasserted, this
> > > is followed almost immediately with qcom_pcie_host_init() asserting it,
> > > initializing it and then finally deasserting it again, for the link to
> > > come up.
> > > 
> > > Some PCIe devices requires a minimum time between the initial deassert
> > > and subsequent reset cycles. In a platform that boots with the reset
> > > GPIO asserted this requirement is being violated by this deassert/assert
> > > pulse.
> > > 
> > > Acquiring the reset GPIO high will prevent this by matching the state to
> > > the subsequent asserted state.
> > > 
> > > Cc: stable@vger.kernel.org
> > 
> > Missing Fixes: tag, please provide me one so that I can proceed.
> > 
> 
> This applies to the original commit introducing this driver, so:
> 
> Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")

Applied to pci/dwc for v5.1, thanks.

Lorenzo
