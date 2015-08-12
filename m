Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20088 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933789AbbHLIVc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 12 Aug 2015 04:21:32 -0400
Subject: Re: next-20150806 build: 2 failures 52 warnings (next-20150806)
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>
References: <E1ZNIul-0007IF-Ev@optimist>
 <20150806175322.GB20873@sirena.org.uk>
 <20150807073954.3d19fc69@canb.auug.org.au>
 <20150807094957.GK20873@sirena.org.uk>
 <CAErSpo6aryRYOJpfXfY6SuJoVe72MYd8RKgPhiDZ9pt5+zmXBQ@mail.gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Yijing Wang <wangyijing@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <michal.simek@xilinx.com>,
	kernel-build-reports@lists.linaro.org,
	linaro-kernel <linaro-kernel@lists.linaro.org>,
	linux-next list <linux-next@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <55CB0205.2020408@linux.intel.com>
Date: Wed, 12 Aug 2015 16:21:25 +0800
MIME-Version: 1.0
In-Reply-To: <CAErSpo6aryRYOJpfXfY6SuJoVe72MYd8RKgPhiDZ9pt5+zmXBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/8/11 2:31, Bjorn Helgaas wrote:
> On Fri, Aug 7, 2015 at 4:49 AM, Mark Brown <broonie@kernel.org> wrote:
>> On Fri, Aug 07, 2015 at 07:39:54AM +1000, Stephen Rothwell wrote:
>>> On Thu, 6 Aug 2015 18:53:22 +0100 Mark Brown <broonie@kernel.org> wrote:
>>
>>>> msi_desc_to_pci_sys_data doesn't appear to exist anywhere else in
>>>> current -next, the usage was introduced by e39758e0ea769e632e (PCI: Use
>>>> helper functions to access fields in struct msi_desc) at which time it
>>>> looks like it did exist but I can't immediately see where it was removed.
>>
>>> Actually, it is a typo ... all other uses are spelt msi_desc_to_pci_sysdata.
> 
> c179c9b978b9 ("PCI: Add helper function msi_desc_to_pci_sysdata()")
> added msi_desc_to_pci_sysdata().
> 
> e39758e0ea76 ("PCI: Use helper functions to access fields in struct
> msi_desc") added calls to msi_desc_to_pci_sysdata() in
> pci-keystone-dw.c and pcie-designware.c, but to
> msi_desc_to_pci_sys_data() (note extra "_") in pcie-xilinx.c.
> 
> These were both merged by Thomas, so I assume he and Jiang will sort this out.
Hi Bjorn and Mark,
	Thomas is on vocation this two weeks, so I will send him a
patch to fix this issue once Thomas is back.
Thanks!
Gerry
