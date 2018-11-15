Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1882FC43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 15:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C4D223DD
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 15:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="IUWOUwjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C4D223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388019AbeKPBIp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:08:45 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:33834 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeKPBIp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Nov 2018 20:08:45 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id AB1E15C01B3;
        Thu, 15 Nov 2018 16:00:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1542294032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JcLgJnD6eOHQXjlmSk/bIMlwhUbgE58oh5D2cAkD/9I=;
        b=IUWOUwjQzgsY4q1kPedE5JN5AGPSx7M7AXtd9Lw/NcAzl+GRlKccx4mB2nbyHXLct39pjJ
        p2BfxZ/2qAv2ZOn7mkXwtI+itgHwXQ3gzlAiG61WbyE+ATtnp2BMWMNKnZYqQ6HZLN++Xk
        SQHxJ8XACQA3Z6KOJfdia6OSqiBlrLY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 15 Nov 2018 16:00:32 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     jingoohan1@gmail.com, l.stach@pengutronix.de,
        gustavo.pimentel@synopsys.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] PCI: dwc: Limit config space size for i.MX6
In-Reply-To: <1542224641.30311.478.camel@impinj.com>
References: <20181019111350.6170-1-stefan@agner.ch>
 <40d0c27d612534033d146497029b1922@agner.ch>
 <1542224641.30311.478.camel@impinj.com>
Message-ID: <b06c24705caddf2f1e97237fd6aa3523@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14.11.2018 20:44, Trent Piepho wrote:
> On Wed, 2018-11-14 at 16:49 +0100, Stefan Agner wrote:
>> On 19.10.2018 13:13, Stefan Agner wrote:
>> > Reading the full 4k config space through sysfs leads to an
>> > external abort. Testing on a platform showed that the upper
>> > limit is 512. Limit config space to 512.
>>
>> Any comment on this patch?
>>
>> Since other devices use similar quirks, I guess the fix can't be far
>> off?
>>
>> Maybe restricting to the PCI device ID used in i.MX 6 only is too
>> restrictive, but I guess better restrictive for now?
> 
> To trigger this bug I should read the sysfs "config" file for the PCI
> bridge device?
> 
> Tested on imx7, no problems.
> 
> # hexdump -C
> /sys/devices/platform/soc/30800000.aips-bus/33800000.pcie/pci0000:00/0000:00:00.0/config
>                                                                       
>
> [stuff]
> 00000130  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 
> |................|
> *                                                                     
>
> 00000400  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff 
> |................|
> *                                                                     
>
> 00000700  76 00 63 01 ff ff ff ff  04 00 00 07 00 f0 f0 1b 
> |v.c.............|
> [more stuff]
> 
> The bridge on imx7d is 16c3:abcd, same as patch I believe.  I do have a
> pci-e device connected, unlike the original bug.  Maybe that is
> related?  Or maybe this problem is fixed in imx7d?

The i.MX 7D seems to have a different register set...

I don't think it is related to whether a PCIe device is connected or
not.

The fact that i.MX 7D has the same device id and does not suffer the
problem actually shows that the approach this patch takes is not
ideal...

Will send a patch limiting register access on a per driver/compatible
string level.

--
Stefan

> 
>> >
>> >  #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
>> > +#define PCI_DEVICE_ID_SYNOPSYS_IMX6	0xabcd
>> >
>> >  #define PCI_VENDOR_ID_VITESSE		0x1725
>> >  #define PCI_DEVICE_ID_VITESSE_VSC7174	0x7174
