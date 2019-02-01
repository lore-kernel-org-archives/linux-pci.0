Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B025CC282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 08:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D45120863
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 08:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mntmn.com header.i=@mntmn.com header.b="wTh7+6ut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfBAIF5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:05:57 -0500
Received: from softboy.mntmn.com ([91.250.115.15]:55366 "EHLO
        softboy.mntmn.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfBAIF4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2019 03:05:56 -0500
Content-Type: text/plain;
        charset=us-ascii
DKIM-Filter: OpenDKIM Filter v2.11.0 softboy.mntmn.com 93816720395
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mntmn.com; s=mailout;
        t=1549008354; bh=bohia/1xL1CZDd+h94ynPHhIlnoaE0DMamoBkVr+LE0=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=wTh7+6utKgv7TQQTfGLxc5c2q5kw2Pr2fZ+MwtakysqReQiNAIEmfgyNJwlMl+cqV
         ObjTjGNd4RuvjbcTsWvknKnd35oQte0GpS+AxvlDxxvDYJoA9GXRfKfgHTz5XkidCP
         J17XxH/pKCtAYuquvxBbRI/GcQNyQlJPgj4gx2No=
Mime-Version: 1.0 (1.0)
Subject: Re: Linux Kernel Regression: HAPS quirk breaks PCIe on i.MX6QP
From:   Lukas Hartmann <lukas@mntmn.com>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <30102591E157244384E984126FC3CB4F639BECAB@us01wembx1.internal.synopsys.com>
Date:   Fri, 1 Feb 2019 09:05:53 +0100
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Youn <john.youn@synopsys.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <16AAD0CF-D411-4880-BEE5-11A30F9B4886@mntmn.com>
References: <87o97wrbef.fsf@mntmn.com> <CAErSpo4T91kbXXuMSCqrDk=_HD+6GZ64WVZsvhSOtW=L89Pf0g@mail.gmail.com> <30102591E157244384E984126FC3CB4F639BEC73@us01wembx1.internal.synopsys.com> <30102591E157244384E984126FC3CB4F639BECAB@us01wembx1.internal.synopsys.com>
To:     Thinh Nguyen <thinh.nguyen@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thinh,

this is in a taped out i.MX6QP 1.2GHz SoC, I also confirmed it with the 1.0G=
Hz version, it has the same 0xabcd device id integrated.

I will try your patch ASAP.

Cheers
Lukas

> On 1. Feb 2019, at 00:46, Thinh Nguyen <thinh.nguyen@synopsys.com> wrote:
>=20
> Hi Lukas,
>=20
> Thinh Nguyen wrote:
>> Bjorn Helgaas wrote:
>>> [+cc linux-pci, linux-kernel]
>>>=20
>>>> On Thu, Jan 31, 2019 at 11:21 AM Lukas F. Hartmann <lukas@mntmn.com> wr=
ote:
>>>> Hi Thinh,
>>>>=20
>>>> I'm writing you because you're the author in this commit:
>>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_torva=
lds_linux_commit_03e6742584af8866ba014874669d0440bed3a623&d=3DDwIBaQ&c=3DDPL=
6_X_6JkXFx7AXWqB0tg&r=3DVKipRJmm95P2RbIxyKKYrcUCOGNlQtjlV-5zhrVhIik&m=3D2sOr=
owYXlsC3rl0LfHQhIZzImag0jFZXGvR6NIQDsh8&s=3DoJoBWRE8_LGAYbX2alh6QnjYZTTmzcgL=
w4MtOMToNyo&e=3D
>>>>=20
>>>> This quirk workaround breaks the PCIe on i.MX6QP, at least on my test
>>>> devices. The reason is because the Synposys PCIe IP in i.MX6QP has the
>>>> same device ID as the HAPS USB3 controller you are targeting in the
>>>> commit: 0xabcd.
>>>>=20
>>>> Definition:
>>>>=20
>>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_torva=
lds_linux_blob_master_include_linux_pci-5Fids.h-23L2364&d=3DDwIBaQ&c=3DDPL6_=
X_6JkXFx7AXWqB0tg&r=3DVKipRJmm95P2RbIxyKKYrcUCOGNlQtjlV-5zhrVhIik&m=3D2sOrow=
YXlsC3rl0LfHQhIZzImag0jFZXGvR6NIQDsh8&s=3D-FVCwe81XNjJsYHYk1w-kdAzSOLunTGeNc=
73azO2QYw&e=3D
>>>>=20
>>>> Here is a bit of lspci output on my i.MX6QP machine (without the proble=
m):
>>>>=20
>>>> mntmn@reform:~/code/linux$ lspci -v
>>>> 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
>>>>                                          ^^^^
>>>> [Normal decode])
>>>>        Flags: bus master, fast devsel, latency 0, IRQ 307
>>>>        Memory at 01000000 (32-bit, non-prefetchable) [size=3D1M]
>>>>        Bus: primary=3D00, secondary=3D01, subordinate=3Dff, sec-latency=
=3D0
>>>> ...
>>>>=20
>>>> The failure mode is that the PCIe controller shows up as a USB
>>>> controller and my ath9k wireless PCIe card cannot be assigned the
>>>> proper resources anymore (-ENOMEM even for very small BARs).
>>>>=20
>>>> Reverting this commit fixes the problem for me. I suggest to make the
>>>> check more specific to the platform/chipset you are targeting.
>>> So Synopsys apparently re-used Device ID 0xabcd?  That's a pretty bad pr=
oblem.
>>>=20
>>> It looks like we merged 03e6742584af ("PCI: Override Synopsys USB 3.x
>>> HAPS device class") for v5.0, and v5.0-final hasn't been released yet,
>>> so if we don't hear from Thinh with a resolution, we can still revert
>>> it.
>>>=20
>>> I set myself a reminder to revert this on Feb 11, but hopefully we'll
>>> have a better resolution before then.
>>>=20
>>> Bjorn
>>>=20
>> This is really odd that the PID for the PCIe controller in i.MX6QP is
>> the same as PID Synopsys use for USB controller. We use a different set
>> of PIDs for PCIe controllers and track VID and PID in our releases.
>>=20
>> Is the Root Complex (00:00.0) part of the SoC? Or is this a Synopsys
>> prototype connected to your board? If it is the latter, then the FPGA
>> configuration needs to be updated to other PID.
>>=20
>> We're investigating the workaround in case this is on a taped-out SoC.
>=20
> Can you try to see if this will help?
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b0a413f3f7ca..64623fbdd1e5 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -629,6 +629,9 @@ static void quirk_synopsys_haps(struct pci_dev *pdev)
> {
>        u32 class =3D pdev->class;
>=20
> +       if (class !=3D PCI_CLASS_SERIAL_USB_XHCI)
> +               return;
> +
>        switch (pdev->device) {
>        case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3:
>        case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI:
>=20
> Thanks,
> Thinh
>=20
>=20

