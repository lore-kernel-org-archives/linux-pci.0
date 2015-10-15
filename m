Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <561FFB4C.1000500@redhat.com>
Date: Thu, 15 Oct 2015 15:15:24 -0400
From: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
To: Hanjun Guo <hanjun.guo@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-kernel@vger.kernel.org,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	linux-acpi@vger.kernel.org,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Mark Salter <msalter@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/11] ARM64 PCI hostbridge init based on ACPI
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
In-Reply-To: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Hanjun,

Thanks for your hard work on ARM64 PCI host bridge/root complex so far!

On 05/26/2015 08:49 AM, Hanjun Guo wrote:
> This patch set is introducing ARM64 PCI hostbridge init based on ACPI,
> which based on Jiang Liu's patch set "Consolidate ACPI PCI root common
> code into ACPI core":
> 
> https://lkml.org/lkml/2015/5/14/98

The latest version (v7) of the ACPI PCI root common code consolidation
series was posted by Gerry (Jiang Liu) yesterday:

https://lkml.kernel.org/g/1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com

This got me wondering what the status is of the ARM64 specific
hostbridge patch series that has a dependency upon the former. Are you
planning to wait for that series to be accepted or post a newer rebased
version for additional review, or something else?

Thanks very much in advance! :)

Jon.

