Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39FDC282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 19:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7055D2184B
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 19:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfAWTCH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:02:07 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:58239 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAWTCH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jan 2019 14:02:07 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 0A7EF100CF150;
        Wed, 23 Jan 2019 20:02:04 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A23EC105DD; Wed, 23 Jan 2019 20:02:04 +0100 (CET)
Date:   Wed, 23 Jan 2019 20:02:04 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Alex_Gagniuc@Dellteam.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, Austin.Bolen@dell.com
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Message-ID: <20190123190204.csjedbvcxkjlr43d@wunner.de>
References: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
 <20190123184453.GB6629@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123184453.GB6629@localhost.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 23, 2019 at 11:44:53AM -0700, Keith Busch wrote:
> On Wed, Jan 23, 2019 at 06:20:57PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> > It's obvious that just relying on presence detect state is prone to race 
> > conditions. However, if a device is replaced, we'd expect the data link 
> > layer state to change as well. So I think the best way to proceed is to 
> > skip the SURPRISE!!!_REMOVAL if the following are true:
> >   * presence detect is set
> >   * DLL changed is not set
> >   * presence detect was not previously set
> > 
> > Thoughts?
> 
> What is the value of PDS on the Link up event? If it's still "Slot
> Empty", could we just ignore the Link event instead and wait for the PDC
> event?

Well, usually it's desirable to bring up the slot as quickly as possible,
so once we get any kind of link or presence event, we immediately try to
bring up the slot.

We do allow a 20 + 100 ms delay in pcie_wait_for_link() between link up
and presence detect up, just not 400 ms.

Thanks,

Lukas
