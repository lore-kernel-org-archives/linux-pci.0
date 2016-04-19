Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:53484 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbcDSNIE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 09:08:04 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Jayachandran C <jchandra@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, jiang.liu@linux.intel.com,
	Jon Masters <jcm@redhat.com>, linaro-acpi@lists.linaro.org,
	linux-pci@vger.kernel.org, Liviu.Dudau@arm.com,
	David Daney <ddaney@caviumnetworks.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, Wangyijing <wangyijing@huawei.com>,
	Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH V6 08/13] PCI: generic, thunder: update to use generic ECAM API
Date: Tue, 19 Apr 2016 15:06:59 +0200
Message-ID: <3830999.dF71UWYsBP@wuerfel>
In-Reply-To: <5715362A.7070701@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com> <10639671.xGDtp1R8bk@wuerfel> <5715362A.7070701@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 18 April 2016 21:31:54 Tomasz Nowicki wrote:
> 
> Basically the whole content of pci-thunder-ecam.c and pci-thunder-pem.c.
> 
> pci-thunder-ecam.c contains config space accessors. Similar for 
> pci-thunder-pem.c but it also has extra init call (it is now called 
> thunder_pem_init) which finds and maps related registers.

They seem to do much more than just override the accessors, they actually
change the contents of the config space as well. Is that really necessary
on ACPI based systems as well?

Another idea: how about moving all of this logic into ACPI and calling
some AML method to access the config space if the devices are that
far out of spec.

	Arnd
