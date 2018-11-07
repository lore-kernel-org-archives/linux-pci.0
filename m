Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20253C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 13:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4A12086B
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 13:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="A393DB6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4A12086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeKGWcd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:32:33 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:60604 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeKGWcd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Nov 2018 17:32:33 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E1DEE10C06BA;
        Wed,  7 Nov 2018 05:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541595735; bh=0LMyKn0nsMhfvpdLPoEnDdrOCDhoQtCXp9cUKM+ENwc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=A393DB6pntq28ORj1Rg7UgaHvOhGxiSi7WHYn5HUqx4Tv8XCv1a3EAZvPVayY60yx
         O2lsrPxryedvJp5XlznM46h1JAlVDD7UDak1FRG7nh45PnZdncwDedzOwoBL4sn8Uw
         EWW9NxWTj+UCvpAQfpBupIbva6nVqcANsbLNk9ZLmGtrgTdGI+1QLQouPsKd4bZqy1
         9MEKPu+ht/FL/nW3H92s2MdGes/iM1xNfzLZqkqTQb8KwT5jlnlMVWYHmd/U/HdLdR
         luvEdF+yWInLYoIq3aWYXjwCyc4EMCj98WcL11e/b2xyknB3pYSx5PybLwTtyCZbZP
         +SJ1i2IGDevGw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id C398B53D2;
        Wed,  7 Nov 2018 05:02:15 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 7 Nov 2018 05:02:15 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 7 Nov 2018 14:02:14 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 7 Nov 2018 14:02:14 +0100
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Trent Piepho <tpiepho@impinj.com>
CC:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "jpinto@synopsys.com" <joao.pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
 <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
 <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
 <1541533217.30311.263.camel@impinj.com>
 <20181107110739.GA11586@e107981-ln.cambridge.arm.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <9366e09e-1411-2fc5-b6c3-fe1fc275534d@synopsys.com>
Date:   Wed, 7 Nov 2018 12:58:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181107110739.GA11586@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07/11/2018 11:07, Lorenzo Pieralisi wrote:
> On Tue, Nov 06, 2018 at 07:40:18PM +0000, Trent Piepho wrote:
>> On Tue, 2018-11-06 at 16:00 +0000, Marc Zyngier wrote:
>>>
>>> It is hard to decide what the right solution is without understanding
>>> exactly what this particular write actually does. It seems to be some
>>> form of acknowledgement, but I'm only making an educated guess, and some
>>> of the defines suggest that there might be another register for that.
>>
>> Unfortunately, there are no docs for this controller.  I've determined
>> that it sets a bit in this register when an MSI is received.  Once set,
>> it acts as a mask and the controller will generate no interrupts when
>> the same MSI is subsequently received.  Writing a 1 to a bit clears
>> that mask bit, obviously so that each bit can be cleared atomically vs
>> a non-atomic RMW.  The controller does not queue any MSIs received
>> while the interrupt was masked.
> 
> I would like to understand if this is the expected behaviour across
> dwc controllers but to understand that, as Marc mentioned, we would
> need some input from Synopsys (if that's not customizable option).
> 
> Side note: what's the register at offset PCIE_MSI_INTR0_MASK
> supposed to do ? It seems unused in the current kernel, with
> a macro name hinting at MSI masking so I am asking.

That's the interrupt mask for the controller #0 offset. Currently it's not used.

Gustavo

> 
>>> What I'm interested in is the relationship this has with the mask/unmask
>>> callbacks, and whether masking the interrupt before acking it would help.
>>
>>
>>>
>>> Gustavo, can you help here?
>>>
>>> In any way, moving the action of acknowledging the interrupt to its
>>> right spot in the kernel (dw_pci_bottom_ack) would be a good start.
>>
>> What about stable kernels that don't have the hierarchical API?
> 
> We will have to backport the patches.
> 
> Lorenzo
> 

