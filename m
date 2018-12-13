Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A061FC67839
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714AA20870
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714AA20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbeLMMuY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:50:24 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59757 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729207AbeLMMuY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 07:50:24 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gXQRZ-0007n2-3n; Thu, 13 Dec 2018 13:50:21 +0100
Message-ID: <1544705420.3137.30.camel@pengutronix.de>
Subject: Re: [v2] PCI: imx: make msi work without pcieportbus
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 13 Dec 2018 13:50:20 +0100
In-Reply-To: <20181213123401.GA26763@red-moon>
References: <1544687042-16595-1-git-send-email-hongxing.zhu@nxp.com>
         <1544692768.3137.25.camel@pengutronix.de>
         <AM0PR0402MB35705EF0F4A77BD7B0AAFDDD8CA00@AM0PR0402MB3570.eurprd04.prod.outlook.com>
         <1544695636.3137.27.camel@pengutronix.de> <20181213123401.GA26763@red-moon>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Donnerstag, den 13.12.2018, 12:34 +0000 schrieb Lorenzo Pieralisi:
> On Thu, Dec 13, 2018 at 11:07:16AM +0100, Lucas Stach wrote:
> > Am Donnerstag, den 13.12.2018, 09:57 +0000 schrieb Richard Zhu:
> > > Hi Lucas:
> > > 
> > > > -----Original Message-----
> > > > > > From: Lucas Stach [mailto:l.stach@pengutronix.de]
> > > > 
> > > > Sent: 2018年12月13日 17:19
> > > > > > > > To: Richard Zhu <hongxing.zhu@nxp.com>; bhelgaas@google.com;
> > > > 
> > > > lorenzo.pieralisi@arm.com; andrew.smirnov@gmail.com
> > > > > > > > Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > > 
> > > > linux-kernel@vger.kernel.org
> > > > Subject: Re: [v2] PCI: imx: make msi work without pcieportbus
> > > > 
> > > > Hi Richard,
> > > > 
> > > > Am Donnerstag, den 13.12.2018, 08:02 +0000 schrieb Richard Zhu:
> > > > > MSI_EN of iMX PCIe RC would be asserted when PCIEPORTBUS driver is
> > > > > selected.
> > > > > Thus, the MSI works fine on iMX PCIe before.
> > > > > Assert it unconditionally when MSI is supported.
> > > > > Otherwise, the MSI wouldn't be triggered although the EP is present
> > > > > and the MSIs are assigned.
> > > > 
> > > > Thanks for digging into this issue. This seems like the right way forward.
> > > > However, did you test this with devices using legacy IRQs?
> > > > I.e. booting with "nomsi" on the kernel command line to see if legacy IRQs still
> > > > work if this bit is set, or if we need to avoid setting this when the user
> > > > explicitly requests to disable MSIs?
> > > > 
> > > > Regards,
> > > > Lucas
> > > > 
> > > 
> > > [Richard Zhu] Thanks for your review.
> > > The Legacy INTx is broken.
> > > The MSI_EN bit shouldn't be asserted when the user explicitly requests to disable MSIs.
> > 
> > Okay, so this patch should be extended with a check for
> > pci_msi_enabled() to see if the user explicitly want legacy IRQs.
> > 
> > > BTW, regarding to Baruch's comments, it seems that all the (IS_ENABLED(CONFIG_PCI_MSI) check in
> > >  the dwc host drivers are not required anymore, since the depends on PCI_MSI_IRQ_DOMAIN, right?
> > 
> > That's correct. This is mostly a historical artifact from the time when
> >  we were able to build without MSI support. Those checks could be
> > cleaned up now that we depend on the MSI options.
> 
> The question is whether we should really depend on PCI_MSI_IRQ_DOMAIN
> option, should we ?

It certainly cuts down on the combinatorial space when testing those
changes. IMHO this is a good thing, so as long as there is no
compelling reason for making this dependency configurable I'm totally
fine with keeping it the way it is now.

Regards,
Lucas
