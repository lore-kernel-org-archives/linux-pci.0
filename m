Return-Path: <SRS0=kCOs=YX=redhat.com=pjones@kernel.org>
Return-Path: <SRS0=kCOs=YX=redhat.com=pjones@kernel.org>
Date: Mon, 9 Jan 2017 18:00:10 -0500
From: Peter Jones <pjones@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lukas Wunner <lukas@wunner.de>, David Airlie <airlied@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Wu <peter@lekensteyn.nl>, Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kilian Singer <kilian.singer@quantumtechnology.info>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170109230010.mzcnw6aw3j6lduhw@redhat.com>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <20170104081639.GA21076@wunner.de>
 <20170104210954.GA11946@al>
 <59349185.1aqio7kYFn@aspire.rjw.lan>
 <1456065516.8360056.1483572074197.JavaMail.zimbra@redhat.com>
 <20170105150646.GB21446@wunner.de>
 <2562d75e-a770-3b9d-da3b-57c12896cd11@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <2562d75e-a770-3b9d-da3b-57c12896cd11@redhat.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 07, 2017 at 12:45:35PM +0100, Hans de Goede wrote:

> I've a W541 sitting in my home office at well. I will take it through
> some gpu runtime suspend/resume testing. Which kernel introduces the
> problem I'm looking for ?
> 
> I believe mine has the old BIOS / EFI which is less troublesome so I
> will first see if I can reproduce the problem with that and then upgrade
> to see if that introduces the problem.
> 
> Peter IIRC you said that after upgrading the firmware I need a new enough
> kernel to be able to even boot, from which kernel onwards will the machine
> boot with the new firmware ?

That fix is currently commit b2a91a35 in the "next" branch of the repo
at git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi .  I'm not sure
what the timeframe for it landing in linus' tree is, but it doesn't look
like it has yet.

> Also is it possible to downgrade the EFI again ? ...

IIRC that model has a switch in the firmware to enable downgrading.  I
have not tried it.  Also, there's some chance the firmware you're
starting from isn't available.

-- 
        Peter
