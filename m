Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AE2C43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 19:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA222084B
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 19:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbfDATW5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:22:57 -0400
Received: from ale.deltatee.com ([207.54.116.67]:45288 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfDATW5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Apr 2019 15:22:57 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hB2WE-0008JM-Qx; Mon, 01 Apr 2019 13:22:56 -0600
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
Message-ID: <07af1407-7253-56a1-495e-2ef7c28737af@deltatee.com>
Date:   Mon, 1 Apr 2019 13:22:54 -0600
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

Hey Bjorn,

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

Any chance you've had a chance to go through this issue yet? Is there
anything I should do with it? Do you want me to try to improve the
commit messages and resend the patches?

Thanks,

Logan
