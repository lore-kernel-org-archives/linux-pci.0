Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:44609 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932965Ab2DLQHe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Apr 2012 12:07:34 -0400
Received: by dake40 with SMTP id e40so2683820dak.11
        for <linux-pci@vger.kernel.org>; Thu, 12 Apr 2012 09:07:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1334229754.30606.7.camel@Nokia-N900>
References: <1333968563.5678.19.camel@infinity>
	<CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com>
	<4F84110E.3000400@snewbury.org.uk>
	<CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com>
	<4F8467AA.90305@snewbury.org.uk>
	<CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com>
	<4F848357.3060007@snewbury.org.uk>
	<CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com>
	<4F848E10.1090703@snewbury.org.uk>
	<CAE9FiQXvwYrJhLi91VDVtD4+OOfbGQ1U20-Cap+8tBZUt7QCkA@mail.gmail.com>
	<1334089568.4083.2.camel@Nokia-N900>
	<CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com>
	<4F84A3EC.6030903@snewbury.org.uk>
	<CAE9FiQU+EEtBWrc66Sw4GFQjSy9Vh9fyFvhgQUheev_aVpAzrw@mail.gmail.com>
	<1334229754.30606.7.camel@Nokia-N900>
Date: Thu, 12 Apr 2012 09:07:33 -0700
Message-ID: <CAE9FiQXhzAOErMeQxz6U-BSYAK1LirHMpiFH90iRoXxwduPhPw@mail.gmail.com>
Subject: Re: PCI resources above 4GB
From: Yinghai Lu <yinghai@kernel.org>
To: Steven Newbury <steve@snewbury.org.uk>
Cc: "Barnes, Jesse" <jesse.barnes@intel.com>,
	Dave Airlie <airlied@linux.ie>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 12, 2012 at 4:22 AM, Steven Newbury <steve@snewbury.org.uk> wrote:
> Thanks, that fixed it! :) I had a similar patch I've been working on but I had my fix in the wrong place!
>
> In the working case, initially the BIOS has set GMA to within the low system DRAM 0xC0000000 obviously invalid.  This conflict is detected and it's relallocated to 0x12000000.
>
> I've attempted to modify probe.c to disable 64-bit BARs not allocated above 4G so they get reallocated above when possible later.  It seemed to work, but again broke GMA despite the BAR originally containing an invalid address as mentioned above, it seems for some reason something is different when the conflict is detected and rellocated, compared to disabling it early then allocating a valid value..?
>
> It would be useful to preserve as much low PCI memory address space as possible for hotplug devices (like my Radeon), but the other problem is small regions get allocated at the bottom, resulting in the inability to find large aligned regions later on.  I see code to default to top-down allocation was reverted, I guess I'm going to have to dig into the archive to find out why...

for hotplug case, You can work around like:
after hotplug add,
1. use lspci and /proc/iomem to find out offending device and bridge.
2. use /sys/.../unbind etc to stop driver for those devices.
3. use setpci to clear related BAR
4. use /sys/devices/pci000..../remove to remove those devices
5. echo 1 > /sys/bus/pci/rescan

then it should work...

Yinghai
