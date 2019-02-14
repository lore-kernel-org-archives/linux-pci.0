Return-Path: <SRS0=m7pK=QV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A58C43381
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 07:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4AB222B6
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 07:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405944AbfBNHBD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:01:03 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:42485 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405695AbfBNHBD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Feb 2019 02:01:03 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 982322800B488;
        Thu, 14 Feb 2019 08:01:00 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5262457CE2; Thu, 14 Feb 2019 08:01:00 +0100 (CET)
Date:   Thu, 14 Feb 2019 08:01:00 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alex_Gagniuc@Dellteam.com
Cc:     mr.nuke.me@gmail.com, bhelgaas@google.com, Austin.Bolen@dell.com,
        keith.busch@intel.com, Shyam.Iyer@dell.com, gustavo@embeddedor.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Do not turn off slot if presence comes up
 after link
Message-ID: <20190214070100.kvikmkkcrp2d32sm@wunner.de>
References: <20190205210701.25387-1-mr.nuke.me@gmail.com>
 <20190209115849.244u67h7wmn3eb7o@wunner.de>
 <52afa1c45f684dbda6a8771b65583a22@ausx13mps321.AMER.DELL.COM>
 <20190212083031.2no7mzn5xug7nba3@wunner.de>
 <b2fffa5beb7941ebaceb8b8ce6e5b133@ausx13mps321.AMER.DELL.COM>
 <20190213083632.GA3387@wunner.de>
 <205e0fd9995a4f2b80ab370a974b6628@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <205e0fd9995a4f2b80ab370a974b6628@ausx13mps321.AMER.DELL.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 13, 2019 at 06:55:46PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 2/13/19 2:36 AM, Lukas Wunner wrote:
> > > (*) A bit hypothetical: There is no hardware yet implementing the ECN.
> > 
> > Hm, this contradicts Austin Bolen's e-mail of Jan 25 that "Yes, this
> > platform disables in-band presence" (when asked whether your host
> > controller already adheres to the ECN).
> 
> Both statements are true. The hardware does indeed disable in-band 
> presence, in a rudimentary way that is not compliant with the ECN -- it 
> doesn't implement the bits required by the ECN.

Ugh, can a BIOS update make those machines compliant to the ECN
or do we need a quirk specifically for them?


> >  Polling PDS in
> > pcie_wait_for_link() or disabling either PDC or DLLSC if in-band presence
> > is disabled seems simpler to reason about.
> 
> pcie_wait_for_link() is generic PCIe layer. I don't think mixing hotplug 
> concepts is a good layering violation.

The function used to live in pciehp_hpc.c, but commits 9f5a70f18c58
and f0157160b359 moved it to generic code to allow code sharing with
the DPC driver.  That's the only reason it's in generic code AFAICS.


> >> in-band PD disable (what's a good acronym for that, BTW?)
> > 
> > I don't know, maybe inband_presence_disabled?
> 
> PCI_EXP_SLTCAP2_IBPD ?

Yes, something like that.  It should match the spec, which I have no
access to.

Thanks,

Lukas
