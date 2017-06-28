Return-Path: <helgaas@kernel.org>
Date: Wed, 28 Jun 2017 15:43:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Bjorn Helgaas <bjorn.helgaas@gmail.com>, bjorn@helgaas.com,
	Ryder Lee <ryder.lee@mediatek.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] critical patch to fix pci-tree build bot failure
Message-ID: <20170628204316.GU17844@bhelgaas-glaptop.roam.corp.google.com>
References: <1498555451-55073-1-git-send-email-ryder.lee@mediatek.com>
 <CABhMZUW0q3iAwsf6_ykEM1wTnEv1O9gMP3YUvXzr+HDwJq=VXA@mail.gmail.com>
 <20170628081026.5a211391@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170628081026.5a211391@canb.auug.org.au>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 28, 2017 at 08:10:26AM +1000, Stephen Rothwell wrote:
> Hi Bjorn,
> 
> On Tue, 27 Jun 2017 08:20:44 -0500 Bjorn Helgaas <bjorn.helgaas@gmail.com> wrote:
> >
> > On Tue, Jun 27, 2017 at 4:24 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> > > Hi Stephen and Andrew,
> > >
> > > Could you help to apply this patch? Seems Bjorn didn't response it these days.  
> > 
> > I'm not dead, but I was on vacation most of last week.  I'll resolve this today.
> 
> Should I just add this patch to linux-next today (if you don't get
> around to it in the next hour or so)?

Just FYI, this should be fixed in my -next branch now, so you shouldn't
need to add the patch yourself, Stephen.
