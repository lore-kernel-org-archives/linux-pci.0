Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 23 Mar 2017 10:57:27 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v3] efifb: avoid reconfiguration of BAR that covers the
 framebuffer
Message-ID: <20170323105727.GA2441@red-moon>
References: <1490196629-28088-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170322193111.GA8190@wunner.de>
 <CAKv+Gu_X-SEnz7h9J8boqqjOQGHQawwdSAq4haH-OGu8zdfNfA@mail.gmail.com>
 <20170323084819.GA23281@h08.hostsharing.net>
 <CAKv+Gu93eJ-js3g7M6Jdm6XGMaWMswFmzBG2qNT4rn+3=1+EyA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu93eJ-js3g7M6Jdm6XGMaWMswFmzBG2qNT4rn+3=1+EyA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 Matt Fleming <matt@codeblueprint.co.uk>, linux-pci <linux-pci@vger.kernel.org>,
 Peter Jones <pjones@redhat.com>, Heyi Guo <heyi.guo@linaro.org>,
 Lukas Wunner <lukas@wunner.de>, Hanjun Guo <hanjun.guo@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 23, 2017 at 09:04:03AM +0000, Ard Biesheuvel wrote:
> On 23 March 2017 at 08:48, Lukas Wunner <lukas@wunner.de> wrote:
> > On Wed, Mar 22, 2017 at 07:32:43PM +0000, Ard Biesheuvel wrote:
> >> On 22 March 2017 at 19:31, Lukas Wunner <lukas@wunner.de> wrote:
> >> > On Wed, Mar 22, 2017 at 03:30:29PM +0000, Ard Biesheuvel wrote:
> >> >> On UEFI systems, the PCI subsystem is enumerated by the firmware,
> >> >> and if a graphical framebuffer is exposed by a PCI device, its base
> >> >> address and size are exposed to the OS via the Graphics Output
> >> >> Protocol (GOP).
> >> >>
> >> >> On arm64 PCI systems, the entire PCI hierarchy is reconfigured from
> >> >> scratch at boot. This may result in the GOP framebuffer address to
> >> >> become stale, if the BAR covering the framebuffer is modified. This
> >> >> will cause the framebuffer to become unresponsive, and may in some
> >> >> cases result in unpredictable behavior if the range is reassigned to
> >> >> another device.
> >> >
> >> > Hm, commit message seems to indicate the issue is restricted to arm64,
> >> > yet there's no IS_ENABLED(ARM64) to constrain the added code to that arch?
> >>
> >> True. I am eager to get some x86 coverage for this, since I would
> >> expect this not to do any harm. But I'm fine with making it ARM/arm64
> >> specific in the final version.
> >
> > I see.  IIUC, this is only a problem because pci_bus_assign_resources()
> > is called from arch/arm64/kernel/pci.c:pci_acpi_scan_root() (as well as
> > the host drivers) and x86 isn't affected because it doesn't do that.
> >
> 
> Correct. But on x86 (or rather, on a PC), you can be sure that UEFI
> (or the legacy PCI bios) performed the resource assignment already.
> One could argue that this is equally the case when running arm64 in
> ACPI mode, but in general, you cannot assume the presence of firmware
> on ARM/arm64 that has already taken care of this, and so the state of
> the BARs has to be presumed invalid.

The story is a bit more convoluted than that owing to x86 (and other
arches) legacy.

x86 tries to claim all PCI resources (in two passes - first enabled
devices, second disabled devices) and that predates ACPI/UEFI.

Mind, x86 reassign resources that can't be claimed too, the only
difference with ARM64 is that, for the better or the worse, we
have decided not to claim the FW PCI set-up on ARM64 even if it
is sane, we do not even try, it was a deliberate choice.

This patch should be harmless on x86 since if the FB PCI BAR is set
up sanely, claiming it again should be a nop (to be checked).

For all the talk about PCI being arch agnostic as I said manifold
times before, that's just theory. In practice different arches
treat PCI FW set-up differently, it would be ideal to make them
uniform but legacy is huge and there is a massive risk of triggering
regressions, it is no mean feat (if achievable at all).

Lorenzo

> > I have no opinion on executing the quirk on x86 as well, I was just
> > confused by the discrepancy between commit message and patch, but that
> > can easily be remedied with a copy+paste of what you replied to Sinan:
> >
> >        "On x86, it works, given that BARs are usually not reassigned,
> >         and so the patch should be a no-op in that case, although it
> >         should still be an improvement to check whether the device that
> >         owns the BAR actually has memory decoding enabled before we
> >         attach the framebuffer driver to it."
> >
> >
> 
> OK, I will include that.
> 
> >> >> +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, efifb_fixup_resources);
> >> >
> >> > Maybe this can be constrained to PCI_BASE_CLASS_DISPLAY?
> >>
> >> How does one do that with DECLARE_PCI_FIXUP_HEADER?
> >
> > With DECLARE_PCI_FIXUP_CLASS_HEADER().
> >
> 
> Ah ok, thanks for pointing that out.
> 
> I do wonder whether it makes sense to keep the code as is, so that we
> spot unexpected configurations, i.e., where the GOP points into a BAR
> that is unrelated to graphics. In this case, I think we should disable
> efifb rather than proceed without claiming any PCI resources (as we
> did without this patch)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
