Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554A5C282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 18:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347D421855
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 18:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfAWSyX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:54:23 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:39443 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAWSyX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jan 2019 13:54:23 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 32C0530000892;
        Wed, 23 Jan 2019 19:54:21 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id EECD32E76F; Wed, 23 Jan 2019 19:54:20 +0100 (CET)
Date:   Wed, 23 Jan 2019 19:54:20 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alex_Gagniuc@Dellteam.com
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        keith.busch@intel.com, Austin.Bolen@dell.com
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Message-ID: <20190123185420.2pennvzvkuhqfmtj@wunner.de>
References: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 23, 2019 at 06:20:57PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> In PCIe, the presence detect bit (PD) in the slot status register should 
> be a logical OR of in-band and out-of band presence. In-band presence is 
> the data link layer status. So one would expect that a link up event, 
> would be accompanied by a PD changed event with PD set. Not everyone 
> follows that.
> 
> I have a system here with the following order of events:
>   *   0 ms : Link up
>   * 400 ms : Presence detect up
> On the first event, the device is probed as expected, and on the second 
> event, the device is removed as a SURPRISE!!!_REMOVAL. This is a bug.

It's normal that there's a lag between presence and link changes.

There's even hardware which flaps the link and presence bits a
couple of times before they settle.  Since commit 6c35a1ac3da63a7
("PCI: pciehp: Tolerate initially unstable link") we're quite lenient
towards such devices and tolerate link and presence flaps for up to
100 ms.  That's basically also the maximum delay we allow between link up
and presence detect up.

Theoretically you could say:  Let's wait after the link goes up
until presence also goes up.  But guess what, some vendors managed
to hardwire the presence detect flag to zero, so you'd wait forever
on those devices.  We have a workaround specifically for such hardware
since commit 80696f991424 ("PCI: pciehp: Tolerate Presence Detect
hardwired to zero").


> It's obvious that just relying on presence detect state is prone to race 
> conditions. However, if a device is replaced, we'd expect the data link 
> layer state to change as well. So I think the best way to proceed is to 
> skip the SURPRISE!!!_REMOVAL if the following are true:
>   * presence detect is set
>   * DLL changed is not set
>   * presence detect was not previously set

Unfortunately it's not that simple.  All we know is that presence has
changed and is currently up and the link is also up.  This could mean
that the device was swapped and it may just take a little longer until
the link flag also flaps.

A possible solution for your hardware would be to amend
pciehp_check_link_status() such that after the call to pci_bus_check_dev()
we wait until presence also goes up.  However it would have to be quirked
to your particular hardware, otherwise it would break devices which
hardwire presence detect to zero.  Or we'd have to define a limit of,
say, 1 second and if presence hasn't gone up within that period,
we'd just silently carry on.  This wouldn't break hardware which hardwires
presence detect to zero, but introduce a 1 sec delay for that hardware
to bring up the slot.

So I don't see a perfect solution.  What device are we talking about
anyway?  400 ms is a *long* time.

Thanks,

Lukas
