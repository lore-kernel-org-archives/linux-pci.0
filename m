Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A529AC282DA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 13:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753942177B
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 13:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555508943;
	bh=EG2OGL/X1WkoFChFExhp45mcsn++LXfu/CQ4eBeJ98k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=axRBVWeCScfE7fArJDIyTTfOxa/ctXTLNftS3F8KxS8gIXWkDSzLC1fJzaQWy9X83
	 owzJRijd4MK9Cdk1l6Kab/QGqcPvpxxBnJmTwajD0ZWoAab0WS86PllDrBqxDHw4Wb
	 aHAetIl1ofVuObK3tLi/ltS5tWj/6y2EhmWgjs+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfDQNtC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731745AbfDQNtC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Apr 2019 09:49:02 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3EBD20872;
        Wed, 17 Apr 2019 13:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555508941;
        bh=EG2OGL/X1WkoFChFExhp45mcsn++LXfu/CQ4eBeJ98k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QMfzbmkBrGNJPa9kx5NgEykU9ASI9E+i+Rat9hBl8kb785ALr0XWZx1KP+MgrXr6Q
         dbxBmD8cLvYYR5CAf8bnnenTp92Ik/I6KnWkfHhghE1CzSNlbQhoI/t1bh2LpQBBFV
         OMv2zmsbkqiHnoasdaA9Yz9ijFcHMvvMp8oUv/aM=
Date:   Wed, 17 Apr 2019 08:49:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Sinan Kaya <Okaya@kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        Rajat Jain <rajatja@google.com>
Subject: Re: Linux pci card forcing a remove and restore
Message-ID: <20190417134900.GA235813@google.com>
References: <3399add0-39da-3711-2614-80f611c2d5db@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3399add0-39da-3711-2614-80f611c2d5db@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Sinan, Luca, Rajat (incidental mention of iwlwifi)]

Hi Scott,

On Tue, Apr 16, 2019 at 04:34:36PM -0700, Scott Branden wrote:
> I have a possibly simple or may be more involved question:
> 
> I have a PCI device that the hardware boots up and enumerates in GEN2 mode.
> 
> Once the linux device driver is loaded we can download new firmware to the
> card that may reinitialize the PCIe PHY in GEN3 mode and resizing the BARs.
> 
> We can have the device re-enumerated via user space:
> 
> echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/remove
> 
> echo 1 > /sys/bus/pci/rescan
> 
> But, is it possible to do this inside the kernel device driver after it has
> downloaded the new firmware instead?
> 
> Before I start trying to play with pci_stop_and_remove_bus_device followed
> by pci_rescan_bus I would like to know if what I'm trying to do is a correct
> approach?

Sinan mentioned the hfi1 driver, which does reinitialize the link to
transition from gen2 to gen3.  This is a little bit messy and I think
it has a little too much knowledge of link internals that
theoretically should be managed by the PCI core, but the PCI core
doesn't offer any good alternatives.

But your situation sounds a little more complicated because you also
want to resize the BARs, which means you need to remove & re-enumerate
the device or at least somehow update the whole dev->resource[] and
resource tree situation.  Removing the device of course means
detaching the driver, and doing that from within the driver itself
is a little problematic.

The iwlwifi driver does seem to do that (it calls
pci_stop_and_remove_bus_device() from iwl_trans_pcie_removal_wk(),
added by 49564a806fc5 ("iwlwifi: pcie: remove non-responsive device"))
but I'm a little hesitant about copying this design.  It's a singleton
(all other uses are in hotplug drivers), the non-responsive device
situation is not unique to iwlwifi, and scheduling work to remove the
current driver seems a little too clever.

In any event, your situation is much different from iwlwifi.  Your
device *is* responding; you merely want to download new firmware,
re-enumerate the device, and re-attach your driver.

I wonder if we could invent some scheme where you'd have a separate
driver (possibly implemented in the same source file as your main
driver but with a different struct pci_driver), where that driver's
.probe() method would check to see whether a firmware update was
needed, and if so it would download the new firmware and return an
indication to the PCI core that the device should be removed, reset,
and re-enumerated.

Bjorn
