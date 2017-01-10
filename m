Return-Path: <SRS0=pVbd=YY=redhat.com=airlied@kernel.org>
Return-Path: <SRS0=pVbd=YY=redhat.com=airlied@kernel.org>
Date: Mon, 9 Jan 2017 19:17:17 -0500 (EST)
From: David Airlie <airlied@redhat.com>
To: Peter Jones <pjones@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Wu <peter@lekensteyn.nl>, Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kilian Singer <kilian.singer@quantumtechnology.info>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Message-ID: <1041052319.9522810.1484007437052.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170109230010.mzcnw6aw3j6lduhw@redhat.com>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com> <20170104081639.GA21076@wunner.de> <20170104210954.GA11946@al> <59349185.1aqio7kYFn@aspire.rjw.lan> <1456065516.8360056.1483572074197.JavaMail.zimbra@redhat.com> <20170105150646.GB21446@wunner.de> <2562d75e-a770-3b9d-da3b-57c12896cd11@redhat.com> <20170109230010.mzcnw6aw3j6lduhw@redhat.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

> 
> On Sat, Jan 07, 2017 at 12:45:35PM +0100, Hans de Goede wrote:
> 
> > I've a W541 sitting in my home office at well. I will take it through
> > some gpu runtime suspend/resume testing. Which kernel introduces the
> > problem I'm looking for ?
> > 
> > I believe mine has the old BIOS / EFI which is less troublesome so I
> > will first see if I can reproduce the problem with that and then upgrade
> > to see if that introduces the problem.
> > 
> > Peter IIRC you said that after upgrading the firmware I need a new enough
> > kernel to be able to even boot, from which kernel onwards will the machine
> > boot with the new firmware ?
> 
> That fix is currently commit b2a91a35 in the "next" branch of the repo
> at git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi .  I'm not sure
> what the timeframe for it landing in linus' tree is, but it doesn't look
> like it has yet.
> 
> > Also is it possible to downgrade the EFI again ? ...
> 
> IIRC that model has a switch in the firmware to enable downgrading.  I
> have not tried it.  Also, there's some chance the firmware you're
> starting from isn't available.
> 
> --
>         Peter
> 

just FYI, but W541 with Fedora 25 and Linux 4.10-rc3 + drm-next and the efi
fix (you might want to motivate that fix a bit harder), seems to be working
well.

I can suspend/resume, and the nvidia seems to go off.

[  411.799035] nouveau 0000:01:00.0: DRM: suspending console...
[  411.799059] nouveau 0000:01:00.0: DRM: suspending display...
[  411.799119] nouveau 0000:01:00.0: DRM: evicting buffers...
[  411.799125] nouveau 0000:01:00.0: DRM: waiting for kernel channels to go idle...
[  411.799176] nouveau 0000:01:00.0: DRM: suspending client object trees...
[  411.805616] nouveau 0000:01:00.0: DRM: suspending kernel object tree...
[  413.217090] device_pm-0235 device_set_power      : Device [VID1] transitioned to D3hot
[  413.217099] device_pm-0124 device_get_power      : Device [VID1] power state is (unknown)
[  413.230201] thinkpad_acpi: EC reports that Thermal Table has changed
[  413.351497]     power-0275 __acpi_power_off      : Power resource [NVP3] turned off
[  413.351507] device_pm-0235 device_set_power      : Device [PEG] transitioned to D3hot
[  413.351526]     power-0189 power_get_state       : Resource [NVP3] is off
[  413.351530]     power-0219 power_get_list_state  : Resource list is off
[  413.351542]     power-0189 power_get_state       : Resource [NVP2] is on
[  413.351545]     power-0219 power_get_list_state  : Resource list is on
[  413.351548] device_pm-0124 device_get_power      : Device [PEG] power state is D2

That is with some acpi debugging enabled (though I'm not quite sure why D2 is where it ends up).

Dave.
