Return-Path: <SRS0=xyCL=RH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7CAC43381
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 20:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7844620684
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 20:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfCDUjC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:39:02 -0500
Received: from ale.deltatee.com ([207.54.116.67]:49652 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfCDUjC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Mar 2019 15:39:02 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h0uMX-0003up-AL; Mon, 04 Mar 2019 13:39:02 -0700
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Kit Chow <kchow@gigaio.com>, Yinghai Lu <yinghai@kernel.org>
References: <20190214170028.27862-1-logang@deltatee.com>
 <20190304002351.GA26569@google.com>
 <3e45b4ab-e848-cf3b-624f-121ad58b0250@deltatee.com>
 <CAErSpo4U6Kys5OzPwfyFdbnJWfTZ-y0P830okf11BwfNv9Y82A@mail.gmail.com>
 <ac64ba0e-e86a-f7ae-775b-753f933f178f@deltatee.com>
 <CAErSpo5icDM2VgYoLdEp8C-CV5XEMThABMA8RBq64grhRSkRWA@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d547770e-9c9d-a73d-8f2d-8bcb8ee4f363@deltatee.com>
Date:   Mon, 4 Mar 2019 13:39:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAErSpo5icDM2VgYoLdEp8C-CV5XEMThABMA8RBq64grhRSkRWA@mail.gmail.com>
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



On 2019-03-04 1:29 p.m., Bjorn Helgaas wrote:
>> I agree, but reworking this code scares me and I suspect it was designed
>> this way for a reason. I'm guessing there are a lot of corner cases and
>> unusual bios issues this stuff works around. We might end up fixing a
>> some cases and breaking a bunch of other cases.
> 
> Scares me too, which is one reason I haven't done anything about it.
> 
> I didn't mean to suggest that you should rework it for *this* issue.
> I just keep hoping that we can chip away at teensy pieces and in ten
> or twenty years maybe make some headway.

Sure. Just trying to brainstorm some ideas.

Another idea to chip away at things might be that instead of
pbus_size_mem() trying to find an appropriate bridge resources by
looping, we simply pass the resource it's supposed to use (which I
suspect __pci_bus_size_bridges should be able to figure out ahead of
time. So instead of guessing and testing for a bunch of different
resource window types we might have, just loop through the actually
available windows and group the resources in what we have. Once we've
sorted out these patches, when I have some free time, I might try
working out a cleanup patch in this direction that we could test and
merge slowly.

Logan
