Return-Path: <SRS0=3oUy=34=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B13C35242
	for <linux-pci@archiver.kernel.org>; Sat,  8 Feb 2020 20:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22FF22522
	for <linux-pci@archiver.kernel.org>; Sat,  8 Feb 2020 20:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgBHUkL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 8 Feb 2020 15:40:11 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:40753 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgBHUkL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Feb 2020 15:40:11 -0500
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Feb 2020 15:40:10 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id A1F232800BB8A;
        Sat,  8 Feb 2020 21:31:04 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6FA132E76A; Sat,  8 Feb 2020 21:31:04 +0100 (CET)
Date:   Sat, 8 Feb 2020 21:31:04 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Oliver Neukum <oneukum@suse.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Yang <mmyangfl@gmail.com>, Rajat Jain <rajatja@google.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Libor Pechacek <lpechacek@suse.cz>
Subject: Re: system generating an NMI due to 80696f991424d ("PCI: pciehp:
 Tolerate Presence Detect hardwired to zero")
Message-ID: <20200208203104.vbeafivjn5bevyq5@wunner.de>
References: <1579083986.15925.31.camel@suse.com>
 <20200115112429.yrj5v2zhvxkoupbw@wunner.de>
 <20200116053500.chp4rsbeflg3qrdr@wunner.de>
 <1580904900.9756.9.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580904900.9756.9.camel@suse.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 05, 2020 at 01:15:00PM +0100, Oliver Neukum wrote:
> Am Donnerstag, den 16.01.2020, 06:35 +0100 schrieb Lukas Wunner:
> > On Wed, Jan 15, 2020 at 11:26:26AM +0100, Oliver Neukum wrote:
> > > I got a bug report about some systems generating an NMI and
> > > subsequently crashing bisected down to 80696f991424d.
> > > Apparently these systems do not react well to __pciehp_enable_slot
> > > while no card is present. Restoring the check to __pciehp_enable_slot()
> > > removed in 80696f991424d makes the current kernels work.
> > 
> > Recent PCIe versions allow turning off in-band presence detect, in which
> > case the DLLLA bit can be set even though Presence Detect is not set.
> > You may be dealing with one of those systems but without full dmesg
> > and lspci output this is just an educated guess.
> > 
> > A series was submitted by Dell last year to support disabling in-band
> > presence detect, but it hasn't been merged yet by Bjorn:
> > 
> > https://lore.kernel.org/linux-pci/20191025190047.38130-1-stuart.w.hayes@gmail.com/
> > 
> > You may want to try if that series helps.
> 
> it has been tested and it does the job. May I ask whether you could
> ack it or propose necessary changes, so that we can proceed?

Thanks for testing, so I assume that's a

Tested-by: Oliver Neukum <oneukum@suse.com>

The series has already been reviewed by Mika Westerberg, additionally
Andy Shevchenko has provided a Reviewed-by for each individual patch.
Nevertheless I've just also reviewed it once more and provided my
opinion in a separate e-mail.

The patches are not forgotten, they're still marked "New" in patchwork:
https://patchwork.kernel.org/cover/11212969/

So I assume Bjorn will get to them after the merge window closes
(and after taking a breather).

Thanks,

Lukas
