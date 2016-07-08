Return-Path: <hdegoede@redhat.com>
Return-Path: <hdegoede@redhat.com>
Subject: Re: [Nouveau] [PATCH v2 0/4] nouveau RPM fixes for Optimus
To: Peter Wu <peter@lekensteyn.nl>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
References: <20160707233827.2100-1-peter@lekensteyn.nl>
Cc: Dave Airlie <airlied@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <05318f07-8ec3-43f2-0a5f-4be87837e744@redhat.com>
Date: Fri, 8 Jul 2016 19:31:24 +0200
MIME-Version: 1.0
In-Reply-To: <20160707233827.2100-1-peter@lekensteyn.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 08-07-16 01:38, Peter Wu wrote:
> Hi,
>
> Here are two patches to fix an issue reported on kernel bugzilla (infinite loop
> due to unchecked function) and a more important fix to fix hanging Optimus
> machines when runtime PM is enabled (with pm/pci patches).
>
> See the first version[1] for a background on the fixed problems. This is the
> second revision of incorporating feedback from Emil Velikov (patch 1), Mika
> Westerberg (patch 4). Patches 2 and 3 are unchanged.
> The previous patchset had R-b from Hans de Goede, I think they are still valid.
>
> Noteworthy is that the fourth patch now checks directly for _PR3. The commit
> message is updated to emphasize that memory/disk corruption is fixed for some
> machines.
>
>
> This patchset can be merged before or after the pci/pm changes[2] (expected to
> be merged for 4.8), see the original posting[1] for consequences. I have tested
> it on top of v4.7-rc5. To make patch four work properly, Lukas' RPM refcounting
> patches should be included. A similar (open/new) RPM refcounting issue in
> snd-hda-intel should also be fixed. Otherwise the bridge will not really sleep.
>
> There is another minor patch for nouveau_pr3_present, but it is not included
> here because it depends on visibility of pci_bridge_d3_possible(). I'll send a
> separate mail for this to linux-pci.

Patches 1 - 3 are:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Patch 4 looks good to me too, but I'm not familiar enough with the
pci-e pm stuff to feel comfortable acking it.

Regards,

Hans



>
> Kind regards,
> Peter
>
>  [1]: https://lists.freedesktop.org/archives/nouveau/2016-May/025116.html
>  [2]: https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/?h=pci/pm
>
> Peter Wu (4):
>   drm/nouveau/acpi: ensure matching ACPI handle and supported functions
>   drm/nouveau/acpi: return supported DSM functions
>   drm/nouveau/acpi: check for function 0x1B before using it
>   drm/nouveau/acpi: fix lockup with PCIe runtime PM
>
>  drivers/gpu/drm/nouveau/nouveau_acpi.c | 103 +++++++++++++++++++++------------
>  1 file changed, 66 insertions(+), 37 deletions(-)
>
