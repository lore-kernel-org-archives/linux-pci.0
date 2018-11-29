Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E3CC43441
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 19:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4A32145D
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 19:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4A32145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbeK3GTl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:19:41 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:55365 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbeK3GTl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Nov 2018 01:19:41 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 036C5300002BE;
        Thu, 29 Nov 2018 20:13:13 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CA771105765; Thu, 29 Nov 2018 20:13:12 +0100 (CET)
Date:   Thu, 29 Nov 2018 20:13:12 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alex_Gagniuc@Dellteam.com
Cc:     helgaas@kernel.org, mr.nuke.me@gmail.com, Austin.Bolen@dell.com,
        keith.busch@intel.com, Shyam.Iyer@dell.com,
        mika.westerberg@linux.intel.com, okaya@codeaurora.org,
        rafael.j.wysocki@intel.com, poza@codeaurora.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Report degraded links via link bandwidth
 notification
Message-ID: <20181129191312.6ksdzjv6qojacv4j@wunner.de>
References: <20181129000829.14751-1-mr.nuke.me@gmail.com>
 <20181129173553.GD178809@google.com>
 <1828edee07fa483d9600aeb5b9b69456@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1828edee07fa483d9600aeb5b9b69456@ausx13mps321.AMER.DELL.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 29, 2018 at 06:57:37PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 11/29/2018 11:36 AM, Bjorn Helgaas wrote:
> > On Wed, Nov 28, 2018 at 06:08:24PM -0600, Alexandru Gagniuc wrote:
> >> A warning is generated when a PCIe device is probed with a degraded
> >> link, but there was no similar mechanism to warn when the link becomes
> >> degraded after probing. The Link Bandwidth Notification provides this
> >> mechanism.
> >>
> >> Use the link bandwidth notification interrupt to detect bandwidth
> >> changes, and rescan the bandwidth, looking for the weakest point. This
> >> is the same logic used in probe().
> > 
> > I like the concept of this.  What I don't like is the fact that it's
> > tied to pciehp, since I don't think the concept of Link Bandwidth
> > Notification is related to hotplug.  So I think we'll only notice this
> > for ports that support hotplug.  Maybe it's worth doing it this way
> > anyway, even if it could be generalized in the future?
> 
> That makes sense. At first, I thought that BW notification was tied to 
> hotplug, but our PCIe spec writer disagreed with that assertion. I'm 
> just not sure where to handle the interrupt otherwise.

I guess the interrupt is shared with hotplug and PME?  In that case write
a separate pcie_port_service_driver and request the interrupt with
IRQF_SHARED.  Define a new service type in drivers/pci/pcie/portdrv.h.
Amend get_port_device_capability() to check for PCI_EXP_LNKCAP_LBNC.

Thanks,

Lukas
