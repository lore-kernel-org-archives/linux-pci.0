Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB15BC169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 23:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630092087F
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 23:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CX9g65eJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfAaXrc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 18:47:32 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:40484 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfAaXrc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 18:47:32 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 1876A24E08D3;
        Thu, 31 Jan 2019 15:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548978452; bh=BtkWIybZzMAOpJ0h2reQTzrDIDWg4hOCsWS06svr484=;
        h=From:To:CC:Subject:Date:References:From;
        b=CX9g65eJF7t34vUT98LGiZi5n2UQAKX7Q1aSqscly1KV4unzfNgjWoEEHRuYLw0dV
         QFPE0ODgpoIozDd2dkZHw7F2jtlkaJzXiB/i9IlQdYjNzzWI7glQE7q6Ju9pQ077ex
         qx8nQVXxsW7PVloOzeuhS8kGzhU1nUNhj9hV1er6zdB6OOwfNfVIT7Wn0bYHMDERmT
         X7FKyD//HJSDC/o1CTK++3li4D7AQPCr0/HbKj60viC2jElHm9xikb7f9L9kvkntO4
         1x3Lvhk3ckut9QllZ0yqLs8IESnR6c5fD2MRnltmSH2ldiLhPPiJlLfrB8nh/rNL+O
         dgGPZzsJM0/CA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 77DE2A0091;
        Thu, 31 Jan 2019 23:47:31 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 31 Jan 2019 15:46:24 -0800
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Lukas F. Hartmann" <lukas@mntmn.com>
CC:     "thinh.nguyen@synopsys.com" <thinh.nguyen@synopsys.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Youn <john.youn@synopsys.com>
Subject: Re: Linux Kernel Regression: HAPS quirk breaks PCIe on i.MX6QP
Thread-Topic: Linux Kernel Regression: HAPS quirk breaks PCIe on i.MX6QP
Thread-Index: AQHUuYlvOcIoiyxgC0SXEBumWw7cKQ==
Date:   Thu, 31 Jan 2019 23:46:23 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639BECAB@us01wembx1.internal.synopsys.com>
References: <87o97wrbef.fsf@mntmn.com>
 <CAErSpo4T91kbXXuMSCqrDk=_HD+6GZ64WVZsvhSOtW=L89Pf0g@mail.gmail.com>
 <30102591E157244384E984126FC3CB4F639BEC73@us01wembx1.internal.synopsys.com>
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
Thinh Nguyen wrote:=0A=
> Bjorn Helgaas wrote:=0A=
>> [+cc linux-pci, linux-kernel]=0A=
>>=0A=
>> On Thu, Jan 31, 2019 at 11:21 AM Lukas F. Hartmann <lukas@mntmn.com> wro=
te:=0A=
>>> Hi Thinh,=0A=
>>>=0A=
>>> I'm writing you because you're the author in this commit:=0A=
>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_torva=
lds_linux_commit_03e6742584af8866ba014874669d0440bed3a623&d=3DDwIBaQ&c=3DDP=
L6_X_6JkXFx7AXWqB0tg&r=3DVKipRJmm95P2RbIxyKKYrcUCOGNlQtjlV-5zhrVhIik&m=3D2s=
OrowYXlsC3rl0LfHQhIZzImag0jFZXGvR6NIQDsh8&s=3DoJoBWRE8_LGAYbX2alh6QnjYZTTmz=
cgLw4MtOMToNyo&e=3D=0A=
>>>=0A=
>>> This quirk workaround breaks the PCIe on i.MX6QP, at least on my test=
=0A=
>>> devices. The reason is because the Synposys PCIe IP in i.MX6QP has the=
=0A=
>>> same device ID as the HAPS USB3 controller you are targeting in the=0A=
>>> commit: 0xabcd.=0A=
>>>=0A=
>>> Definition:=0A=
>>>=0A=
>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_torva=
lds_linux_blob_master_include_linux_pci-5Fids.h-23L2364&d=3DDwIBaQ&c=3DDPL6=
_X_6JkXFx7AXWqB0tg&r=3DVKipRJmm95P2RbIxyKKYrcUCOGNlQtjlV-5zhrVhIik&m=3D2sOr=
owYXlsC3rl0LfHQhIZzImag0jFZXGvR6NIQDsh8&s=3D-FVCwe81XNjJsYHYk1w-kdAzSOLunTG=
eNc73azO2QYw&e=3D=0A=
>>>=0A=
>>> Here is a bit of lspci output on my i.MX6QP machine (without the proble=
m):=0A=
>>>=0A=
>>> mntmn@reform:~/code/linux$ lspci -v=0A=
>>> 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00=0A=
>>>                                           ^^^^=0A=
>>> [Normal decode])=0A=
>>>         Flags: bus master, fast devsel, latency 0, IRQ 307=0A=
>>>         Memory at 01000000 (32-bit, non-prefetchable) [size=3D1M]=0A=
>>>         Bus: primary=3D00, secondary=3D01, subordinate=3Dff, sec-latenc=
y=3D0=0A=
>>> ...=0A=
>>>=0A=
>>> The failure mode is that the PCIe controller shows up as a USB=0A=
>>> controller and my ath9k wireless PCIe card cannot be assigned the=0A=
>>> proper resources anymore (-ENOMEM even for very small BARs).=0A=
>>>=0A=
>>> Reverting this commit fixes the problem for me. I suggest to make the=
=0A=
>>> check more specific to the platform/chipset you are targeting.=0A=
>> So Synopsys apparently re-used Device ID 0xabcd?  That's a pretty bad pr=
oblem.=0A=
>>=0A=
>> It looks like we merged 03e6742584af ("PCI: Override Synopsys USB 3.x=0A=
>> HAPS device class") for v5.0, and v5.0-final hasn't been released yet,=
=0A=
>> so if we don't hear from Thinh with a resolution, we can still revert=0A=
>> it.=0A=
>>=0A=
>> I set myself a reminder to revert this on Feb 11, but hopefully we'll=0A=
>> have a better resolution before then.=0A=
>>=0A=
>> Bjorn=0A=
>>=0A=
> This is really odd that the PID for the PCIe controller in i.MX6QP is=0A=
> the same as PID Synopsys use for USB controller. We use a different set=
=0A=
> of PIDs for PCIe controllers and track VID and PID in our releases.=0A=
>=0A=
> Is the Root Complex (00:00.0) part of the SoC? Or is this a Synopsys=0A=
> prototype connected to your board? If it is the latter, then the FPGA=0A=
> configuration needs to be updated to other PID.=0A=
>=0A=
> We're investigating the workaround in case this is on a taped-out SoC.=0A=
=0A=
Can you try to see if this will help?=0A=
=0A=
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c=0A=
index b0a413f3f7ca..64623fbdd1e5 100644=0A=
--- a/drivers/pci/quirks.c=0A=
+++ b/drivers/pci/quirks.c=0A=
@@ -629,6 +629,9 @@ static void quirk_synopsys_haps(struct pci_dev *pdev)=
=0A=
 {=0A=
        u32 class =3D pdev->class;=0A=
 =0A=
+       if (class !=3D PCI_CLASS_SERIAL_USB_XHCI)=0A=
+               return;=0A=
+=0A=
        switch (pdev->device) {=0A=
        case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3:=0A=
        case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI:=0A=
=0A=
Thanks,=0A=
Thinh=0A=
=0A=
=0A=
