Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 4 Oct 2012 16:35:11 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Matthew Wilcox <willy@linux.intel.com>, x86@kernel.org,
	linux-pci@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v3 -tip 5/5] AHCI: Support multiple MSIs
Message-ID: <20121004143511.GE2258@dhcp-26-207.brq.redhat.com>
References: <cover.1349074231.git.agordeev@redhat.com>
 <cc6441a31a2c600ad9ae33e7715de65b8d46a66f.1349074231.git.agordeev@redhat.com>
 <20121002050929.GD7756@gmail.com>
 <20121002164220.GB2258@dhcp-26-207.brq.redhat.com>
 <506B1A26.2060609@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <506B1A26.2060609@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 02, 2012 at 12:45:26PM -0400, Jeff Garzik wrote:
> >>>+	VPRINTK("ENTER\n");
> >>
> >>Is this per IRQ handler execution debugging code still needed?
> >>Same for the other VPRINTK() lines in this patch.
> >
> >These VPRINKs are only to make new handlers look like ahci_interrupt()
> >which did not change. I believe, if they need to go it is better to
> >remove them altogether, with a separate followup patch.
> 
> Definitely followup patch material + discussion :)

It appears the discussion comes first :)

As DPRINTKs/VPRINTKs are all over the ATA stack, I do not really realize
why it should be eliminated in one places (i.e. in hardware handlers) and
left in anothers. So as long as you would not like to remove them all, I
would leave it as is for now.

Does it make sense for you?

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
