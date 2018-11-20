Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE170C32788
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 22:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE52E2147D
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 22:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zEB/rkfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE52E2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbeKUIj5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:39:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbeKUIj5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Nov 2018 03:39:57 -0500
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3294B20C01;
        Tue, 20 Nov 2018 22:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542751717;
        bh=Nj6iELAkQQxYCZbhsXDSV8wHQH7XanhdNLzW76MFiZA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=zEB/rkfD7uhAxxwED87kSsx9KhTQrETujXmrg0Q/VtgiF29D7+AZkoBKUwMcKWNO2
         fLlSb4fK3jyr8AH/SVpelihMXL7nR+gF2aMKy6x8QyHQtOkduj6mkeq/yx+Ff3ErnH
         ZpThzDvYwZSlbEVoTd595KlXohV8PCqoaoNwE/7s=
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
 <3b18a9fa-7bdd-0fb4-285d-4efb454be50a@kernel.org>
 <e86f04ef8c054d61969862a6e7b72d0d@ausx13mps321.AMER.DELL.COM>
 <314e59da-48e1-545b-3ee9-6e5056b90fd9@kernel.org>
 <4728316eb84446358e0a07bbf1e42b57@ausx13mps321.AMER.DELL.COM>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <bac2c78a-cd56-7287-e4fd-6042e9b3432c@kernel.org>
Date:   Tue, 20 Nov 2018 17:08:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <4728316eb84446358e0a07bbf1e42b57@ausx13mps321.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/20/2018 4:46 PM, Alex_Gagniuc@Dellteam.com wrote:
> Now, let's assume, for the sake of argument, that the firmware on those
> system's is broken, and it didn't intend to give the OS control of AER.
> OSPM checking HEST instead of _OSC is still wrong, according to the
> spec. Two wrongs don't make a right, they just don't crash.
> 
> I think the correct way is to identify those broken systems, and add
> quirks for them. Continuing to have inconsistent and over-complicated
> logic that is not spec compliant is not any better.

Remember that both _OSC and HEST are in the ACPI specification. I don't
think there is a consensus on what is "wrong".

There is certainly a need for spec clarification.

One version is:

"if HEST table is present, ignore _OSC"

or

Another version is:

"if HEST table is present, make sure that FW sets _OSC bit for AER to
false. Otherwise, warn like crazy that this BIOS is broken and needs
an update and can cause all sorts of trouble"

I can see both points of view. The second one can also be worked around
by an SMBIOS quirk too as you suggested. Counting the number of quirks
and random bug reports will be an interesting exercise / regression.

I followed the ASWG thread yesterday. There will be a meeting next week to
discuss this.

My preference is not to introduce new behavior/regression to the kernel.
