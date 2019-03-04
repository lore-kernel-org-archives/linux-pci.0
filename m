Return-Path: <SRS0=xyCL=RH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3229FC43381
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 20:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E53206B6
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 20:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCDUV5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:21:57 -0500
Received: from ale.deltatee.com ([207.54.116.67]:49500 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfCDUV5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Mar 2019 15:21:57 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h0u5y-0003kd-Tl; Mon, 04 Mar 2019 13:21:56 -0700
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Kit Chow <kchow@gigaio.com>, Yinghai Lu <yinghai@kernel.org>
References: <20190214170028.27862-1-logang@deltatee.com>
 <20190304002351.GA26569@google.com>
 <3e45b4ab-e848-cf3b-624f-121ad58b0250@deltatee.com>
 <CAErSpo4U6Kys5OzPwfyFdbnJWfTZ-y0P830okf11BwfNv9Y82A@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ac64ba0e-e86a-f7ae-775b-753f933f178f@deltatee.com>
Date:   Mon, 4 Mar 2019 13:21:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAErSpo4U6Kys5OzPwfyFdbnJWfTZ-y0P830okf11BwfNv9Y82A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: yinghai@kernel.org, kchow@gigaio.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org, bhelgaas@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/2] PCI: Prevent 64-bit resources from being counted in
 32-bit bridge region
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-03-04 1:11 p.m., Bjorn Helgaas wrote:
> On Mon, Mar 4, 2019 at 1:21 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>> On 2019-03-03 5:23 p.m., Bjorn Helgaas wrote:
>>> Sorry for the delay.  This code gives a headache.  I still remember
>>> my headache from the last time we touched it.  Help me understand
>>> what's going on here.
>>
>> Yes, this code gave me a headache debugging it too. And it's not the
>> first time I've tried to figure out what's going on with it because it
>> often just prints noisy messages that look like errors. I think I
>> understand it better now but it's something that's a bit fleeting and
>> easy to forget the details of. There may also be other solutions to this
>> problem.
> 
> Thanks for the explanation below.  I haven't worked through it yet, but I will.
> 
> Obviously it would be far better than an explanation if we could
> simplify the code (and the noisy messages) such that it didn't
> *require* so much explanation.

I agree, but reworking this code scares me and I suspect it was designed
this way for a reason. I'm guessing there are a lot of corner cases and
unusual bios issues this stuff works around. We might end up fixing a
some cases and breaking a bunch of other cases.

It would probably be a lot simpler if (for 'realloc', at least) it
unassigns everything then only does one pass. It wouldn't make the code
itself much simpler but it would might make it easier to reason about
and debug; and would also remove a lot of the noisy messages. I suspect
the multi-pass setup would still be required for cases where the bios
doesn't assign a device or whatever it's doing and it was probably
designed this way to try and keep as many of the bios assignments the
same as possible, though I'm not really sure if that would be necessary.

Logan
