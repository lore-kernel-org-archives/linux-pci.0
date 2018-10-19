Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A961ECDE3D
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 15:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC282083A
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 15:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC282083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeJSXHe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:07:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:8316 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbeJSXHe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 19:07:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 08:01:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,400,1534834800"; 
   d="scan'208";a="100889079"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 19 Oct 2018 08:01:04 -0700
Date:   Fri, 19 Oct 2018 08:58:20 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Matthew Wilcox <willy@infradead.org>,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI/AER: Enable error reporting for all ports
Message-ID: <20181019145820.GB23571@localhost.localdomain>
References: <153989603841.78375.436243401553964151.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20181018230312.GB23301@localhost.localdomain>
 <20181019011135.GP5906@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019011135.GP5906@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 18, 2018 at 08:11:35PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 18, 2018 at 05:03:13PM -0600, Keith Busch wrote:
> > On Thu, Oct 18, 2018 at 03:53:58PM -0500, Bjorn Helgaas wrote:
> > > Change the AER service driver so it binds to *all* PCIe Ports,
> > > including Switch Upstream and Downstream Ports.  Enable AER error
> > > reporting for all these Ports, but not for any children.
> > 
> > I'm looking at this again and think enabling/disabling error
> > reporting for ports is the responsibility of the port driver, not
> > the AER service.
> 
> That's an interesting idea.  Can you expand on this a little more?
> Why is it the responsibility of the port driver?
> 
> Do you think pci_enable_pcie_error_reporting() shouldn't be part of
> the AER service because it updates the Device Control register, which
> is in the PCIe Capability, not the AER Capability?
> 
> What about pci_aer_clear_device_status(), which clears Device Status,
> which is also in the PCIe Capability?

I was comparing how other end device driver's enable this, and they all call
pci_enable_pcie_error_reporting() somewhere along their pci_driver->probe
path. With that in mind, are ports special compared to end devices for this
particular feature?
 
> > The following should do the same as this patch, but without making
> > AER driver handle non-root ports.  The report enabling/disabling
> > functions are already stubbed for '!CONFIG_PCIE_AER' and have checks
> > for aer_cap and firmware first.
> 
> If we thought we should enable error reporting *always*, regardless of
> whether the AER service is enabled, this would make perfect sense to
> me, and I might suggest doing it in an even more generic place like
> pci_configure_device() or pci_init_capabilities().

There are unfortunately still pci_driver instances that don't implement
the err_handler callbacks, and may cause problems if we enable error
reporting in the device when its driver isn't capable of reacting to them.

If it wasn't for that, I think it would make more sense to move this
responsibility from drivers to the pci core.

> But that doesn't seem like where you're headed.  It seems like you
> still only want error reporting enabled when CONFIG_PCIEAR=y.  If
> that's the case, it seems like doing it in portdrv only obfuscates the
> connection with AER.  When CONFIG_PCIEAER is unset, the portdrv code
> *looks* like it's doing something but it's really not because of the
> #ifdef magic.

Right, but that's no different than every other Linux pci_driver. The
component that provides the pci_driver.err_handler should be responsible
for requesting to enable device error reporting, and that's provided by
the port driver, not AER.
