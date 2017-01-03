Return-Path: <SRS0=hWXb=YR=quantumtechnology.info=kilian.singer@kernel.org>
Return-Path: <SRS0=hWXb=YR=quantumtechnology.info=kilian.singer@kernel.org>
Date: Tue, 3 Jan 2017 18:10:17 +0100 (CET)
From: Kilian Singer <kilian.singer@quantumtechnology.info>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-ID: <833636486.15.1483463417701.JavaMail.zimbra@quantumtechnology.info>
In-Reply-To: <20170102121019.GA3353@lahna.fi.intel.com>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com> <472708904.419.1483028422817.JavaMail.zimbra@quantumtechnology.info> <20161229175028.GA18510@wunner.de> <52715138.511.1483053634089.JavaMail.zimbra@quantumtechnology.info> <20161230000731.GB18700@wunner.de> <1180505121.522.1483056977880.JavaMail.zimbra@quantumtechnology.info> <20170102114040.GA20127@wunner.de> <20170102121019.GA3353@lahna.fi.intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

This makes the bash where executed locked but system stays responsive.
Lockscreen still leads to system becoming unresponsive.

----- Original Message -----
From: "Mika Westerberg" <mika.westerberg@linux.intel.com>
To: "Lukas Wunner" <lukas@wunner.de>
Cc: "Kilian Singer" <kilian.singer@quantumtechnology.info>, "Bjorn Helgaas" <helgaas@kernel.org>, "linux-pci" <linux-pci@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Sent: Monday, January 2, 2017 1:10:19 PM
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"

On Mon, Jan 02, 2017 at 12:40:40PM +0100, Lukas Wunner wrote:
> On Fri, Dec 30, 2016 at 01:16:17AM +0100, Kilian Singer wrote:
> > I did the debug message on the 4.10-rc1 for now. I could go back to 4.9
> > if that helps but needs some time again to compile.
> > The debug messages from the first rpm_... to the crash are:
> [...]
> > [   24.831417] nouveau 0000:01:00.0: rpm_suspend
> > [   24.831427] nouveau 0000:01:00.0: DRM: suspending console...
> > [   24.831432] nouveau 0000:01:00.0: DRM: suspending display...
> > [   24.831477] nouveau 0000:01:00.0: DRM: evicting buffers...
> > [   24.865243] nouveau 0000:01:00.0: DRM: waiting for kernel channels to go idle...
> > [   24.865269] nouveau 0000:01:00.0: DRM: suspending client object trees...
> > [   24.870724] nouveau 0000:01:00.0: DRM: suspending kernel object tree...
> > [   26.080300] thinkpad_acpi: EC reports that Thermal Table has changed
> > [   26.207691] pcieport 0000:00:01.0: rpm_idle
> > [   26.207693] pcieport 0000:00:01.0: rpm_suspend
> > [   28.927640] snd_hda_codec_hdmi hdaudioC0D0: rpm_suspend
> > SYSTEM IS NOW NOT RESPONSIVE
> 
> So two seconds before the system became unresponsive, the root port above
> the discrete GPU suspended, suggesting that's the culprit.  Could you test
> either of the attached patches to confirm this theory?  They disable
> runtime PM on this specific root port but allow it on all the others.
> 
> You've got an Optimus laptop, i.e. power to the discrete GPU can be cut.
> Traditionally this is achieved by invoking an ACPI _DSM (Device Specific
> Method).  That's what we did up until v4.7.
> 
> However on newer laptops Windows no longer cuts power to the discrete GPU
> by invoking the _DSM, but rather by suspending the root port above the
> GPU.  (More specifically by turning off Power Resources required for D3
> of the root port, those are specified in a _PR3 object.)  We started
> supporting this with v4.8.
> 
> If the above theory is correct, we need to involve Optimus experts
> because this is not an issue then with powering down root ports in
> general, but rather specific to this Optimus use case.

[Back from vacation now]

I've checked the acpidump of this machine and it does not seem to be a
traditional Optimus machine. At least this one is missing the magic _DSM
which is used to gather capabilities of the graphics device.

However, it does have _PR3 and it is attached to the device
(_SB.PCI0.PEG) itself, not the root port.

One thing you could try in addition to Lucas' patches is just to prevent
D3cold from the device by doing this:

  # echo 0 > /sys/bus/pci/devices/0000:01:00.0/d3cold_allowed
