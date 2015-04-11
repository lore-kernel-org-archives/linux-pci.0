Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:49160 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbbDKOu7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 11 Apr 2015 10:50:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Feng Kan <fkan@apm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Duc Dang <dhdang@apm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Tanmay Inamdar <tinamdar@apm.com>, Loc Ho <lho@apm.com>
Subject: Re: [PATCH v3 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX termination driver
Date: Sat, 11 Apr 2015 16:50:47 +0200
Message-ID: <8653876.C24YDfhd04@wuerfel>
In-Reply-To: <CAL85gmDmycodMV2WJydmA7u60S+K2w3Ji=BSVPfAg04N6unX0g@mail.gmail.com>
References: <20150408084448.5f0793b7@why.wild-wind.fr.eu.org> <55280665.9020603@arm.com> <CAL85gmDmycodMV2WJydmA7u60S+K2w3Ji=BSVPfAg04N6unX0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 10 April 2015 17:16:32 Feng Kan wrote:
> Hi Marc:
> 
> Is there any plans to support ACPI for GICv2m MSI? Both this driver and the
> GICv2m seems to support OF model of discovery for msi controller. X-Gene1
> uses this driver and X-Gene2 uses GICv2m, there needs to be a way to
> associate msi controller with the PCIe bus. I haven't
> found a standard way of doing finding "msi-parent" for ACPI. Do you have
> any suggestion.
> 
> Sorry for top posting.

Doing gicv2m in ACPI should be straightforward, and the ACPI code can simply
assume that there is only one GIC instance (whichever version) in the system
and use that for all standard PCI hosts.

	Arnd
