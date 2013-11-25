Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 25 Nov 2013 14:49:15 +0100
From: Alexander Gordeev <agordeev@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Michael Ellerman <michael@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ben Hutchings <bhutchings@solarflare.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Mark Lord <kernel@start.ca>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v2 09/29] PCI/MSI: Factor out pci_get_msi_cap()
 interface
Message-ID: <20131125134914.GA6924@dhcp-26-207.brq.redhat.com>
References: <cover.1382103786.git.agordeev@redhat.com>
 <85500e7239fcb104df091bbfa873eef8ae654772.1382103786.git.agordeev@redhat.com>
 <20131120161808.GI28946@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131120161808.GI28946@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 20, 2013 at 11:18:08AM -0500, Tejun Heo wrote:
> > +If this function returns a negative number, it indicates the device is
> > +not capable of sending MSIs.
> 
> Wouldn't "errno" better describe the error return rather than
> "negative number"?

Term "negative number" is used throughout the whole document.
Could be updated in a separate patch if it worth it.

> tejun

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
