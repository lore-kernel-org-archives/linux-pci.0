Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:57185 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419Ab2EYDi5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 May 2012 23:38:57 -0400
Message-ID: <1337917105.16119.11.camel@pasglop>
Subject: Re: [PATCH v3 1/2] powerpc/PCI: move DMA & IRQ init to device_add()
 notification path
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>,
	Michal Simek <monstr@monstr.eu>,
	microblaze-uclinux@itee.uq.edu.au, linux-pci@vger.kernel.org,
	Jesse Larrew <jlarrew@linux.vnet.ibm.com>,
	jbarnes@virtuousgeek.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linuxppc-dev@lists.ozlabs.org
Date: Fri, 25 May 2012 13:38:25 +1000
In-Reply-To: <CAErSpo6W28r4f5pJmZr=ofUAaffiUtOqgXWeabGpr+DmKw+Z+g@mail.gmail.com>
References: <20120523222635.24276.80023.stgit@bhelgaas.mtv.corp.google.com>
	 <20120523223700.24276.76804.stgit@bhelgaas.mtv.corp.google.com>
	 <1337914811.16119.7.camel@pasglop>
	 <CAErSpo6W28r4f5pJmZr=ofUAaffiUtOqgXWeabGpr+DmKw+Z+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2012-05-24 at 21:08 -0600, Bjorn Helgaas wrote:
> 
> OK.  Are you worried about cardbus in particular?
> 
> This is headed for the 3.6, not 3.5, so we should have plenty of time.
>  As soon as everything for the current merge window gets merged and
> -next is ready for the next batch, I'll put this in there.

I'm not that worried about cardbus ... in fact I wouldn't be surprised
if it's already somewhat broken, I haven't tested it in a long time...

I'm more worried about basic functionality and expectations about when
things happen during boot vs. platform hacks, that and pseries specific
kind of hotplug which can be a bit odd.

Cheers,
Ben.


