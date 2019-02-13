Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDDDC282CA
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 14:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89064222B2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 14:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390064AbfBMOgw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:36:52 -0500
Received: from foss.arm.com ([217.140.101.70]:55276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730377AbfBMOgw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 09:36:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FD0380D;
        Wed, 13 Feb 2019 06:36:52 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73D603F557;
        Wed, 13 Feb 2019 06:36:49 -0800 (PST)
Date:   Wed, 13 Feb 2019 14:36:46 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alan Douglas <adouglas@cadence.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/15] PCI: pci-epf-test: Use pci_epc_get_features to get
 EPC features
Message-ID: <20190213143646.GC25260@e107981-ln.cambridge.arm.com>
References: <20190107064148.10152-1-kishon@ti.com>
 <20190107064148.10152-12-kishon@ti.com>
 <20190212150718.GA28306@e107981-ln.cambridge.arm.com>
 <6d72cfdf-97a7-4aab-f746-d0e545431ea2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d72cfdf-97a7-4aab-f746-d0e545431ea2@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 13, 2019 at 07:08:18PM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 12/02/19 8:37 PM, Lorenzo Pieralisi wrote:
> > On Mon, Jan 07, 2019 at 12:11:44PM +0530, Kishon Vijay Abraham I wrote:
> > 
> > [...]
> > 
> >>  static int pci_epf_test_bind(struct pci_epf *epf)
> >>  {
> >>  	int ret;
> >>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> >>  	struct pci_epf_header *header = epf->header;
> >> +	const struct pci_epc_features *epc_features;
> >> +	enum pci_barno test_reg_bar = BAR_0;
> >>  	struct pci_epc *epc = epf->epc;
> >>  	struct device *dev = &epf->dev;
> >> +	bool linkup_notifier = false;
> >> +	bool msix_capable = false;
> >> +	bool msi_capable = true;
> >>  
> >>  	if (WARN_ON_ONCE(!epc))
> >>  		return -EINVAL;
> >>  
> >> -	if (epc->features & EPC_FEATURE_NO_LINKUP_NOTIFIER)
> >> -		epf_test->linkup_notifier = false;
> >> -	else
> >> -		epf_test->linkup_notifier = true;
> >> -
> >> -	epf_test->msix_available = epc->features & EPC_FEATURE_MSIX_AVAILABLE;
> >> +	epc_features = pci_epc_get_features(epc, epf->func_no);
> > 
> > I think it would work out better if struct pci_epc_features was
> > allocated in the caller (stack) and pci_epc_get_features() take a
> > pointer parameter to it rather than the callee and the callee would just
> > have to fill it out, this also removes data in the driver that is not
> > really useful.
> > 
> > Is there any other reason behind the current design choice ?
> 
> Some drivers are used by multiple platforms each with different features. In
> such cases it's cleaner to have separate epc_feature table for each platform.
> 
> I think the driver should maintain some sort of data to even populate
> pci_epc_features allocated by EP function driver.

You mean that every EP controller driver should keep a table of
pci_epc_features (instead of a single instance) to be matched using DT
compatible strings to detect the platform variations ?

Thanks,
Lorenzo
