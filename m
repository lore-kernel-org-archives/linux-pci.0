Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:42604 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753215AbdLMWEW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Dec 2017 17:04:22 -0500
Received: by mail-vk0-f41.google.com with SMTP id 189so2378161vkc.9
        for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2017 14:04:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CANn89iJ1O+a9-ZUhZK94npGwURpWv8u1aHhVsd0-xEad_+_p8w@mail.gmail.com>
References: <MWHPR12MB1600C4F1693E88236CA8F78EC84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <20171017133702.1b0e35bc@t450s.home> <MWHPR12MB16008EEBF251F321E9B48D41C84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <CAB=NE6U-1ytEbL9A2FeVjcOfN3VSNAJUa9JbsQH9UfjRfANKxw@mail.gmail.com>
 <MWHPR12MB16006DB7914B111AD93FEC10C84D0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <CAB=NE6Xwj20hwX3XzW_bYEby+24c=gY_nQtXPOu1J_c7uRHRjA@mail.gmail.com>
 <MWHPR12MB16004ED0D14F6531DDDD1692C84D0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <SN1PR12MB03524AF87997DFAC404CD514C8350@SN1PR12MB0352.namprd12.prod.outlook.com>
 <CAKdAkRRuX-NcWB_fwWr6XHV61t+L2MCjedfZgaiAD-xpVB-mMQ@mail.gmail.com> <CANn89iJ1O+a9-ZUhZK94npGwURpWv8u1aHhVsd0-xEad_+_p8w@mail.gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Wed, 13 Dec 2017 14:04:20 -0800
Message-ID: <CAKdAkRSiVkTo84W7_eDwoLL0UH0jYE7Nbb5D9VEBQS3+UPLXEg@mail.gmail.com>
Subject: Re: 4.14.0-rc3 is auto-reloading PCIe SR-IOV Virtual Function device
 drivers when VFs are attached to VMs ...
To: Eric Dumazet <edumazet@google.com>
Cc: Casey Leedom <leedom@chelsio.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Juan Alvarez <jjalvare@linux.vnet.ibm.com>,
        Komali Katari <komali@chelsio.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 13, 2017 at 1:54 PM, Eric Dumazet <edumazet@google.com> wrote:
> On Wed, Dec 13, 2017 at 1:47 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Wed, Dec 13, 2017 at 1:33 PM, Casey Leedom <leedom@chelsio.com> wrote:
>>> / From: Casey Leedom <leedom@chelsio.com>
>>> | Date: Tuesday, October 17, 2017 11:36 AM
>>> |
>>> |   I hope this is the right Linux list for this issue.  One of our QA staff
>>> | has noticed a new behavior starting about 4.14.0-rc3.  We instantiate PCIe
>>> | SR-IOV Virtual Functions and the corresponding driver (cxgb4vf in this case)
>>> | is automatically loaded.  That's fine and has been the case for some time.
>>> | But, we remove the driver module (rmmod cxgb4vf) and then attach one of the
>>> | VFs to a KVM Virtual Machine and the cxgb4vf driver module gets reloaded in
>>> | the KVM Hypervisor.  This is new behavior.  I see that there was a pretty
>>> | big change done by Luis R. Rodriguez in kernel.org commit revision 2355869
>>> | but we haven't yet isolated the new behavior to that commit.  That'll be our
>>> \ next test but I wanted to get this out there for comment.
>>>
>>> ...
>>>
>>> / From: Casey Leedom <leedom@chelsio.com>
>>> | Date: Wednesday, October 18, 2017 10:09 AM
>>> |
>>> |   Ah, my bad.  Sorry, I had the impression that git commit IDs were
>>> | preserved across repositories.  That's in Linus' main repository:
>>> |
>>> |   commit 235586939d7fe4833ada9e988f92af543ee6851f
>>> |   Author: Luis R. Rodriguez <mcgrof@kernel.org>
>>> |   Date:   Fri Sep 8 16:17:00 2017 -0700
>>> |
>>> |     kmod: split out umh code into its own file
>>> |
>>> |     Patch series "kmod: few code cleanups to split out umh code"
>>> |
>>> |     The usermode helper has a provenance from the old usb code which first
>>> |     required a usermode helper.  Eventually this was shoved into kmod.c and
>>> |     the kernel's modprobe calls was converted over eventually to share the
>>> |     same code.  Over time the list of usermode helpers in the kernel has grown
>>> |     -- so kmod is just but one user of the API.
>>> |     ...
>>> |
>>> | But, that was just a random guess since it was the largest recent change in
>>> | this area.  Komali tried to apply a reverse patch to see if that guess
>>> | worked out but that didn't apply cleanly and trying to reset to 2355869^ led
>>> | to other problems with systemd-udev.service running constantly reloading the
>>> | driver with a RHEL7 installation ... which may be a hint about what's going
>>> | on ...  I'm going to recommend that Komali do a bisect to see if she can
>>> \ figure out where this new behavior started ...
>>>
>>>
>>> / From:  Luis R. Rodriguez <mcgrof@kernel.org>
>>> | Date: Wednesday, October 18, 2017 10:18 AM
>>> |
>>> | I'd recommend to do a full bisect, I *highly* doubt the above commit is the
>>> | issue given it really should not have introduced any functional changes as
>>> | its just a code shuffle, moving code from one file to another. Specially for
>>> | the type of change you are describing, that requires significant changes. So
>>> \ save your time and just focus on a proper bisect.
>>>
>>>
>>> / From: Casey Leedom
>>> | Date: Wednesday, October 18, 2017 10:23 AM
>>> |
>>> \   Okay, I'll have Komali do a full bisct and report back.
>>>
>>>
>>>   Sorry for the incredibly late response to this -- we've all been busy with
>>> release schedules, etc.  I hope it's okay that I included a significant
>>> amount of the previous message context -- I figured that it had been so long
>>> that it would be better to bring everyone back up to speed.
>>>
>>>   In any case, Komali did the bisect and identified the commit which has
>>> resulted in the new behavior which is causing problems:
>>>
>>>   commit 1455cf8dbfd06aa7651dcfccbadb7a093944ca65
>>>   Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>>   Date:   Wed Jul 19 17:24:30 2017 -0700
>>>
>>>     driver core: emit uevents when device is bound to a driver
>>>
>>>     There are certain touch controllers that may come up in either normal
>>>     (application) or boot mode, depending on whether firmware/configuration is
>>>     corrupted when they are powered on. In boot mode the kernel does not create
>>>     input device instance (because it does not necessarily know the
>>>     characteristics of the input device in question).
>>>
>>>     Another number of controllers does not store firmware in a non-volatile
>>>     memory, and they similarly need to have firmware loaded before input device
>>>     instance is created. There are also other types of devices with similar
>>>     behavior.
>>>
>>>     There is a desire to be able to trigger firmware loading via udev, but it
>>>     has to happen only when driver is bound to a physical device (i2c or spi).
>>>     These udev actions can not use ADD events, as those happen too early, so we
>>>     are introducing BIND and UNBIND events that are emitted at the right
>>>     moment.
>>>
>>>     Also, many drivers create additional driver-specific device attributes
>>>     when binding to the device, to provide userspace with additional controls.
>>>     The new events allow userspace to adjust these driver-specific attributes
>>>     without worrying that they are not there yet.
>>>
>>>     Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>
>>> I've Cc'ed both Dmitry and Greg on this message to get their feedback on this.
>>>
>>
>> This should have been fixed with:
>>
>> commit 6878e7de6af726de47f9f3bec649c3f49e786586
>> Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Date:   Wed Sep 13 16:29:48 2017 -0700
>>
>>    driver core: suppress sending MODALIAS in UNBIND uevents
>>
>>    The current udev rules cause modules to be loaded on all device events save
>>    for "remove". With the introduction of KOBJ_BIND/KOBJ_UNBIND this causes
>>    issues, as driver modules that have devices bound to their drivers get
>>    immediately reloaded, and it appears to the user that module unloading doe
>>    snot work.
>>
>>    The standard udev matching rule is foillowing:
>>
>>    ENV{MODALIAS}=="?*", RUN{builtin}+="kmod load $env{MODALIAS}"
>>
>>    Given that MODALIAS data is not terribly useful for UNBIND event, let's zap
>>    it from the generated uevent environment until we get userspace updated
>>    with the correct udev rule that only loads modules on "add" event.
>>
>>    Reported-by: Jakub Kicinski <kubakici@wp.pl>
>>    Tested-by: Jakub Kicinski <kubakici@wp.pl>
>>    Fixes: 1455cf8dbfd0 ("driver core: emit uevents when device is bound ...")
>>    Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> but may have been broken again with:
>>
>> commit 4a336a23d619e96aef37d4d054cfadcdd1b581ba
>> Author: Eric Dumazet <edumazet@google.com>
>> Date:   Tue Sep 19 16:27:04 2017 -0700
>>
>>    kobject: copy env blob in one go
>>
>>    No need to iterate over strings, just copy in one efficient memcpy() call.
>>
>> CCing Eric as well.
>>
>> --
>> Dmitry
>
> I am about to send this fix :

Don't you need to update individual pointers if you are altering the buffer?

-- 
Dmitry
