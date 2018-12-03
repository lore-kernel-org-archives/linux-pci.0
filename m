Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AEBC04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 17:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9EC2087F
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 17:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9EC2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbeLCRnI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:43:08 -0500
Received: from foss.arm.com ([217.140.101.70]:43228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbeLCRnI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Dec 2018 12:43:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70A921682;
        Mon,  3 Dec 2018 09:43:06 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8001D3F59C;
        Mon,  3 Dec 2018 09:43:04 -0800 (PST)
Date:   Mon, 3 Dec 2018 17:42:57 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        faiz_abbas@ti.com, Joao Pinto <Joao.Pinto@synopsys.com>,
        Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Message-ID: <20181203174257.GA13670@e107981-ln.cambridge.arm.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
 <693b46a1-18ea-ef94-ca18-8d3c23698986@mm-sol.com>
 <20181201235058.GA21020@centauri.lan>
 <20181203104218.GB6090@e107981-ln.cambridge.arm.com>
 <20181203130924.GA5105@centauri.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203130924.GA5105@centauri.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 03, 2018 at 02:09:24PM +0100, Niklas Cassel wrote:
> On Mon, Dec 03, 2018 at 10:42:19AM +0000, Lorenzo Pieralisi wrote:
> > On Sun, Dec 02, 2018 at 12:50:58AM +0100, Niklas Cassel wrote:
> > > On Wed, Nov 21, 2018 at 07:24:53PM +0200, Stanimir Varbanov wrote:
> > > > Hi,
> > > > 
> > > > On 11/14/18 12:57 AM, Marc Zyngier wrote:
> > > > > It recently came to light that the Designware PCIe driver is rather
> > > > > broken in the way it handles MSI[1]:
> > > > > 
> > > > > - It masks interrupt by disabling them, meaning that MSIs generated
> > > > >   during the masked window are simply lost. Oops.
> > > > > 
> > > > > - Acking of the currently pending MSI is done outside of the interrupt
> > > > >   flow, getting moved around randomly and ultimately breaking the
> > > > >   driver. Not great.
> > > > > 
> > > > > This series attempts to address this by switching to using the MASK
> > > > > register for masking interrupts (!), and move the ack into the
> > > > > appropriate callback, giving it a fixed place in the MSI handling
> > > > > flow.
> > > > > 
> > > > > Note that this is only compile-tested on my arm64 laptop, as I'm
> > > > > travelling and do not have the required HW to test it anyway. I'd
> > > > > welcome both review and testing by the interested parties (dwc
> > > > > maintainer and users affected by existing bugs).
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > 	M.
> > > > > 
> > > > > [1] https://patchwork.kernel.org/patch/10657987/
> > > > > 
> > > > > Marc Zyngier (3):
> > > > >   PCI: designware: Use interrupt masking instead of disabling
> > > > >   PCI: designware: Take lock when ACKing an interrupt
> > > > >   PCI: designware: Move interrupt acking into the proper callback
> > > > > 
> > > > >  .../pci/controller/dwc/pcie-designware-host.c | 22 ++++++++++++-------
> > > > >  1 file changed, 14 insertions(+), 8 deletions(-)
> > > > > 
> > > > 
> > > > for pcie-qcom:
> > > > 
> > > > Tested-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> > > 
> > > Hello PCI folks,
> > > 
> > > Since this is a real bug, we should try get a couple of Tested-by tags
> > > before it's too late.
> > > It would be nice if v4.20 was released without broken MSIs in this driver.
> > > 
> > > Personally I get confused just by looking at this mail thread.
> > > 
> > > I see 3 patches from Marc and a fix-up from Marc, but I also see
> > > a patch from Gustavo, and another patch from Trent.
> > > 
> > > Is seems like Lorenzo has a branch with Marc's 3 patches + Marc's fix-up
> > > folded in here:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/log/?h=test%2Fpci-dwc-msi
> > > 
> > > Perhaps it would be a good idea to send a V2, with proper Fixes-tags,
> > > just so that people would know what to test, so that we can start getting
> > > those Tested-by tags.
> > 
> > Perhaps it would be a good idea to pull the branch above and test it
> > after I have sent three reminders to all DWC host bridge maintainers through
> > this email thread.
> > 
> > I have no problem reposting those patches but it is time you started
> > testing them, I have already explained what's the issue they are fixing
> > in this thread, I do not think a Fixes: tag will add any further degree
> > of urgency.
> > 
> 
> I tested Lorenzo's
> https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/log/?h=test%2Fpci-dwc-msi
> branch with drivers/pci/controller/dwc/pcie-qcom.c.
> 
> Without this branch, when having an ath10k PCIe endpoint connected,
> and simply running the ath10k as a host access point (running hostapd):
> watch cat /proc/interrupts | grep ath10k_pci
> I consistenly stop getting interrupts in less than a minute.
> 
> With this branch, I've been able to run the same test case successfully
> for 30+ minutes.
> 
> Tested-by: Niklas Cassel <niklas.cassel@linaro.org>

Thank you very much, I need this tag on linux-pci@vger.kernel.org in
reply to this series:

https://patchwork.ozlabs.org/project/linux-pci/list/?series=75827

I need more testing done, I encourage other DWC maintainers to test my
branch above. I am mulling over it but I may consider this v4.21
material if I do not get enough testing done this week.

Thanks,
Lorenzo
