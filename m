Return-Path: <SRS0=bOp+=MB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAB3ECE564
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 17:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3FF2150E
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 17:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3FF2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeISWm2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:42:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:32542 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbeISWm2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 18:42:28 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 10:03:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,394,1531810800"; 
   d="scan'208";a="74325423"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga007.jf.intel.com with ESMTP; 19 Sep 2018 10:03:39 -0700
Date:   Wed, 19 Sep 2018 11:05:33 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCHv3 01/10] PCI/portdrv: Use subsys_init for service drivers
Message-ID: <20180919170533.GA28310@localhost.localdomain>
References: <20180918235702.26573-1-keith.busch@intel.com>
 <20180918235702.26573-2-keith.busch@intel.com>
 <20180919162846.GB243610@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919162846.GB243610@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180919170533.l_SSYzdwOeI2reQ1y49oh5BQTKHbCWsMj_bI-aZ4zJg@z>

On Wed, Sep 19, 2018 at 11:28:46AM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 18, 2018 at 05:56:53PM -0600, Keith Busch wrote:
> > The PCI port driver saves the PCI state after initializing all the
> > service devices. This was, however, before the service drivers were even
> > registered. The config space state that the service drivers were setting
> > up were not being saved.
> > 
> > This patch fixes this by changing the service drivers use the
> > subsys_init, which gets the service drivers registered after the pci bus
> > system is initialized, but before the pci devices are probed. This gets
> > the state saved as expected.
> 
> I agree this is a problem.  What are the user-visible symptoms of it?
> Incorrect service behavior after a resume?  Nice debugging and fix!

I'll look at the suspend/resume case too, but I noticed the incorrect
behavior after a bus reset: future DPC or HPC events downstream a port
were lost after an AER recovery because the control registers were
never restored.

The very next patch is required too, since that's what actually restores
the registers to the saved state.

> I think the ordering here is pretty obscure.  We have a lot of
> initcalls here and they all have to line up exactly right.  If I
> understand correctly, the flow of the required pieces (after this
> patch) is like this:
> 
>   pci_driver_init                             # postcore_initcall (2)
>     bus_register(&pcie_port_bus_type)
> 
>   pcied_init (pciehp)                         # subsys_initcall (4)
>     pcie_port_service_register(&hpdriver_portdrv)
>       new->driver.bus = &pcie_port_bus_type   # depends on above
>                                               # bus_register()
>       driver_register(&new->driver)
> 
>   pcie_portdrv_init                           # device_initcall (6)
>     pci_register_driver(&pcie_portdriver)
> 
>   pcie_portdrv_probe                          # pcie_portdriver.probe
>     pcie_port_device_register
>       pcie_device_init
>         device_register
>           device_add
>             bus_probe_device
>               ...
>                 pciehp_probe                  # <-- critical init
>                                               # depends on above
>                                               # service_register() and
>                                               # eager probing
>     pci_save_state                            # <-- critical save
> 
> The problem used to be that both pcied_init() (for pciehp) and
> pcie_portdrv_init() were device initcalls and pcie_portdrv_init() was
> called before pcied_init() because of link order, so the
> pci_save_state() happened before the pciehp init.
> 
> Since none of the service drivers can be modules, I don't think it
> buys us much to make their init functions initcalls.  Can we
> explicitly call them from the pcie_portdrv_probe() path?

That sounds good to me. The portdrv isn't all that abstracted from the
child services anyway.
