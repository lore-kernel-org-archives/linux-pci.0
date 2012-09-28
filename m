Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:50836 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423141Ab2I1Vuf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 28 Sep 2012 17:50:35 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linux PM list <linux-pm@vger.kernel.org>
Subject: [RFD][PATCH 0/7] PM / QoS: Support for PM QoS device flags
Date: Fri, 28 Sep 2012 23:51:10 +0200
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Huang Ying <ying.huang@intel.com>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Lan Tianyu <tianyu.lan@intel.com>,
	Aaron Lu <aaron.lu@intel.com>, Jean Pihet <j-pihet@ti.com>,
	linux-pci@vger.kernel.org,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	mark gross <markgross@thegnar.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201209282351.10663.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

The following patch series extends the existing device PM QoS core code to
support PM QoS flags representing binary (on/off) requirements, such as
whether or not power may be removed entirely from the device or whether
or not remote wakeup (i.e. signalling of external events while suspended)
should work for it.

[1/7] Prepare PM QoS device structure for adding more constraint types.
[2/7] Introduce request and constraint data types for PM QoS flags.
[3/7] Prepare struct dev_pm_qos_request for representing more request types. 
[4/7] Introduce device PM QoS flags support.
[5/7] Make it possible to expose PM QoS device flags to user space.
[6/7] PM / Domains: Check device PM QoS flags in pm_genpd_poweroff().
[7/7] PM / ACPI: Take device PM QoS flags into account.

The last two patches make the generic PM domains framework and ACPI / PCI,
respectively, take the PM QoS device flags introduced by patch [5/7] into
accont when making their decisions.

The changelogs describe the details, but if anything isn't clear, please let
me know.

Thanks,
Rafael

