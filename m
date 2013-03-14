Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:41321 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501Ab3CNVFj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 Mar 2013 17:05:39 -0400
Date: Thu, 14 Mar 2013 15:05:34 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Mitch Bradley <wmb@firmworks.com>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130314210534.GA18505@obsidianresearch.com>
References: <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
 <5140E85A.3040900@firmworks.com>
 <20130313220235.GA29895@avionic-0098.mockup.avionic-design.de>
 <20130313222102.GA28336@obsidianresearch.com>
 <20130314090120.GA2224@avionic-0098.mockup.avionic-design.de>
 <20130314172555.GA14048@obsidianresearch.com>
 <20130314203858.GA4539@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130314203858.GA4539@avionic-0098.mockup.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 14, 2013 at 09:38:58PM +0100, Thierry Reding wrote:
> >                pci@1,0 {
> >                         device_type = "pci";
> >                         assigned-addresses = <0x82000000 0 0x80000000  0 0x1000>;

Sorry, I missed this. The b,d,f bits should be set:

                        assigned-addresses = <0x82000800 0 0x80000000  0 0x1000>;


> >                         reg = <0x000800 0 0 0 0>;
> >                }
> >                pci@2,0 {
> >                         device_type = "pci";
> >                         assigned-addresses = <0x82000000 0 0x80001000  0 0x1000>;

                         assigned-addresses = <0x82001000 0 0x80001000  0 0x1000>;


The 'ranges' stays the same, the PCI 3/2 parse will ignore the b,d,f
bits when comparing against ranges.

The use of r == 0 for assigned-addresses should be enough to
disambiguate this case from any future use of assigned-addresses - the
normal case has r == offset of the associated BAR != 0.

Cheers,
Jason
