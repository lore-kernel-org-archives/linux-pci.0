Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35954 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933209AbcKHL1x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2016 06:27:53 -0500
MIME-Version: 1.0
In-Reply-To: <CADnq5_N5_fyJKDpbaew_1t9jNP3+jja+0dAf0WJVOOQ_pOoJXw@mail.gmail.com>
References: <20161101154232.6451-1-emil.l.velikov@gmail.com> <CADnq5_N5_fyJKDpbaew_1t9jNP3+jja+0dAf0WJVOOQ_pOoJXw@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 8 Nov 2016 11:27:37 +0000
Message-ID: <CACvgo53XDqtE9weWHP4zQmhtxNVieNm1G92YbWmgFF-HYnqArQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: create revision file in sysfs
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Dropping Jammy since his email bounces]

On 1 November 2016 at 15:47, Alex Deucher <alexdeucher@gmail.com> wrote:
> On Tue, Nov 1, 2016 at 11:42 AM, Emil Velikov <emil.l.velikov@gmail.com> =
wrote:
>> From: Emil Velikov <emil.velikov@collabora.com>
>>
>> Currently the revision isn't available via sysfs/libudev thus if one
>> wants to know the value they need to read through the config file.
>>
>> This in itself wakes/powers up the device, causing unwanted delay
>> since it can be quite costly.
>>
>> Expose the revision as a separate file, just like we do for the device,
>> vendor, their subsystem version and class.
>>
>> Cc: Jammy Zhou <Jammy.Zhou@amd.com>
>> Cc: Michel D=C3=A4nzer <michel.daenzer@amd.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
Thanks Alex.

Gents, to elaborate a bit:

When using the Mesa drivers alongside firefox [1] (since Mesa 13.0),
glxinfo (Mesa 10.0) and others, all the GPUs* will be awaken, causing
unwanted delays and increased power usage.
>From the userspace POV we have two distinct users who require the
revision file - libdrm and libpciaccess. * The latter would even wake
up _all_ the devices located on a PCI bus !

Let me know if you'd like the above in the patch summary, meanwhile
I'll poke and collect a few more ack/r-b/t-b.

Thanks
Emil

[1] https://bugs.freedesktop.org/show_bug.cgi?id=3D98502
