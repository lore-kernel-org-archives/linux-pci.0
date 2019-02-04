Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C007C282C4
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 23:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D122081B
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 23:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VjoJq0Qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfBDXSE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:18:04 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:45364 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfBDXSE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Feb 2019 18:18:04 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 780D510C1CA5;
        Mon,  4 Feb 2019 15:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549322283; bh=+Ax83/ZNQipyM9vgIXqS5S8k52ZWTuevU0CTZFiaA/Y=;
        h=From:To:CC:Subject:Date:References:From;
        b=VjoJq0QjagbRodTljs7wglcS2bM6nkF7qKA2AAqT75oQemBbD1yWqVhOSmXCAGBIZ
         UPd13PTNB9kNuMuoODIDXFIArSWyBQUFWsIt/QJA3H4zl+GWbtKIsKd12+SkaHdtNa
         KxLClSjcziFFGJWVTZwB3Pykeu5S0zA9WlFHW7u7JzQGIIZ2aTSBwej2SyFXxtW1V+
         gNMc1kmORUsGYSWkxOlF9dllt+gXnCzXzqwi/Iy2MWVzGzL1yRD7Qpc+Hu6y6qOg5X
         fhJrUha3CsqTt7gxTlHOX8jEEiyMaPrrY3T+6p3uIKDcX2InxtfodSjHkv6RXdMOoT
         bGm+duwbVpXtQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 350BFA0095;
        Mon,  4 Feb 2019 23:18:03 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 4 Feb 2019 15:18:02 -0800
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
To:     Trent Piepho <tpiepho@impinj.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thinh.nguyen@synopsys.com" <thinh.nguyen@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "john.youn@synopsys.com" <john.youn@synopsys.com>
Subject: Re: [PATCH v2 2/2] PCI: Override Synopsys USB 3.x HAPS device class
Thread-Topic: [PATCH v2 2/2] PCI: Override Synopsys USB 3.x HAPS device class
Thread-Index: AQHUkNTZgvXzDoaX606wWoQcIUKu2w==
Date:   Mon, 4 Feb 2019 23:18:01 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639C0B41@us01wembx1.internal.synopsys.com>
References: <3aa06c4e54bf98a59e510d7a833934fce4b0083b.1544478969.git.thinhn@synopsys.com>
 <8994fd7d7ee2bf5c1b32ce5bca25be4beb4405b5.1544478969.git.thinhn@synopsys.com>
 <1549320120.3075.12.camel@impinj.com>
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

Hi Trent,=0A=
=0A=
Trent Piepho wrote:=0A=
> On Mon, 2018-12-10 at 14:08 -0800, Thinh Nguyen wrote:=0A=
>> Synopsys USB 3.x host HAPS platform has a class code of=0A=
>> PCI_CLASS_SERIAL_USB_XHCI, and xhci driver can claim it. However, these=
=0A=
>> devices should use dwc3-haps driver. Change these devices' class code to=
=0A=
>> PCI_CLASS_SERIAL_USB_DEVICE to prevent the xhci-pci driver from claiming=
=0A=
>> them.=0A=
>>=0A=
>> +=0A=
>> +	switch (pdev->device) {=0A=
>> +	case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3:=0A=
>> +	case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI:=0A=
>> +	case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB31:=0A=
>> +		pdev->class =3D PCI_CLASS_SERIAL_USB_DEVICE;=0A=
>> +		pci_info(pdev, "PCI class overridden (%#08x -> %#08x) so dwc3 driver =
can claim this instead of xhci\n",=0A=
>> +			 class, pdev->class);=0A=
>> +		break;=0A=
>> +	default:=0A=
>> +		return;=0A=
>> +	}=0A=
>> +}=0A=
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,=0A=
>> +			 quirk_synopsys_haps);=0A=
>> +=0A=
> This change breaks my IMX7d based device.  This SoC has a PCIe bus=0A=
> based on the Synopsys Designware host controller.  This has a root=0A=
> bridge that shows up as:=0A=
>=0A=
> 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00 [Norm=
al decode])                                 =0A=
> 00:00.0 0604: 16c3:abcd (rev 01) (prog-if 00 [Normal decode])            =
                                            =0A=
>=0A=
> Which is to say, class 0x0604, vendor PCI_VENDOR_ID_SYNOPSYS, and the=0A=
> device ID 0xabcd.=0A=
>=0A=
> It looks like there has been a bit of sloppy allocation of PCI device=0A=
> codes, as PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3 is also 0xabcd.=0A=
>=0A=
> So the result of this patch is to try to turn the imx7d PCIe root=0A=
> bridge into a USB controller.  Which of course breaks it and prevents=0A=
> anything behind it, i.e. the endpoint attached to the pci-e bus, from=0A=
> working.=0A=
>=0A=
> Somehow this quirk needs to be more targeted.=0A=
=0A=
Right. Lukas also reported this. It appears that there's a duplicate VID=0A=
PID used for the USB controller on HAPS platform. You can review the=0A=
discussion subject "Linux Kernel Regression: HAPS quirk breaks PCIe on=0A=
i.MX6QP".=0A=
=0A=
I'll send out a patch to resolve this issue. You can check the change to=0A=
see if this resolves your issue:=0A=
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
=0A=
