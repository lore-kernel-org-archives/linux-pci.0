Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:59352 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbcDROjk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2016 10:39:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Jayachandran C <jchandra@broadcom.com>,
	Jon Masters <jcm@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, jiang.liu@linux.intel.com,
	robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>,
	Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>,
	Wangyijing <wangyijing@huawei.com>,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH V6 00/13] Support for generic ACPI based PCI host controller
Date: Mon, 18 Apr 2016 16:38:26 +0200
Message-ID: <4253385.YPSgBqNLfg@wuerfel>
In-Reply-To: <5714E224.1030307@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com> <CAKc_7PVC6O4oh+bTmpLQRrhHrqGbaKB2hynecKOLmc5fBc-VVQ@mail.gmail.com> <5714E224.1030307@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 18 April 2016 15:33:24 Tomasz Nowicki wrote:
> 
> Of course we can split discussion into the two topics:
> 1. ECAM based ACPI host controller - patches [1-10]
> 2. Quirks handling and examples.
> 
> IMO, it is very helpful for reviewers to go with one unified patch set 
> and see the whole picture. Also, as you can see, quirks handling allows 
> people to test it easily with their servers (not only QEMU but real HW).

I think splitting the two would help tremendously. The regular
PCI support should just get merged (it should have been completed
years ago when ACPI for ARM64 was first implemented), while the quirks
handling contains all ugly nonstandard hacks we have to be careful
about.

	Arnd
