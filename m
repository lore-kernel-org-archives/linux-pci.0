Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528FFC67839
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 12:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFCD20849
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 12:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFCD20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeLMMdW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:33:22 -0500
Received: from foss.arm.com ([217.140.101.70]:60858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbeLMMdW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 07:33:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81326A78;
        Thu, 13 Dec 2018 04:33:21 -0800 (PST)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 298E23F575;
        Thu, 13 Dec 2018 04:33:20 -0800 (PST)
Date:   Thu, 13 Dec 2018 12:34:01 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [v2] PCI: imx: make msi work without pcieportbus
Message-ID: <20181213123401.GA26763@red-moon>
References: <1544687042-16595-1-git-send-email-hongxing.zhu@nxp.com>
 <1544692768.3137.25.camel@pengutronix.de>
 <AM0PR0402MB35705EF0F4A77BD7B0AAFDDD8CA00@AM0PR0402MB3570.eurprd04.prod.outlook.com>
 <1544695636.3137.27.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544695636.3137.27.camel@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 13, 2018 at 11:07:16AM +0100, Lucas Stach wrote:
> Am Donnerstag, den 13.12.2018, 09:57 +0000 schrieb Richard Zhu:
> > Hi Lucas:
> > 
> > > -----Original Message-----
> > > > > From: Lucas Stach [mailto:l.stach@pengutronix.de]
> > > Sent: 2018年12月13日 17:19
> > > > > > > To: Richard Zhu <hongxing.zhu@nxp.com>; bhelgaas@google.com;
> > > lorenzo.pieralisi@arm.com; andrew.smirnov@gmail.com
> > > > > > > Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [v2] PCI: imx: make msi work without pcieportbus
> > > 
> > > Hi Richard,
> > > 
> > > Am Donnerstag, den 13.12.2018, 08:02 +0000 schrieb Richard Zhu:
> > > > MSI_EN of iMX PCIe RC would be asserted when PCIEPORTBUS driver is
> > > > selected.
> > > > Thus, the MSI works fine on iMX PCIe before.
> > > > Assert it unconditionally when MSI is supported.
> > > > Otherwise, the MSI wouldn't be triggered although the EP is present
> > > > and the MSIs are assigned.
> > > 
> > > Thanks for digging into this issue. This seems like the right way forward.
> > > However, did you test this with devices using legacy IRQs?
> > > I.e. booting with "nomsi" on the kernel command line to see if legacy IRQs still
> > > work if this bit is set, or if we need to avoid setting this when the user
> > > explicitly requests to disable MSIs?
> > > 
> > > Regards,
> > > Lucas
> > > 
> > 
> > [Richard Zhu] Thanks for your review.
> > The Legacy INTx is broken.
> > The MSI_EN bit shouldn't be asserted when the user explicitly requests to disable MSIs.
> 
> Okay, so this patch should be extended with a check for
> pci_msi_enabled() to see if the user explicitly want legacy IRQs.
> 
> > BTW, regarding to Baruch's comments, it seems that all the (IS_ENABLED(CONFIG_PCI_MSI) check in
> >  the dwc host drivers are not required anymore, since the depends on PCI_MSI_IRQ_DOMAIN, right?
> 
> That's correct. This is mostly a historical artifact from the time when
>  we were able to build without MSI support. Those checks could be
> cleaned up now that we depend on the MSI options.

The question is whether we should really depend on PCI_MSI_IRQ_DOMAIN
option, should we ?

Lorenzo
