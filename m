Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D586C43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 17:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E5821104
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 17:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pm+uYopu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E5821104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbeKTEVd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:21:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730591AbeKTEVc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Nov 2018 23:21:32 -0500
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B017C21104;
        Mon, 19 Nov 2018 17:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542650219;
        bh=V9qtF61GHo4IHDPzDIm25uo5gqIcfl6y2k9N5PFE7KE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pm+uYopuouqkHotCZETTJpAwt/Vi5fVpAItRR1WphMTqtB03DgN4uH9/hMhxM0vd5
         b0LVTVQixVid6y0MVLH/bD68YjvIBdL4fLWQIWqaHYmUSsbTZAVkKiX4WjsDewyw4X
         se4ay461ZRK1mwPV8VP4STZj/P9AdQoOa1n39060=
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
To:     Keith Busch <keith.busch@intel.com>
Cc:     Tyler Baicar <baicar.tyler@gmail.com>, mr.nuke.me@gmail.com,
        helgaas@google.com, austin_bolen@dell.com,
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
 <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
 <ab2427f1-c1f0-68fe-5335-1494caafdcbb@kernel.org>
 <20181119174127.GE26595@localhost.localdomain>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <ef0a24e4-906e-f6df-c646-1fe47ea0dcc0@kernel.org>
Date:   Mon, 19 Nov 2018 12:56:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181119174127.GE26595@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/19/2018 12:41 PM, Keith Busch wrote:
>> Still, breaking existing systems that rely on HEST table is not cool.
>> I'd rather have users specify "pcie_ports=native" to skip FF rather than
>> having broken systems by default to be honest.
> The pcie_ports=native work-around ignores FF to potentially unknown
> results, though.
> 

How about being able to enable/disable FF in BIOS?

We can't really turn off firmware first in the kernel without asking help
from the firmware. Like you said, it causes unpredictable results.

There will be two competing software trying to touch the same registers.
