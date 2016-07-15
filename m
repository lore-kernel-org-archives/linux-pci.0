Return-Path: <peter@lekensteyn.nl>
Return-Path: <peter@lekensteyn.nl>
Date: Fri, 15 Jul 2016 18:54:27 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: Dave Airlie <airlied@redhat.com>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [Nouveau] [PATCH v3 0/4] nouveau RPM fixes for Optimus (final)
Message-ID: <20160715165427.GD2632@al>
References: <20160715131218.2416-1-peter@lekensteyn.nl>
 <CAKb7UvisjzPs_K1SNdDb7aZjxGQL4AOs05R8CX2xjU4uRpfcfA@mail.gmail.com>
 <20160715163622.GC2632@al>
 <CAKb7Uvg+E_92DF6p_3O0XtzG66qTdDM7Fa=TaesNs2Y6bzTQSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKb7Uvg+E_92DF6p_3O0XtzG66qTdDM7Fa=TaesNs2Y6bzTQSA@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 15, 2016 at 12:41:49PM -0400, Ilia Mirkin wrote:
> On Fri, Jul 15, 2016 at 12:36 PM, Peter Wu <peter@lekensteyn.nl> wrote:
> > On Fri, Jul 15, 2016 at 12:10:23PM -0400, Ilia Mirkin wrote:
> >> On Fri, Jul 15, 2016 at 9:12 AM, Peter Wu <peter@lekensteyn.nl> wrote:
> >> > Hi,
> >> >
> >> > Here are two patches to fix an issue reported on kernel bugzilla (infinite loop
> >> > due to unchecked function) and a more important fix to fix hanging Optimus
> >> > machines when runtime PM is enabled (with pm/pci patches).
> >> >
> >> > These are the final patches targeting v4.8. Changes compared to v2[1]:
> >> > collected R-b from Hans and Mika and fixed a minor comment style issue.
> >> >
> >> > I recommend it to be merged before the pci/pm patches[2], otherwise there is a
> >> > window where newer Nvidia Optimus laptops might fail to runtime resume and/or
> >> > lock up.  Once the pci/pm branch is merged I will propose another patch to
> >> > improve reliability[3].
> >> >
> >> > Known issue with patch 4: when a Nvidia HDMI audio function is present, the
> >> > bridge will not suspend and hence the Nvidia card will still be powered. Fixing
> >>
> >> That's basically all optimus gpu's, right? Anything GT21x+ has a HDMI
> >> audio subfunction, and prior to that, the nvidia gpu tended to be the
> >> only gpu, or hard-muxed.
> >>
> >> If that's the case, that's pretty much a non-starter, IMO.
> >
> > For some reason the audio function tends to disappear/hide, so maybe it
> > is not as problematic as it appears (see
> > https://bugs.freedesktop.org/show_bug.cgi?id=75985). For my laptop I
> 
> I'm aware of that bug. I believe this is an exceedingly rare scenario
> or it would have been reported a lot more.
> 
> > also had to runtime suspend/resume before lspci -H1 shows the device,
> > loading with runpm=0 didn't return my HDMI audio device.
> 
> Hm ok. Do you have the same laptop as the reporter of that bug?

Nope, I have a Clevo P651RA (GTX965M). That reporter has a Dell XPS 15,
but it also seems present for the Lenovo ThinkPad T420s (see comment on
bug), Asus N56VZ, MSI GT60 2PE, Dell L502x (Launchpad 1377653), Asus
G46vw (Ask Ubuntu user). There is another AU report for a GT 525M
(laptop brand/model unknown).

Maybe there are more affected users, but then they did not notice it
because they did not use HDMI audio.

> >
> > The powered on issue will also only appear on devices produced in 2013
> > and newer that happen to have this ACPI _PR3 ACPI method (which is quite
> > common for new machines supporting Windows 8 though).
> >
> > For these newer laptops, after the pci/pm merge and after a patch like
> > http://www.spinics.net/lists/linux-pci/msg52601.html, the user can
> > revert to the old DSM method by booting with pcie_port_pm=off which will
> > retain the current behavior.
> >
> > The advantage of this patch is that it fixes memory corruption on some
> > devices. The risk is that the card stays on because the audio subsystem
> > needs some more work.  FWIW, I was working on some patches that properly
> > suspended in presence of the HDA controller, but somehow the audio
> > device was not properly resumed resulting in "no AFG or MFG node found"
> > and "snd_hda_intel 0000:01:00.1: no codecs initialized".
> 
> Does this restriction (runpm being broken in presence of the audio
> subfunction) only affect devices with _PR3? If so, that's a lot more
> palatable - I bet Windows 8+ is in an era when the display-less thing
> became more popular, and thus less likely to affect a ton of people.

Yes it only affects those devices with _PR3.
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
