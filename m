Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8708C04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 21:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2352081F
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 21:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gnCx4tIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2352081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeLJVvK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:51:10 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:39440 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJVvK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Dec 2018 16:51:10 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id CB44D24E047E;
        Mon, 10 Dec 2018 13:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544478670; bh=aqcQyjPx3ytHfMhXqKLis4gju3VKim2yn030oJNx0h8=;
        h=From:To:CC:Subject:Date:References:From;
        b=gnCx4tIYVPNOO5l97uk4ojvqYTD28rbIxzt8NNkxj/gDI06t46eqmIGye6KRDtJp0
         ZD0s3aNBPcYSw7o5WbqbsG7xwvlnee87sb4KsbqCxWsy1CzIjtDPDAFe2xsEeXUeMG
         w1HjaWV8PDCV/NpSkze5CoeXMT8Oka5cwrI2Tf/LECee1GpLKuDMs9KeksRybgrU+L
         dDNC6l1EVuUbnoG2SZejasMgObd2+1DzphNf/3TYSlq8W4L/z6Y2+x96jrElXhB9Dd
         U33Mr4rh4UGZ2vYYmvNCq9fteonKTW5KflNc0m2znXjaMVqQglpK+7GQSIFL48iHHq
         RMy9En3mKaTEw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id A104D52F9;
        Mon, 10 Dec 2018 13:51:09 -0800 (PST)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 10 Dec 2018 13:51:09 -0800
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>
CC:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/2] pci: quirks: Override Synopsys USB 3.x HAPS device
 driver
Thread-Topic: [PATCH 2/2] pci: quirks: Override Synopsys USB 3.x HAPS device
 driver
Thread-Index: AQHUcxc44LgHg6rNbUCK28Y7SbNQQg==
Date:   Mon, 10 Dec 2018 21:51:09 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639A8E87@us01wembx1.internal.synopsys.com>
References: <62f746c341ea00ccadda47c3cb02eb57f2e90db2.1541209477.git.thinhn@synopsys.com>
 <8faa039d80ba1f8ab2c7192a237ff8431d5cdc4a.1541209477.git.thinhn@synopsys.com>
 <30102591E157244384E984126FC3CB4F639A0308@us01wembx1.internal.synopsys.com>
 <87in1avbnc.fsf@linux.intel.com>
 <30102591E157244384E984126FC3CB4F639A8945@us01wembx1.internal.synopsys.com>
 <20181210185433.GB47246@google.com>
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
On 12/10/2018 10:54 AM, Bjorn Helgaas wrote:=0A=
> On Sat, Dec 08, 2018 at 02:49:09AM +0000, Thinh Nguyen wrote:=0A=
>> Hi Bjorn,=0A=
>>=0A=
>> On 11/6/2018 12:44 AM, Felipe Balbi wrote:=0A=
>>> Thinh Nguyen <thinh.nguyen@synopsys.com> writes:=0A=
>>>=0A=
>>>> ++ linux-usb=0A=
>>>> ++ Greg=0A=
>>>>=0A=
>>>> On 11/2/2018 6:47 PM, Thinh Nguyen wrote:=0A=
>>>>> Synopsys USB 3.x host HAPS platform has a class code of=0A=
>>>>> PCI_CLASS_SERIAL_USB_XHCI, and xhci driver can claim it. However, the=
se=0A=
>>>>> devices should use dwc3-haps driver. Set driver_override to dwc3-haps=
=0A=
>>>>> for these platforms.=0A=
>>>>>=0A=
>>>>> Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>=0A=
>>> FWIW:=0A=
>>>=0A=
>>> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>=0A=
>>>=0A=
>> Please let me know if you're ok with these 2 patches.  (This and patch=
=0A=
>> subject "[PATCH 1/2] pci: pci_ids: Move Synopsys HAPS platform device ID=
s")=0A=
> 1) Run "git log --oneline drivers/pci/quirks.c" ...=0A=
>=0A=
> 2) quirk_amd_nl_class() and quirk_netmos() do something similar in a=0A=
> different way.  quirk_amd_nl_class() in particular seems to be doing=0A=
> exactly the same thing.  I think since they're doing the same thing, they=
=0A=
> should do it the same way.  Would the quirk_amd_nl_class() solution work=
=0A=
> for you?=0A=
>=0A=
> Bjorn=0A=
>=0A=
=0A=
Yes. Also, the way Netmos handling multiple devices is cleaner. I'll=0A=
incorporate the their solutions.=0A=
=0A=
Thanks,=0A=
Thinh=0A=
