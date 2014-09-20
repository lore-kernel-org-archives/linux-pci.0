Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:48036 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754944AbaITLUA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 20 Sep 2014 07:20:00 -0400
From: andreas.noever@gmail.com
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.or,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	matthew.garrett@nebula.com,
	Andreas Noever <andreas.noever@gmail.com>
Subject: [PATCH v2 0/3] ACPI: Improve behaviour on Apple hardware
Date: Sat, 20 Sep 2014 13:19:44 +0200
Message-Id: <cover.1411211725.git.andreas.noever@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Andreas Noever <andreas.noever@gmail.com>

This is a resend of Matthew's patches from https://lkml.org/lkml/2014/6/1/165
which are needed to fully support Thunderbolt on Apple hardware:
> Apple hardware behaves differently depending on whether or not the OS claims
> to be Darwin. Failing to report Darwin results in some hardware being
> disabled.  However, claiming to be Darwin also alters the behaviour of
> battery reporting and PCI handling. These patches add support for reporting
> Darwin support and fixing up the behavioural quirks that are exposed as a
> result.
Without these patches the firmware will cut power to the controller after
suspend (at the latest) and the thunderbolt driver will fail.

I have reordered them such that the two battery fixes/quirks come before the
_OSI change that breaks battery reporting. I have also merged "ACPI: Don't call
PCI OSC on Apple hardware when claiming to be Darwin" into "ACPI: Support
_OSI("Darwin") correctly" to avoid (temporarily) breaking hotplug events and
modified the patch to not touch ACPICA, as requested by Rafael.

Matthew Garrett (3):
  ACPI: Don't assume the existence of an SBS charger
  ACPI: Disable smart battery manager on Apple
  ACPI: Support _OSI("Darwin") correctly

 drivers/acpi/osl.c      | 10 +++++++
 drivers/acpi/pci_root.c | 14 +++++++++
 drivers/acpi/sbs.c      | 80 +++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 89 insertions(+), 15 deletions(-)

-- 
2.1.0

