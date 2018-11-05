Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C820CC0044C
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 18:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9167720819
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 18:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mOcPf6Sp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9167720819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbeKFELA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:11:00 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:37278 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeKFELA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Nov 2018 23:11:00 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 6CF4310C06D1;
        Mon,  5 Nov 2018 10:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541443800; bh=XJ2KUSaM+RTZ8/RvJPzHV4F8c7xpg/3I3rw2N+A2WVA=;
        h=From:To:CC:Subject:Date:References:From;
        b=mOcPf6SpFxxt3zDD/y4jsVp6d3eMQOX2F6WbVw9X7EWx8KWRHSwCQCyBFwc2Qup+K
         X/K70OM8Lp1Qce25l+msgi5VGyJl64ZFTWfWUUSZJ+nTCg1tc4mL9AzqnhqEgofldf
         I//ecUYNedm3PC0tM5rDZ0mA0oh32X3AsvxqHfJZH3E4FOyM+fO8V0Obko3VYgNshN
         NsOwY5mHxHPgfX3KL8jFmaqr9F1YSml1JxrPAhGQe44eRiVxOrCNB41JMk7EdAfmVJ
         HyFsJw/swZF/vSnRaIiSV3l2m0VRPL+4xGLAdpWD5LcBLL0FcwAUsY9BwN3wHIkMxd
         MgOZUNbAA9NgQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4598A3BE2;
        Mon,  5 Nov 2018 10:50:00 -0800 (PST)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon, 5
 Nov 2018 10:50:00 -0800
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     USB <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/2] pci: quirks: Override Synopsys USB 3.x HAPS device
 driver
Thread-Topic: [PATCH 2/2] pci: quirks: Override Synopsys USB 3.x HAPS device
 driver
Thread-Index: AQHUcxc44LgHg6rNbUCK28Y7SbNQQg==
Date:   Mon, 5 Nov 2018 18:49:59 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639A0308@us01wembx1.internal.synopsys.com>
References: <62f746c341ea00ccadda47c3cb02eb57f2e90db2.1541209477.git.thinhn@synopsys.com>
 <8faa039d80ba1f8ab2c7192a237ff8431d5cdc4a.1541209477.git.thinhn@synopsys.com>
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

++ linux-usb=0A=
++ Greg=0A=
=0A=
On 11/2/2018 6:47 PM, Thinh Nguyen wrote:=0A=
> Synopsys USB 3.x host HAPS platform has a class code of=0A=
> PCI_CLASS_SERIAL_USB_XHCI, and xhci driver can claim it. However, these=
=0A=
> devices should use dwc3-haps driver. Set driver_override to dwc3-haps=0A=
> for these platforms.=0A=
>=0A=
> Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>=0A=
> ---=0A=
>  drivers/pci/quirks.c | 21 +++++++++++++++++++++=0A=
>  1 file changed, 21 insertions(+)=0A=
>=0A=
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c=0A=
> index 6bc27b7fd452..5f7c3ade7749 100644=0A=
> --- a/drivers/pci/quirks.c=0A=
> +++ b/drivers/pci/quirks.c=0A=
> @@ -618,6 +618,27 @@ static void quirk_amd_nl_class(struct pci_dev *pdev)=
=0A=
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,=0A=
>  		quirk_amd_nl_class);=0A=
>  =0A=
> +/*=0A=
> + * Synopsys USB 3.x host HAPS platform has a class code of=0A=
> + * PCI_CLASS_SERIAL_USB_XHCI, and xhci driver can claim it. However, the=
se=0A=
> + * devices should use dwc3-haps driver. Set driver_override to dwc3-haps=
 for=0A=
> + * these platforms.=0A=
> + */=0A=
> +static void quirk_synopsys_haps(struct pci_dev *pdev)=0A=
> +{=0A=
> +	/* Use dwc3-haps driver instead of xhci-pci */=0A=
> +	pdev->driver_override =3D "dwc3-haps";=0A=
> +}=0A=
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SYNOPSYS,=0A=
> +			PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3,=0A=
> +			quirk_synopsys_haps);=0A=
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SYNOPSYS,=0A=
> +			PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI,=0A=
> +			quirk_synopsys_haps);=0A=
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SYNOPSYS,=0A=
> +			PCI_DEVICE_ID_SYNOPSYS_HAPSUSB31,=0A=
> +			quirk_synopsys_haps);=0A=
> +=0A=
>  /*=0A=
>   * Let's make the southbridge information explicit instead of having to=
=0A=
>   * worry about people probing the ACPI areas, for example.. (Yes, it=0A=
=0A=
=0A=
