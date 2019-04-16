Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE46DC10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 18:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEA42075B
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 18:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfDPSdG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:33:06 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:50227 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728373AbfDPSdG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 14:33:06 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from spencer@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 16 Apr 2019 21:32:59 +0300
Received: from [10.15.7.186] ([10.15.7.186])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x3GIWtAt002772;
        Tue, 16 Apr 2019 14:32:56 -0400
Subject: Re: [PATCH] PCI: pciehp: Fix false command timeouts on boot
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Keith Busch <keith.busch@intel.com>
References: <1554919668-24873-1-git-send-email-spencer@mellanox.com>
 <20190414193641.xo7yf4uqh7ci7lci@wunner.de>
 <20190415025908.bd45jqtp62eeuiuz@wunner.de>
From:   Spencer Lingard <spencer@mellanox.com>
Reply-To: spencer@mellanox.com
Message-ID: <a24e3667-9aa6-1ee5-0746-c780523cc0bf@mellanox.com>
Date:   Tue, 16 Apr 2019 14:32:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415025908.bd45jqtp62eeuiuz@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/14/2019 10:59 PM, Lukas Wunner wrote:
> On Sun, Apr 14, 2019 at 09:36:41PM +0200, Lukas Wunner wrote:
>> I suppose this can happen if a write to the Slot Control register is
>> performed while HPIE and/or CCIE is disabled, the two notifications
>> are subsequently enabled and another write to the Slot Control is
>> performed.  That second write will then call wait_event_timeout()
>> because of the stale ctrl->cmd_busy == 1, but the Command Complete
>> notification has already happened and was cleared by pcie_poll_cmd(),
>> hence it times out.
>>
>> Sounds reasonable, I'm a little suprised though that I've never seen
>> this myself.  I guess we've been doing this wrong for years, so:
> On second thought, it's not surprising at all that I never saw this
> because Thunderbolt sets NoCompl+, so doesn't use Command Complete
> notifications.
>
> I suspect that even though we've been doing this wrong for a long time,
> the bug was exposed by a recent change to pciehp.  Do you happen to
> know since which kernel version or commit you've been witnessing the
> timeouts?

Hi Lukas, thank you for your time.

We started seeing these timeouts when we went to 4.20.5 from 4.14.61.

In pcie_init(), there's a check that turns off a slot if it's powered on
but unoccupied. Before 4e6a13356f1c ("PCI: pciehp: Deduplicate presence
check on probe & resume"), that power check was at the end of
pcie_probe(), after the IRQ is requested. I've investigated a little and
found that the delays go away if the power check is moved back where it
was before that commit.

- Spencer
