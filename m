Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FABC46465
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 20:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDDA20851
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 20:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="w4/7j6M3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDDA20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbeKUHNc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:13:32 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:53406 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeKUHNc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Nov 2018 02:13:32 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 28D2D5C16C3;
        Tue, 20 Nov 2018 21:42:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1542746550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JIlkzFL5ni1KQvifw/xP3TQWVR+SYj4kPGw/PyVmLKY=;
        b=w4/7j6M3qZgHwZWOhZZ/qfjQlPUo1r1SIkVDq1AlZiwtM54VDKy0AmfRK9eEW3/3OgqGMK
        bVZREMTUPiwV/+sXToAtLNKVNnPWNyOWPsQeYO4h6WQkBWX+RUcmuQgZxM0gmruGAA4AsW
        y5HqOWSftVYGDb7zUQZJL9Yt6c4j/so=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 20 Nov 2018 21:42:28 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     l.stach@pengutronix.de, lorenzo.pieralisi@arm.com,
        leonard.crestez@nxp.com, jingoohan1@gmail.com,
        linux-kernel@vger.kernel.org, andrew.smirnov@gmail.com,
        hongxing.zhu@nxp.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v3 2/2] PCI: imx6: limit DBI register length
In-Reply-To: <1542741198.30311.608.camel@impinj.com>
References: <20181120165626.26424-1-stefan@agner.ch>
 <20181120165626.26424-2-stefan@agner.ch>
 <581b9548043d5276f6685f534386180fd0673a9a.camel@nxp.com>
 <1542741198.30311.608.camel@impinj.com>
Message-ID: <268e109e1c6b309454bd5a313078894c@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20.11.2018 20:13, Trent Piepho wrote:
> On Tue, 2018-11-20 at 18:19 +0000, Leonard Crestez wrote:
>> On Tue, 2018-11-20 at 17:56 +0100, Stefan Agner wrote:
>> > Define the length of the DBI registers. This makes sure that
>> > the kernel does not access registers beyond that point, avoiding
>> > the following abort on a i.MX 6Quad:
>> >   # cat
>> > /sys/devices/soc0/soc/1ffc000.pcie/pci0000\:00/0000\:00\:00.0/config
>> >   [  100.021433] Unhandled fault: imprecise external abort (0x1406)
>> > at 0xb6ea7000
>> >   ...
>> >   [  100.056423] PC is at dw_pcie_read+0x50/0x84
>> >   [  100.060790] LR is at dw_pcie_rd_own_conf+0x44/0x48
>>
>> I don't know exactly where this limitation comes from, I can indeed
>> reproduce a stack dump when dumping pci config from /sys/
>>
>> Unfortunately this seems to block access to registers used for
>> functionality like interrupts. For example dw_handle_msi_irq does:
>>
>> 	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS +
>> 			    (i * MSI_REG_CTRL_BLOCK_SIZE),
>> 			    4, &val);
>>
>> where PCI_MSI_INTR0_STATUS is 0x830. There are more accesses like this.
>>
>> Testing on 6dl-sabreauto (dts change required) with an ath9k pcie card
>> with your series I sometimes get "irq 295: nobody cared" on boot. Maybe
>> I'm missing something?
> 
> On IMX7d, there are significant blocks of 00s in the config space, and
> all 0xff at 0xb50 on up.
> 
> I.e., significant portions are empty, in the middle of the config
> space, not just at the end.
> 
> But they can be read without problem.
> 
> Perhaps imx6q aborts on a read of an unimplemented address instead of
> returning zeros like imx7d.  In that case it really needs something
> more complex to prevent abort than just a length.

Yeah it seems those SoCs behave differently.

Describing a register set with holes will get complicated, I guess it
would ask for a regmap...

> 
> It also seems to me that this doesn't need to be in the internal pci
> config access functions.  The driver shouldn't be reading registers
> that don't exist anyway.  It's really about trying to fix sysfs access
> to registers that don't exist.  So maybe it should be done there.

That was my first approach, see:
https://lkml.org/lkml/2018/11/14/716

--
Stefan
