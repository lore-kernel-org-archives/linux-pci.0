Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42171 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932890AbeCCAUc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Mar 2018 19:20:32 -0500
MIME-Version: 1.0
In-Reply-To: <20180302165919.423cd45b@t450s.home>
References: <20180302234218.3337.16486.stgit@localhost.localdomain>
 <20180302234412.3337.71321.stgit@localhost.localdomain> <20180302165919.423cd45b@t450s.home>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 2 Mar 2018 16:20:30 -0800
Message-ID: <CAKgT0UcXf+w6P2=EbbZKzOxfK5vAf2tgtnTeLh9mRaysKJStwQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] pci-iov: Add support for unmanaged SR-IOV
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        kvm@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maximilian Heyne <mheyne@amazon.de>,
        "Wang, Liang-min" <liang-min.wang@intel.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        David Woodhouse <dwmw2@infradead.org>, dwmw@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 2, 2018 at 3:59 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Fri, 02 Mar 2018 15:44:25 -0800
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>
>> From: Alexander Duyck <alexander.h.duyck@intel.com>
>>
>> This patch is meant to add some basic functionality to support for SR-IOV
>> on devices when the VFs are not managed by the kernel. The functions
>> provided here can be used by drivers such as vfio-pci and virtio to enable
>> SR-IOV on devices that are either managed by userspace, or by some sort of
>> firmware entity respectively.
>>
>> A new sysfs value called sriov_unmanaged_autoprobe has been added. This
>> value is used as the drivers_autoprobe setting of the VFs when they are
>> being managed by an external entity such as userspace or device firmware
>> instead of being managed by the kernel.
>>
>> One side effect of this change is that the sriov_drivers_autoprobe and
>> sriov_unmanaged_autoprobe will only apply their updates when SR-IOV is
>> disabled. Attempts to update them when SR-IOV is in use will only update
>> the local value and will not update sriov->autoprobe.
>>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-pci |   17 ++++++++++++++
>>  drivers/pci/iov.c                       |   37 +++++++++++++++++++++++++++++++
>>  drivers/pci/pci-driver.c                |    2 +-
>>  drivers/pci/pci-sysfs.c                 |   29 ++++++++++++++++++++++++
>>  drivers/pci/pci.h                       |    4 +++
>>  include/linux/pci.h                     |    1 +
>>  6 files changed, 88 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
>> index 44d4b2be92fd..ff0b6c19cb1a 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-pci
>> +++ b/Documentation/ABI/testing/sysfs-bus-pci
>> @@ -323,3 +323,20 @@ Description:
>>
>>               This is similar to /sys/bus/pci/drivers_autoprobe, but
>>               affects only the VFs associated with a specific PF.
>> +
>> +What:                /sys/bus/pci/devices/.../sriov_unmanaged_autoprobe
>> +Date:                March 2018
>> +Contact:     Alexander Duyck <alexander.h.duyck@intel.com>
>> +Description:
>> +             This file is associated with the PF of a device that
>> +             supports SR-IOV.  It determines whether newly-enabled VFs
>> +             are immediately bound to a driver when the PF driver does
>> +             not manage the VFs itself.  It initially contains 0, which
>> +             means the kernel will not automatically bind VFs to a driver.
>> +             If an application writes 1 to the file before enabling VFs,
>> +             the kernel will bind VFs to a compatible driver immediately
>> +             after they are enabled.
>> +
>> +             This overrides /sys/bus/pci/devices/.../sriov_drivers_autoprobe
>> +             when a PF driver is not present to manage a device, or the PF
>> +             driver does not provide functionality to support SR-IOV.
>
>
> Given a pf, how does a user determine whether it is managed or unmanaged
> and therefore which autoprobe attributes are in effect?  Thanks,
>
> Alex

Basically it comes down to what driver is loaded on it. For now
vfio-pci and virtio would be the only two using the "unmanaged"
version of things.

Really you don't know which autoprobe is in effect until SR-IOV is
enabled by whatever driver. As such you should really be setting both
the drivers_autoprobe and the unmanaged_autoprobe based on the
expected use case.

- Alex
