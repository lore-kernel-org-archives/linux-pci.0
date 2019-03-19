Return-Path: <SRS0=xwy5=RW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758FCC43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 03:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3198320872
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 03:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMqexT7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfCSDfr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:35:47 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:45838 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCSDfr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Mar 2019 23:35:47 -0400
Received: by mail-wr1-f43.google.com with SMTP id s15so3990029wra.12;
        Mon, 18 Mar 2019 20:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBXYPXLWASjbaQjUFBFDYdnIs/DH3ZDLfgEjYjeu8Wg=;
        b=oMqexT7SyNWILkJ0+1c1iAsj02rYoCijFaiSn/IVHd1GU2RRaLUIlLJvsVnLR7y2Nh
         tnzcNrSptKhlRAi28qb8F/ZKrMYuOB0rpiVU911zEJekOXLdf+9hlzR2ORW5unN5iT57
         52bgRKUUdTCBRV8mhxqWaytX/8a9IIOhI0ICZ6/3rluZmqAWA20GYA8uYFVQqciv3ejn
         pPNQpqcnOOa4sk9T96CAAUdtmTNA6sjsmFf2CLSEIzYFpF/9mqnk8gf8ZssyfYq1aoI3
         xI6NdhgJeUB6jOPy/PVwIQLvTdNw+NHidZoUmdvnXTFyphfziNVPwWXI2cGIRtB7CifN
         PGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBXYPXLWASjbaQjUFBFDYdnIs/DH3ZDLfgEjYjeu8Wg=;
        b=ZXKHucTQTmUzZxUUs7yrV7daZKLf7BWnXou4IkknJMJbgyVzqRHVq0wdtz5U+PQVD/
         nitop8CX2kyiucXlmci8xBswA/VHFqyIj3grCQrvEaeU9aggcQL8dZWERn2qM3vFGXyk
         p6P2pG3TIkZ7T6GhYqmuZ3sumjBg648gByVWDTQB+2iYBv0Pch1z0504tCtSQEv4av8y
         9il38WnRasf/11QiFM8Z0VaZS198xBfsDE2WBq9cudVu/SmdWYz/fkaKhn/iEUjpW7h8
         pM3BVWa20bs7R/Id1vvJonut/l+ryq59NQUiTqT5V/AvGdLlsn5zmZGg+pQiZPiz7H+p
         KaUg==
X-Gm-Message-State: APjAAAX7OcGcAMB0p10Mlrt39HvnM7CnXjCKg/LsdowhrA+tM+DRKuVO
        NfA9ledFJx1m2Hp/94etqKEDKO1DgmINblL0l0SkVBmx
X-Google-Smtp-Source: APXvYqyhIQShDAAhbOE3OapeABxnSyJWPLuQW4/o6+C6Gn/k+TxetOYdt8/F7h3rHgyflIsTU8gNTjtzE3Wy7vbb3Ak=
X-Received: by 2002:adf:e510:: with SMTP id j16mr9653654wrm.259.1552966544870;
 Mon, 18 Mar 2019 20:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <1552467452-538-1-git-send-email-hongxing.zhu@nxp.com>
 <1552467452-538-2-git-send-email-hongxing.zhu@nxp.com> <CAHQ1cqE3fcCQ2mHk-SuLdBn3XDUy9U2h=qsTCS6aO+3za0Aptw@mail.gmail.com>
 <AM0PR0402MB357070EA4DF0331D0F29EDCE8C4B0@AM0PR0402MB3570.eurprd04.prod.outlook.com>
 <CAHQ1cqHjiLUFRUMO40fcpO83ATrkAa5NcZWnjjZMe+ZskSCQiQ@mail.gmail.com> <AM0PR0402MB35709D0CB62204A2AE49BDBD8C440@AM0PR0402MB3570.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR0402MB35709D0CB62204A2AE49BDBD8C440@AM0PR0402MB3570.eurprd04.prod.outlook.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 18 Mar 2019 20:35:33 -0700
Message-ID: <CAHQ1cqEQUw+nE9novFC2oh8OBAGQ_KW2Q=d8EsQnFmD+BN4EAg@mail.gmail.com>
Subject: Re: [RFC 2/2] PCI: imx6: Add support for i.MX8QM/QXP PCIe
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 14, 2019 at 11:05 PM Richard Zhu <hongxing.zhu@nxp.com> wrote:
> > > > > +               imx6_pcie->pcie_inbound_axi =
> > > > devm_clk_get(&pdev->dev,
> > > > > +                               "pcie_inbound_axi");
> > > > > +               if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
> > > > > +                       dev_err(&pdev->dev,
> > > > > +                               "pcie clock source missing or
> > > > invalid\n");
> > > > > +                       return
> > > > PTR_ERR(imx6_pcie->pcie_inbound_axi);
> > > > > +               }
> > > >
> > > > On i.MX8MQ "pcie_bus" clock in vendor tree wasn't actually pointing
> > > > to actual PCIE bus clock, so it might be worth checking if that's
> > > > the case for i.MX8QM/X and you actually need one more clock.
> > > [Richard Zhu] Regarding to my understanding, iMX PCIe module is
> > connected to AXI bus.
> > > Thus, the AXI related clock can be treated as bus clock. Correct me if my
> > understand is wrong.
> > > So, I use the pcie_bus clock for i.MX8QM/QXP PCIe in the dts binding.
> > > Otherwise, I can use another new clock in codes to support i.MX8QM/QXP
> > PCIes.
> > >
> >
> > So, "pcie_bus" is supposed to be the clock driving PCIE bus itself. In this case
> > the clock that is controlled by CLKREQ_B. On i.MX8MQ EVK that was an
> > external 100 Mhz oscillator, so the final patch has "pcie_bus" pointing to a
> > dedicated "fixed-clock":
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.ke
> > rnel.org%2Flkml%2F20190220015857.7136-6-andrew.smirnov%40gmail.com
> > %2FT%2F%23u&amp;data=02%7C01%7Chongxing.zhu%40nxp.com%7Cb745
> > 5fe59e384723f44208d6a8ec835a%7C686ea1d3bc2b4c6fa92cd99c5c301635
> > %7C0%7C0%7C636882131105162138&amp;sdata=s7438xBSNxnWwTMxZXkj
> > LhgdPiS6puCRdrgr9suZpPQ%3D&amp;reserved=0
> >
> > Originally vendor tree was using "pcie_bus" to point at
> > IMX8MQ_CLK_PCIE1_AUX. If the situation on i.MX8QM/QXP is similar, then,
> > yeah, I think it should be moved out into a separate clock.
> >
> [Richard Zhu] The clocks of the i.MX8QM/QXP PCIe are different to the iMX8MQ PCIe's.
> Five clocks MASTER_AXI, SLAVE_AXI, DBI_AXI, PIPE_CLK and PER_CLK are mandatory required.
> Currently, They are named "pcie", "pcie_bus", "pcie_inbound_axi", "pcie_phy", "pcie_per" in the vendor tree.
> PIPE_CLK is output to PHY, so "pcie_phy" clock name is used by it.
> I'm not sure that the names of the xxx_AXI clocks are proper or not.
> What're your suggests about the names of xxx_AXI clocks?
> Did new clock names for all or part of these three xxx_AXI clocks shall be added in to the codes?
> Thanks in advanced.
>

I am hardly an authority on how those clocks should be named, so don't
put too much value in my suggestion. However if I had to do, I'd
probably use "pcie" for MASTER_AXI and add "pcie_slave" or maybe
"pcie2" to control SLAVE_AXI.

Lucas, if you don't mind, could you please comment on clock naming
situation here?

Thanks,
Andrey Smirnov
