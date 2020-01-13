Return-Path: <SRS0=NAiA=3C=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB83C3F68F
	for <linux-pci@archiver.kernel.org>; Mon, 13 Jan 2020 14:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21960207FD
	for <linux-pci@archiver.kernel.org>; Mon, 13 Jan 2020 14:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgAMOMn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:12:43 -0500
Received: from foss.arm.com ([217.140.110.172]:40084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgAMOMn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 09:12:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B79EE1045;
        Mon, 13 Jan 2020 06:12:42 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82A5E3F68E;
        Mon, 13 Jan 2020 06:12:41 -0800 (PST)
Date:   Mon, 13 Jan 2020 14:12:39 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2 16/20] pci: exynos: Rename Exynos to lowercase
Message-ID: <20200113141239.GB15939@e121166-lin.cambridge.arm.com>
References: <20200104152107.11407-1-krzk@kernel.org>
 <20200104152107.11407-17-krzk@kernel.org>
 <20200113122902.GA15939@e121166-lin.cambridge.arm.com>
 <CAJKOXPcNJ5QCabPUh4kcOj_9Gj2SF8+JGtSJu8cLEp0Ciqy96g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPcNJ5QCabPUh4kcOj_9Gj2SF8+JGtSJu8cLEp0Ciqy96g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 13, 2020 at 01:44:45PM +0100, Krzysztof Kozlowski wrote:
> On Mon, 13 Jan 2020 at 13:29, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Sat, Jan 04, 2020 at 04:21:03PM +0100, Krzysztof Kozlowski wrote:
> > > Fix up inconsistent usage of upper and lowercase letters in "Exynos"
> > > name.
> > >
> > > "EXYNOS" is not an abbreviation but a regular trademarked name.
> > > Therefore it should be written with lowercase letters starting with
> > > capital letter.
> > >
> > > The lowercase "Exynos" name is promoted by its manufacturer Samsung
> > > Electronics Co., Ltd., in advertisement materials and on website.
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > ---
> > >  drivers/pci/controller/dwc/pci-exynos.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >
> > Should I pick it up or you are sending the series via another tree ?
> >
> > If so (if it is not queued already):
> >
> > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> Please pick it up.

Done, pushed out on pci/misc, thanks.

Lorenzo
