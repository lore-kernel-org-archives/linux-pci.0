Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175AFC282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 20:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FF12077B
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 20:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IGpw7Hc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfBEUjZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:39:25 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:38598 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfBEUjY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Feb 2019 15:39:24 -0500
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id A27CA10C1DD2;
        Tue,  5 Feb 2019 12:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549399164; bh=DQBLqiZdDHmBvm7bpJ7lGldV4lsu6J3t7fiWhGnBYGk=;
        h=From:To:CC:Subject:Date:References:From;
        b=IGpw7Hc1vHXzxqZYXjZ+st9DMabino2FyKUjBBWM8u7rD9lOuzoiY7+0PtXJqdWT4
         CTDC1gTlHEaxwAQybBrGJpYGHOjnTE55cWUoP8jJEQm3oE1Un58MEBaMZCMFqa5tnr
         GhUlKGbbeECu+dJLbHTElH+H51IJmvmOCCIqFwlsA5nifA857+auPzWWIaaP/liV+n
         elQVy9P9q3Ptx8OyGbYOoO0cQM5OzHhfhToEwVoboML7SZZO120tcpbsEgNYNA6jXA
         IpQwNBEl77Qm3ifsRgXrXvfkTIUKbgj3xV4f1rBjexX+BE6NcIG+pbI0lSY0JmtI4B
         tzSmPXt7QCSXQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id DE970A0093;
        Tue,  5 Feb 2019 20:39:22 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue, 5
 Feb 2019 12:38:58 -0800
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
Date:   Tue, 5 Feb 2019 20:38:58 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639C0F73@us01wembx1.internal.synopsys.com>
References: <87o97wrbef.fsf@mntmn.com>
 <CAErSpo4T91kbXXuMSCqrDk=_HD+6GZ64WVZsvhSOtW=L89Pf0g@mail.gmail.com>
 <30102591E157244384E984126FC3CB4F639BEC73@us01wembx1.internal.synopsys.com>
 <30102591E157244384E984126FC3CB4F639BECAB@us01wembx1.internal.synopsys.com>
 <20190201085906.tqp6ysbb65n7jfkv@wunner.de>
 <30102591E157244384E984126FC3CB4F639BF351@us01wembx1.internal.synopsys.com>
 <20190205200957.GA7268@google.com>
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

Hi Bjorn,=0A=
=0A=
Bjorn Helgaas wrote:=0A=
> On Fri, Feb 01, 2019 at 08:27:00PM +0000, Thinh Nguyen wrote:=0A=
>> Lukas Wunner wrote:=0A=
>>> On Thu, Jan 31, 2019 at 11:46:23PM +0000, Thinh Nguyen wrote:=0A=
>>>> --- a/drivers/pci/quirks.c=0A=
>>>> +++ b/drivers/pci/quirks.c=0A=
>>>> @@ -629,6 +629,9 @@ static void quirk_synopsys_haps(struct pci_dev *pd=
ev)=0A=
>>>>  {=0A=
>>>>         u32 class =3D pdev->class;=0A=
>>>>  =0A=
>>>> +       if (class !=3D PCI_CLASS_SERIAL_USB_XHCI)=0A=
>>>> +               return;=0A=
>>>> +=0A=
>>>>         switch (pdev->device) {=0A=
>>>>         case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3:=0A=
>>>>         case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI:=0A=
>>> Please use DECLARE_PCI_FIXUP_CLASS_HEADER() instead.=0A=
>> Sure. That's a better option. Can you test this with your setup?=0A=
>>=0A=
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c=0A=
>> index b0a413f3f7ca..f46e7de9e15d 100644=0A=
>> --- a/drivers/pci/quirks.c=0A=
>> +++ b/drivers/pci/quirks.c=0A=
>> @@ -639,8 +639,8 @@ static void quirk_synopsys_haps(struct pci_dev *pdev=
)=0A=
>>                 break;=0A=
>>         }=0A=
>>  }=0A=
>> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,=0A=
>> -                        quirk_synopsys_haps);=0A=
>> +DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,=0A=
>> +               PCI_CLASS_SERIAL_USB_XHCI, 0, quirk_synopsys_haps);=0A=
>>  =0A=
>>  /*=0A=
>>   * Let's make the southbridge information explicit instead of having to=
=0A=
>>=0A=
>>=0A=
> Can we get a formal patch, including details about the issue (I assume=0A=
> Synopsys released two different parts with Device ID 0xabcd) and a=0A=
> signed-off-by?=0A=
>=0A=
> I'd like to get this into for-linus as soon as possible for v5.0.=0A=
>=0A=
=0A=
I already submitted a patch for this. Please review patch subject=0A=
"[PATCH] PCI: Check for USB xHCI class for HAPS platform".=0A=
=0A=
Thanks,=0A=
Thinh=0A=
