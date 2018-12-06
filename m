Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D223CC04EB8
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 15:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3EA208E7
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 15:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3EA208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbeLFPui (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:50:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60819 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeLFPuh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Dec 2018 10:50:37 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gUvv6-0003nm-Oa; Thu, 06 Dec 2018 16:50:32 +0100
Message-ID: <1544111431.3709.70.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: controller: dwc: Make PCI_IMX6 depend on
 PCIEPORTBUS
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robert Hancock <hancock@sedsystems.ca>,
        Baruch Siach <baruch@tkos.co.il>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pci@vger.kernel.org, "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, bhelgaas@google.com,
        Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
        Trent Piepho <tpiepho@impinj.com>
Date:   Thu, 06 Dec 2018 16:50:31 +0100
In-Reply-To: <5a3543f2-fe58-221d-694f-0f98a643edfc@sedsystems.ca>
References: <20181206074555.19579-1-andrew.smirnov@gmail.com>
         <87o99zjcsc.fsf@tkos.co.il>
         <5a3543f2-fe58-221d-694f-0f98a643edfc@sedsystems.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Donnerstag, den 06.12.2018, 09:45 -0600 schrieb Robert Hancock:
> On 2018-12-06 2:10 a.m., Baruch Siach wrote:
> > Hi Andrey,
> > 
> > Adding Robert Hancock who reported[1] on a PCIe MSI issue with i.MX6.
> > 
> > Andrey Smirnov writes:
> > 
> > > Building a kernel with CONFIG_PCI_IMX6=y, but CONFIG_PCIEPORTBUS=n
> > > produces a system where built-in PCIE bridge (16c3:abcd) isn't bound
> > > to pcieport driver. This, in turn, results in a PCIE bus that is
> > > capable of enumerating attached PCIE device, but lacks functional
> > > interrupt support.
> > 
> > Robert, does that fix your issue?
> 
> Unfortunately, no.. in fact the situation on my setup is even worse with
> CONFIG_PCIEPORTBUS enabled: Not only does MSI still not function, but
> now INTx interrupts are somehow broken as well - no interrupts are
> received. The IRQ information shown in /proc/interrupts is correct, but
> the count remains stubbornly at 0.

That's expected. The port services will use an MSI IRQ when available
and due to a design issue with the DWC PCIe it will not forward any
legacy IRQs if any MSI is in use. If any of the PCIe devices in your
system are unable to work with MSI IRQs, you must boot with "nomsi" on
the kernel command line set.

Regards,
Lucas
