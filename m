Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19681 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948AbcEWIxk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 May 2016 04:53:40 -0400
From: Amir Levy <amir.jer.levy@intel.com>
To: andreas.noever@gmail.com, gregkh@linuxfoundation.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, amir.jer.levy@intel.com,
	michael.jamet@intel.com, dan.alloun@intel.com,
	mika.westerberg@intel.com, kai.svahn@intel.com,
	andriy.shevchenko@intel.com, tomas.winkler@intel.com
Subject: [PATCH 0/6] thunderbolt: Introducing Thunderbolt(TM) networking
Date: Mon, 23 May 2016 11:48:50 +0300
Message-Id: <1463993336-2750-1-git-send-email-amir.jer.levy@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thunderbolt(TM) generation 3 provides USB, charging, Display Port and
Thunderbolt connectivity over a single physical port.

Thunderbolt(TM) networking, introduced in these patches, provides the
capability of connecting hosts together by emulating an Ethernet adapter.
It provides the same networking benefits with the advantage of the fast
Thunderbolt medium capabilities.
Thunderbolt(TM) networking is capable of operating in the last position
in the Thunderbolt(TM) device daisy chain.

It is also compatible with Thunderbolt(TM) Networking in OS X and Windows
implementations, and supports both Thunderbolt(TM) generation 2 and 3.

The kernel code operates in coordination with the Thunderbolt(TM)
user-space daemon. Together, they implement full Thunderbolt(TM) networking
functionality.
This implementation runs on ICM (firmware) based 
Thunderbolt(TM) controllers.

Note that the Thunderbolt(TM) Hardware specs have not been published yet and
were partially used for register definitions.

Information
===========
Mailing list:
	thunderbolt-software@lists.01.org
	Register at: https://lists.01.org/mailman/listinfo/thunderbolt-software
	Archives at: https://lists.01.org/pipermail/thunderbolt-software/

For additional information about Thunderbolt technology visit:
	https://01.org/thunderbolt-sw
	https://thunderbolttechnology.net/

Daemon code:
	https://github.com/01org/thunderbolt-software

Amir Levy, Michael Jamet (6):
  thunderbolt: Updating the register definitions
  thunderbolt: Communication with the ICM (firmware)
  thunderbolt: Networking state machine
  thunderbolt: Networking transmit and receive
  thunderbolt: Kconfig for Thunderbolt(TM) networking
  thunderbolt: Networking doc

 Documentation/00-INDEX         |    2 +
 Documentation/thunderbolt.txt  |  135 +++
 drivers/thunderbolt/Kconfig    |    9 +-
 drivers/thunderbolt/Makefile   |    3 +-
 drivers/thunderbolt/icm_nhi.c  | 1540 +++++++++++++++++++++++++++
 drivers/thunderbolt/icm_nhi.h  |   53 +
 drivers/thunderbolt/net.c      | 2273 ++++++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/net.h      |  276 +++++
 drivers/thunderbolt/nhi.c      |  195 ++--
 drivers/thunderbolt/nhi_regs.h |  164 ++-
 drivers/thunderbolt/tb.h       |   14 +-
 include/linux/pci_ids.h        |    2 +
 12 files changed, 4580 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/thunderbolt.txt
 create mode 100644 drivers/thunderbolt/icm_nhi.c
 create mode 100644 drivers/thunderbolt/icm_nhi.h
 create mode 100644 drivers/thunderbolt/net.c
 create mode 100644 drivers/thunderbolt/net.h
-- 
1.9.1

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

