Return-Path: <SRS0=uaRa=YY=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=uaRa=YY=wunner.de=lukas@kernel.org>
Date: Tue, 10 Jan 2017 02:24:03 +0100
From: Lukas Wunner <lukas@wunner.de>
To: David Airlie <airlied@redhat.com>
Cc: Peter Jones <pjones@redhat.com>, Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Peter Wu <peter@lekensteyn.nl>, Bjorn Helgaas <helgaas@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Kilian Singer <kilian.singer@quantumtechnology.info>,
	linux-pci <linux-pci@vger.kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170110012403.GA23513@wunner.de>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <20170104081639.GA21076@wunner.de>
 <20170104210954.GA11946@al>
 <59349185.1aqio7kYFn@aspire.rjw.lan>
 <1456065516.8360056.1483572074197.JavaMail.zimbra@redhat.com>
 <20170105150646.GB21446@wunner.de>
 <2562d75e-a770-3b9d-da3b-57c12896cd11@redhat.com>
 <20170109230010.mzcnw6aw3j6lduhw@redhat.com>
 <1041052319.9522810.1484007437052.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1041052319.9522810.1484007437052.JavaMail.zimbra@redhat.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 09, 2017 at 07:17:17PM -0500, David Airlie wrote:
> just FYI, but W541 with Fedora 25 and Linux 4.10-rc3 + drm-next and the efi
> fix (you might want to motivate that fix a bit harder), seems to be working
> well.

The efi fix is on the efi.git next branch without stable designation,
i.e. slated for 4.11 not 4.10, and Matt Fleming usually sends his pull
to Ingo between rc4 and rc5.


> I can suspend/resume, and the nvidia seems to go off.
> 
> [  411.799035] nouveau 0000:01:00.0: DRM: suspending console...
> [  411.799059] nouveau 0000:01:00.0: DRM: suspending display...
> [  411.799119] nouveau 0000:01:00.0: DRM: evicting buffers...
> [  411.799125] nouveau 0000:01:00.0: DRM: waiting for kernel channels to go idle...
> [  411.799176] nouveau 0000:01:00.0: DRM: suspending client object trees...
> [  411.805616] nouveau 0000:01:00.0: DRM: suspending kernel object tree...
> [  413.217090] device_pm-0235 device_set_power      : Device [VID1] transitioned to D3hot
> [  413.217099] device_pm-0124 device_get_power      : Device [VID1] power state is (unknown)
> [  413.230201] thinkpad_acpi: EC reports that Thermal Table has changed
> [  413.351497]     power-0275 __acpi_power_off      : Power resource [NVP3] turned off
> [  413.351507] device_pm-0235 device_set_power      : Device [PEG] transitioned to D3hot
> [  413.351526]     power-0189 power_get_state       : Resource [NVP3] is off
> [  413.351530]     power-0219 power_get_list_state  : Resource list is off
> [  413.351542]     power-0189 power_get_state       : Resource [NVP2] is on
> [  413.351545]     power-0219 power_get_list_state  : Resource list is on
> [  413.351548] device_pm-0124 device_get_power      : Device [PEG] power state is D2
> 
> That is with some acpi debugging enabled (though I'm not quite sure why D2 is where it ends up).

The ACPI D2 state seems fishy indeed, could you post the log for a
runtime resume as well?  It would be interesting to see how it gets
out of this incorrect power state.  Also, what is the firmware version
that you're using?  If it's not GNET80WW (2.28), could you attach an
acpidump to the bugzilla entry?

https://bugzilla.kernel.org/show_bug.cgi?id=190861

Thanks,

Lukas
