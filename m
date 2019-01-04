Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49266C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 18:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212C521872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 18:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfADSop (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:44:45 -0500
Received: from smtprelay0093.hostedemail.com ([216.40.44.93]:46046 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726262AbfADSop (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 13:44:45 -0500
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jan 2019 13:44:44 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id DDB321802FA51
        for <linux-pci@vger.kernel.org>; Fri,  4 Jan 2019 18:38:02 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3F1EF1802FA29;
        Fri,  4 Jan 2019 18:38:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wish49_b837086a7342
X-Filterd-Recvd-Size: 2433
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri,  4 Jan 2019 18:37:59 +0000 (UTC)
Message-ID: <ddbf72a52cd5b6c5e2cba2c6f301d12be651e220.camel@perches.com>
Subject: Re: [PATCH 07/21] PCI: designware: Make use of IS_ALIGNED()
From:   Joe Perches <joe@perches.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 04 Jan 2019 10:37:57 -0800
In-Reply-To: <9b275993-c511-50d3-e18e-b421010c1bba@synopsys.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
         <20181221072716.29017-8-andrew.smirnov@gmail.com>
         <9b275993-c511-50d3-e18e-b421010c1bba@synopsys.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-01-02 at 09:33 +0000, Gustavo Pimentel wrote:
> On 21/12/2018 07:27, Andrey Smirnov wrote:
> > Make the intent a bit more clear as well as get rid of explicit
> > arithmetic by using IS_ALIGNED() to determine if "addr" is aligned to
> > "size". No functional change intended.
[]
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
[]
> > @@ -22,7 +22,7 @@
> >  
> >  int dw_pcie_read(void __iomem *addr, int size, u32 *val)
> >  {
> > -	if ((uintptr_t)addr & (size - 1)) {
> > +	if (!IS_ALIGNED((uintptr_t)addr, size)) {

The (uintptr_t) cast could probably be removed as well.

> > @@ -43,7 +43,7 @@ int dw_pcie_read(void __iomem *addr, int size, u32 *val)
> >  
> >  int dw_pcie_write(void __iomem *addr, int size, u32 val)
> >  {
> > -	if ((uintptr_t)addr & (size - 1))
> > +	if (!IS_ALIGNED((uintptr_t)addr, size))
> >  		return PCIBIOS_BAD_REGISTER_NUMBER;

here too

