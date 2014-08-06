Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:55998 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbaHFOyO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Aug 2014 10:54:14 -0400
From: Gerhard Sittig <gsi@denx.de>
To: linux-pci@vger.kernel.org, Jon Mason <jon.mason@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Detlev Zundel <dzu@denx.de>,
	Gerhard Sittig <gsi@denx.de>
Subject: [PATCH RFC v1 0/4] PCI NTB: prepare for more hardware support
Date: Wed,  6 Aug 2014 16:53:51 +0200
Message-Id: <1407336835-30586-1-git-send-email-gsi@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The current implementation of the PCI non-transparent bridge
support exclusively supports Intel hardware.  This series
prepares for the introduction of other vendor's hardware support,
by separating the generic 'data transport' driver from the
specific 'hardware support' driver.

The current implementation has a circular dependency, where the
data transport uses hardware specific routines for its
communication, while the hardware driver calls into the data
transport layer to have the data link established upon probe.  In
addition, existing documentation suggests that out-of-tree
drivers may use the hardware driver's routines, working in
parallel to the in-tree data transport and the network interface
on top if it.

This series "puts the data transport first", to provide routines
to register hardware drivers with the transport and to have the
transport become available as hardware is found.  While several
hardware drivers may implement the common "hw" API, and one of
those drivers gets probed at runtime and then is used for the
data transport.  The relation of exactly one hardware driver to
one transport instance is kept, as is the NTB driver's API within
the kernel.  No new hardware support gets introduced by this
series.  It's "mere refactoring".


Unfortunately I don't have Intel hardware to exercise runtime
tests for the series.  It has only been compile-tested for
bisectability and with several combinations of the tristate
options, and the series is checkpatch clean including --strict.
Testers who have access to hardware are cordially invited. :)


BTW was I surprised to find the NTB driver under drivers/ntb/,
and not underneath the PCI subsystem.  I hope I got the list of
recipients correct for the series.


Gerhard Sittig (4):
  ntb: split Intel specifics out of the "NTB hardware" interface
  ntb: header file nits (multiple inclusion, explicit entries)
  ntb: prepare to build the 'data transport' as a separate module
  ntb: de-couple data transport from hardware support

 drivers/ntb/Kconfig                          |   45 ++++--
 drivers/ntb/Makefile                         |    5 +-
 drivers/ntb/ntb_hw.h                         |  101 +++++++------
 drivers/ntb/{ntb_hw.c => ntb_hw_intel.c}     |   83 +++++++----
 drivers/ntb/ntb_hw_intel.h                   |   73 ++++++++++
 drivers/ntb/{ntb_regs.h => ntb_regs_intel.h} |    0
 drivers/ntb/ntb_transport.c                  |  196 ++++++++++++++++++++++++++
 include/linux/ntb.h                          |    7 +
 8 files changed, 426 insertions(+), 84 deletions(-)
 rename drivers/ntb/{ntb_hw.c => ntb_hw_intel.c} (94%)
 create mode 100644 drivers/ntb/ntb_hw_intel.h
 rename drivers/ntb/{ntb_regs.h => ntb_regs_intel.h} (100%)

-- 
1.7.10.4

