Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 29 Oct 2014 19:22:58 -0500
From: Jeff Epler <jepler@unpythonic.net>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: incompatible pci sysfs change since 3.12 (5136b2da770d)
Message-ID: <20141030002258.GA59253@unpythonic.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi.

I am an author of LinuxCNC, a GPL'd CNC control for Linux.

Recently we added support for userspace PCI drivers.  This worked with
kernel 3.2 but doesn't with kernel 3.16.  The software fails early with
    Failed to open "/sys/devices/pci0000:00/.../enable" (Permission denied)

This appears to be because our software relies on the documented
"enable" sysfs file for pci devices (Documentation/filesystem/sysfs-pci.txt)
which was (unintentionally?) changed to "enabled" in the above-named
patch:

5136b2da770d PCI: convert bus code to use dev_groups
...
+static DEVICE_ATTR_RW(enabled);
...
-   __ATTR(enable, 0600, is_enabled_show, is_enabled_store),

Are we in the LinuxCNC project wrong in thinking that stuff in /sys (and
not /sys/debug) is supposed to be a durable API/interface for userspace
to the kernel?  (It must be a low-usage API if it went unnoticed for a
year :-/)

We'll have to work around it by modifying our software (since we'd like
to work with the kernels people already have) in any case.

Even if it is not going to be changed compatibly with older kernels, it
seems like the documentation should be updated!

Jeff
