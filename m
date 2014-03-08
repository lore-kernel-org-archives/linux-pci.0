Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.13]:52066 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbaCHRSD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 8 Mar 2014 12:18:03 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v6 2/6] pci: OF: Fix the conversion of IO ranges into IO resources.
Date: Sat, 8 Mar 2014 18:17:39 +0100
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
References: <1394020137-1830-1-git-send-email-Liviu.Dudau@arm.com> <1394020137-1830-3-git-send-email-Liviu.Dudau@arm.com>
In-Reply-To: <1394020137-1830-3-git-send-email-Liviu.Dudau@arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201403081817.39810.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 05 March 2014, Liviu Dudau wrote:
> +               unsigned long port = -1;
> +               if (!pci_register_io_range(range->cpu_addr, range->size))
> +                       port = pci_address_to_pio(range->cpu_addr);

I don't remember the outcome of my suggestion to just return 'port' from
pci_register_io_range(). In my mind that would be much simpler than
adding the range in a data structure just so we can look it up in the very
next line.

	Arnd
