Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48102 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753428AbaJAW2g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 18:28:36 -0400
Message-ID: <1412201390.4285.233.camel@pasglop>
Subject: Re: [PATCH 1/4] pci/msi: Move "force_32bit_msi" flag from powerpc
 to generic pci_dev
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Deucher <alexdeucher@gmail.com>,
	Dave Airlie <airlied@linux.ie>,
	Brian King <brking@linux.vnet.ibm.com>,
	Takashi Iwai <tiwai@suse.de>, linux-pci@vger.kernel.org,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org
Date: Thu, 02 Oct 2014 08:09:50 +1000
In-Reply-To: <20141001203322.GE4171@google.com>
References: <1412048401.4285.128.camel@pasglop>
	 <CAErSpo4B6kuZJcKwreNvW1qC5sZ=1Ko71vbzNz7T8-_pjf7mww@mail.gmail.com>
	 <CADnq5_PT+dX=KA4epGNRaoraco2z1pe5K7UgqLmTUhWMnvtWkw@mail.gmail.com>
	 <1412108504.4285.155.camel@pasglop>
	 <CADnq5_O_iLAZUKLL4nph8VwuP2NOkWXhBZC2XTSkFm5P42WZ+g@mail.gmail.com>
	 <1412110946.4285.158.camel@pasglop>
	 <CADnq5_OXBax1+TKPsR2RDYTWijQKDVw34ECfWzcwN2SibCGYTg@mail.gmail.com>
	 <1412112324.4285.160.camel@pasglop> <1412129363.4285.190.camel@pasglop>
	 <20141001203322.GE4171@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2014-10-01 at 14:33 -0600, Bjorn Helgaas wrote:
> I like the idea of handling this more generically, e.g., with a bit like
> this in struct pci_dev (I'd probably name it something like "no_64bit_msi"
> along the lines of your driver #defines).
> 
> What I don't like is that we haven't done anything to help other
> architectures, because the only code that *looks* at this bit is in
> arch/powerpc.  The next arch that tries to use 64-bit MSI addresses for
> these devices will trip over the same problem.

I started looking. From my (limited) understanding of x86, it doesn't
even look at the "size" of MSIs which makes me think it's always 32-bit,
and I plan to look at the others next (though not for stable).

> Can we check in pci_enable_msi_range() and pci_enable_msix_range() whether
> the MSI addresses allocated by the arch are too big, and fail the call if
> they are?

Yes, good idea, I'll add something.

Cheers,
Ben.


