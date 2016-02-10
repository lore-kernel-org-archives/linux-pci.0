Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:60788 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbcBJO3b (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2016 09:29:31 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Duc Dang <dhdang@apm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Tomasz Nowicki <tn@semihalf.com>, Feng Kan <fkan@apm.com>,
	linux-pci@vger.kernel.org, patches@apm.com,
	linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>,
	Mark Salter <msalter@redhat.com>,
	Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH] pci: xgene: Add ECAM fixups
Date: Wed, 10 Feb 2016 15:28:56 +0100
Message-ID: <2994764.UGKJE3zfLx@wuerfel>
In-Reply-To: <1455068984-22210-1-git-send-email-dhdang@apm.com>
References: <1455068984-22210-1-git-send-email-dhdang@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 09 February 2016 17:49:44 Duc Dang wrote:
> X-Gene PCIe controller does not fully support ECAM.
> This patch adds required ECAM fixup to allow X-Gene
> PCIe controller to be functional in ACPI boot mode.
> 
> This patch is based on the original work of
> Mark Salter <msalter@redhat.com> and depends on
> Tomasz's PCIe ACPI series:
> https://lkml.org/lkml/2016/2/4/646
> 
> Signed-off-by: Duc Dang <dhdang@apm.com>
> ---

This really has nothing to do with the PCI host device driver, please
keep it in a separate file in drivers/acpi/.

	Arnd
