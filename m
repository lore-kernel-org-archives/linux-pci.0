Return-Path: <SRS0=N/Da=QW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10027C43381
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 10:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0CC21B1A
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 10:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfBOKNP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:13:15 -0500
Received: from foss.arm.com ([217.140.101.70]:57558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfBOKNP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Feb 2019 05:13:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87995A78;
        Fri, 15 Feb 2019 02:13:14 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B20E3F557;
        Fri, 15 Feb 2019 02:13:12 -0800 (PST)
Date:   Fri, 15 Feb 2019 10:13:09 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/20] i.MX6, DesignWare PCI improvements
Message-ID: <20190215101309.GB26061@e107981-ln.cambridge.arm.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
 <20190201162729.GA22030@e107981-ln.cambridge.arm.com>
 <CAHQ1cqENSb0ORrcN0Qh93DGx1C7AVxSqAKhcfJH2qZ8+WuVH+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqENSb0ORrcN0Qh93DGx1C7AVxSqAKhcfJH2qZ8+WuVH+g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 14, 2019 at 04:59:04PM -0800, Andrey Smirnov wrote:

[...]

> > @Lucas: May I ask you to consider please which patches you deem
> > worth for inclusion ? I will have a look too but I would be grateful
> > if the driver maintainers can chime in to help.
> >
> 
> Lorenzo, can you apply the dwc specific patches that are already
> reviewed by Gustavo Pimentel from this series, to keep things moving
> while we are waiting on Lucas? I can also spin them out into a
> separate series if that's perferable.

Yes I can apply them, provided I can cherry-pick them from the series,
otherwise I would ask you please to create a series out of them and send
it so that I can proceed.

Thanks,
Lorenzo
