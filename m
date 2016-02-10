Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V4 12/23] x86, ia64, pci: Remove ACPI companion device
 from platform specific data.
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
 <1454606941-9523-13-git-send-email-tn@semihalf.com>
 <20160209172800.GB22868@red-moon>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <56BBA9CB.5060407@semihalf.com>
Date: Wed, 10 Feb 2016 22:21:15 +0100
MIME-Version: 1.0
In-Reply-To: <20160209172800.GB22868@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/09/2016 06:28 PM, Lorenzo Pieralisi wrote:
> This patch has to be squashed with the previous one otherwise it
> has bisectability issues (ie the previous patch passes the parent
> to the pci_create_root_bus() call so, without this patch applied,
> the companion initialization would fail).
I do not think so. The previous patch passes the parent to the 
pci_create_root_bus(), indeed, so pci_create_root_bus() set companion 
device before calling pcibios_root_bridge_prepare() (for both cases x86 
and ia64). In turn, pcibios_root_bridge_prepare() will do nothing, since 
bridge->dev.parent != NULL. After all, pcibios_root_bridge_prepare() is 
dead code.
>
> Other than that:
>
> Reviewed-by: Lorenzo Pieralisi<lorenzo.pieralisi@arm.com>
Thanks!

Tomasz
