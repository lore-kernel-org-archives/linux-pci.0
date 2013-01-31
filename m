Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:52944 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533Ab3AaOXS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2013 09:23:18 -0500
Date: Thu, 31 Jan 2013 14:23:03 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, thierry.reding@avionic-design.de,
	thomas.petazzoni@free-electrons.com, rjw@sisk.pl,
	jbarnes@virtuousgeek.org
Subject: PME and dependency on ACPI
Message-ID: <20130131142303.GA29628@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I think that PME may place an unnecessary dependency on ACPI...

in drivers/pci/pcie/Kconfig:

config PCIE_PME
	def_bool y
	depends on PCIEPORTBUS && PM_RUNTIME && ACPI


and drivers/pci/pcie/pme.c:

#include <linux/acpi.h>
#include <linux/pci-acpi.h>

On an ARM platform I can remove the #include's and remove the Kconfig
dependency on ACPI and PME springs into life. 

Is there any other reason why ACPI may be needed here?

Andrew Murray

