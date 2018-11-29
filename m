Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4BBC04EB9
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 23:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E2521019
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 23:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhV33sG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E2521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbeK3KME (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:12:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbeK3KME (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Nov 2018 05:12:04 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96ED320863;
        Thu, 29 Nov 2018 23:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543532697;
        bh=SnI4YkvoCDWU11Nn81ZU7jCEYMiHp2OTIQ+2Cz5SqOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UhV33sG6rtPPX7KZOTDFp4Zk5HmOTVF6D0QVl9Jz6A7eeGi9NgeY+nFz6W/QkNMb3
         r+aX2doE17cVhqRPwoKmTElyafBSxsKfmoYzG7zfuOSzeNtP6cM+YYbbhvIEva+vRs
         ts4Db/aIW9lChc+RcYTlFacV0VM0pESYEpoSpDcw=
Date:   Thu, 29 Nov 2018 17:04:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Alex_Gagniuc@Dellteam.com, mr.nuke.me@gmail.com,
        Austin.Bolen@dell.com, keith.busch@intel.com, Shyam.Iyer@dell.com,
        mika.westerberg@linux.intel.com, okaya@codeaurora.org,
        rafael.j.wysocki@intel.com, poza@codeaurora.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Report degraded links via link bandwidth
 notification
Message-ID: <20181129230454.GF178809@google.com>
References: <20181129000829.14751-1-mr.nuke.me@gmail.com>
 <20181129173553.GD178809@google.com>
 <1828edee07fa483d9600aeb5b9b69456@ausx13mps321.AMER.DELL.COM>
 <20181129191312.6ksdzjv6qojacv4j@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129191312.6ksdzjv6qojacv4j@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 29, 2018 at 08:13:12PM +0100, Lukas Wunner wrote:
> On Thu, Nov 29, 2018 at 06:57:37PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> > On 11/29/2018 11:36 AM, Bjorn Helgaas wrote:
> > > On Wed, Nov 28, 2018 at 06:08:24PM -0600, Alexandru Gagniuc wrote:
> > >> A warning is generated when a PCIe device is probed with a degraded
> > >> link, but there was no similar mechanism to warn when the link becomes
> > >> degraded after probing. The Link Bandwidth Notification provides this
> > >> mechanism.
> > >>
> > >> Use the link bandwidth notification interrupt to detect bandwidth
> > >> changes, and rescan the bandwidth, looking for the weakest point. This
> > >> is the same logic used in probe().
> > > 
> > > I like the concept of this.  What I don't like is the fact that it's
> > > tied to pciehp, since I don't think the concept of Link Bandwidth
> > > Notification is related to hotplug.  So I think we'll only notice this
> > > for ports that support hotplug.  Maybe it's worth doing it this way
> > > anyway, even if it could be generalized in the future?
> > 
> > That makes sense. At first, I thought that BW notification was tied to 
> > hotplug, but our PCIe spec writer disagreed with that assertion. I'm 
> > just not sure where to handle the interrupt otherwise.
> 
> I guess the interrupt is shared with hotplug and PME?  In that case write
> a separate pcie_port_service_driver and request the interrupt with
> IRQF_SHARED.  Define a new service type in drivers/pci/pcie/portdrv.h.
> Amend get_port_device_capability() to check for PCI_EXP_LNKCAP_LBNC.

I really don't like the port driver design.  I'd rather integrate
those services more tightly into the PCI core.  But realistically
that's wishful thinking and may never happen, so this might be the
most expedient approach.

Bjorn
