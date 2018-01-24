Return-Path: <SRS0=/8jO=ET=gmail.com=jpgrayson@kernel.org>
Return-Path: <SRS0=/8jO=ET=gmail.com=jpgrayson@kernel.org>
Date: Wed, 24 Jan 2018 11:45:30 -0500
From: Peter Grayson <jpgrayson@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Grayson <jpgrayson@gmail.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	linux-pci@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@linux.ie>
Subject: Re: [GIT PULL] PCI fixes for v4.15
Message-ID: <20180124164530.br5mlcj777gxxt4w@chibold.localdomain>
References: <20180123195644.GA92112@bhelgaas-glaptop.roam.corp.google.com>
 <CA+55aFxFp_rjSviLUEH-uZ1U=x_g-xiAFKoEQqOOxZQs4xV11A@mail.gmail.com>
 <20180124004603.GH5317@bhelgaas-glaptop.roam.corp.google.com>
 <CA+55aFwpmqZUnD=3U23c-r89XmyncoXQzK7+b8AyuQ9+soC19g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CA+55aFwpmqZUnD=3U23c-r89XmyncoXQzK7+b8AyuQ9+soC19g@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 23, 2018 at 05:04:22PM -0800, Linus Torvalds wrote:
> On Tue, Jan 23, 2018 at 4:46 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jan 23, 2018 at 12:49:22PM -0800, Linus Torvalds wrote:
> 
> > Applying that patch with "git am" results in the correct
> >
> >   Author: Christian König <ckoenig.leichtzumerken@gmail.com
> 
> But apparently stgit does not:
> 
> > Applying the identical patch with "stg import -M" results in
> >
> >   Author: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
> 
> I'm adding Peter Grayson and Catalin Marinas to the participants,
> since they seem to be the main stgit developers.

It it probable that I caused this stgit regression with changes to make
stgit compatible with Python 3. Mea culpa.

The issue is possibly already repaired. Catalin recently (a few days
ago) merged repairs for several related email encoding regressions.

> Bjorn, maybe you can send Catalin an example mbox?

An example mbox or even just forwarding the email with the patch in
question would be helpful.

Also helpful would be the versions of stgit and python being used along
with the LC_ALL and LANG environment variables used when running `stg
import`.

Thanks,
Pete
