Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29594 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbcF2Ih0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 29 Jun 2016 04:37:26 -0400
From: Amir Levy <amir.jer.levy@intel.com>
To: andreas.noever@gmail.com, gregkh@linuxfoundation.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, thunderbolt-linux@intel.com,
	mika.westerberg@intel.com, tomas.winkler@intel.com,
	Amir Levy <amir.jer.levy@intel.com>
Subject: [PATCH v2 0/8] thunderbolt: Introducing Thunderbolt(TM) networking
Date: Wed, 29 Jun 2016 11:35:28 +0300
Message-Id: <1467189336-29556-1-git-send-email-amir.jer.levy@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is version 2 of Thunderbolt(TM) driver for non-Apple hardware.

Changes since v1:
 - Separation to 2 modules.
 - Moved ICM specific registers definition to ICM header file.
 - Added new Thunderbolt device IDs.
 - Renamed the Thunderbolt networking documentation.
 - General cleanups

These patches were pushed to GitHub where they can be reviewed more
comfortably with green/red highlighting:
	https://github.com/01org/thunderbolt-software-kernel-tree

Daemon code:
	https://github.com/01org/thunderbolt-software-daemon

For reference, here's a link to version 1:
[v1]:	http://www.spinics.net/lists/linux-pci/msg51287.html

Amir Levy (8):
  thunderbolt: Macro rename
  thunderbolt: Updating device IDs
  thunderbolt: Updating the register definitions
  thunderbolt: Kconfig for Thunderbolt(TM) networking
  thunderbolt: Communication with the ICM (firmware)
  thunderbolt: Networking state machine
  thunderbolt: Networking transmit and receive
  thunderbolt: Networking doc

 Documentation/00-INDEX                   |    2 +
 Documentation/thunderbolt-networking.txt |  135 ++
 drivers/thunderbolt/Kconfig              |   25 +-
 drivers/thunderbolt/Makefile             |    4 +-
 drivers/thunderbolt/icm_nhi.c            | 1631 +++++++++++++++++++++
 drivers/thunderbolt/icm_nhi.h            |   84 ++
 drivers/thunderbolt/net.c                | 2277 ++++++++++++++++++++++++++++++
 drivers/thunderbolt/net.h                |  274 ++++
 drivers/thunderbolt/nhi_regs.h           |  115 +-
 include/linux/pci_ids.h                  |   44 +-
 10 files changed, 4565 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/thunderbolt-networking.txt
 create mode 100644 drivers/thunderbolt/icm_nhi.c
 create mode 100644 drivers/thunderbolt/icm_nhi.h
 create mode 100644 drivers/thunderbolt/net.c
 create mode 100644 drivers/thunderbolt/net.h

-- 
2.7.4

