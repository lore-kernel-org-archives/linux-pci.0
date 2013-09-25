Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 25 Sep 2013 17:00:16 -0400
From: Tejun Heo <tj@kernel.org>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Michael Ellerman <michael@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jan Beulich <JBeulich@suse.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Message-ID: <20130925210016.GA8926@htj.dyndns.org>
References: <20130909152044.GA24962@dhcp-26-207.brq.redhat.com>
 <20130916102210.GA14102@dhcp-26-207.brq.redhat.com>
 <20130917143022.GA7707@concordia>
 <20130918094759.GA2353@dhcp-26-207.brq.redhat.com>
 <20130918142231.GA21650@mtj.dyndns.org>
 <20130918165045.GB2353@dhcp-26-207.brq.redhat.com>
 <20130920082458.GA10507@dhcp-26-207.brq.redhat.com>
 <20130920122736.GD7630@mtj.dyndns.org>
 <20130925180220.GB26273@google.com>
 <20130925205804.GA21737@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130925205804.GA21737@dhcp-26-207.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Wed, Sep 25, 2013 at 10:58:05PM +0200, Alexander Gordeev wrote:
> Unfortunately, pSeries is a shows-topper here :( It seems we have to
> introduce pci_get_msi{,x}_limit() interfaces to honour the quota
> thing.  I just hope the hardware set for pSeries is limited and we
> won't need to use it for all drivers.

Can you please go into a bit of detail on that?  Why does it matter?
Is it because you're worried you might cause performance regression by
forcing prevoius partial multiple allocations to single interrupt
operation?

Thanks.

-- 
tejun
