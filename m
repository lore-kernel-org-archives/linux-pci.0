Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from icebox.esperi.org.uk ([81.187.191.129]:47241 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbbBCUB5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Feb 2015 15:01:57 -0500
From: Nix <nix@esperi.org.uk>
To: Myron Stowe <myron.stowe@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Myron Stowe <mstowe@redhat.com>,
	"linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Myron Stowe <myron.stowe@redhat.com>,
	Bill Unruh <unruh@physics.ubc.ca>, martin@lucina.net,
	Matthew Wilcox <willy@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [3.18.3 BISECTED REGRESSION] scx200_acb / cs5535-smb / geodewdt / cs5535-clockevt torpedoed
References: <8761boas78.fsf@spindle.srvr.nix>
	<1422847799.2491.13.camel@zim.stowe> <87h9v42p22.fsf@spindle.srvr.nix>
	<CAErSpo4SKP=nKdn43rE37JFNW5SSb4uRyRyO6vAO5tqa2TOpQg@mail.gmail.com>
	<CAL-B5D1ytTtQ6JnzWW3VTL2PnM67nj8karxSf5u0e-pmSdZNMg@mail.gmail.com>
Date: Tue, 03 Feb 2015 20:01:35 +0000
In-Reply-To: <CAL-B5D1ytTtQ6JnzWW3VTL2PnM67nj8karxSf5u0e-pmSdZNMg@mail.gmail.com>
	(Myron Stowe's message of "Tue, 3 Feb 2015 10:06:46 -0700")
Message-ID: <87twz2kbmo.fsf@spindle.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3 Feb 2015, Myron Stowe uttered the following:
> As expressed above, I believe this device is non-conformant.  This could be
> validated by instrumenting the kernel's sizing code in '__pci_read_base()';
> specifically the initial 'pci_read_config_dword()'s of 'l' and 'sz'.
> 
> Whereas we have been able to ignore read-only BARs in past occurrances, this
> time they are needed.  As such, I think we can solve this issue by expanding
> the existing quirk for this device.  I'll work that up and post.  If you
> would, please apply and test what is posted and report back.  In the mean
> time, I would be interested in obtaining confirmation as to my belief that
> this device's BARs are read-only (i.e. the instrumentation mentioned).  If
> you have time and are willing I would appreaciate that.  If not, I'm
> confident that is what is occurring and you can just stick with applying and
> testing the expanded quirk patch I intend to post.

Here, and the device behind it, just in case it's useful:

[    1.050352] pci 0000:00:14.0: [1022:2090] type 00 class 0x060100
[    1.060152] name: 0000:00:14.0; l: 6001; sz: 6001
[    1.070037] pci 0000:00:14.0: reg 0x10: [io  0x6000-0x7fff]
[    1.080114] name: 0000:00:14.0; l: 6101; sz: 6101
[    1.090037] pci 0000:00:14.0: reg 0x14: [io  0x6100-0x61ff]
[    1.100113] name: 0000:00:14.0; l: 6201; sz: 6201
[    1.110036] pci 0000:00:14.0: reg 0x18: [io  0x6200-0x63ff]
[    1.120113] name: 0000:00:14.0; l: 0; sz: 0
[    1.130130] name: 0000:00:14.0; l: 0; sz: 0
[    1.140129] name: 0000:00:14.0; l: 0; sz: 0
[    1.150129] name: 0000:00:14.0; l: 0; sz: 0
[    1.160075] pci 0000:00:14.0: CS5536 ISA bridge bug detected (incorrect header); workaround applied
[    1.180018] pci 0000:00:14.2: [1022:209a] type 00 class 0x010180
[    1.190155] name: 0000:00:14.2; l: 0; sz: 0
[    1.200133] name: 0000:00:14.2; l: 0; sz: 0
[    1.210133] name: 0000:00:14.2; l: 0; sz: 0
[    1.220133] name: 0000:00:14.2; l: 0; sz: 0
[    1.230150] name: 0000:00:14.2; l: e001; sz: fffffff1
[    1.240037] pci 0000:00:14.2: reg 0x20: [io  0xe000-0xe00f]
[    1.250115] name: 0000:00:14.2; l: 0; sz: 0
[    1.260133] name: 0000:00:14.2; l: 0; sz: 0
[    1.270091] pci 0000:00:14.2: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    1.280021] pci 0000:00:14.2: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    1.290019] pci 0000:00:14.2: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    1.300018] pci 0000:00:14.2: legacy IDE quirk: reg 0x1c: [io  0x0376]

-- 
NULL && (void)
