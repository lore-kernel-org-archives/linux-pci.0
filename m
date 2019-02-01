Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C9BC282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 20:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11490218F0
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 20:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NopPOWXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfBAU1D (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:27:03 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:55456 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfBAU1D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2019 15:27:03 -0500
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 62E5924E0D43;
        Fri,  1 Feb 2019 12:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549052822; bh=YvhbZO3dclqexZkXGLTyZVBUFhTslgZqlBxk9MwRxLA=;
        h=From:To:CC:Subject:Date:References:From;
        b=NopPOWXgCabB2zxkCdn/PGvFdK6+jOVcLBWreS+AJ31aOFYyobk0MlUvr278caKcw
         KjJsjvbXeEdRrqIGPu3gxX3lqrBHt3u88igMLx1mUFMbdwh2v7iTHAsXdzqnCc6vHf
         jaNh6CTlHThAIytSTu8TYgdLc1fM6sSyzMqzhBd99RlUy8oNZSeznuQJQZk5tDyDcW
         y2dYDpbHPVFhG2Eejepw3Yx1R6SKKbXem7ZAVVUyJrSPzKsk9OGju2PyYiAyFyx0m3
         klYXe967+Z+XDM3Zv8rYaHSyaJf6aDU+aVvMpsgoIpGanjxGG17EELLa1kHJCrXCES
         HdAesdBVrUD+Q==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B1283A005D;
        Fri,  1 Feb 2019 20:27:01 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Fri, 1 Feb 2019 12:27:01 -0800
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
To:     Lukas Wunner <lukas@wunner.de>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "Lukas F. Hartmann" <lukas@mntmn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Lucas Stach" <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Youn <john.youn@synopsys.com>
Subject: Re: Linux Kernel Regression: HAPS quirk breaks PCIe on i.MX6QP
Thread-Topic: Linux Kernel Regression: HAPS quirk breaks PCIe on i.MX6QP
Thread-Index: AQHUuYlvOcIoiyxgC0SXEBumWw7cKQ==
Date:   Fri, 1 Feb 2019 20:27:00 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639BF351@us01wembx1.internal.synopsys.com>
References: <87o97wrbef.fsf@mntmn.com>
 <CAErSpo4T91kbXXuMSCqrDk=_HD+6GZ64WVZsvhSOtW=L89Pf0g@mail.gmail.com>
 <30102591E157244384E984126FC3CB4F639BEC73@us01wembx1.internal.synopsys.com>
 <30102591E157244384E984126FC3CB4F639BECAB@us01wembx1.internal.synopsys.com>
 <20190201085906.tqp6ysbb65n7jfkv@wunner.de>
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

Hi Lukas,=0A=
=0A=
Lukas Wunner wrote:=0A=
> On Thu, Jan 31, 2019 at 11:46:23PM +0000, Thinh Nguyen wrote:=0A=
>> --- a/drivers/pci/quirks.c=0A=
>> +++ b/drivers/pci/quirks.c=0A=
>> @@ -629,6 +629,9 @@ static void quirk_synopsys_haps(struct pci_dev *pdev=
)=0A=
>>  {=0A=
>>         u32 class =3D pdev->class;=0A=
>>  =0A=
>> +       if (class !=3D PCI_CLASS_SERIAL_USB_XHCI)=0A=
>> +               return;=0A=
>> +=0A=
>>         switch (pdev->device) {=0A=
>>         case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3:=0A=
>>         case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI:=0A=
> Please use DECLARE_PCI_FIXUP_CLASS_HEADER() instead.=0A=
=0A=
Sure. That's a better option. Can you test this with your setup?=0A=
=0A=
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c=0A=
index b0a413f3f7ca..f46e7de9e15d 100644=0A=
--- a/drivers/pci/quirks.c=0A=
+++ b/drivers/pci/quirks.c=0A=
@@ -639,8 +639,8 @@ static void quirk_synopsys_haps(struct pci_dev *pdev)=
=0A=
                break;=0A=
        }=0A=
 }=0A=
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,=0A=
-                        quirk_synopsys_haps);=0A=
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,=0A=
+               PCI_CLASS_SERIAL_USB_XHCI, 0, quirk_synopsys_haps);=0A=
 =0A=
 /*=0A=
  * Let's make the southbridge information explicit instead of having to=0A=
=0A=
=0A=
Thanks,=0A=
Thinh=0A=
