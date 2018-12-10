Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB1EC04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 18:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C5E20672
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 18:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544468077;
	bh=H1CxQTakCuOBMShNWBwPieBqvPrqjSTudamQADvfkfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZBuCL9ePyBEWAUrQNQVZZn54SWRbmkBLtEyoqX4n0r2aldtUjTt7gPxZcAzqsQ9Vx
	 iZWO6GnccoyThxGd1JmaeojYBMBwBTI+h1IRQ785opyNk+am+shNk5cZNq9A01ElLM
	 E5CbTXXuKZXjgcSND7hxShAm10OnwDYnYU6jNde8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C5E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbeLJSyg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:54:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728467AbeLJSyg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Dec 2018 13:54:36 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E3C820672;
        Mon, 10 Dec 2018 18:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544468075;
        bh=H1CxQTakCuOBMShNWBwPieBqvPrqjSTudamQADvfkfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sAKNudd6NlcLuIdK+Gfy3NosSXBXOO3VX0BMoAxrAjOiZiOHEHXRBARH03EdiSNOx
         eWTKzElITygsxkCsJrB/yMCDIb3hQhVVpy85XiIjeY3IbR+nNKnxcqHJMFwut70lbm
         zVzURJsoHPEkjwcXi3A1XGHYAKzTlr6GLV3pmZlo=
Date:   Mon, 10 Dec 2018 12:54:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thinh Nguyen <thinh.nguyen@synopsys.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/2] pci: quirks: Override Synopsys USB 3.x HAPS device
 driver
Message-ID: <20181210185433.GB47246@google.com>
References: <62f746c341ea00ccadda47c3cb02eb57f2e90db2.1541209477.git.thinhn@synopsys.com>
 <8faa039d80ba1f8ab2c7192a237ff8431d5cdc4a.1541209477.git.thinhn@synopsys.com>
 <30102591E157244384E984126FC3CB4F639A0308@us01wembx1.internal.synopsys.com>
 <87in1avbnc.fsf@linux.intel.com>
 <30102591E157244384E984126FC3CB4F639A8945@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30102591E157244384E984126FC3CB4F639A8945@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 08, 2018 at 02:49:09AM +0000, Thinh Nguyen wrote:
> Hi Bjorn,
> 
> On 11/6/2018 12:44 AM, Felipe Balbi wrote:
> > Thinh Nguyen <thinh.nguyen@synopsys.com> writes:
> >
> >> ++ linux-usb
> >> ++ Greg
> >>
> >> On 11/2/2018 6:47 PM, Thinh Nguyen wrote:
> >>> Synopsys USB 3.x host HAPS platform has a class code of
> >>> PCI_CLASS_SERIAL_USB_XHCI, and xhci driver can claim it. However, these
> >>> devices should use dwc3-haps driver. Set driver_override to dwc3-haps
> >>> for these platforms.
> >>>
> >>> Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
> > FWIW:
> >
> > Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> >
> 
> Please let me know if you're ok with these 2 patches.  (This and patch
> subject "[PATCH 1/2] pci: pci_ids: Move Synopsys HAPS platform device IDs")

1) Run "git log --oneline drivers/pci/quirks.c" ...

2) quirk_amd_nl_class() and quirk_netmos() do something similar in a
different way.  quirk_amd_nl_class() in particular seems to be doing
exactly the same thing.  I think since they're doing the same thing, they
should do it the same way.  Would the quirk_amd_nl_class() solution work
for you?

Bjorn
