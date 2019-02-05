Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80156C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 21:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FBE2184B
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 21:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cFqBvL1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBEVff (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:35:35 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:58400 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbfBEVff (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Feb 2019 16:35:35 -0500
Received: from mailhost.synopsys.com (unknown [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 14CE624E2830;
        Tue,  5 Feb 2019 13:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549402534; bh=BbGZQwurjAUTEDM/Z0yMKvSMfq8TIh9SQUexyCZG/MM=;
        h=From:To:CC:Subject:Date:References:From;
        b=cFqBvL1uFIq2ccWd4mNsKgSvQ6wMrU/7H95kG83qRdgaXWZfHK13xtlvOlDlaXw8p
         d+Jsx8065EEIcGuA9OoH9kfDebUseF5v2c+/ld0frpubjMumQXhLfDmBxefzhOM5vv
         2R8Y2RTau8VBQ4yKqM3j0tf4iozI9VJkPI26TCsLD4Dnlq+hp/D1bvwBcSFduLuw1h
         7EpAh0eVRnB9ba0KrFwP70pI5ZmqgFTs8Yv/sQ9Er/4dZpIc1KC704J68c6lm1a/ja
         tz+BPk8JuPxmhXjA3CFSnxZ6Y2shXmR8v6T5Dqj5NtsMO+2Z5Eh3pOrG+9uR3gbk6B
         cHeOE3nOb+dYg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E907FA00C5;
        Tue,  5 Feb 2019 21:35:33 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue, 5
 Feb 2019 13:33:34 -0800
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>
CC:     Lukas Wunner <lukas@wunner.de>,
        "Lukas F. Hartmann" <lukas@mntmn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Youn <john.youn@synopsys.com>
Subject: Re: Linux Kernel Regression: HAPS quirk breaks PCIe on i.MX6QP
Thread-Topic: Linux Kernel Regression: HAPS quirk breaks PCIe on i.MX6QP
Thread-Index: AQHUuYlvOcIoiyxgC0SXEBumWw7cKQ==
Date:   Tue, 5 Feb 2019 21:33:33 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639C0FEB@us01wembx1.internal.synopsys.com>
References: <87o97wrbef.fsf@mntmn.com>
 <CAErSpo4T91kbXXuMSCqrDk=_HD+6GZ64WVZsvhSOtW=L89Pf0g@mail.gmail.com>
 <30102591E157244384E984126FC3CB4F639BEC73@us01wembx1.internal.synopsys.com>
 <30102591E157244384E984126FC3CB4F639BECAB@us01wembx1.internal.synopsys.com>
 <20190201085906.tqp6ysbb65n7jfkv@wunner.de>
 <30102591E157244384E984126FC3CB4F639BF351@us01wembx1.internal.synopsys.com>
 <20190205200957.GA7268@google.com>
 <30102591E157244384E984126FC3CB4F639C0F73@us01wembx1.internal.synopsys.com>
 <20190205205922.GB7268@google.com>
 <30102591E157244384E984126FC3CB4F639C0FA9@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.20]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thinh Nguyen wrote:=0A=
> Bjorn Helgaas wrote:=0A=
>> On Tue, Feb 05, 2019 at 08:38:58PM +0000, Thinh Nguyen wrote:=0A=
>>> Hi Bjorn,=0A=
>>>=0A=
>>> Bjorn Helgaas wrote:=0A=
>>>> On Fri, Feb 01, 2019 at 08:27:00PM +0000, Thinh Nguyen wrote:=0A=
>>>>> Lukas Wunner wrote:=0A=
>>>>>> On Thu, Jan 31, 2019 at 11:46:23PM +0000, Thinh Nguyen wrote:=0A=
>>>>>>> --- a/drivers/pci/quirks.c=0A=
>>>>>>> +++ b/drivers/pci/quirks.c=0A=
>>>>>>> @@ -629,6 +629,9 @@ static void quirk_synopsys_haps(struct pci_dev =
*pdev)=0A=
>>>>>>>  {=0A=
>>>>>>>         u32 class =3D pdev->class;=0A=
>>>>>>>  =0A=
>>>>>>> +       if (class !=3D PCI_CLASS_SERIAL_USB_XHCI)=0A=
>>>>>>> +               return;=0A=
>>>>>>> +=0A=
>>>>>>>         switch (pdev->device) {=0A=
>>>>>>>         case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3:=0A=
>>>>>>>         case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI:=0A=
>>>>>> Please use DECLARE_PCI_FIXUP_CLASS_HEADER() instead.=0A=
>>>>> Sure. That's a better option. Can you test this with your setup?=0A=
>>>>>=0A=
>>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c=0A=
>>>>> index b0a413f3f7ca..f46e7de9e15d 100644=0A=
>>>>> --- a/drivers/pci/quirks.c=0A=
>>>>> +++ b/drivers/pci/quirks.c=0A=
>>>>> @@ -639,8 +639,8 @@ static void quirk_synopsys_haps(struct pci_dev *p=
dev)=0A=
>>>>>                 break;=0A=
>>>>>         }=0A=
>>>>>  }=0A=
>>>>> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,=0A=
>>>>> -                        quirk_synopsys_haps);=0A=
>>>>> +DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,=
=0A=
>>>>> +               PCI_CLASS_SERIAL_USB_XHCI, 0, quirk_synopsys_haps);=
=0A=
>>>>>  =0A=
>>>>>  /*=0A=
>>>>>   * Let's make the southbridge information explicit instead of having=
 to=0A=
>>>>>=0A=
>>>>>=0A=
>>>> Can we get a formal patch, including details about the issue (I assume=
=0A=
>>>> Synopsys released two different parts with Device ID 0xabcd) and a=0A=
>>>> signed-off-by?=0A=
>>>>=0A=
>>>> I'd like to get this into for-linus as soon as possible for v5.0.=0A=
>>> I already submitted a patch for this. Please review patch subject=0A=
>>> "[PATCH] PCI: Check for USB xHCI class for HAPS platform".=0A=
>> OK, maybe I'm missing something.  I don't see it on the linux-pci list=
=0A=
>> [1] or the PCI patchwork [2] yet.  Maybe it's still making its way=0A=
>> through the mailing list servers.  If you have a URL to the archive or=
=0A=
>> patchwork, let me know.=0A=
>>=0A=
>> Bjorn=0A=
>>=0A=
>> [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.o=
rg_linux-2Dpci_&d=3DDwIBAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3Du9FYoxKtyhjrGFcyi=
xFYqTjw1ZX0VsG2d8FCmzkTY-w&m=3Dgf8tJEWOt92UvWl-0yPhkFlhOXuG0fn-pG0zPdqsHv8&=
s=3DvQgsCLqN63Bd-d7ZMY5HPVmBa4Htnz64oO96cG-6pNA&e=3D=0A=
>> [2] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__patchwork.ozl=
abs.org_project_linux-2Dpci_list&d=3DDwIBAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D=
u9FYoxKtyhjrGFcyixFYqTjw1ZX0VsG2d8FCmzkTY-w&m=3Dgf8tJEWOt92UvWl-0yPhkFlhOXu=
G0fn-pG0zPdqsHv8&s=3DTbm0SOa0CCxMxzGcwT6YJrYYzVEU6x7sR8JB9l82VGg&e=3D=0A=
=0A=
After I removed some names in the CC list, it looks like it appears on=0A=
PCI patchwork now.=0A=
https://patchwork.ozlabs.org/patch/1037211/=0A=
=0A=
Thanks,=0A=
Thinh=0A=
