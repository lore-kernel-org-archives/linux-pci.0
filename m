Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [Patch v5 0/6] Consolidate ACPI PCI root common code into ACPI
 core
To: Bjorn Helgaas <bhelgaas@google.com>,
	Hanjun Guo <hanjun.guo@linaro.org>
References: <1433780448-18636-1-git-send-email-jiang.liu@linux.intel.com>
 <55B8C46F.4090109@linaro.org> <20150729203027.GB9640@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Lv Zheng <lv.zheng@intel.com>,
	"lenb @ kernel . org" <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <55B9D938.4020204@linux.intel.com>
Date: Thu, 30 Jul 2015 15:58:49 +0800
MIME-Version: 1.0
In-Reply-To: <20150729203027.GB9640@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/7/30 4:30, Bjorn Helgaas wrote:
> On Wed, Jul 29, 2015 at 08:17:51PM +0800, Hanjun Guo wrote:
>> Hi Bjorn, Rafael,
>>
>> Just kindly ping for this patchset, it has been reviewed and tested,
>> can it be merged in 4.3?
> 
> There are open review issues, e.g., IORESOURCE_MEM_8AND16BIT, so I'm not
> ready to merge it as-is.  I'll look at it some more, but we definitely need
> some revisions.
Hi Bjorn,
	Thanks for review and I will handle all review comments in
coming days.
Regards!
Gerry
