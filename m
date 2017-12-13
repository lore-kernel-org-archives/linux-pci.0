Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0126.outbound.protection.outlook.com ([104.47.34.126]:34134
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753744AbdLMVde (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Dec 2017 16:33:34 -0500
From: Casey Leedom <leedom@chelsio.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Juan Alvarez <jjalvare@linux.vnet.ibm.com>,
        "Komali Katari" <komali@chelsio.com>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: 4.14.0-rc3 is auto-reloading PCIe SR-IOV Virtual Function device
 drivers when VFs are attached to VMs ...
Date: Wed, 13 Dec 2017 21:33:28 +0000
Message-ID: <SN1PR12MB03524AF87997DFAC404CD514C8350@SN1PR12MB0352.namprd12.prod.outlook.com>
References: <MWHPR12MB1600C4F1693E88236CA8F78EC84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <20171017133702.1b0e35bc@t450s.home>
 <MWHPR12MB16008EEBF251F321E9B48D41C84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <CAB=NE6U-1ytEbL9A2FeVjcOfN3VSNAJUa9JbsQH9UfjRfANKxw@mail.gmail.com>
 <MWHPR12MB16006DB7914B111AD93FEC10C84D0@MWHPR12MB1600.namprd12.prod.outlook.com>,<CAB=NE6Xwj20hwX3XzW_bYEby+24c=gY_nQtXPOu1J_c7uRHRjA@mail.gmail.com>,<MWHPR12MB16004ED0D14F6531DDDD1692C84D0@MWHPR12MB1600.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR12MB16004ED0D14F6531DDDD1692C84D0@MWHPR12MB1600.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

/ From: Casey Leedom <leedom@chelsio.com>
| Date: Tuesday, October 17, 2017 11:36 AM
|=20
|   I hope this is the right Linux list for this issue.  One of our QA staf=
f
| has noticed a new behavior starting about 4.14.0-rc3.  We instantiate PCI=
e
| SR-IOV Virtual Functions and the corresponding driver (cxgb4vf in this ca=
se)
| is automatically loaded.  That's fine and has been the case for some time=
.
| But, we remove the driver module (rmmod cxgb4vf) and then attach one of t=
he
| VFs to a KVM Virtual Machine and the cxgb4vf driver module gets reloaded =
in
| the KVM Hypervisor.  This is new behavior.  I see that there was a pretty
| big change done by Luis R. Rodriguez in kernel.org commit revision 235586=
9
| but we haven't yet isolated the new behavior to that commit.  That'll be =
our
\ next test but I wanted to get this out there for comment.

...

/ From: Casey Leedom <leedom@chelsio.com>
| Date: Wednesday, October 18, 2017 10:09 AM
|=20
|   Ah, my bad.  Sorry, I had the impression that git commit IDs were
| preserved across repositories.  That's in Linus' main repository:
|=20
|   commit 235586939d7fe4833ada9e988f92af543ee6851f
|   Author: Luis R. Rodriguez <mcgrof@kernel.org>
|   Date:   Fri Sep 8 16:17:00 2017 -0700
|=20
|     kmod: split out umh code into its own file
|=20
|     Patch series "kmod: few code cleanups to split out umh code"
|=20
|     The usermode helper has a provenance from the old usb code which firs=
t
|     required a usermode helper.  Eventually this was shoved into kmod.c a=
nd
|     the kernel's modprobe calls was converted over eventually to share th=
e
|     same code.  Over time the list of usermode helpers in the kernel has =
grown
|     -- so kmod is just but one user of the API.
|     ...
|=20
| But, that was just a random guess since it was the largest recent change =
in
| this area.  Komali tried to apply a reverse patch to see if that guess
| worked out but that didn't apply cleanly and trying to reset to 2355869^ =
led
| to other problems with systemd-udev.service running constantly reloading =
the
| driver with a RHEL7 installation ... which may be a hint about what's goi=
ng
| on ...  I'm going to recommend that Komali do a bisect to see if she can
\ figure out where this new behavior started ...


/ From:  Luis R. Rodriguez <mcgrof@kernel.org>
| Date: Wednesday, October 18, 2017 10:18 AM
|=20
| I'd recommend to do a full bisect, I *highly* doubt the above commit is t=
he
| issue given it really should not have introduced any functional changes a=
s
| its just a code shuffle, moving code from one file to another. Specially =
for
| the type of change you are describing, that requires significant changes.=
 So
\ save your time and just focus on a proper bisect.


/ From: Casey Leedom
| Date: Wednesday, October 18, 2017 10:23 AM
|=20
\   Okay, I'll have Komali do a full bisct and report back.


  Sorry for the incredibly late response to this -- we've all been busy wit=
h
release schedules, etc.  I hope it's okay that I included a significant
amount of the previous message context -- I figured that it had been so lon=
g
that it would be better to bring everyone back up to speed.

  In any case, Komali did the bisect and identified the commit which has
resulted in the new behavior which is causing problems:

  commit 1455cf8dbfd06aa7651dcfccbadb7a093944ca65
  Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
  Date:   Wed Jul 19 17:24:30 2017 -0700

    driver core: emit uevents when device is bound to a driver

    There are certain touch controllers that may come up in either normal
    (application) or boot mode, depending on whether firmware/configuration=
 is
    corrupted when they are powered on. In boot mode the kernel does not cr=
eate
    input device instance (because it does not necessarily know the
    characteristics of the input device in question).

    Another number of controllers does not store firmware in a non-volatile
    memory, and they similarly need to have firmware loaded before input de=
vice
    instance is created. There are also other types of devices with similar
    behavior.

    There is a desire to be able to trigger firmware loading via udev, but =
it
    has to happen only when driver is bound to a physical device (i2c or sp=
i).
    These udev actions can not use ADD events, as those happen too early, s=
o we
    are introducing BIND and UNBIND events that are emitted at the right
    moment.

    Also, many drivers create additional driver-specific device attributes
    when binding to the device, to provide userspace with additional contro=
ls.
    The new events allow userspace to adjust these driver-specific attribut=
es
    without worrying that they are not there yet.

    Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I've Cc'ed both Dmitry and Greg on this message to get their feedback on th=
is.

Casey
