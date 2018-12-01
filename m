Return-Path: <SRS0=IfUz=OK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791B0C04EB9
	for <linux-pci@archiver.kernel.org>; Sat,  1 Dec 2018 23:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD0E2081C
	for <linux-pci@archiver.kernel.org>; Sat,  1 Dec 2018 23:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mttdkig7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD0E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbeLBLEn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:04:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45504 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725746AbeLBLEn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Dec 2018 06:04:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so8148884ljd.12
        for <linux-pci@vger.kernel.org>; Sat, 01 Dec 2018 15:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dJqu8NHpEN92F/IQCosC/XhJVaTYZ6mhU3eHr6NH9es=;
        b=Mttdkig7aO49xnF+GQIj3ue1xoL/dpUZqB3avTrWjDfrG5SujnUByVBnD8saS5SdLi
         0WP24KMalG9Vx1TGr/fFHe06cyZYIdYBu75F73nonmnlJl3MxIxwpnC1nMahPd5efnKU
         fYOdmGeY7KI2ogoBFRVtx7FR5PWE6Uig++iwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dJqu8NHpEN92F/IQCosC/XhJVaTYZ6mhU3eHr6NH9es=;
        b=I/ENC5g7U4xMx63o6bhxzHxf8oUuwwpM/gZyWOUGoXJz9lOy9Lf0/ezlgPBgO/tD51
         D00o6yd3ZrXVqgY2/y1QJf95MnaFFwJDQ5tG9/O5izCrKUdxC/E6q1S74AgvtbQyNmWf
         fkNTzRaUfL1VBUuVz/yPPKmQXUeWPcphuE1+5Og0SA8fFMQLpZvdJ4oQ5eN06jnVgAed
         mzaRFtCQV/HekaNw404cXNThSLZU+6JzxI67f3t4L7gtdhryvf0NPTX0b2fdM6oHzRdf
         Kyzej+YxQKyVr8bagk7w798qzKSk2ZJyklLpCzTLTHOhIGP45UoHYNJKrzBs11lRD0QG
         MNHw==
X-Gm-Message-State: AA+aEWaxxy0Dwq86u/ISZ+w8GyLpU731qvQVKcpcvJPIBouNihrbB587
        vGI6GqL21h+fOHHRNZE/vX3HRA==
X-Google-Smtp-Source: AFSGD/VpnuohUei4fbGyWKMvs4dAi0YQSzQ+X6gkSoEETZxacGqtuSwhCXiao2U9/5/RTm3H/TPeyA==
X-Received: by 2002:a2e:851a:: with SMTP id j26-v6mr5164127lji.163.1543708260936;
        Sat, 01 Dec 2018 15:51:00 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id i75sm1552559lfb.58.2018.12.01.15.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 15:51:00 -0800 (PST)
Date:   Sun, 2 Dec 2018 00:50:58 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@google.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        faiz_abbas@ti.com, Joao Pinto <Joao.Pinto@synopsys.com>,
        Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Message-ID: <20181201235058.GA21020@centauri.lan>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
 <693b46a1-18ea-ef94-ca18-8d3c23698986@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <693b46a1-18ea-ef94-ca18-8d3c23698986@mm-sol.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 21, 2018 at 07:24:53PM +0200, Stanimir Varbanov wrote:
> Hi,
> 
> On 11/14/18 12:57 AM, Marc Zyngier wrote:
> > It recently came to light that the Designware PCIe driver is rather
> > broken in the way it handles MSI[1]:
> > 
> > - It masks interrupt by disabling them, meaning that MSIs generated
> >   during the masked window are simply lost. Oops.
> > 
> > - Acking of the currently pending MSI is done outside of the interrupt
> >   flow, getting moved around randomly and ultimately breaking the
> >   driver. Not great.
> > 
> > This series attempts to address this by switching to using the MASK
> > register for masking interrupts (!), and move the ack into the
> > appropriate callback, giving it a fixed place in the MSI handling
> > flow.
> > 
> > Note that this is only compile-tested on my arm64 laptop, as I'm
> > travelling and do not have the required HW to test it anyway. I'd
> > welcome both review and testing by the interested parties (dwc
> > maintainer and users affected by existing bugs).
> > 
> > Thanks,
> > 
> > 	M.
> > 
> > [1] https://patchwork.kernel.org/patch/10657987/
> > 
> > Marc Zyngier (3):
> >   PCI: designware: Use interrupt masking instead of disabling
> >   PCI: designware: Take lock when ACKing an interrupt
> >   PCI: designware: Move interrupt acking into the proper callback
> > 
> >  .../pci/controller/dwc/pcie-designware-host.c | 22 ++++++++++++-------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> > 
> 
> for pcie-qcom:
> 
> Tested-by: Stanimir Varbanov <svarbanov@mm-sol.com>

Hello PCI folks,

Since this is a real bug, we should try get a couple of Tested-by tags
before it's too late.
It would be nice if v4.20 was released without broken MSIs in this driver.

Personally I get confused just by looking at this mail thread.

I see 3 patches from Marc and a fix-up from Marc, but I also see
a patch from Gustavo, and another patch from Trent.

Is seems like Lorenzo has a branch with Marc's 3 patches + Marc's fix-up
folded in here:
https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/log/?h=test%2Fpci-dwc-msi

Perhaps it would be a good idea to send a V2, with proper Fixes-tags,
just so that people would know what to test, so that we can start getting
those Tested-by tags.

Stan, may I ask exactly what patches you tested?


Kind regards,
Niklas
