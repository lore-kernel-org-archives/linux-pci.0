Return-Path: <SRS0=wm6w=VT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C78AC76191
	for <linux-pci@archiver.kernel.org>; Mon, 22 Jul 2019 00:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E30206BF
	for <linux-pci@archiver.kernel.org>; Mon, 22 Jul 2019 00:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfGVAra (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 21 Jul 2019 20:47:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:36324 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfGVAra (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 21 Jul 2019 20:47:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6M0l91M018324;
        Sun, 21 Jul 2019 19:47:10 -0500
Message-ID: <bed99b3d9b4ea5ddba568dd65b3a4aad4ad837bd.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 6/8] PCI: al: Add support for DW based driver type
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "Chocron, Jonathan" <jonnyc@amazon.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Gustavo.Pimentel@synopsys.com" <Gustavo.Pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Hanoch, Uri" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wasserstrom, Barak" <barakw@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Shenhar, Talel" <talel@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date:   Mon, 22 Jul 2019 10:47:06 +1000
In-Reply-To: <d323007c6bf14cb9f90a497a26b66dac151164fc.camel@amazon.com>
References: <20190718094531.21423-1-jonnyc@amazon.com>
         <20190718094718.25083-2-jonnyc@amazon.com>
         <DM6PR12MB4010913E5408349A600762CADACB0@DM6PR12MB4010.namprd12.prod.outlook.com>
         <d323007c6bf14cb9f90a497a26b66dac151164fc.camel@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 2019-07-21 at 15:08 +0000, Chocron, Jonathan wrote:
> > Please sort the variables following the reverse tree order.
> > 
> 
> Done. 
> 
> I'd think that it would make sense to group variables which have a
> common characteristic (e.g. resources read from the DT), even if it
> mildly breaks the convention (as long as the general frame is longest
> to shortest). Does this sound ok?
> 
> BTW, I couldn't find any documentation regarding the reverse-tree
> convention, do you have a pointer to some?

It's a complete stupidity that people who have nothing better to
comment about keep throwing at you when you are trying to get stuff
working.

Yes, we should avoid ugly stuff such as

	int rc;
	struct something_very_long foo;

But this definitely should come second to saner ordering such as the
one you propose of grouping related things together. At least IMHO.

You'll notice that the kernel these days attract way more people
interested in commenting to death on various minor points of coding
style than actual worthwhile technical comments on the code.

Cheers,
Ben.


