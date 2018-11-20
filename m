Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2134BC43441
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 01:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66542089F
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 01:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBK1FpuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66542089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbeKTMVE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:21:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730044AbeKTMVE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 07:21:04 -0500
Received: from [192.168.0.109] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5CA22080C;
        Tue, 20 Nov 2018 01:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542678865;
        bh=SKyjJA+9q/5M5jSNQgYSS65jciomRDOHucw5o12BtcQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bBK1FpuKT6phXZvtPCDoi+Gl7M6r44TxJA73vBXa1h4NYBI2uMGB1s+q6QOox3IFS
         0IBMJG4GiyVN0lXvFxK+OImrLYaNsaBX7GNzevBL4PPcT/CGtdM8+topoM6hWTa8db
         gAojzIXBhYa/8ZDZ4xh9cYiVatjt2TJI4Uc8UPN0=
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
To:     Alex_Gagniuc@Dellteam.com, mr.nuke.me@gmail.com,
        keith.busch@intel.com
Cc:     baicar.tyler@gmail.com, Austin.Bolen@dell.com, Shyam.Iyer@dell.com,
        lukas@wunner.de, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, ruscur@russell.cc, sbobroff@linux.ibm.com,
        oohall@gmail.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
 <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
 <20181119165318.GB26595@localhost.localdomain>
 <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
 <ab2427f1-c1f0-68fe-5335-1494caafdcbb@kernel.org>
 <20181119174127.GE26595@localhost.localdomain>
 <ef0a24e4-906e-f6df-c646-1fe47ea0dcc0@kernel.org>
 <20181119181051.GA26707@localhost.localdomain>
 <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
 <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
 <ef6b19de-dd18-850f-4db9-8ab71b975e94@kernel.org>
 <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
 <84013a8a-287d-d700-6710-91cc35f507c8@kernel.org>
 <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <3b18a9fa-7bdd-0fb4-285d-4efb454be50a@kernel.org>
Date:   Mon, 19 Nov 2018 20:54:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/19/2018 6:49 PM, Alex_Gagniuc@Dellteam.com wrote:
> On 11/19/2018 02:33 PM, Sinan Kaya wrote:
>> However; table assumes governance about for which entities firmware first
>> should be enabled. There is no cross reference to _OSC or permission
>> negotiation like _OST.
> 
> Well, from an OSPM perspective, is FFS something that can be enabled or
> disabled? FFS seems to be static to OSPM, which would change the sort of
> assumptions we can reasonably make here.

IMO, it can be enabled/disabled in BIOS. I have seen this implementation before.
If the trigger is the presence of a statically compiled ACPI HEST table (as the
current code does); presence of FFS would be static from OSPM perspective.
BIOS could patch this table or hide it during boot.

If FFS were to be negotiated via _OSC as indirectly implied in this series, then
same BIOS could patch the ACPI table to return different values for the _OSC
return.

> 
> 
>>>> As I said in my previous email, the right place to talk about this is UEFI
>>>> forum.
>>>
>>> The way I would present the problem to he spec writers is that, although
>>> the spec appears to be consistent, we've seen firmware vendors that made
>>> the wrong assumptions about HEST/_OSC. Instead of describing AER
>>> ownership with _OSC, they attempted to do it with HEST. So we should add
>>> an implementation note, or clarification about this.
>>
>> I agree.
> 
> Cool. While the UEFI Secret Society debates, can we figure out if/how
> [patch 1/2] breaks those systems, or is it only [patch 2/2] of this
> series that we suspect?

I went back and looked at both patches. Both of them are removing references to
HEST table. I think both patches are impacted by this discussion.

> 
> Alex
> 

