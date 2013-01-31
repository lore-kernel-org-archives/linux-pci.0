Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:37024 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264Ab3AaUwv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Jan 2013 15:52:51 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Murray <andrew.murray@arm.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	thierry.reding@avionic-design.de,
	thomas.petazzoni@free-electrons.com, jbarnes@virtuousgeek.org
Subject: Re: PME and dependency on ACPI
Date: Thu, 31 Jan 2013 21:59:02 +0100
Message-ID: <1640358.IasfHydsYU@vostro.rjw.lan>
In-Reply-To: <20130131142303.GA29628@arm.com>
References: <20130131142303.GA29628@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, January 31, 2013 02:23:03 PM Andrew Murray wrote:
> I think that PME may place an unnecessary dependency on ACPI...
> 
> in drivers/pci/pcie/Kconfig:
> 
> config PCIE_PME
> 	def_bool y
> 	depends on PCIEPORTBUS && PM_RUNTIME && ACPI
> 
> 
> and drivers/pci/pcie/pme.c:
> 
> #include <linux/acpi.h>
> #include <linux/pci-acpi.h>
> 
> On an ARM platform I can remove the #include's and remove the Kconfig
> dependency on ACPI and PME springs into life. 
> 
> Is there any other reason why ACPI may be needed here?

On x86 (PC) we need ACPI to determine whether or not we're allowed to use the
PME interrupt.  In turn, without that iterrupt PME is rather useless.

That said I don't think we need to make the PME *code* depend on ACPI, so it
should be OK to remove the dependency from Kconfig.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
