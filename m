Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751199AbdL2APY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Dec 2017 19:15:24 -0500
Date: Thu, 28 Dec 2017 18:15:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexandru Chirvasitu <achirvasub@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        Mihai Costache <v-micos@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org, KY Srinivasan <kys@microsoft.com>
Subject: Re: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
Message-ID: <20171229001519.GD19819@bhelgaas-glaptop.roam.corp.google.com>
References: <alpine.DEB.2.20.1712281706010.1899@nanos>
 <20171228172250.GD10658@chirva-slack.chirva-slack>
 <alpine.DEB.2.20.1712281823140.1899@nanos>
 <20171228175009.ucxr4to2nb42e3s4@D-69-91-141-110.dhcp4.washington.edu>
 <alpine.DEB.2.20.1712281930590.1899@nanos>
 <alpine.DEB.2.20.1712282253180.1899@nanos>
 <20171228225014.GE10658@chirva-slack.chirva-slack>
 <alpine.DEB.2.20.1712282357380.1899@nanos>
 <alpine.DEB.2.20.1712290018210.1899@nanos>
 <20171228233058.c76a4upqbx6elmvg@D-69-91-141-110.dhcp4.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171228233058.c76a4upqbx6elmvg@D-69-91-141-110.dhcp4.washington.edu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 28, 2017 at 06:30:58PM -0500, Alexandru Chirvasitu wrote:
> Attached, but heads up on this: when redirecting the output of lspci
> -vvv to a text file as root I get
> 
> pcilib: sysfs_read_vpd: read failed: Input/output error
> 
> I can find bugs filed for various distros to this same effect, but
> haven't tracked down any explanations.

This is a tangent, but I think you should *always* see "Input/output
error" on this system when running "lspci -vvv" as root, regardless of
whether you redirect the output (the error probably goes to stderr,
not stdout, so it's probably easy to miss when not redirecting the
output).

I think this is the -EIO return from pci_vpd_read(), which probably
means pci_vpd_size() returned 0 for one of your devices, which means
the VPD data provided by the device wasn't formatted correctly.  If
this happens, you should see a warning in dmesg about it ("invalid VPD
tag" or similar) -- could you verify that?

It's possible we should return something other than -EIO, or maybe
pcilib should do something other than emitting the warning.  In
pcilib, sysfs_read_vpd() emits the warning [1], and it would seem sort
of ugly to special-case EIO, so maybe we should change this in the
kernel.

It looks like your Qualcomm Atheros Attansic NIC at 06:00.0 is the
only device with VPD, so that's probably the one:

  06:00.0 Ethernet controller: Qualcomm Atheros Attansic L2 Fast Ethernet
    Capabilities: [6c] Vital Product Data
      Not readable

I think lspci would still print "Not readable" if we just made the
kernel return 0 instead of -EIO [2].

Bjorn

[1] https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/lib/sysfs.c#n410
[2] https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/ls-vpd.c#n87
