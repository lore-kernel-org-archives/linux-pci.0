Return-Path: <SRS0=kTIb=OR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4CAC07E85
	for <linux-pci@archiver.kernel.org>; Sat,  8 Dec 2018 02:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EF420892
	for <linux-pci@archiver.kernel.org>; Sat,  8 Dec 2018 02:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iz5P3RV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EF420892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbeLHCtL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 21:49:11 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:41382 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeLHCtL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Dec 2018 21:49:11 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id AFEF210C06EF;
        Fri,  7 Dec 2018 18:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544237350; bh=sRa46jmTP8gc1GN/j/J58HrtgCSICds9Eso6pXu0CSg=;
        h=From:To:CC:Subject:Date:References:From;
        b=iz5P3RV0R814f6VwfbHxqGWZswG0cW0wi71zFeuP5vLUWSrFcgm4Ub6azVValJh7T
         6W6pupS3hIIafpaAexBZgsBqbAY2GcHwNSNCmL5xJ/RK3k+dx0oh428k74FTfCvFkH
         plFJ1UMppkU94mmQzYe0aSuoXEYXSAX8zpf/+CobDRxiOxfgbcCkMckSzFBI+BRo+5
         VBjG94YzGwEgm5yXahhA0QAGmMGQp8UOjbXrSeJypcIALvTEkJnRPrgBjeTMN93/e6
         SgpLYthf7Gfa3w+6pWeszB9TxBlt3/inSuyaR+/uqngzk0aGg88McbdBawci/5GrRL
         ZXMgQvvDmnyvQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 870723ABA;
        Fri,  7 Dec 2018 18:49:10 -0800 (PST)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 7 Dec 2018 18:49:10 -0800
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     USB <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/2] pci: quirks: Override Synopsys USB 3.x HAPS device
 driver
Thread-Topic: [PATCH 2/2] pci: quirks: Override Synopsys USB 3.x HAPS device
 driver
Thread-Index: AQHUcxc44LgHg6rNbUCK28Y7SbNQQg==
Date:   Sat, 8 Dec 2018 02:49:09 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639A8945@us01wembx1.internal.synopsys.com>
References: <62f746c341ea00ccadda47c3cb02eb57f2e90db2.1541209477.git.thinhn@synopsys.com>
 <8faa039d80ba1f8ab2c7192a237ff8431d5cdc4a.1541209477.git.thinhn@synopsys.com>
 <30102591E157244384E984126FC3CB4F639A0308@us01wembx1.internal.synopsys.com>
 <87in1avbnc.fsf@linux.intel.com>
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
On 11/6/2018 12:44 AM, Felipe Balbi wrote:=0A=
> Thinh Nguyen <thinh.nguyen@synopsys.com> writes:=0A=
>=0A=
>> ++ linux-usb=0A=
>> ++ Greg=0A=
>>=0A=
>> On 11/2/2018 6:47 PM, Thinh Nguyen wrote:=0A=
>>> Synopsys USB 3.x host HAPS platform has a class code of=0A=
>>> PCI_CLASS_SERIAL_USB_XHCI, and xhci driver can claim it. However, these=
=0A=
>>> devices should use dwc3-haps driver. Set driver_override to dwc3-haps=
=0A=
>>> for these platforms.=0A=
>>>=0A=
>>> Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>=0A=
> FWIW:=0A=
>=0A=
> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>=0A=
>=0A=
=0A=
Please let me know if you're ok with these 2 patches.  (This and patch=0A=
subject "[PATCH 1/2] pci: pci_ids: Move Synopsys HAPS platform device IDs")=
=0A=
=0A=
Thanks,=0A=
Thinh=0A=
