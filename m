Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C487C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 20:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE788217F9
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 20:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549397401;
	bh=ho+ITocgotbIwCJbdRd/04eyQQBpljZc/dJ0m9mziYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XSszWsLK9cNXamuQtP/owJ6qt+xeBK69I9Z+7gtcblToffj+1O8q632s63IVnFRWr
	 +Vjo5BtWwo0tLRkmybPTs0egcmhOQH6NPQCMPTRHryTRB57Aw+crkJ9SXFxJ9QFxWN
	 a1/3VrMooETMz7FRyR9phqTlK6DM9p7HhatgkTfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfBEUKB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:10:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfBEUKB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Feb 2019 15:10:01 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16E162083B;
        Tue,  5 Feb 2019 20:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549397400;
        bh=ho+ITocgotbIwCJbdRd/04eyQQBpljZc/dJ0m9mziYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t0OthfelIdAKCsEAvnaaqg699lM3aALivF96jL3xEHv/pMsjA/X30ge+Zef8WBXPp
         M/bsWaroH1DcDgGv61WhUGBglndt3l/fVKMaJMXB8Yb/YtWxFxAWi7cRNn5GAD895l
         M51HAw8pY+CAtwrMGbRW7zbiZEpiXZIE66gbgI3E=
Date:   Tue, 5 Feb 2019 14:09:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thinh Nguyen <thinh.nguyen@synopsys.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        "Lukas F. Hartmann" <lukas@mntmn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Youn <john.youn@synopsys.com>
Subject: Re: Linux Kernel Regression: HAPS quirk breaks PCIe on i.MX6QP
Message-ID: <20190205200957.GA7268@google.com>
References: <87o97wrbef.fsf@mntmn.com>
 <CAErSpo4T91kbXXuMSCqrDk=_HD+6GZ64WVZsvhSOtW=L89Pf0g@mail.gmail.com>
 <30102591E157244384E984126FC3CB4F639BEC73@us01wembx1.internal.synopsys.com>
 <30102591E157244384E984126FC3CB4F639BECAB@us01wembx1.internal.synopsys.com>
 <20190201085906.tqp6ysbb65n7jfkv@wunner.de>
 <30102591E157244384E984126FC3CB4F639BF351@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30102591E157244384E984126FC3CB4F639BF351@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 01, 2019 at 08:27:00PM +0000, Thinh Nguyen wrote:
> Lukas Wunner wrote:
> > On Thu, Jan 31, 2019 at 11:46:23PM +0000, Thinh Nguyen wrote:
> >> --- a/drivers/pci/quirks.c
> >> +++ b/drivers/pci/quirks.c
> >> @@ -629,6 +629,9 @@ static void quirk_synopsys_haps(struct pci_dev *pdev)
> >>  {
> >>         u32 class = pdev->class;
> >>  
> >> +       if (class != PCI_CLASS_SERIAL_USB_XHCI)
> >> +               return;
> >> +
> >>         switch (pdev->device) {
> >>         case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3:
> >>         case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI:
> > Please use DECLARE_PCI_FIXUP_CLASS_HEADER() instead.
> 
> Sure. That's a better option. Can you test this with your setup?
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b0a413f3f7ca..f46e7de9e15d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -639,8 +639,8 @@ static void quirk_synopsys_haps(struct pci_dev *pdev)
>                 break;
>         }
>  }
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
> -                        quirk_synopsys_haps);
> +DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
> +               PCI_CLASS_SERIAL_USB_XHCI, 0, quirk_synopsys_haps);
>  
>  /*
>   * Let's make the southbridge information explicit instead of having to
> 
> 

Can we get a formal patch, including details about the issue (I assume
Synopsys released two different parts with Device ID 0xabcd) and a
signed-off-by?

I'd like to get this into for-linus as soon as possible for v5.0.

Bjorn
