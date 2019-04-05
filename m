Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD1CC282CE
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 22:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9A22171F
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 22:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfDEWLw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:11:52 -0400
Received: from ale.deltatee.com ([207.54.116.67]:58256 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfDEWLv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Apr 2019 18:11:51 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hCX3s-0004Vs-37; Fri, 05 Apr 2019 16:11:48 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Andrew Maier <andrew.maier@eideticom.com>
References: <20190401193302.12813-1-logang@deltatee.com>
 <20190405213939.GC159318@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f7f06f17-b644-dfea-e355-f44c8e920a33@deltatee.com>
Date:   Fri, 5 Apr 2019 16:11:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405213939.GC159318@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: andrew.maier@eideticom.com, sbates@raithlin.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] PCI: Fix issue with "pci=disable_acs_redir" parameter
 being ignored
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-04-05 3:39 p.m., Bjorn Helgaas wrote:
>> -static const char *disable_acs_redir_param;
>> +static char disable_acs_redir_param[COMMAND_LINE_SIZE];
> 
> I certainly acknowledge the problem, but I'm a little hesitant to add
> a static buffer of 256-4096 bytes (2048 on x86, arm64, powerpc, sparc)
> for a relatively low-usage situation.  The memory usage doesn't seem
> in proportion to the value-add.
> 
> Ugh, and we allocate another similar buffer for
> resource_alignment_param[], which I would guess is also rarely used.

Yeah, I was looking for a better solution and eventually decided to just
copy what was done in the past.

> Since disable_acs_redir_param[] and resource_alignment_param[] are
> both read-only and big enough to hold the entire command line, we
> should be able to share a single buffer between them if we made the
> parsers a little smarter.  

That sounds like a good idea that I didn't think of. If I can't find
something better, I'll do that.

> In fact, I bet there's already a static
> copy lying around somewhere for /proc/cmdline.

There are lots of copies of cmdline around, but none that are available
for early param. I did a sampling of some of the other early params but
none seem to be anywhere near as complex as the PCI one and I haven't
yet found one that needs to keep a copy of any or all of the command line.

In any case, I'll keep digging and try to get a better patch for you
shortly.

Logan
