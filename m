Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750926AbdJRRSr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Oct 2017 13:18:47 -0400
Received: from mail-io0-f175.google.com (mail-io0-f175.google.com [209.85.223.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C24F121913
        for <linux-pci@vger.kernel.org>; Wed, 18 Oct 2017 17:18:46 +0000 (UTC)
Received: by mail-io0-f175.google.com with SMTP id m16so7050103iod.1
        for <linux-pci@vger.kernel.org>; Wed, 18 Oct 2017 10:18:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <MWHPR12MB16006DB7914B111AD93FEC10C84D0@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <MWHPR12MB1600C4F1693E88236CA8F78EC84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <20171017133702.1b0e35bc@t450s.home> <MWHPR12MB16008EEBF251F321E9B48D41C84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <CAB=NE6U-1ytEbL9A2FeVjcOfN3VSNAJUa9JbsQH9UfjRfANKxw@mail.gmail.com> <MWHPR12MB16006DB7914B111AD93FEC10C84D0@MWHPR12MB1600.namprd12.prod.outlook.com>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Wed, 18 Oct 2017 10:18:25 -0700
Message-ID: <CAB=NE6Xwj20hwX3XzW_bYEby+24c=gY_nQtXPOu1J_c7uRHRjA@mail.gmail.com>
Subject: Re: 4.14.0-rc3 is auto-reloading PCIe SR-IOV Virtual Function device
 drivers when VFs are attached to VMs ...
To: Casey Leedom <leedom@chelsio.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Juan Alvarez <jjalvare@linux.vnet.ibm.com>,
        Komali Katari <komali@chelsio.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 18, 2017 at 10:09 AM, Casey Leedom <leedom@chelsio.com> wrote:
> | From: Luis R. Rodriguez <mcgrof@kernel.org>
> | Sent: Tuesday, October 17, 2017 6:14:20 PM
> |
> | You referred to commit 2355869. What tree and more importantly what patch
> | title?
>
>   Ah, my bad.  Sorry, I had the impression that git commit IDs were
> preserved across repositories.  That's in Linus' main repository:
>
>   commit 235586939d7fe4833ada9e988f92af543ee6851f
>   Author: Luis R. Rodriguez <mcgrof@kernel.org>
>   Date:   Fri Sep 8 16:17:00 2017 -0700
>
>     kmod: split out umh code into its own file
>
>     Patch series "kmod: few code cleanups to split out umh code"
>
>     The usermode helper has a provenance from the old usb code which first
>     required a usermode helper.  Eventually this was shoved into kmod.c and
>     the kernel's modprobe calls was converted over eventually to share the
>     same code.  Over time the list of usermode helpers in the kernel has grown
>     -- so kmod is just but one user of the API.
>     ...
>
> But, that was just a random guess since it was the largest recent change in
> this area.  Komali tried to apply a reverse patch to see if that guess
> worked out but that didn't apply cleanly and trying to reset to 2355869^ led
> to other problems with systemd-udev.service running constantly reloading the
> driver with a RHEL7 installation ... which may be a hint about what's going
> on ...  I'm going to recommend that Komali do a bisect to see if she can
> figure out where this new behavior started ...

I'd recommend to do a full bisect, I *highly* doubt the above commit
is the issue given it really should not have introduced any functional
changes as its just a code shuffle, moving code from one file to
another. Specially for the type of change you are describing, that
requires significant changes. So save your time and just focus on a
proper bisect.

  Luis
