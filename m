Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76EAC282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 20:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80ECD20863
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 20:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Arxa+WwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbfBAUWg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:22:36 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:60242 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfBAUWf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2019 15:22:35 -0500
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 329C010C1BA5;
        Fri,  1 Feb 2019 12:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549052555; bh=VDd6uZzZV2rObKoRMLaBwUpdxD3wMtRJ2ApeJEMZWgY=;
        h=From:To:CC:Subject:Date:References:From;
        b=Arxa+WwGrmQUpljAMawKaWf/O7MWv+AsHQ8pezJB8UdmZQM1Ewf6KujwrSms68qAd
         jnP5r/+KsyiMox3YKPeRyAlO5D6uG3yl+0P77W5QJUdEXY7Q3lDgj0nOy2V6L+C522
         SDSny3DYr94RFVBTKeVAU5/OwRpaktIcPcQb6cJIiaOuvGOR5ZofRfLz8Lm2ejDjsg
         bWbjZISuisXT0sYizBtCL11O73crw25JsD+qmTQGYIMKF02REsW2ljiLbE8Ud1jIc5
         Xz3WMDsLqx/pTaMPnZa1sttDwvcWcPQoa9l4wDFotT8aMqsTT25FJhVJezy2v+gV+o
         bidpXST6UX8kg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 57F43A005D;
        Fri,  1 Feb 2019 20:22:34 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Fri, 1 Feb 2019 12:22:34 -0800
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
To:     Lukas Hartmann <lukas@mntmn.com>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        John Youn <john.youn@synopsys.com>
Subject: Re: Linux Kernel Regression: HAPS quirk breaks PCIe on i.MX6QP
Thread-Topic: Linux Kernel Regression: HAPS quirk breaks PCIe on i.MX6QP
Thread-Index: AQHUuYlvOcIoiyxgC0SXEBumWw7cKQ==
Date:   Fri, 1 Feb 2019 20:22:33 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639BF33C@us01wembx1.internal.synopsys.com>
References: <87o97wrbef.fsf@mntmn.com>
 <CAErSpo4T91kbXXuMSCqrDk=_HD+6GZ64WVZsvhSOtW=L89Pf0g@mail.gmail.com>
 <30102591E157244384E984126FC3CB4F639BEC73@us01wembx1.internal.synopsys.com>
 <30102591E157244384E984126FC3CB4F639BECAB@us01wembx1.internal.synopsys.com>
 <16AAD0CF-D411-4880-BEE5-11A30F9B4886@mntmn.com>
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
Lukas Hartmann wrote:=0A=
> Hi Thinh,=0A=
>=0A=
> this is in a taped out i.MX6QP 1.2GHz SoC, I also confirmed it with the 1=
.0GHz version, it has the same 0xabcd device id integrated.=0A=
=0A=
I see.=0A=
=0A=
> I will try your patch ASAP.=0A=
=0A=
Thank you.=0A=
Thinh=0A=
=0A=
=0A=
>=0A=
>> On 1. Feb 2019, at 00:46, Thinh Nguyen <thinh.nguyen@synopsys.com> wrote=
:=0A=
>>=0A=
>> Hi Lukas,=0A=
>>=0A=
>> Thinh Nguyen wrote:=0A=
>>> Bjorn Helgaas wrote:=0A=
>>>> [+cc linux-pci, linux-kernel]=0A=
>>>>=0A=
>>>>> On Thu, Jan 31, 2019 at 11:21 AM Lukas F. Hartmann <lukas@mntmn.com> =
wrote:=0A=
>>>>> Hi Thinh,=0A=
>>>>>=0A=
>>>>> I'm writing you because you're the author in this commit:=0A=
>>>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_tor=
valds_linux_commit_03e6742584af8866ba014874669d0440bed3a623&d=3DDwIBaQ&c=3D=
DPL6_X_6JkXFx7AXWqB0tg&r=3DVKipRJmm95P2RbIxyKKYrcUCOGNlQtjlV-5zhrVhIik&m=3D=
2sOrowYXlsC3rl0LfHQhIZzImag0jFZXGvR6NIQDsh8&s=3DoJoBWRE8_LGAYbX2alh6QnjYZTT=
mzcgLw4MtOMToNyo&e=3D=0A=
>>>>>=0A=
>>>>> This quirk workaround breaks the PCIe on i.MX6QP, at least on my test=
=0A=
>>>>> devices. The reason is because the Synposys PCIe IP in i.MX6QP has th=
e=0A=
>>>>> same device ID as the HAPS USB3 controller you are targeting in the=
=0A=
>>>>> commit: 0xabcd.=0A=
>>>>>=0A=
>>>>> Definition:=0A=
>>>>>=0A=
>>>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_tor=
valds_linux_blob_master_include_linux_pci-5Fids.h-23L2364&d=3DDwIBaQ&c=3DDP=
L6_X_6JkXFx7AXWqB0tg&r=3DVKipRJmm95P2RbIxyKKYrcUCOGNlQtjlV-5zhrVhIik&m=3D2s=
OrowYXlsC3rl0LfHQhIZzImag0jFZXGvR6NIQDsh8&s=3D-FVCwe81XNjJsYHYk1w-kdAzSOLun=
TGeNc73azO2QYw&e=3D=0A=
>>>>>=0A=
>>>>> Here is a bit of lspci output on my i.MX6QP machine (without the prob=
lem):=0A=
>>>>>=0A=
>>>>> mntmn@reform:~/code/linux$ lspci -v=0A=
>>>>> 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00=
=0A=
>>>>>                                          ^^^^=0A=
>>>>> [Normal decode])=0A=
>>>>>        Flags: bus master, fast devsel, latency 0, IRQ 307=0A=
>>>>>        Memory at 01000000 (32-bit, non-prefetchable) [size=3D1M]=0A=
>>>>>        Bus: primary=3D00, secondary=3D01, subordinate=3Dff, sec-laten=
cy=3D0=0A=
>>>>> ...=0A=
>>>>>=0A=
>>>>> The failure mode is that the PCIe controller shows up as a USB=0A=
>>>>> controller and my ath9k wireless PCIe card cannot be assigned the=0A=
>>>>> proper resources anymore (-ENOMEM even for very small BARs).=0A=
>>>>>=0A=
>>>>> Reverting this commit fixes the problem for me. I suggest to make the=
=0A=
>>>>> check more specific to the platform/chipset you are targeting.=0A=
>>>> So Synopsys apparently re-used Device ID 0xabcd?  That's a pretty bad =
problem.=0A=
>>>>=0A=
>>>> It looks like we merged 03e6742584af ("PCI: Override Synopsys USB 3.x=
=0A=
>>>> HAPS device class") for v5.0, and v5.0-final hasn't been released yet,=
=0A=
>>>> so if we don't hear from Thinh with a resolution, we can still revert=
=0A=
>>>> it.=0A=
>>>>=0A=
>>>> I set myself a reminder to revert this on Feb 11, but hopefully we'll=
=0A=
>>>> have a better resolution before then.=0A=
>>>>=0A=
>>>> Bjorn=0A=
>>>>=0A=
>>> This is really odd that the PID for the PCIe controller in i.MX6QP is=
=0A=
>>> the same as PID Synopsys use for USB controller. We use a different set=
=0A=
>>> of PIDs for PCIe controllers and track VID and PID in our releases.=0A=
>>>=0A=
>>> Is the Root Complex (00:00.0) part of the SoC? Or is this a Synopsys=0A=
>>> prototype connected to your board? If it is the latter, then the FPGA=
=0A=
>>> configuration needs to be updated to other PID.=0A=
>>>=0A=
