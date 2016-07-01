Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35948 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbcGAVQu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2016 17:16:50 -0400
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 1 Jul 2016 23:16:48 +0200
Message-ID: <CAJZ5v0jhCkM8azgxisb-wf08-ecsqqKFh6TRNP5-tKHn2jao5A@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v4.7-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.7-rc6

to receive an ACPI fix for v4.7-rc6 as commit
54794580f5949253520265e46c903878ab222d84

 ACPI,PCI,IRQ: correct operator precedence

on top of commit 4c2e07c6a29e0129e975727b9f57eede813eea85

 Linux 4.7-rc5

Fix an expression in the PCI ACPI IRQ management code added by a
recent commit that overlooked missing parens in it, so the result
of the computation is incorrect in some cases (Sinan Kaya).

Thanks!

---------------

Sinan Kaya (1):
      ACPI,PCI,IRQ: correct operator precedence

---------------

 drivers/acpi/pci_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
