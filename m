Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46394 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932158AbcCDQ1l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Mar 2016 11:27:41 -0500
Date: Fri, 4 Mar 2016 10:27:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] Fix NULL ptr dereference in pci_bus_assign_domain_nr()
 on ARM
Message-ID: <20160304162737.GA1296@localhost>
References: <m337sapw89.fsf@t19.piap.pl>
 <20160303173522.GA9189@localhost>
 <m38u1yojmq.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <m38u1yojmq.fsf@t19.piap.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 04, 2016 at 07:13:49AM +0100, Krzysztof Hałasa wrote:
> Hi Bjorn,
> 
> Bjorn Helgaas <helgaas@kernel.org> writes:
> 
> > On Tue, Mar 01, 2016 at 07:07:18AM +0100, Krzysztof Hałasa wrote:
> >> Many ARM platforms use a wrapper:
> >> /*
> >>  * Compatibility wrapper for older platforms that do not care about
> >>  * passing the parent device.
> >>  */
> >> static inline void pci_common_init(struct hw_pci *hw)
> >> {
> >>         pci_common_init_dev(NULL, hw);
> >> }
> >> 
> >> which means that pci_bus_assign_domain_nr() can be called without
> >> a parent. This patch fixes the NULL pointer dereference.
> >
> > What exactly is the impact of this?  Does this fix need to be in v4.5?
> > It sounds like it should be, but I need a little more detailed
> > justification, e.g., "platforms X, Y, Z don't boot at all without
> > this change."
> 
> At least CNS3xxx doesn't boot. I haven't verified a couple of others,
> but they may be broken as well.

Good, thanks.  Also (I should have asked this before), please include a
"Fixes:" line so we know exactly when this broke and what stable kernels
need the fix.

Bjorn
