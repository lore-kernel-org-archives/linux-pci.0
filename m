Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 22 Mar 2017 14:18:21 +0000
From: Will Deacon <will.deacon@arm.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] arm64: Do not expose PCI mmap through procfs
Message-ID: <20170322141820.GI8026@arm.com>
References: <cover.1490188942.git.dwmw2@infradead.org>
 <4281f8e01b9fc5628cbf4a5c77abd642801e23c7.1490188942.git.dwmw2@infradead.org>
 <cd878fb7-86f1-50cc-d394-364cb8bde344@codeaurora.org>
 <1490191473.28249.9.camel@infradead.org>
 <5362b452-8526-1a97-ebf7-7052f1af56f7@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5362b452-8526-1a97-ebf7-7052f1af56f7@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 22, 2017 at 10:15:04AM -0400, Sinan Kaya wrote:
> On 3/22/2017 10:04 AM, David Woodhouse wrote:
> > On Wed, 2017-03-22 at 09:54 -0400, Sinan Kaya wrote:
> >> On 3/22/2017 9:25 AM, David Woodhouse wrote:
> >>>
> >>>  
> >>> +#ifdef __aarch64__
> >>> +/* ARM64 wants to be special and not expose this through /proc
> >>> like everyone else */
> >>> +#undef HAVE_PCI_MMAP
> >>> +#endif
> >>> +
> >> Where is this ARM64 special requirement coming from?
> > 
> > The idea is that as a new platform, ARM64 shouldn't need to implement
> > legacy userspace interfaces.
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/422571.html
> > 
> 
> Aren't we breaking an ABI for userspace? I know DPDK relies on this feature.

It relies on the /proc interface? That's the first I've ever heard of that
-- everybody so far has only been interested in the sysfs stuff.

Nothing's more broken than before, because we've never supported the /proc
interface, but if existing arm64 code out there is failing because of that
then I'm of course open to supporting it. I'm just surprised that nobody
else has come up with that before, since DPDK is in common use.

Can you point me at the specific code, please?

Will
