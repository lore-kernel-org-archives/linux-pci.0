Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0121DC41536
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 17:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EEA20684
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 17:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gTN0ltJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6EEA20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeKUETZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:19:25 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:43414 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeKUETZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Nov 2018 23:19:25 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 842D510C066C;
        Tue, 20 Nov 2018 09:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542736144; bh=hJrew1+BLZbvmJEkzVapkIl57wmxdxafJUsl0kjM2v4=;
        h=From:Subject:To:CC:References:Date:In-Reply-To:From;
        b=gTN0ltJf17HUDJaX4+SNW9E/+BxSsu9LF/RIwpzMSzMX25NH/TqF+PmdEHMgrnmc9
         isRVVFLt+hb+sWYorN4pjBIiwR4WE3nxhdUpafrSmVB4aeKRM9y1IwwiTezlkWAo2U
         8Pugc7x7Rzuqnps0aMEeizViS8CwoBgSj6HFqmrpMs3504kXi3w8mMmcu7MZkUPMkY
         ojAUkhP6LgUmPkvt0vp07ECwX3sAe3ZINaKTITJB+qpUNj5Uk6w9IHzgEKMKdYzcim
         6qNdZy9rsGZnPPgxllC4BdY/TotIt9rhtBu2b4eU86SchEYw3rJsjpeSamJNaXLkT+
         087tPlG9lW2OA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4C7465DB4;
        Tue, 20 Nov 2018 09:49:04 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 20 Nov 2018 09:49:04 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 20 Nov 2018 18:49:02 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 20 Nov 2018 18:49:02 +0100
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH] PCI: designware: don't hard-code DBI/ATU offset
To:     Stephen Warren <swarren@wwwdotorg.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        "Stephen Warren" <swarren@nvidia.com>
References: <20181112225710.29557-1-swarren@wwwdotorg.org>
 <ce3ac825-c05b-c782-81ba-dad0acc8d3c8@synopsys.com>
 <87acc658-489a-6b8f-44cb-f9fbad3297a3@wwwdotorg.org>
 <3f4797f3-5477-a31f-9292-ac89c21533fd@synopsys.com>
 <8a004998-095c-b7a9-0b41-bf6a61f2380d@wwwdotorg.org>
Message-ID: <8c88869b-77a8-4adc-ade2-248c70ec0e6c@synopsys.com>
Date:   Tue, 20 Nov 2018 17:44:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8a004998-095c-b7a9-0b41-bf6a61f2380d@wwwdotorg.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15/11/2018 18:24, Stephen Warren wrote:
> On 11/14/18 9:33 PM, Gustavo Pimentel wrote:
>> Hi Stephen,
>>
>> On 14/11/2018 04:31, Stephen Warren wrote:
>>> On 11/12/18 9:19 PM, Gustavo Pimentel wrote:
>>>> Hi Stephen,
>>>>
>>>> I'd suggest to change the designware on the patch name by dwc and use another
>>>> description for the patch instead of don't hard-code DBI/ATU offset.
>>>
>>> What issue do you see with the patch description? I believe it's
>>> correct/accurate. Perhaps the confusion is due to the question you
>>> raised below; see my answer there.
>>>
>>>> On 12/11/2018 22:57, Stephen Warren wrote:
>>>>> From: Stephen Warren <swarren@nvidia.com>
>>>>>
>>>>> The DWC PCIe core contains various separate register spaces: DBI, DBI2,
>>>>> ATU, DMA, etc. The relationship between the addresses of these register
>>>>> spaces is entirely determined by the implementation of the IP block, not
>>>>> by the IP block design itself. Hence, the DWC driver must not make
>>>>> assumptions that one register space can be accessed at a fixed offset from
>>>>> any other register space. To avoid such assumptions, introduce an
>>>>> explicit/separate register pointer for the ATU register space. In
>>>>> particular, the current assumption is not valid for NVIDIA's T194 SoC.
>>>>
>>>> If I understood this patch correctly, you basically replace the dbi_base offset
>>>> by atu_base offset that still depends of dbi_base offset.
>>>
>>> That's not what the patch does.
>>>
>>> The patch leaves most DBI accesses still using dbi_base, but updates
>>> just a few accesses to use atu_base. Thus, after the patch, all accesses
>>> use the correct base address for the register being accessed.
>>>
>>> There is a default value supplied for atu_base, which does indeed depend
>>> on dbi_base. This maintains backwards compatibility, so that all the
>>> existing drivers don't need to be updated to explicitly set atu_base,
>>> and will continue to use the existing offset between DBI and ATU base.
>>
>> I think we're talking about the same thing, but with different terms.
>>
>>> In the future, we'll send a driver for the NVIDIA Tegra SoC which does
>>> explicitly set atu_base to a non-default value.
>>
>> That's what I wanted to know. Because otherwise this patch was just to turn the
>> code more readable.
> 
> So it sounds like I've addressed your questions? If so, is the next step
> for you to ack the patch and Bjorn to apply it? Thanks!
> 

Please change "designware" by "dwc" on the title (which is the normal tag) as I
suggested and put the first letter of "don't" in capital letter.

With that fix, please re-submit patch version.

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Thanks.

Regards,
Gustavo

