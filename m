Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D592EC43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 12:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8CF20660
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 12:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="YRdXvqfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8CF20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeK1Xqv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:46:51 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:41468 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeK1Xqv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Nov 2018 18:46:51 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 603B95C03BB;
        Wed, 28 Nov 2018 13:45:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1543409115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i37+8Zmu7QIa2sTS41oBI+kGzorEJQk3OyenywtQJRg=;
        b=YRdXvqfx3U6i0WuVn7huD1kD42AjA5zjH44RKeBEoHg8ZAXBuzfbtHtFEaLq2kI5NU3TBc
        xqy2jdsxdPbugpLhpHE88qqr9Ojy1wQwXqFNMrNQbl3N1cQH7oH2aiebfFF9UnkgReu7nc
        UcYdh95awa1Hnrv11nYdwbpRYPAthSM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 28 Nov 2018 13:45:15 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        gustavo.pimentel@synopsys.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Trent Piepho <tpiepho@impinj.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH v2 3/3] PCI: imx6: limit DBI register length
In-Reply-To: <CAHQ1cqFprD4k+aO_x-znEs6sXpx9jxih-moSuNZZ3dAKHuLpPw@mail.gmail.com>
References: <20181120132705.6917-1-stefan@agner.ch>
 <20181120132705.6917-3-stefan@agner.ch>
 <CAHQ1cqEfjqtJbb6qxTRa-rVvgy8+_Og4Eh21XMRETJHnRG9a6w@mail.gmail.com>
 <CAOMZO5DZRUUkkqNPRZWhK0C56sRU+eQqFzV+akpEvwcKHW1DNw@mail.gmail.com>
 <CAHQ1cqFprD4k+aO_x-znEs6sXpx9jxih-moSuNZZ3dAKHuLpPw@mail.gmail.com>
Message-ID: <482dc823b1567c9a933104b02a6bfeac@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28.11.2018 02:28, Andrey Smirnov wrote:
> On Tue, Nov 27, 2018 at 5:12 PM Fabio Estevam <festevam@gmail.com> wrote:
>>
>> Hi Andrey,
>>
>> On Tue, Nov 27, 2018 at 10:57 PM Andrey Smirnov
>> <andrew.smirnov@gmail.com> wrote:
>>
>> > Could this be a regression? Prior to 415b6185c541 ("PCI: imx6: Fix
>> > config read timeout handling") all of the imprecise aborts were caught
>> > and handled via no-op handler. I did an experiment on i.MX6Q board
>> > that I have (ZII RDU2) and adding a simple no-op for imprecise aborts
>> > via
>> >
>> > hook_fault_code(16 + 6, imx6q_pcie_no_op_handler, SIGBUS, 0,
>> >                        "imprecise external abort");

Unsurprisingly, introducing this handler also "fixes" the issue in my
setup.

FWIW, during my investigation with the Thumb2 issue, I was looking at
the abort handler and its history a bit more closely too. I was about to
suggest readding this handler too, you just beat me by some hours :-)

The current 4.9 downstream BSP still has the old fault handler, and
hence this issue does not happen in the downstream BSP.

>> >
>> > seems to "resolve" this problem:
>>
>> Please check https://patchwork.kernel.org/patch/9720313/
>>
>> This commit fixed a kernel crash on mx6q boards with a PCI switch.
>>
>> So we can't go back to the simple no-op.
> 
> It's probably not exactly clear form my message, but I wasn't
> proposing to go back to a no-op. What I had in mind is having a no-op
> handler for imprecise aborts _alongside_ the non-linefetch handlers
> that is already there when running against i.MX6Q type of the IP
> block.
> 

Agreed, it should be alongside the "external abort on non-linefetch"
handler.

I actually encountered another issue when I had a Intel e1000e running
yesterday. Unfortunately I wasn't able to reproduce the issue, so maybe
it was just a fluke. It probably would be solved by the additional
"imprecise external abort" too:

[   37.644300] fec 2188000.ethernet eth0: Link is Down
[   38.077383] Unhandled fault: imprecise external abort (0x1406) at
0xb64e8000
[   38.084638] pgd = ac4709d6
[   38.087434] [b64e8000] *pgd=00000000
[   38.091129] Internal error: : 1406 [#1] PREEMPT SMP ARM
[   38.096508] CPU: 0 PID: 468 Comm: kworker/0:2 Not tainted
4.19.4-00044-ged7a0cc2ef01-dirty #479
[   38.105428] Hardware name: Freescale i.MX6 Quad/DualLite (Device
Tree)
[   38.112143] Workqueue: events e1000_watchdog_task
[   38.116993] PC is at e1000e_update_stats+0x68/0xa7c
[   38.122008] LR is at e1000_watchdog_task+0xe8/0x71c
[   38.127021] pc : [<c0621238>]    lr : [<c0628d0c>]    psr: 60010013
[   38.133449] sp : ed185ea0  ip : 00007374  fp : ec83ece4
[   38.138814] r10: ec71f700  r9 : ec83c500  r8 : ec83c000
[   38.144180] r7 : ec83c924  r6 : ec83c000  r5 : c1104cc8  r4 :
ec83c500
[   38.150875] r3 : f14c4000  r2 : 000003e8  r1 : 00000000  r0 :
ec83c500
[   38.157573] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment none
[   38.164890] Control: 10c5387d  Table: 3d1c004a  DAC: 00000051
[   38.170789] Process kworker/0:2 (pid: 468, stack limit = 0xbc71b316)
[   38.177306] Stack: (0xed185ea0 to 0xed186000)
[   38.181794] 5ea0: ef7a9100 c0619ba3 ec0870e0 ec087068 ec0870e0
00000000 60010013 c0619ba3
[   38.190184] 5ec0: ef7a8d00 ec83c54c c1104cc8 ec83e54c ec83c924
ec83c000 ec83c500 ec71f700
[   38.198573] 5ee0: ec83ece4 c0628d0c ecbd16c0 c0c0237c ed185f3c
c0b26de0 ec131c04 c0619ba3
[   38.206966] 5f00: c1153fe4 ec83c54c ecdcc100 ef7a8d00 ef7a9e00
00000000 ec83c550 00000000
[   38.221770] 5f20: ef7a8d00 c0136aec c1103d00 ef7a8d18 ecdcc100
ef7a8d00 ecdcc114 c1103d00
[   38.236801] 5f40: ef7a8d18 ffffe000 00000008 c0136d40 ec521c70
c1176068 c0e4213c ed184000
[   38.251874] 5f60: ecfecfdc ecfecfc0 ed0db1c0 00000000 ed184000
ecdcc100 c0136cfc ec0a3ea4
[   38.267199] 5f80: ecfecfdc c013c810 00000000 ed0db1c0 c013c6c8
00000000 00000000 00000000
[   38.282612] 5fa0: 00000000 00000000 00000000 c01010e8 00000000
00000000 00000000 00000000
[   38.298080] 5fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   38.313792] 5fe0: 00000000 00000000 00000000 00000000 00000013
00000000 00000000 00000000
[   38.329716] [<c0621238>] (e1000e_update_stats) from [<c0628d0c>]
(e1000_watchdog_task+0xe8/0x71c)
[   38.346597] [<c0628d0c>] (e1000_watchdog_task) from [<c0136aec>]
(process_one_work+0x1f0/0x400)
[   38.363493] [<c0136aec>] (process_one_work) from [<c0136d40>]
(worker_thread+0x44/0x584)
[   38.379844] [<c0136d40>] (worker_thread) from [<c013c810>]
(kthread+0x148/0x150)
[   38.395575] [<c013c810>] (kthread) from [<c01010e8>]
(ret_from_fork+0x14/0x2c)
[   38.411119] Exception stack(0xed185fb0 to 0xed185ff8)
[   38.420331] 5fa0:                                     00000000
00000000 00000000 00000000
[   38.436662] 5fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   38.452933] 5fe0: 00000000 00000000 00000000 00000000 00000013
00000000
[   38.463661] Code: e590641c e2833901 e5931000 f57ff04f (e280ad9f)

--
Stefan
