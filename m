Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:58380 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321AbbAFTd4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jan 2015 14:33:56 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Duc Dang <dhdang@apm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, Feng Kan <fkan@apm.com>,
	linux-pci@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>
Subject: Re: [PATCH 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX termination driver
Date: Tue, 06 Jan 2015 20:33:41 +0100
Message-ID: <22570652.F088Afk9OX@wuerfel>
In-Reply-To: <94f9823d9a8c9c7ef819173f0a5ab06fb8fff408.1420499393.git.dhdang@apm.com>
References: <cover.1420499393.git.dhdang@apm.com> <94f9823d9a8c9c7ef819173f0a5ab06fb8fff408.1420499393.git.dhdang@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 06 January 2015 08:15:41 Duc Dang wrote:
> X-Gene v1 SOC supports total 2688 MSI/MSIX vectors coalesced into
> 16 HW IRQ lines.
> 
> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
> Signed-off-by: Duc Dang <dhdang@apm.com>
> 

I might be a little behind the latest development, but why is this
not a struct msi_controller?

	Arnd
