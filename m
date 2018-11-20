Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E5CC46475
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 21:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E790214C4
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 21:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvnMfPWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E790214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeKUHdb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:33:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbeKUHda (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Nov 2018 02:33:30 -0500
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EBC120851;
        Tue, 20 Nov 2018 21:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542747745;
        bh=+H4VbaJdQAlv1QbD6GhraMDDwH8w0gYksvJZOrZu0uM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hvnMfPWYZ8w5Dm1JLaNGxfW2uKfN8EbVfwixkLTT11Dhy882EXgHwUDThJkKLRshN
         nqUD8uTVV53d6GxY/ftw9MSKbHRFcbsMZkhBT1Ey1MTst/PRLH2cHD+41tL6EVfhMT
         kAfqXGZI4svGhj3r4WC4kmDFKcW52EOYwUacNLho=
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
 <3b18a9fa-7bdd-0fb4-285d-4efb454be50a@kernel.org>
 <e86f04ef8c054d61969862a6e7b72d0d@ausx13mps321.AMER.DELL.COM>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <314e59da-48e1-545b-3ee9-6e5056b90fd9@kernel.org>
Date:   Tue, 20 Nov 2018 16:02:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <e86f04ef8c054d61969862a6e7b72d0d@ausx13mps321.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/20/2018 3:44 PM, Alex_Gagniuc@Dellteam.com wrote:
> I'd prefer "sure" instead of "think". "I think it breaks some system I'm
> not telling you about" doesn't help much in figuring out how not to
> break said system(s).:)

Sorry, I thought I mentioned why it would break but let me repeat.

The systems I have seen rely on the HEST table presence as an indicator
to the OS that firmware first is enabled. If you go look at the _OSC bits
on such systems, it still says OS owns the AER service.

The assumption here is that HEST table has precedence over the _OSC bits.
That's what needs to be clarified in the UEFI forum.

If this code is to go in and ignore the HEST table presence, then firmware
will think that it owns AER service and OS will think that it owns AER
service too.
