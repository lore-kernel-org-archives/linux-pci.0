Return-Path: <SRS0=okY7=QN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E502EC282CB
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 01:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B393A218A3
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 01:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549418114;
	bh=lcD8WUOQZPwq75dnocoALzp68dmsLTVhTSwacaW0pQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2m1vWiZDZaPD03mQWxcX22CJUyRq5X0g/sBMZDl1HiJs089A4xhSSygyUIWma0apm
	 FQKdB5Bgrsnd4WR7F51WHlnVrgyniJzAd/u+pVYFZ5akbZEDgLtpNdagr0dKOsND62
	 VmKJJQCx6nMOCOyDKQ9VJvs5OpSpKUjPqn6SQ0pU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfBFBzO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 20:55:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:58166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfBFBzN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Feb 2019 20:55:13 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADE70218A1;
        Wed,  6 Feb 2019 01:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549418113;
        bh=lcD8WUOQZPwq75dnocoALzp68dmsLTVhTSwacaW0pQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0HRMejrQTGRN9YGuuVOUq8ywysH12Yj1PXXSt7PgHyyy8Zo5E7h6oNPhga7KW1F6
         G/RnZfwen7e/VWh6zKBJ0kUBSL/ioQJv11CjOMtlNXxRwerl0o7x1+EdiZfqP9rng6
         njAq+Uv0uAOguBjhvQya28UnjoulgNpw7JRvnNBQ=
Date:   Tue, 5 Feb 2019 19:55:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     John Youn <john.youn@synopsys.com>
Cc:     Thinh Nguyen <thinh.nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Lukas F. Hartmann" <lukas@mntmn.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH RESEND] PCI: Check for USB xHCI class for HAPS platform
Message-ID: <20190206015510.GD7268@google.com>
References: <a28cfcee61f0842efe114c97b566bb3d967ba3d3.1549326366.git.thinhn@synopsys.com>
 <20190205233159.GC7268@google.com>
 <5d78ac08-0809-d219-ff7c-5cea5f7aba8b@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d78ac08-0809-d219-ff7c-5cea5f7aba8b@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 05, 2019 at 05:01:18PM -0800, John Youn wrote:
> On 02/05/2019 03:32 PM, Bjorn Helgaas wrote:
> > On Tue, Feb 05, 2019 at 01:04:28PM -0800, Thinh Nguyen wrote:
> > > The Synopsys HAPS USB controller has a VID PID (16c3,abcd) that matches
> > > to an existing PCIe controller. This quirk is intended for USB HAPS
> > > devices only. To fix this, check for the PCI class USB xHCI to prevent
> > > matching the PCIe controllers.
> > 
> > So there are at least three different parts with the same Vendor &
> > Device ID ([16c3:abcd]):
> > 
> >    1) Synopsys HAPS USB3 controller
> >    2) Synopsys PCIe IP in the NXP i.MX6QP (reported by Lukas)
> >    3) Synopsys PCIe IP in the NXP i.MX7D (reported by Trent)
> > 
> > I don't know if Synopsys is to blame for 2 & 3, or if NXP was expected
> > to change the Vendor ID when incorporating the Synopsys IP into the
> > i.MX designs.  But even leaving the default Device ID of the PCIe IP
> > the same as another Synopsys device was probably a bad idea.
> 
> Hi Bjorn,
> 
> From talking with our PCIe folks, our best guess is a vendor
> misconfiguration. The PCIe IP ships with a different PID by default
> and does not collide with USB.

If that's true, your vendor was very unlucky in choosing 0xabcd.  They
also have a pretty serious misunderstanding of how PCI IDs work, which
will cause you major headaches if they continue allocating Device IDs
from the Synopsys space.

In this particular case it's probably not a disaster because the
i.MX6QP and i.MX7D devices are both bridges (Root Ports, I think), and
we don't currently have any drivers that claim those by ID.  The
portdrv claims them by Class Code.

> > dwc3-haps claims by Vendor & Device ID; it doesn't look at the Class
> > Code.  What happens when it tries to claim the PCIe IP in i.MX?
> 
> We can add the class code to dwc3-haps to account for this.

I think that'd be a good idea.  I think portdrv will claim the Root
Port first, before dwc3-haps has a chance, so the driver core won't
even call dwc3_haps_probe().

But if you unset CONFIG_PCIEPORTBUS or boot with "pcie_ports=compat",
I bet dwc3-haps *will* claim it, and things will fail a little less
gracefully.

Bjorn
