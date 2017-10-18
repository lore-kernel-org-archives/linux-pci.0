Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:60698
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751485AbdJRRJi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Oct 2017 13:09:38 -0400
From: Casey Leedom <leedom@chelsio.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Juan Alvarez <jjalvare@linux.vnet.ibm.com>,
        "Komali Katari" <komali@chelsio.com>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 4.14.0-rc3 is auto-reloading PCIe SR-IOV Virtual Function device
 drivers when VFs are attached to VMs ...
Date: Wed, 18 Oct 2017 17:09:33 +0000
Message-ID: <MWHPR12MB16006DB7914B111AD93FEC10C84D0@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <MWHPR12MB1600C4F1693E88236CA8F78EC84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <20171017133702.1b0e35bc@t450s.home>
 <MWHPR12MB16008EEBF251F321E9B48D41C84C0@MWHPR12MB1600.namprd12.prod.outlook.com>,<CAB=NE6U-1ytEbL9A2FeVjcOfN3VSNAJUa9JbsQH9UfjRfANKxw@mail.gmail.com>
In-Reply-To: <CAB=NE6U-1ytEbL9A2FeVjcOfN3VSNAJUa9JbsQH9UfjRfANKxw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

| From: Luis R. Rodriguez <mcgrof@kernel.org>
| Sent: Tuesday, October 17, 2017 6:14:20 PM
|
| You referred to commit 2355869. What tree and more importantly what patch
| title?

  Ah, my bad.  Sorry, I had the impression that git commit IDs were
preserved across repositories.  That's in Linus' main repository:

  commit 235586939d7fe4833ada9e988f92af543ee6851f
  Author: Luis R. Rodriguez <mcgrof@kernel.org>
  Date:   Fri Sep 8 16:17:00 2017 -0700

    kmod: split out umh code into its own file

    Patch series "kmod: few code cleanups to split out umh code"

    The usermode helper has a provenance from the old usb code which first
    required a usermode helper.  Eventually this was shoved into kmod.c and
    the kernel's modprobe calls was converted over eventually to share the
    same code.  Over time the list of usermode helpers in the kernel has gr=
own
    -- so kmod is just but one user of the API.
    ...

But, that was just a random guess since it was the largest recent change in
this area.  Komali tried to apply a reverse patch to see if that guess
worked out but that didn't apply cleanly and trying to reset to 2355869^ le=
d
to other problems with systemd-udev.service running constantly reloading th=
e
driver with a RHEL7 installation ... which may be a hint about what's going
on ...  I'm going to recommend that Komali do a bisect to see if she can
figure out where this new behavior started ...

Casey
