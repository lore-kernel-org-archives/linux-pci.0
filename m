Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:60269 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbbBXUX1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Feb 2015 15:23:27 -0500
MIME-Version: 1.0
In-Reply-To: <20150224200603.14443.68971.stgit@gimli.home>
References: <20150224200603.14443.68971.stgit@gimli.home>
Date: Tue, 24 Feb 2015 15:23:27 -0500
Message-ID: <CADnq5_PDjww+TkPWVV7HLLA50az2n20SfD5ShVp+OpT8Cy4Dew@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI: pci_unignore_hotplug()
From: Alex Deucher <alexdeucher@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>,
	"Deucher, Alexander" <alexander.deucher@amd.com>,
	Maling list - DRI developers
	<dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 24, 2015 at 3:12 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> I'd kinda like to use pci_ignore_hotplug() for devices in use by a
> user via vfio-pci, but the interface seems only partially implemented
> since we can only set ignore_hotplug and not clear it.  This adds the
> capability to clear the flag and applies it as seems to be appropriate
> to the existing users.  I don't have a system with power control for
> a radeon or nouveau device, so I'd certainly appreciate testing.  It
> seems though that once the device is in D0, we've passed the critical
> point where the device could be accidentally unplugged.  Thanks,

Something re-broke this recently.  See:
https://bugzilla.kernel.org/show_bug.cgi?id=61891
https://bugzilla.kernel.org/show_bug.cgi?id=89731

Alex

>
> Alex
>
> ---
>
> Alex Williamson (2):
>       pci: Add reciprocal function for pci_ignore_hotplug()
>       nouveau/radeon: Un-ignore hotplug on resume
>
>
>  drivers/gpu/drm/nouveau/nouveau_drm.c |    1 +
>  drivers/gpu/drm/radeon/radeon_drv.c   |    1 +
>  include/linux/pci.h                   |    5 +++++
>  3 files changed, 7 insertions(+)
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
