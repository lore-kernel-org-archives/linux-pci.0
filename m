Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <556FAFEF.6040802@linux.intel.com>
Date: Thu, 04 Jun 2015 09:54:55 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Al Stone <ahs3@redhat.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>
CC: Lv Zheng <lv.zheng@intel.com>,
	"lenb @ kernel . org" <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [Patch v4 0/8] Consolidate ACPI PCI root common code into ACPI
 core
References: <1433225576-8215-1-git-send-email-jiang.liu@linux.intel.com> <556F6332.2040501@redhat.com>
In-Reply-To: <556F6332.2040501@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/6/4 4:27, Al Stone wrote:
> On 06/02/2015 12:12 AM, Jiang Liu wrote:
>> This patch set consolidates common code to support ACPI PCI root on x86
>> and IA64 platforms into ACPI core, to reproduce duplicated code and
>> simplify maintenance. And a patch set based on this to support ACPI based
>> PCIe host bridge on ARM64 has been posted at:
> 
> Link is missing (or it's a typo of some flavor).
HI Al,
	Sorry, I missed the link. It has been posted at:
https://lkml.org/lkml/2015/5/26/207
Thanks!
Gerry
