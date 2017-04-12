Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 12 Apr 2017 23:53:59 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Tony Luck <tony.luck@gmail.com>
cc: David Woodhouse <dwmw2@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 25/27] ia64: Use generic pci_mmap_resource_range()
In-Reply-To: <CA+8MBbKwN=pBN17Msm-g=x-iEgvy6KNFkutKsw_pDboBHgMifA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1704122352440.2548@nanos>
References: <cover.1491999859.git.dwmw2@infradead.org> <109e9ddbde4334d0da34f331797236309d789353.1491999859.git.dwmw2@infradead.org> <CA+8MBbKwN=pBN17Msm-g=x-iEgvy6KNFkutKsw_pDboBHgMifA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 12 Apr 2017, Tony Luck wrote:

> On Wed, Apr 12, 2017 at 5:26 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> > From: David Woodhouse <dwmw@amazon.co.uk>
> >
> > Now that we eliminated the different behaviour in separately-reviewable
> > commits, we can switch IA64 to the generic implementation.
> >
> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> 
> Well it builds and boots on my last remaining ia64 machine.

Does that mean ia64 reached the 'NCR Voyager' stage and can be scheduled
for removal?

Thanks,

	tglx
