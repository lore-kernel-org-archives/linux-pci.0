Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1B9C04EB8
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 08:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7213B2084E
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 08:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DgjP9wz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7213B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbeLLI7b (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:59:31 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:59870 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLI7b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2018 03:59:31 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DBF8224E0DE9;
        Wed, 12 Dec 2018 00:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544605171; bh=LjLACqoycVwRrvvjC7tCEB70u3lIvxIQAyPfmFnTnUs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=DgjP9wz0/oxNEICphgRfpLqn6NawK4YRSW/xnEUZE5cIa6yHkaZ5cG1VWz6Z97QmJ
         cqx+fwcz3j8ZF+OOMq9fsqyxAFsuuQCQEKt4cwpA1xnfzRC1XU5AN5iG3qxoREpJVB
         D208JNb9G/gbtDjy2PqWhbtFLXVAPgoSika6AxfQhffEDxI2dz/m92SXEhV7UIJvNJ
         uJRIN//E4ILXrQNrFStXgXF//uaxDN1Rs6l5Ns7DmGoEjBSIly4ms6Z06n2a8EzNRj
         VPSMwc36uqMQgj/biW7G8HtI7LJzUDRssDcAy8w7wV5buWu/ctt9QOmbnBeo+Sdqh/
         x++1vtYzc7mqA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 739955204;
        Wed, 12 Dec 2018 00:59:30 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Dec 2018 00:59:30 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Dec 2018 09:59:28 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Dec 2018 09:59:27 +0100
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@google.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Vignesh R <vigneshr@ti.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
 <20181210161753.GA12563@e107981-ln.cambridge.arm.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <887f8bb9-d1bc-7f06-634c-6111ba58b889@synopsys.com>
Date:   Wed, 12 Dec 2018 08:55:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181210161753.GA12563@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 10/12/2018 16:17, Lorenzo Pieralisi wrote:
> On Tue, Nov 13, 2018 at 10:57:31PM +0000, Marc Zyngier wrote:
>> It recently came to light that the Designware PCIe driver is rather
>> broken in the way it handles MSI[1]:
>>
>> - It masks interrupt by disabling them, meaning that MSIs generated
>>   during the masked window are simply lost. Oops.
>>
>> - Acking of the currently pending MSI is done outside of the interrupt
>>   flow, getting moved around randomly and ultimately breaking the
>>   driver. Not great.
>>
>> This series attempts to address this by switching to using the MASK
>> register for masking interrupts (!), and move the ack into the
>> appropriate callback, giving it a fixed place in the MSI handling
>> flow.
>>
>> Note that this is only compile-tested on my arm64 laptop, as I'm
>> travelling and do not have the required HW to test it anyway. I'd
>> welcome both review and testing by the interested parties (dwc
>> maintainer and users affected by existing bugs).
>>
>> Thanks,
>>
>> 	M.
>>
>> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.kernel.org_patch_10657987_&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=SrPrRrHtYpjpRa6GKChsIMueIxK1EJVXMRMX4-JhuSE&s=wlMpkjgZDQ_a2lgGHhHLH6OPLkM2RKuYfSFPHbwGEBg&e=
>>
>> Marc Zyngier (3):
>>   PCI: designware: Use interrupt masking instead of disabling
>>   PCI: designware: Take lock when ACKing an interrupt
>>   PCI: designware: Move interrupt acking into the proper callback
>>
>>  .../pci/controller/dwc/pcie-designware-host.c | 22 ++++++++++++-------
>>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> Marc, Gustavo,
> 
> I have decided to queue this series - fixed-up as per this thread,
> available at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git test/pci-dwc-msi
> 
> We allowed enough time for people to test it, we can't leave mainline
> broken for the, apparently few, people who care.
> 
> I *think* that this is the Fixes: tag to be added to all patches in this
> series, @Gustavo please countercheck:
> 
> 7c5925afbc58 ("PCI: dwc: Move MSI IRQs allocation to IRQ domains
> hierarchical API")

Yes, I confirm, that is the patch to fix.

Regards,
Gustavo

> 
> I will mark them for stable too and we will work on backports to be
> sent in due course.
> 
> Thanks,
> Lorenzo
> 

