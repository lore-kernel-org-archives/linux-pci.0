Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:60428 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbcD2XCY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2016 19:02:24 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: catalin.marinas@arm.com, linux-pci@vger.kernel.org,
	will.deacon@arm.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>, ddaney@caviumnetworks.com,
	robert.richter@caviumnetworks.com, msalter@redhat.com,
	Liviu.Dudau@arm.com, jchandra@broadcom.com,
	linux-kernel@vger.kernel.org, hanjun.guo@linaro.org,
	Suravee.Suthikulpanit@amd.com,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [RFC] experimental pci_register_host API
Date: Sat, 30 Apr 2016 01:01:36 +0200
Message-Id: <1461970899-4150603-1-git-send-email-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As mentioned in another thread, I have tried to come up with
a way to make the PCI host driver registration more flexible
and simpler.

We have actually discussed this multiple times in the past,
but always ended up elsewhere, so this is a proof of concept
work, leaving all the existing interfaces in place, and
adding a way to allocate a pci_host_bridge structure from
a driver and register that after filling out all the interesting
fields.

This is not tested at all, and certainly not meant for
inclusion until the concept has been discussed better.

Please have a look.

        Arnd

[PATCH 1/3] [RFC] pci: add new method for register PCI hosts
[PATCH 2/3] [RFC] pci: host-common: use new pci_register_host
[PATCH 3/3] [RFC] pci: tegra: use new pci_register_host interface

