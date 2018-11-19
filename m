Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E68C43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 18:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9C521104
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 18:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wm5rkxyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9C521104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbeKTEs4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:48:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730128AbeKTEs4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Nov 2018 23:48:56 -0500
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E660206BA;
        Mon, 19 Nov 2018 18:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542651853;
        bh=yV1rVaw923ctrstMXbWZZ47ohaFBqDXftmwGiCTdyAs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=wm5rkxytxQVbBIHJa7Hu/UEjjET/nRxEbTBWTA39BWYCCvCO6ejODh5CaQX5T6GrQ
         2ic5zZvoxLMYdHOtCFsE+HXbvb2L7bALfYbFB4++z8+1Zfl3zDbCIYKcjD8GurGM6Y
         UEVD4rxgq9KuJl055h532kSsM/W+FOWy3DY0gQGI=
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
To:     Keith Busch <keith.busch@intel.com>
Cc:     Tyler Baicar <baicar.tyler@gmail.com>, mr.nuke.me@gmail.com,
        austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        Shyam_Iyer@dell.com, lukas@wunner.de, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, oohall@gmail.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
Date:   Mon, 19 Nov 2018 13:24:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181119181051.GA26707@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/19/2018 1:10 PM, Keith Busch wrote:
>> We can't really turn off firmware first in the kernel without asking help
>> from the firmware.
> The _OSC method this patch utilizes is the ACPI spec defined way for
> the kernel to wrest control from firmware. BIOS specific menu settings
> shouldn't be our only recourse when we have a spec authority defining
> generic OS interfaces to accomplish the same thing.
> 
> Unless there is a disagreement on the _OSC interpreation, we'd have to
> accept that platforms breaking from this patch are non-compliant.
> 

It depends on which spec you look :)

UEFI HEST table specification also claims that it should be the ultimate
table for when PCI firmware-first should be disabled/enabled.

I think somebody needs to fix these. I saw an email from Harb Abdulhamid
sent to aswg this morning.

That's why I suggested circulating this idea in UEFI forums first.
Let's see what everybody thinks. We can go from there.
