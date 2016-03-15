Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 15 Mar 2016 21:47:41 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] nouveau: use new vga_switcheroo power domain.
Message-ID: <20160315204741.GC27934@wunner.de>
References: <1457504045-12738-1-git-send-email-airlied@gmail.com>
 <1457504045-12738-2-git-send-email-airlied@gmail.com>
 <20160309144047.GB26158@wunner.de>
 <CAPM=9txfEOoXLr35qEMQrpfMdDf_rCyUx0pQoC4HbQ=t0HNKdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPM=9txfEOoXLr35qEMQrpfMdDf_rCyUx0pQoC4HbQ=t0HNKdw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Dave,

On Thu, Mar 10, 2016 at 08:04:26AM +1000, Dave Airlie wrote:
> On 10 March 2016 at 00:40, Lukas Wunner <lukas@wunner.de> wrote:
> > On Wed, Mar 09, 2016 at 04:14:05PM +1000, Dave Airlie wrote:
> >> From: Dave Airlie <airlied@redhat.com>
> >>
> >> This fixes GPU auto powerdown on the Lenovo W541,
> >> since we advertise Windows 2013 to the ACPI layer.
> >>
> >> Signed-off-by: Dave Airlie <airlied@redhat.com>
> >> ---
> >>  drivers/gpu/drm/nouveau/nouveau_vga.c | 10 +++++++---
> >>  1 file changed, 7 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/nouveau/nouveau_vga.c b/drivers/gpu/drm/nouveau/nouveau_vga.c
> >> index af89c36..b987427f 100644
> >> --- a/drivers/gpu/drm/nouveau/nouveau_vga.c
> >> +++ b/drivers/gpu/drm/nouveau/nouveau_vga.c
> >> @@ -101,8 +101,12 @@ nouveau_vga_init(struct nouveau_drm *drm)
> >>               runtime = true;
> >>       vga_switcheroo_register_client(dev->pdev, &nouveau_switcheroo_ops, runtime);
> >>
> >> -     if (runtime && nouveau_is_v1_dsm() && !nouveau_is_optimus())
> >> -             vga_switcheroo_init_domain_pm_ops(drm->dev->dev, &drm->vga_pm_domain);
> >> +     if (runtime) {
> >> +             if (nouveau_is_v1_dsm() && !nouveau_is_optimus())
> >
> > The " && !nouveau_is_optimus()" can be dropped because a machine cannot
> > have both. Note the "else" in nouveau_dsm_detect():
> 
> I'm pretty sure I've seen a machine with both in my past, back in the
> Vista/Win7 crossover days.

Yes, but the code in nouveau_dsm_detect() is such that you'll never have
both nouveau_is_v1_dsm() and nouveau_is_optimus() return true.

So you can drop the " && !nouveau_is_optimus()".

Best regards,

Lukas

> 
> > You're calling this unconditionally for all Optimus machines yet
> > I assume pre Windows 10 machines lack the PR3 hooks.
> >
> 
> Yes and I've confirmed on my older machine that nothing bad happens
> doing it unconditionally,
> and I couldn't find any bits in the _DSM flags to tell me if I should
> do something different.
> 
> Dave.
