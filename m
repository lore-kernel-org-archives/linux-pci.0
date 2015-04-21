Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46086 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586AbbDUIcp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Apr 2015 04:32:45 -0400
Message-ID: <55360B28.1060703@arm.com>
Date: Tue, 21 Apr 2015 09:32:40 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Feng Kan <fkan@apm.com>
CC: Duc Dang <dhdang@apm.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Loc Ho <lho@apm.com>
Subject: Re: [PATCH v3 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX
 termination driver
References: <20150408084448.5f0793b7@why.wild-wind.fr.eu.org>	<cover.1428564115.git.dhdang@apm.com>	<7923ef6ffd60a7c3de3c8c04fe746bbd3c15b5ac.1428564115.git.dhdang@apm.com>	<55280665.9020603@arm.com>	<CADaLNDkrqwnEOX1HgQ7V3-1o4cDJnG4dW1=U4ujod7fUW_PQ0w@mail.gmail.com>	<7a739a984c1b849ae92cb3bb3edc92f2@www.loen.fr>	<CADaLNDmxrpJ-t6fR=DVBzB1q_jp58H94oZnRrxZYtCvDCWJpog@mail.gmail.com>	<20150415091655.02361cdc@arm.com>	<CADaLNDkuXpMVanyPD1oMOK-uvdt+vK2+UabgUxvaK9bBZDmdKg@mail.gmail.com>	<5530DD9D.9020808@arm.com>	<CADaLNDkAu4o6YQkw528+1npWAa_CeX-ZfFED0zWRsz+WAfwf6A@mail.gmail.com>	<55310050.7000003@arm.com> <CAL85gmBFpKU7q31Utr+L_iHDM259kxmsL-0X=7WLB4k5xw65CA@mail.gmail.com>
In-Reply-To: <CAL85gmBFpKU7q31Utr+L_iHDM259kxmsL-0X=7WLB4k5xw65CA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 20/04/15 19:51, Feng Kan wrote:

> Is it possible to use the pci_msi_create_default_irq_domain for the X-Gene MSI
> driver. Or is this going to be removed in the future. Thanks

This is not the preferred way. pci_msi_create_default_irq_domain is only
there for legacy purposes, so that we can lookup an MSI without
specifying the domain. New code shouldn't have to rely on it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
