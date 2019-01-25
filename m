Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA71C282C0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 08:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7271E2192D
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 08:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfAYIWQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:22:16 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:48269 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfAYIWQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jan 2019 03:22:16 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7455B102A5CA2;
        Fri, 25 Jan 2019 09:22:13 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DD1D9D7F4; Fri, 25 Jan 2019 09:22:12 +0100 (CET)
Date:   Fri, 25 Jan 2019 09:22:12 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Austin.Bolen@dell.com
Cc:     keith.busch@intel.com, Alex_Gagniuc@Dellteam.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Message-ID: <20190125082212.ltq2fos5a27kqqi3@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a833dec6028485cbceaf7e7743588ce@AUSX13MPC131.AMER.DELL.COM>
 <016c526ec63240c799ac03bef7a20e74@AUSX13MPC131.AMER.DELL.COM>
 <99e0b159d31a4f70ab9572d0f4093a31@AUSX13MPC131.AMER.DELL.COM>
 <8242ccdc28e04fca9f9264ec75112b8b@AUSX13MPC131.AMER.DELL.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 24, 2019 at 10:00:49PM +0000, Austin.Bolen@dell.com wrote:
> You're welcome!  And yes, this ECN is not yet in 5.0 draft but should be 
> there soon.  Much of what is in the ECN can be implemented with existing 
> DPC hardware.  There are associated ECNs in ACPI and PCI Firmware 
> Specifications as well.  The ACPI spec changes will not be public until 
> the 6.3 spec is released (soon).  The PCI Firmware Specification changes 
> should be ratified in a few weeks as well.  In the meantime, UEFI org 
> (which ACPI is a part of) has a git repo accessible to UEFI forum 
> members where the Linux code to support these new async hot-plug 
> mechanisms is being developed.  Will be made public once the specs are 
> public.

Unfortunately I don't have access to those ECNs or the non-public
git repo.


> Some people have slow hands :-).  This is a U.2 device.  There are 2 
> pins (Pin 4 = IfDet#/Pin 10 = PRSNT#) that determine presence and each 
> pin is a different length (On insert, IfDet# mates first, PRSNT# mates 
> second, PCIe data lanes mate 3rd).

But I've found a public spec for that:
http://www.ssdformfactor.org/docs/SSD_Form_Factor_Version1_00.pdf


> These 2 pins determine if it is a SAS or NVMe drive.  We have to wait 
> until both pins mate in order to know for sure it's an NVMe drive and 
> therefore generate PRSNT# to DSP above the drive.  But there is no way 
> to know when both pins have mated due to the way the U.2 connector 
> signals were defined so we have to dead wait.

What I don't get is, a lot of the pins are used either for PCIe or SAS:
If the host controller doesn't know yet whether it's PCIe or SAS, why does
it already start driving them in PCIe mode and bring up the link?

Also, those PCIe pins mate 3rd, so by the time the host controller starts
driving those pins in PCIe mode, IfDet# and PRSNT# pins are known to be
connected (because they mate earlier), so the host controller can stop
waiting and start sampling the two pins?  Or is it mechanically possible
to insert the drive in such a way that the pins do not mate before the
PCIe pins, contrary to the spec?

Link up means in-band presence, so I assume this host controller already
adheres to the ECN discussed earlier?  What is the rationale of the ECN
given that it causes these issues?  Is this product being shipped or
can it still be changed?


> > We do allow a 20 + 100 ms delay in pcie_wait_for_link() between link up
> > and presence detect up, just not 400 ms.
> 
> Is the hot-inserted device's config space accessed immediately after 
> waiting this 20 + 100 ms delay?

Yes.

You can follow the code via this link, click your way down the call stack:
https://elixir.bootlin.com/linux/v5.0-rc3/source/drivers/pci/hotplug/pciehp_hpc.c#L602

pciehp_ist()
  pciehp_handle_presence_or_link_change() /* called on PDC or DLLSC event */
    pciehp_enable_slot() /* called if PDS or DLLLA is 1 */
      __pciehp_enable_slot()
        board_added()
	  pciehp_check_link_status()
	    pcie_wait_for_link()
	      /*
	       * wait 20 ms per PCIe r4.0 sec 6.6.1,
	       * then wait for up to 1 s until DLLLA is 1,
	       * then wait 100 ms per PCIe r4.0 sec 6.7.3.3
	       */
	    pci_bus_check_dev()
	      /*
	       * first access to hotplugged device:
	       * wait for up to 1 s until vendor ID is accessible
	       */
	    /*
	     * any additionl PDC or DLLSC event that occurred up to this point
	     * is ignored because the link is up and config space accessible;
	     * read Link Status register and verify link is trained
	     */
	  pciehp_configure_device()
	    /* enumerate hotplugged device */

The 20 ms delay in pcie_wait_for_link() was added by Keith with commit
f0157160b359 ("PCI: Make link active reporting detection generic")
so that the function can also be used by the DPC driver.  I think that
additional delay wouldn't normally be necessary for hotplug but it
doesn't hurt much either.


> Per PCIe spec, in Gen 3 mode, software 
> should wait at least (1s - CTO value) after Data Link Layer Link Active 
> before accessing config space.

Hm, do you have a spec reference for that?  PCIe r4.0 sec 6.7.3.3 only says:

   "Software must wait for 100 ms after the Data Link Layer Link Active
    bit reads 1b before initiating a configuration access to the hot
    added device (see Section 6.6)."


> The exception is if OS enables CRS 
> Software Visibility in which case config space can be accessed 100 ms 
> after Data Link Layer Link Active.  Is CRS Software Visibility being used?

Not that I'm aware of, no.


> I forgot... Readiness Notifications can also let software bypass these 
> first access times but I've not seen anybody implement RN so assume it 
> is not being used here.

Right, I think this isn't used either so far.

Thanks,

Lukas
