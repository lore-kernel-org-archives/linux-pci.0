Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFE7C43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 17:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2914B213A2
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 17:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlBb8Ms9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2914B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390994AbeKTD5K (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:57:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390242AbeKTD5K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Nov 2018 22:57:10 -0500
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB4F8213A2;
        Mon, 19 Nov 2018 17:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542648764;
        bh=f5jXAEtHIW0yHUGhIlpB1DKM3MCKC1MibrxuM8Dd4ic=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JlBb8Ms9VxyBOyewAMmc5qnS7DgUfZBgNld6DhG+rEJ+V8UnX6dCABPA3KMsqqfDW
         zGtnyl6CDzb3Hae01ad9WzxZmIQo6nqPXRckLbraUfmEAeMlwWiq5gasMJDg+ffYwU
         zeFR52OBnRyCQmFb0NniC9n4NC2NFfwajjFzgFO0=
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
To:     Keith Busch <keith.busch@intel.com>,
        Tyler Baicar <baicar.tyler@gmail.com>
Cc:     mr.nuke.me@gmail.com, helgaas@google.com, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, Shyam_Iyer@dell.com, lukas@wunner.de,
        bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org,
        ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
 <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
 <20181119165318.GB26595@localhost.localdomain>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
Date:   Mon, 19 Nov 2018 12:32:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181119165318.GB26595@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/19/2018 11:53 AM, Keith Busch wrote:
> On Mon, Nov 19, 2018 at 11:53:05AM -0500, Tyler Baicar wrote:
>> On Thu, Nov 15, 2018 at 8:49 PM Sinan Kaya <okaya@kernel.org> wrote:
>>>
>>> On 11/15/2018 3:16 PM, Alexandru Gagniuc wrote:
>>>> I've asked around a few people at Dell and they unanimously agree that
>>>> _OSC is the correct way to determine ownership of AER. In linux, we
>>>> use the result of _OSC to enable AER services, but we use HEST to
>>>> determine AER ownership. That's inconsistent. This series drops the
>>>> use of HEST in favor of _OSC.
>>>>
>>>> [1]https://lkml.org/lkml/2018/11/15/62
>>>
>>> This change breaks the existing systems that rely on the HEST table
>>> telling the operating system about firmware first presence.
>>>
>>> Besides, HEST table has much more granularity about which PCI component
>>> needs firmware such as global/device/switch.
>>>
>>> You should probably circulate these ideas for wider consumption in UEFI
>>> forum as UEFI owns the HEST table definition.
>>
>> I agree with Sinan, this will break existing systems, and the granularity of the
>> HEST definition is more useful than the single bit in _OSC.
> 
> But we're not using HEST as a fine grain control. We disable native AER
> handling if *any* device has FF set in HEST, and that just forces people
> to use pcie_ports=native to get around that.
> 

I don't see *any* in the code.  aer_hest_parse() does the HEST table parsing.
It switches to firmware first mode if global flag in HEST is set. Otherwise
for each BDF in device, hest_match_pci() is used to do a cross-matching against
HEST table contents.

Am I missing something?
