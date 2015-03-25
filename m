Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34959 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815AbbCYGcQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Mar 2015 02:32:16 -0400
Message-ID: <55125611.8040507@intel.com>
Date: Wed, 25 Mar 2015 14:30:41 +0800
From: Aaron Lu <aaron.lu@intel.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: [PATCH v3 0/3] PCI / ACPI: PCI delay optimization from ACPI
References: <54FD4FB9.2060802@intel.com>
In-Reply-To: <54FD4FB9.2060802@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here is v3, changes from v2 are:
- Patch 1/3: add Rafael's acked-by tag;
- Patch 2/3: newly introduced, to rename find_pci_host_bridge and export it
- Patch 3/3: address Bjorn's comments for v2

Thanks a lot for your suggestions and review!

Regards,
Aaron
