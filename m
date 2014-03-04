Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58586 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108AbaCFPoK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Mar 2014 10:44:10 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v5 1/7] pci: Introduce pci_register_io_range() helper function.
Date: Tue, 4 Mar 2014 23:30:09 +0100
Cc: "linux-pci" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"linaro-kernel" <linaro-kernel@lists.linaro.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Tanmay Inamdar <tinamdar@apm.com>
References: <1393948204-11555-1-git-send-email-Liviu.Dudau@arm.com> <1393948204-11555-2-git-send-email-Liviu.Dudau@arm.com>
In-Reply-To: <1393948204-11555-2-git-send-email-Liviu.Dudau@arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201403042330.09607.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 04 March 2014, Liviu Dudau wrote:
> +int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
> +{
> +       return 0;
> +}
> +

How about returning an error here? You don't actually register the range.

	Arnd
