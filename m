Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5604C04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 13:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668B720878
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 13:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmnrBRuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668B720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbeLCNK2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:10:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38643 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeLCNK2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Dec 2018 08:10:28 -0500
Received: by mail-lf1-f66.google.com with SMTP id p86so9067224lfg.5
        for <linux-pci@vger.kernel.org>; Mon, 03 Dec 2018 05:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QazPNqy2GmaylZud1bxylp7PVPQNJd82DiVXq+eVNtI=;
        b=kmnrBRuQAJvYvzMEe3AZhjKtTS6o63ffPa3e4pgamixW92/bmFFB1CjM9PQYZ2tP4o
         K7/9qzOSWOXuVZO9xx6QBz40+0s1Wvg2EmFGbQPPDY5D0EuJuvS/uMPyDUJg8YoqRSoC
         X5XDlYsuCb1Gqh2ZD+AZaB9GFDAxAUUTU36L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QazPNqy2GmaylZud1bxylp7PVPQNJd82DiVXq+eVNtI=;
        b=lwTQUhCCSOCw8EqgmqCeLbqYikAeuUE+BKhZp2E38TY6Z0D1njvmkTvB96ejGIN9QD
         TWnFjMLkF38myyp6FYWs86Cf7Scie6TUpXSN6Kco1K9LgkGP490uTEfSPAkUEdZwCc1H
         m1IjXkJHKraUBx/SybbU94jpq3mIWOKQqyf98dJY5FW6r3BtXNUaRpIlOrojuVH1H5E+
         EYfUZZmKx5/SDYuP9a2NjYBCvBKPewntgNbybdeyxHHEVXorPLMGTWDOvqcN094B5/Vc
         uftj5UF41v4uTvlo1OQl//2eiiHW5ZOjF8rmJqNutWm4Mb/Nhyryqai424JSyk12fJaE
         pNPg==
X-Gm-Message-State: AA+aEWb0LUDmC489Hlt0aCRcfC+KJKYQPxrSMlWoqpSLJ75zn9M8IlDJ
        d2q1qNgoaEYasCMuCiUAhUA35g==
X-Google-Smtp-Source: AFSGD/VNvlNsZHtq/YrNZK48bdCcw0a9nltjPfaWs4qII6tcxi0+zOAcioHrBd/AHn0i1erpxIzu6w==
X-Received: by 2002:a19:26ce:: with SMTP id m197mr8840448lfm.23.1543842567948;
        Mon, 03 Dec 2018 05:09:27 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id o26sm2498227lfl.18.2018.12.03.05.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 05:09:27 -0800 (PST)
Date:   Mon, 3 Dec 2018 14:09:24 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        faiz_abbas@ti.com, Joao Pinto <Joao.Pinto@synopsys.com>,
        Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Message-ID: <20181203130924.GA5105@centauri.lan>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
 <693b46a1-18ea-ef94-ca18-8d3c23698986@mm-sol.com>
 <20181201235058.GA21020@centauri.lan>
 <20181203104218.GB6090@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203104218.GB6090@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 03, 2018 at 10:42:19AM +0000, Lorenzo Pieralisi wrote:
> On Sun, Dec 02, 2018 at 12:50:58AM +0100, Niklas Cassel wrote:
> > On Wed, Nov 21, 2018 at 07:24:53PM +0200, Stanimir Varbanov wrote:
> > > Hi,
> > > 
> > > On 11/14/18 12:57 AM, Marc Zyngier wrote:
> > > > It recently came to light that the Designware PCIe driver is rather
> > > > broken in the way it handles MSI[1]:
> > > > 
> > > > - It masks interrupt by disabling them, meaning that MSIs generated
> > > >   during the masked window are simply lost. Oops.
> > > > 
> > > > - Acking of the currently pending MSI is done outside of the interrupt
> > > >   flow, getting moved around randomly and ultimately breaking the
> > > >   driver. Not great.
> > > > 
> > > > This series attempts to address this by switching to using the MASK
> > > > register for masking interrupts (!), and move the ack into the
> > > > appropriate callback, giving it a fixed place in the MSI handling
> > > > flow.
> > > > 
> > > > Note that this is only compile-tested on my arm64 laptop, as I'm
> > > > travelling and do not have the required HW to test it anyway. I'd
> > > > welcome both review and testing by the interested parties (dwc
> > > > maintainer and users affected by existing bugs).
> > > > 
> > > > Thanks,
> > > > 
> > > > 	M.
> > > > 
> > > > [1] https://patchwork.kernel.org/patch/10657987/
> > > > 
> > > > Marc Zyngier (3):
> > > >   PCI: designware: Use interrupt masking instead of disabling
> > > >   PCI: designware: Take lock when ACKing an interrupt
> > > >   PCI: designware: Move interrupt acking into the proper callback
> > > > 
> > > >  .../pci/controller/dwc/pcie-designware-host.c | 22 ++++++++++++-------
> > > >  1 file changed, 14 insertions(+), 8 deletions(-)
> > > > 
> > > 
> > > for pcie-qcom:
> > > 
> > > Tested-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> > 
> > Hello PCI folks,
> > 
> > Since this is a real bug, we should try get a couple of Tested-by tags
> > before it's too late.
> > It would be nice if v4.20 was released without broken MSIs in this driver.
> > 
> > Personally I get confused just by looking at this mail thread.
> > 
> > I see 3 patches from Marc and a fix-up from Marc, but I also see
> > a patch from Gustavo, and another patch from Trent.
> > 
> > Is seems like Lorenzo has a branch with Marc's 3 patches + Marc's fix-up
> > folded in here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/log/?h=test%2Fpci-dwc-msi
> > 
> > Perhaps it would be a good idea to send a V2, with proper Fixes-tags,
> > just so that people would know what to test, so that we can start getting
> > those Tested-by tags.
> 
> Perhaps it would be a good idea to pull the branch above and test it
> after I have sent three reminders to all DWC host bridge maintainers through
> this email thread.
> 
> I have no problem reposting those patches but it is time you started
> testing them, I have already explained what's the issue they are fixing
> in this thread, I do not think a Fixes: tag will add any further degree
> of urgency.
> 

I tested Lorenzo's
https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/log/?h=test%2Fpci-dwc-msi
branch with drivers/pci/controller/dwc/pcie-qcom.c.

Without this branch, when having an ath10k PCIe endpoint connected,
and simply running the ath10k as a host access point (running hostapd):
watch cat /proc/interrupts | grep ath10k_pci
I consistenly stop getting interrupts in less than a minute.

With this branch, I've been able to run the same test case successfully
for 30+ minutes.

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
