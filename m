Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:44278 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbbCFWMf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2015 17:12:35 -0500
MIME-Version: 1.0
In-Reply-To: <20150306184920.GI20077@google.com>
References: <20150224200603.14443.68971.stgit@gimli.home>
	<CADnq5_PDjww+TkPWVV7HLLA50az2n20SfD5ShVp+OpT8Cy4Dew@mail.gmail.com>
	<20150306184920.GI20077@google.com>
Date: Fri, 6 Mar 2015 17:12:34 -0500
Message-ID: <CADnq5_Nvz+GGABYWRzzAJJP01cX0e62y-hdxXO=XRqszuHLj-A@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI: pci_unignore_hotplug()
From: Alex Deucher <alexdeucher@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>,
	"Deucher, Alexander" <alexander.deucher@amd.com>,
	Maling list - DRI developers
	<dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 6, 2015 at 1:49 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Feb 24, 2015 at 03:23:27PM -0500, Alex Deucher wrote:
>> On Tue, Feb 24, 2015 at 3:12 PM, Alex Williamson
>> <alex.williamson@redhat.com> wrote:
>> > I'd kinda like to use pci_ignore_hotplug() for devices in use by a
>> > user via vfio-pci, but the interface seems only partially implemented
>> > since we can only set ignore_hotplug and not clear it.  This adds the
>> > capability to clear the flag and applies it as seems to be appropriate
>> > to the existing users.  I don't have a system with power control for
>> > a radeon or nouveau device, so I'd certainly appreciate testing.  It
>> > seems though that once the device is in D0, we've passed the critical
>> > point where the device could be accidentally unplugged.  Thanks,
>>
>> Something re-broke this recently.  See:
>> https://bugzilla.kernel.org/show_bug.cgi?id=61891
>> https://bugzilla.kernel.org/show_bug.cgi?id=89731
>
> I'm not opposed to adding pci_unignore_hotplug() when we have users for it.
> I don't really want to throw in the nouveau and radeon changes while there
> are open issues in the same area, though.
>
> I haven't looked at the bugzillas above.  Let me know if I should.

Please do.  My comments were not targeted at this patch set, but
rather at the fact that pci hotplug (acpiphp in this case) is again
trying to remove the driver even though it's flagged to ignore hotplug
in the hybrid laptop case.

Alex
