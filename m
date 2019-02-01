Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C857C282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 08:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D071020869
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 08:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfBAI7K (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:59:10 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:42811 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfBAI7K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2019 03:59:10 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 410122800C7E8;
        Fri,  1 Feb 2019 09:59:07 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E62EAD7F4; Fri,  1 Feb 2019 09:59:06 +0100 (CET)
Date:   Fri, 1 Feb 2019 09:59:06 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Thinh Nguyen <thinh.nguyen@synopsys.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Lukas F. Hartmann" <lukas@mntmn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Youn <john.youn@synopsys.com>
Subject: Re: Linux Kernel Regression: HAPS quirk breaks PCIe on i.MX6QP
Message-ID: <20190201085906.tqp6ysbb65n7jfkv@wunner.de>
References: <87o97wrbef.fsf@mntmn.com>
 <CAErSpo4T91kbXXuMSCqrDk=_HD+6GZ64WVZsvhSOtW=L89Pf0g@mail.gmail.com>
 <30102591E157244384E984126FC3CB4F639BEC73@us01wembx1.internal.synopsys.com>
 <30102591E157244384E984126FC3CB4F639BECAB@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30102591E157244384E984126FC3CB4F639BECAB@us01wembx1.internal.synopsys.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 31, 2019 at 11:46:23PM +0000, Thinh Nguyen wrote:
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -629,6 +629,9 @@ static void quirk_synopsys_haps(struct pci_dev *pdev)
>  {
>         u32 class = pdev->class;
>  
> +       if (class != PCI_CLASS_SERIAL_USB_XHCI)
> +               return;
> +
>         switch (pdev->device) {
>         case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3:
>         case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI:

Please use DECLARE_PCI_FIXUP_CLASS_HEADER() instead.

Thanks,

Lukas
