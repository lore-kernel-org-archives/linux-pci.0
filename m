Return-Path: <SRS0=dd4N=OL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6B8C04EB8
	for <linux-pci@archiver.kernel.org>; Sun,  2 Dec 2018 11:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE0E20834
	for <linux-pci@archiver.kernel.org>; Sun,  2 Dec 2018 11:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="HB4zBWox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE0E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=mm-sol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbeLBL2Q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:28:16 -0500
Received: from ns.mm-sol.com ([37.157.136.199]:50494 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbeLBL2P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 Dec 2018 06:28:15 -0500
Received: from [192.168.1.8] (hst-221-64.medicom.bg [84.238.221.64])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 1F649CDB4;
        Sun,  2 Dec 2018 13:28:13 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1543750093; bh=fN4XpyVMA7TNjRb86FBv2QaShriauPvg8Pcq4yqQlI8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HB4zBWoxu84b1L43hFLoSWzuJZU3s2RgRI7t2eHVHUyThJjaSJp6axReaIikzB4Iq
         yNun6itChb5dZdrFQz6SfmbDA8W1yphFyHQERc9ER1NaKpU6XYAXMfeKrbrWN0cQ6R
         PTBXLrNitIu9uzQXKbg+awimu1cbPFSBS9XUmrOvWexRPcjyQm2VwkNHOUbllEAKNz
         RhKFc8pk6/djVla7LOiUv3hcNrxfep8WeMVizyAOziB/+dJQdb7ytsgBAPbDRDHgX8
         zQUv1eg8nmXlBi8rRajEIWCk0TiC87Y4nP1gRXLMauuulJv7ze4Ksh9/tAFMBPNj6H
         Lf6Zzu74kuVsw==
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
To:     Niklas Cassel <niklas.cassel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@google.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        faiz_abbas@ti.com, Joao Pinto <Joao.Pinto@synopsys.com>,
        Vignesh R <vigneshr@ti.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
 <693b46a1-18ea-ef94-ca18-8d3c23698986@mm-sol.com>
 <20181201235058.GA21020@centauri.lan>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <fb5b549f-8b73-108c-1d29-660573478385@mm-sol.com>
Date:   Sun, 2 Dec 2018 13:28:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181201235058.GA21020@centauri.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Niklas,

On 2.12.18 г. 1:50 ч., Niklas Cassel wrote:
> On Wed, Nov 21, 2018 at 07:24:53PM +0200, Stanimir Varbanov wrote:
>> Hi,
>>
>> On 11/14/18 12:57 AM, Marc Zyngier wrote:
>>> It recently came to light that the Designware PCIe driver is rather
>>> broken in the way it handles MSI[1]:
>>>
>>> - It masks interrupt by disabling them, meaning that MSIs generated
>>>    during the masked window are simply lost. Oops.
>>>
>>> - Acking of the currently pending MSI is done outside of the interrupt
>>>    flow, getting moved around randomly and ultimately breaking the
>>>    driver. Not great.
>>>
>>> This series attempts to address this by switching to using the MASK
>>> register for masking interrupts (!), and move the ack into the
>>> appropriate callback, giving it a fixed place in the MSI handling
>>> flow.
>>>
>>> Note that this is only compile-tested on my arm64 laptop, as I'm
>>> travelling and do not have the required HW to test it anyway. I'd
>>> welcome both review and testing by the interested parties (dwc
>>> maintainer and users affected by existing bugs).
>>>
>>> Thanks,
>>>
>>> 	M.
>>>
>>> [1] https://patchwork.kernel.org/patch/10657987/
>>>
>>> Marc Zyngier (3):
>>>    PCI: designware: Use interrupt masking instead of disabling
>>>    PCI: designware: Take lock when ACKing an interrupt
>>>    PCI: designware: Move interrupt acking into the proper callback
>>>
>>>   .../pci/controller/dwc/pcie-designware-host.c | 22 ++++++++++++-------
>>>   1 file changed, 14 insertions(+), 8 deletions(-)
>>>
>>
>> for pcie-qcom:
>>
>> Tested-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> 
> Hello PCI folks,
> 
> Since this is a real bug, we should try get a couple of Tested-by tags
> before it's too late.
> It would be nice if v4.20 was released without broken MSIs in this driver.
> 
> Personally I get confused just by looking at this mail thread.
> 
> I see 3 patches from Marc and a fix-up from Marc, but I also see
> a patch from Gustavo, and another patch from Trent.
> 
> Is seems like Lorenzo has a branch with Marc's 3 patches + Marc's fix-up
> folded in here:
> https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/log/?h=test%2Fpci-dwc-msi
> 
> Perhaps it would be a good idea to send a V2, with proper Fixes-tags,
> just so that people would know what to test, so that we can start getting
> those Tested-by tags.
> 
> Stan, may I ask exactly what patches you tested?

I tested Lorenzo's branch above ^^^.

regards,
Stan
