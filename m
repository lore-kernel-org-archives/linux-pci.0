Return-Path: <SRS0=pA/b=QC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B15FC282C7
	for <linux-pci@archiver.kernel.org>; Sat, 26 Jan 2019 12:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4347A218A2
	for <linux-pci@archiver.kernel.org>; Sat, 26 Jan 2019 12:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfAZMMS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 26 Jan 2019 07:12:18 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:46159 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfAZMMS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Jan 2019 07:12:18 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 20576100D9402;
        Sat, 26 Jan 2019 13:12:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id ED7EE4E26; Sat, 26 Jan 2019 13:12:12 +0100 (CET)
Date:   Sat, 26 Jan 2019 13:12:12 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Austin.Bolen@dell.com
Cc:     keith.busch@intel.com, Alex_Gagniuc@Dellteam.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Message-ID: <20190126121212.lyt5zpwvo6eijhsi@wunner.de>
References: <20190125082212.ltq2fos5a27kqqi3@wunner.de>
 <731c53d1e5f849388e530a537cde1060@AUSX13MPC131.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731c53d1e5f849388e530a537cde1060@AUSX13MPC131.AMER.DELL.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 25, 2019 at 10:39:04PM +0000, Austin.Bolen@dell.com wrote:
> On 1/25/2019 2:22 AM, Lukas Wunner wrote:
> > 	    pcie_wait_for_link()
> > 	      /*
> > 	       * wait 20 ms per PCIe r4.0 sec 6.6.1,
> > 	       * then wait for up to 1 s until DLLLA is 1,
> > 	       * then wait 100 ms per PCIe r4.0 sec 6.7.3.3
> > 	       */
> > 	    pci_bus_check_dev()
> > 	      /*
> > 	       * first access to hotplugged device:
> > 	       * wait for up to 1 s until vendor ID is accessible
> > 	       */
[...]
> >  PCIe r4.0 sec 6.7.3.3 only says:
> > 
> >     "Software must wait for 100 ms after the Data Link Layer Link Active
> >      bit reads 1b before initiating a configuration access to the hot
> >      added device (see Section 6.6)."
> > 
> 
> Next sentence says "Software must allow 1 second after the Data Link 
> Layer Link Active bit reads 1b before it is permitted to determine that 
> a hot plugged device which fails to return a Successful Completion for a 
> Valid Configuration Request is a broken device".

Yes, that's why pci_bus_check_dev() polls the vendor ID register for
up to 1 sec before it declares failure.  If that approach is not correct
or if we deviate from the spec somewhere else then that should of course
be fixed, so please let me know if so.


> And Section 6.6.1 on Conventional Reset says "Software should use 100 ms 
> wait periods only if software enables CRS Software Visibility. 
> Otherwise, Completion timeouts, platform timeouts, or lengthy processor 
> instruction stalls may result."
> 
> The "Completion timeouts" reference here is the key. Since CRS Software 
> Visibility is not used, the device still has 900 ms before it has to 
> return a Successful Completion if you issue a config read 100 ms after 
> DLLSC.

I'm truly sorry, I double-checked the code and it turns out Linux does
enable CRS Software Visibility unconditionally for all bridges that
support it:

pci_scan_bridge_extend()
  pci_enable_crs()

My apologies for the misinformation in my previous e-mail.  Since your
explanation hinges on CRS not being used, I'm not sure in how far it
applies to the problem at hand.  (I do thank you though for the
comprehensive explanation, I have a much better understanding now
of the issue you're facing.)


> > Is this product being shipped or can it still be changed?
> 
> It's shipping.  It could be changed with a firmware change to re-enable 
> in-band presence but then we'd have the issue where hot-plug breaks when 
> removing devices when link is in certain states like L1 so that is not a 
> viable solution.

An alternative idea would be to change firmware to always drive PCIe PRSNT#
high as soon as U.2 PRSNT#/IfDet# is sensed, regardless whether it's NVMe
or not.  Linux will try to bring up the slot and if it can't be brought up
because it's a SAS drive, all you'll get is an error message in dmesg,
but you shouldn't see other negative effects.

I think the proper solution would be to add a microcontroller to each
U.2 slot on your motherboard which snoops on the PCIe pins to determine
whether communication is taking place and sample the PRSNT#/IfDet# pins
if so.  This leads to higher BOM cost and development cost of course.

Arguably your platform firmware-based solution tries avoid that cost
by simulating what a microcontroller would do but can't really achieve
the same result because it lacks access to the PCIe pins.  Vendors such
as Apple do go to the lengths of adding microcontrollers in similar cases,
e.g. Apple used one on their motherboards with first generation Thunderbolt
controllers:

Because the physical port can be used either to attach a Thunderbolt
or a DisplayPort device, they added an NXP LP1112A ARM controller
which snoops on the pins and drives a multiplexer to route signals
either to the Thunderbolt controller or the GPU.  See page 75 of
these schematics ("DisplayPort/T29 A MUXing"):

https://forums.macrumors.com/attachments/a1278-j30-820-3115-b-051-9058-pdf.451409/

Newer Thunderbolt controllers integrate that functionality so the
BOM cost and development cost is no longer necessary today.


> > Unfortunately I don't have access to those ECNs or the non-public
> > git repo.
> 
> The PCIe Async Hot-Plug ECN has most of the new stuff. It has been 
> released and has the same level of access as the PCIe Base Spec so if 
> you have access to the PCIe base spec then you should have access to 
> this ECN.

Unfortunately I'm not associated with a member of the PCISIG,
so my level of access to the PCIe Base Spec is constrained
to leaked documents found on Ukrainian websites. ;-)

Thanks,

Lukas
