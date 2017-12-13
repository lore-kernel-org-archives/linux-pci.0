Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:32801 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753463AbdLMVzC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Dec 2017 16:55:02 -0500
Received: by mail-wr0-f169.google.com with SMTP id v22so3459592wrb.0
        for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2017 13:55:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKdAkRRuX-NcWB_fwWr6XHV61t+L2MCjedfZgaiAD-xpVB-mMQ@mail.gmail.com>
References: <MWHPR12MB1600C4F1693E88236CA8F78EC84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <20171017133702.1b0e35bc@t450s.home> <MWHPR12MB16008EEBF251F321E9B48D41C84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <CAB=NE6U-1ytEbL9A2FeVjcOfN3VSNAJUa9JbsQH9UfjRfANKxw@mail.gmail.com>
 <MWHPR12MB16006DB7914B111AD93FEC10C84D0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <CAB=NE6Xwj20hwX3XzW_bYEby+24c=gY_nQtXPOu1J_c7uRHRjA@mail.gmail.com>
 <MWHPR12MB16004ED0D14F6531DDDD1692C84D0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <SN1PR12MB03524AF87997DFAC404CD514C8350@SN1PR12MB0352.namprd12.prod.outlook.com>
 <CAKdAkRRuX-NcWB_fwWr6XHV61t+L2MCjedfZgaiAD-xpVB-mMQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Dec 2017 13:54:58 -0800
Message-ID: <CANn89iJ1O+a9-ZUhZK94npGwURpWv8u1aHhVsd0-xEad_+_p8w@mail.gmail.com>
Subject: Re: 4.14.0-rc3 is auto-reloading PCIe SR-IOV Virtual Function device
 drivers when VFs are attached to VMs ...
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Casey Leedom <leedom@chelsio.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Juan Alvarez <jjalvare@linux.vnet.ibm.com>,
        Komali Katari <komali@chelsio.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: multipart/mixed; boundary="f403045f4f3aa9209f05603fd133"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--f403045f4f3aa9209f05603fd133
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 13, 2017 at 1:47 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Dec 13, 2017 at 1:33 PM, Casey Leedom <leedom@chelsio.com> wrote:
>> / From: Casey Leedom <leedom@chelsio.com>
>> | Date: Tuesday, October 17, 2017 11:36 AM
>> |
>> |   I hope this is the right Linux list for this issue.  One of our QA staff
>> | has noticed a new behavior starting about 4.14.0-rc3.  We instantiate PCIe
>> | SR-IOV Virtual Functions and the corresponding driver (cxgb4vf in this case)
>> | is automatically loaded.  That's fine and has been the case for some time.
>> | But, we remove the driver module (rmmod cxgb4vf) and then attach one of the
>> | VFs to a KVM Virtual Machine and the cxgb4vf driver module gets reloaded in
>> | the KVM Hypervisor.  This is new behavior.  I see that there was a pretty
>> | big change done by Luis R. Rodriguez in kernel.org commit revision 2355869
>> | but we haven't yet isolated the new behavior to that commit.  That'll be our
>> \ next test but I wanted to get this out there for comment.
>>
>> ...
>>
>> / From: Casey Leedom <leedom@chelsio.com>
>> | Date: Wednesday, October 18, 2017 10:09 AM
>> |
>> |   Ah, my bad.  Sorry, I had the impression that git commit IDs were
>> | preserved across repositories.  That's in Linus' main repository:
>> |
>> |   commit 235586939d7fe4833ada9e988f92af543ee6851f
>> |   Author: Luis R. Rodriguez <mcgrof@kernel.org>
>> |   Date:   Fri Sep 8 16:17:00 2017 -0700
>> |
>> |     kmod: split out umh code into its own file
>> |
>> |     Patch series "kmod: few code cleanups to split out umh code"
>> |
>> |     The usermode helper has a provenance from the old usb code which first
>> |     required a usermode helper.  Eventually this was shoved into kmod.c and
>> |     the kernel's modprobe calls was converted over eventually to share the
>> |     same code.  Over time the list of usermode helpers in the kernel has grown
>> |     -- so kmod is just but one user of the API.
>> |     ...
>> |
>> | But, that was just a random guess since it was the largest recent change in
>> | this area.  Komali tried to apply a reverse patch to see if that guess
>> | worked out but that didn't apply cleanly and trying to reset to 2355869^ led
>> | to other problems with systemd-udev.service running constantly reloading the
>> | driver with a RHEL7 installation ... which may be a hint about what's going
>> | on ...  I'm going to recommend that Komali do a bisect to see if she can
>> \ figure out where this new behavior started ...
>>
>>
>> / From:  Luis R. Rodriguez <mcgrof@kernel.org>
>> | Date: Wednesday, October 18, 2017 10:18 AM
>> |
>> | I'd recommend to do a full bisect, I *highly* doubt the above commit is the
>> | issue given it really should not have introduced any functional changes as
>> | its just a code shuffle, moving code from one file to another. Specially for
>> | the type of change you are describing, that requires significant changes. So
>> \ save your time and just focus on a proper bisect.
>>
>>
>> / From: Casey Leedom
>> | Date: Wednesday, October 18, 2017 10:23 AM
>> |
>> \   Okay, I'll have Komali do a full bisct and report back.
>>
>>
>>   Sorry for the incredibly late response to this -- we've all been busy with
>> release schedules, etc.  I hope it's okay that I included a significant
>> amount of the previous message context -- I figured that it had been so long
>> that it would be better to bring everyone back up to speed.
>>
>>   In any case, Komali did the bisect and identified the commit which has
>> resulted in the new behavior which is causing problems:
>>
>>   commit 1455cf8dbfd06aa7651dcfccbadb7a093944ca65
>>   Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>   Date:   Wed Jul 19 17:24:30 2017 -0700
>>
>>     driver core: emit uevents when device is bound to a driver
>>
>>     There are certain touch controllers that may come up in either normal
>>     (application) or boot mode, depending on whether firmware/configuration is
>>     corrupted when they are powered on. In boot mode the kernel does not create
>>     input device instance (because it does not necessarily know the
>>     characteristics of the input device in question).
>>
>>     Another number of controllers does not store firmware in a non-volatile
>>     memory, and they similarly need to have firmware loaded before input device
>>     instance is created. There are also other types of devices with similar
>>     behavior.
>>
>>     There is a desire to be able to trigger firmware loading via udev, but it
>>     has to happen only when driver is bound to a physical device (i2c or spi).
>>     These udev actions can not use ADD events, as those happen too early, so we
>>     are introducing BIND and UNBIND events that are emitted at the right
>>     moment.
>>
>>     Also, many drivers create additional driver-specific device attributes
>>     when binding to the device, to provide userspace with additional controls.
>>     The new events allow userspace to adjust these driver-specific attributes
>>     without worrying that they are not there yet.
>>
>>     Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> I've Cc'ed both Dmitry and Greg on this message to get their feedback on this.
>>
>
> This should have been fixed with:
>
> commit 6878e7de6af726de47f9f3bec649c3f49e786586
> Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Date:   Wed Sep 13 16:29:48 2017 -0700
>
>    driver core: suppress sending MODALIAS in UNBIND uevents
>
>    The current udev rules cause modules to be loaded on all device events save
>    for "remove". With the introduction of KOBJ_BIND/KOBJ_UNBIND this causes
>    issues, as driver modules that have devices bound to their drivers get
>    immediately reloaded, and it appears to the user that module unloading doe
>    snot work.
>
>    The standard udev matching rule is foillowing:
>
>    ENV{MODALIAS}=="?*", RUN{builtin}+="kmod load $env{MODALIAS}"
>
>    Given that MODALIAS data is not terribly useful for UNBIND event, let's zap
>    it from the generated uevent environment until we get userspace updated
>    with the correct udev rule that only loads modules on "add" event.
>
>    Reported-by: Jakub Kicinski <kubakici@wp.pl>
>    Tested-by: Jakub Kicinski <kubakici@wp.pl>
>    Fixes: 1455cf8dbfd0 ("driver core: emit uevents when device is bound ...")
>    Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> but may have been broken again with:
>
> commit 4a336a23d619e96aef37d4d054cfadcdd1b581ba
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Tue Sep 19 16:27:04 2017 -0700
>
>    kobject: copy env blob in one go
>
>    No need to iterate over strings, just copy in one efficient memcpy() call.
>
> CCing Eric as well.
>
> --
> Dmitry

I am about to send this fix :

--f403045f4f3aa9209f05603fd133
Content-Type: text/plain; charset="US-ASCII"; name="patch_zap_modalias_env.txt"
Content-Disposition: attachment; filename="patch_zap_modalias_env.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jb5lfo6o0

ZGlmZiAtLWdpdCBhL2xpYi9rb2JqZWN0X3VldmVudC5jIGIvbGliL2tvYmplY3RfdWV2ZW50LmMK
aW5kZXggYzNlODRlZGM0N2M5NjVkNDAxOTliNjUyYmE3ODg3NmNkYWE5YzcwYy4uMDc5NTQ4MmIx
NWQ1YThmMWI2NWI1NzBhMDcxYWExNDE5Y2I5MjNkOCAxMDA2NDQKLS0tIGEvbGliL2tvYmplY3Rf
dWV2ZW50LmMKKysrIGIvbGliL2tvYmplY3RfdWV2ZW50LmMKQEAgLTM0NiwxOSArMzQ2LDI1IEBA
IHN0YXRpYyBpbnQga29iamVjdF91ZXZlbnRfbmV0X2Jyb2FkY2FzdChzdHJ1Y3Qga29iamVjdCAq
a29iaiwKIHN0YXRpYyB2b2lkIHphcF9tb2RhbGlhc19lbnYoc3RydWN0IGtvYmpfdWV2ZW50X2Vu
diAqZW52KQogewogCXN0YXRpYyBjb25zdCBjaGFyIG1vZGFsaWFzX3ByZWZpeFtdID0gIk1PREFM
SUFTPSI7CisJc2l6ZV90IG9mZnNldCA9IDAsIGxlbjsKIAlpbnQgaTsKIAogCWZvciAoaSA9IDA7
IGkgPCBlbnYtPmVudnBfaWR4OykgeworCQlsZW4gPSBzdHJsZW4oZW52LT5lbnZwW2ldKSArIDE7
CiAJCWlmIChzdHJuY21wKGVudi0+ZW52cFtpXSwgbW9kYWxpYXNfcHJlZml4LAogCQkJICAgIHNp
emVvZihtb2RhbGlhc19wcmVmaXgpIC0gMSkpIHsKIAkJCWkrKzsKKwkJCW9mZnNldCArPSBsZW47
CiAJCQljb250aW51ZTsKIAkJfQogCi0JCWlmIChpICE9IGVudi0+ZW52cF9pZHggLSAxKQorCQll
bnYtPmJ1ZmxlbiAtPSBsZW47CisJCWlmIChpICE9IGVudi0+ZW52cF9pZHggLSAxKSB7CisJCQlt
ZW1tb3ZlKGVudi0+ZW52cFtpXSwgZW52LT5lbnZwW2kgKyAxXSwKKwkJCQllbnYtPmJ1ZmxlbiAt
IG9mZnNldCk7CiAJCQltZW1tb3ZlKCZlbnYtPmVudnBbaV0sICZlbnYtPmVudnBbaSArIDFdLAog
CQkJCXNpemVvZihlbnYtPmVudnBbaV0pICogZW52LT5lbnZwX2lkeCAtIDEpOwotCisJCX0KIAkJ
ZW52LT5lbnZwX2lkeC0tOwogCX0KIH0K
--f403045f4f3aa9209f05603fd133--
