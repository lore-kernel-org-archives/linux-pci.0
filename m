Return-Path: <SRS0=Mfjj=JM=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=Mfjj=JM=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180625232633.GB191076@bhelgaas-glaptop.roam.corp.google.com>
References: <bug-199879-41252@https.bugzilla.kernel.org/> <CAErSpo5U9D5kmYix2SbcJH_mW8urpmZcgN6Zh=FbGtLch+ACuA@mail.gmail.com>
 <20180620211349.GB108993@bhelgaas-glaptop.roam.corp.google.com> <20180625232633.GB191076@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Jun 2018 10:23:24 +0200
Message-ID: <CAJZ5v0gCu93rj1kLdNkYKMo+yKmf3ot33St=x4_TVxhM42yH6Q@mail.gmail.com>
Subject: Re: Fwd: [Bug 199879] New: Very basic the Pci device is not resumed
 from suspend mode
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rafal <uzg@wp.pl>, Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Huang Ying <ying.huang@intel.com>, Martin Mares <mj@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 26, 2018 at 1:26 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc Rafael, Huang, Martin]
>
> On Wed, Jun 20, 2018 at 04:13:49PM -0500, Bjorn Helgaas wrote:
>> [+to Rafal]
>>
>> Sorry, I'm an idiot and forgot to include Rafal, the submitter, when I
>> forwarded this report to the mailing lists.
>>
>> I suspect that the config accessors used by lspci should temporarily
>> wake up devices that are asleep, instead of reporting 0xff data (or if
>> that's not feasible, maybe we should add a comment in the kernel and a
>> note in the lspci man page).
>
> The lspci output you attached
> (https://bugzilla.kernel.org/attachment.cgi?id=276771) shows this:
>
>   01:00.0 3D controller: NVIDIA Corporation GK107M [GeForce GT 745M] (rev ff) (prog-if ff)
>         !!! Unknown header type 7f
>
> I think that means the config reads are returning ~0 data (0xff),
> probably because the device is powered off and the config reads don't
> work.
>
> But I don't understand that because both proc_bus_pci_read() (for
> reads vis /proc) and pci_read_config() (for reads via /sys) call
> pci_config_pm_runtime_get(), and I thought that would wake up the
> device so we could read config space.

That's correct, it should.

> Is it the intended behavior that lspci will show this sort of invalid
> data sometimes?

I don't really think so.

>  It's pretty confusing to users.  Or is there
> something wrong with the pci_config_pm_runtime_get() path in those
> config accessors?

It looks like in this particular case the device does not resume or we
don't wait for long enough for it to resume.

Or the write returns all ones for a different reason.

>> On Wed, May 30, 2018 at 07:41:35AM -0700, Bjorn Helgaas wrote:
>> > [+cc linux-pci, linux-kernel, linux-pm]
>> >
>> > I'm not sure I understand the problem yet, so please correct me if I'm wrong:
>> >
>> >   - Your system has both Nvidia and Intel graphics devices
>> >
>> >   - When you use Intel graphics, lspci, lshw, and /proc/bus/pci for
>> > the Nvidia device show invalid data (0xff) after suspend/resume
>> >
>> >   - When you use Nvidia graphics, suspend/resume doesn't work (instead
>> > of resuming, you just get a blank screen)
>> >
>> > Can you attach the output of "sudo lspci -vv" to the bugzilla, please?
>> >
>> > ---------- Forwarded message ---------
>> > From: <bugzilla-daemon@bugzilla.kernel.org>
>> > Date: Tue, May 29, 2018 at 1:29 PM
>> > Subject: [Bug 199879] New: Very basic the Pci device is not resumed
>> > from suspend mode
>> > To: <bhelgaas@google.com>
>> >
>> >
>> > https://bugzilla.kernel.org/show_bug.cgi?id=199879
>> >
>> >             Bug ID: 199879
>> >            Summary: Very basic the Pci device is not resumed from suspend
>> >                     mode
>> >            Product: Drivers
>> >            Version: 2.5
>> >     Kernel Version: kernel-4.15.17
>> >           Hardware: x86-64
>> >                 OS: Linux
>> >               Tree: Mainline
>> >             Status: NEW
>> >           Severity: high
>> >           Priority: P1
>> >          Component: PCI
>> >           Assignee: drivers_pci@kernel-bugs.osdl.org
>> >           Reporter: uzg@wp.pl
>> >         Regression: No
>> >
>> > Hi, I have problem with very basic device. Device pci-e not resume from
>> > suspend. Only sleep.
>> >
>> > I have a problem with anyone interested in it, because everyone thinks it is
>> > the fault of the device drivers themselves. But this is not a problem.
>> >
>> > This device is a basic device. I've already installed drivers on various
>> > hardware and it has always been ok, but not this time.
>> >
>> > I'm an electronics technician. After diagnosing what I managed, in my opinion
>> > the device remains asleep.
>> >
>> > Where does my application come from?
>> > I have multiuser mode and I do not use this device. After suspend lspci and
>> > lshw show normal data. Normal data is in /proc/bus/pci/...
>> > Next suspend and resume, and...
>> > lspci see hardware, but is error
>> > lshw see hardware as undefined device
>> > data in /proc/bus/pci/... is only 0xFF
>> > Hardware sleep, not work, not ready. This is bug.
>> >
>> > But since the problem concerns the graphics card in the configuration with the
>> > second default Intel card, everyone thinks that this is another driver problem
>> > as always and nobody wants to take a look at it :(
>> >
>> > The problem is easy to recognize. On the internet, I've seen a lot of
>> > unresolved problems in which I could see exactly what I found.
>> >
>> > My hardware is Lenovo with NVidia and Intel Graphics. Problem is with NVidia. I
>> > tested Z710 and Z50-70. The first symptom of the problem is lspci in multiuser
>> > mode (or when is XServer with intel graphics). After suspend NVidia have e.g
>> > "rev. A1", after resume is "rev. FF". Next symptom lshw and /proc/bus/pci/...
>> > When system started with normal NVidia driver, system not resume and halt, only
>> > black screen.
>> >
>> > There are many examples on the Internet with unsolved problems e.g
>> > https://www.lwks.com/index.php?option=com_kunena&func=view&catid=21&id=124374&Itemid=81
>> >
>> > --
>> > You are receiving this mail because:
>> > You are watching the assignee of the bug.
