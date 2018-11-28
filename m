Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C843C43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 17:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DDF20665
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 17:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DDF20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbeK2ExO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:53:14 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36993 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbeK2ExO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Nov 2018 23:53:14 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gS3yy-0003VL-PR; Wed, 28 Nov 2018 18:50:40 +0100
Message-ID: <1543427438.2507.52.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/2] PCI: imx6: limit DBI register length
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Stefan Agner <stefan@agner.ch>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     lorenzo.pieralisi@arm.com, Trent Piepho <tpiepho@impinj.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        linux-kernel@vger.kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, andrew.smirnov@gmail.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Date:   Wed, 28 Nov 2018 18:50:38 +0100
In-Reply-To: <fd74de3125bf7df8789e83f2e0631157@agner.ch>
References: <20181120165626.26424-1-stefan@agner.ch>
         <20181120165626.26424-2-stefan@agner.ch>
         <581b9548043d5276f6685f534386180fd0673a9a.camel@nxp.com>
         <1542741198.30311.608.camel@impinj.com>
         <268e109e1c6b309454bd5a313078894c@agner.ch>
         <1542749302.30311.624.camel@impinj.com>
         <VI1PR04MB5533BBC2B45752ED84E4D037EEDA0@VI1PR04MB5533.eurprd04.prod.outlook.com>
         <fd07b82d2473d5d7db9826142e79b00a@agner.ch>
         <fd74de3125bf7df8789e83f2e0631157@agner.ch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Mittwoch, den 28.11.2018, 18:36 +0100 schrieb Stefan Agner:
> On 28.11.2018 13:19, Stefan Agner wrote:
> > On 21.11.2018 14:47, Leonard Crestez wrote:
> > > On 11/20/2018 11:28 PM, Trent Piepho wrote:
> > > > On Tue, 2018-11-20 at 21:42 +0100, Stefan Agner wrote:
> > > > > On 20.11.2018 20:13, Trent Piepho wrote:
> > > > > > It also seems to me that this doesn't need to be in the internal pci
> > > > > > config access functions.  The driver shouldn't be reading registers
> > > > > > that don't exist anyway.  It's really about trying to fix sysfs access
> > > > > > to registers that don't exist.  So maybe it should be done there.
> > > > > 
> > > > > That was my first approach, see:
> > > > 
> > > > Yes, but that just used the pci device id which applies to every IMX
> > > > design.
> > > > 
> > > > It's also not totally correct, as it seems real registers after 0x200
> > > > do work on imx6, and that would prevent access to them.
> > > 
> > > I see that Lorenzo already accepted the patch in pci/dwc:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?h=pci/dwc&id=f14eaec153aaebbe940ddd21e4198cc2abc927c2
> > > 
> > > My tests show that this series breaks pci cards on 6qdl and I think it
> > > should be reverted until a fix is found. Are you OK with this?
> > > 
> > > Fixing might require an entirely different approach.
> > 
> > I tried to reproduce this issue on Apalis iMX6 (i.MX 6Q) with a ath9k
> > PCIe WiFi card, the issue you are seeing did not happen. My lspci looks
> > as follows:
> > 
> > root@ea210c63d739:/# lspci -v
> > 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
> > [Normal decode])
> >         Flags: bus master, fast devsel, latency 0, IRQ 255
> >         Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
> >         Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
> >         Memory behind bridge: 01100000-011fffff
> >         [virtual] Expansion ROM at 01200000 [disabled] [size=64K]
> >         Capabilities: [40] Power Management version 3
> >         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
> >         Capabilities: [70] Express Root Port (Slot-), MSI 00
> >         Capabilities: [100] Advanced Error Reporting
> >         Capabilities: [140] Virtual Channel
> > lspci: Unable to load libkmod resources: error -12
> > 
> > 01:00.0 Network controller: Qualcomm Atheros AR928X Wireless Network
> > Adapter (PCI-Express) (rev 01)
> >         Subsystem: Foxconn International, Inc. Device e007
> >         Flags: bus master, fast devsel, latency 0, IRQ 312
> >         Memory at 01100000 (64-bit, non-prefetchable) [size=64K]
> >         Capabilities: [40] Power Management version 2
> >         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
> >         Capabilities: [60] Express Legacy Endpoint, MSI 00
> >         Capabilities: [90] MSI-X: Enable- Count=1 Masked-
> >         Capabilities: [100] Advanced Error Reporting
> >         Capabilities: [140] Virtual Channel
> >         Capabilities: [160] Device Serial Number 00-00-00-00-00-00-00-00
> >         Kernel driver in use: ath9k
> > 
> > 
> > I did also setup a WiFi network and transmitted some packages, but I did
> > not get a nobody carred message. Do you have an idea why that might be?
> > 
> > # cat /proc/interrupts
> > ...
> > 312:      10967          0          0          0       GPC 123 Level    
> > ath9k
> > ...
> > 
> > 
> > Your conclusion in this thread seem reasonable, hence reverting the
> > issue does. However, I still would like to reproduce the issue so I can
> > make sure that future patches don't break it :-)
> 
> Hm, I realized that I need to enable CONFIG_PCIEPORTBUS and set
> ath9k.use_msi=1 to get MSI for that card. However, it seems that ath9k
> does not behave well in that setup. It does get interrupts, and seems to
> work to some degree, but I was not successful in transmitting data over
> WiFi, but that might be an entirly different thing.
> 
> However, what I noticed is that when CONFIG_PCIEPORTBUS and
> CONFIG_PCI_MSI is enabled, MSI works but legacy interrupt seem not to
> fire anymore. That is true for ath9k as well as e1000e (using
> e1000e.IntMode=0 to force legacy). Is that a known issue/limitation with
> i.MX 6 PCIe?

Yes, this is a known issue with the Designware PCIe core, not just on
i.MX6. As soon as any MSI interrupt is enabled, the core doesn't
forward legacy IRQs anymore.

So if any card in your system needs legacy interrupts (and ath9k is
very likely to need this, as MSI support is pretty new and
experimental), you need to boot with "nomsi" set on the kernel command
line.

Regards,
Lucas
