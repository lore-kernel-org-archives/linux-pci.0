Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V4 22/23] arm64, pci, acpi: Assign legacy IRQs once device
 is enable.
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
 <1454606941-9523-23-git-send-email-tn@semihalf.com>
 <20160211115843.GA24136@red-moon>
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
Message-ID: <56BCD6FE.4030107@semihalf.com>
Date: Thu, 11 Feb 2016 19:46:22 +0100
MIME-Version: 1.0
In-Reply-To: <20160211115843.GA24136@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11.02.2016 12:58, Lorenzo Pieralisi wrote:
> As for the MSI check, by reading commit history its need I think
> it harks back to bba6f6fc, which was supposed to be a quick hack and it
> has been in the kernel for 9 years:), is it really needed ?

IMO, yes it is needed. We need to chose MSI vs IRQ, and MSI is 
preferable option.

Tomasz
