Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36833 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbbHJSbb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 14:31:31 -0400
Received: by wicja10 with SMTP id ja10so47611955wic.1
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2015 11:31:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150807094957.GK20873@sirena.org.uk>
References: <E1ZNIul-0007IF-Ev@optimist> <20150806175322.GB20873@sirena.org.uk>
 <20150807073954.3d19fc69@canb.auug.org.au> <20150807094957.GK20873@sirena.org.uk>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 10 Aug 2015 13:31:10 -0500
Message-ID: <CAErSpo6aryRYOJpfXfY6SuJoVe72MYd8RKgPhiDZ9pt5+zmXBQ@mail.gmail.com>
Subject: Re: next-20150806 build: 2 failures 52 warnings (next-20150806)
To: Mark Brown <broonie@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <michal.simek@xilinx.com>,
	kernel-build-reports@lists.linaro.org,
	linaro-kernel <linaro-kernel@lists.linaro.org>,
	linux-next list <linux-next@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 7, 2015 at 4:49 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Aug 07, 2015 at 07:39:54AM +1000, Stephen Rothwell wrote:
>> On Thu, 6 Aug 2015 18:53:22 +0100 Mark Brown <broonie@kernel.org> wrote:
>
>> > msi_desc_to_pci_sys_data doesn't appear to exist anywhere else in
>> > current -next, the usage was introduced by e39758e0ea769e632e (PCI: Use
>> > helper functions to access fields in struct msi_desc) at which time it
>> > looks like it did exist but I can't immediately see where it was removed.
>
>> Actually, it is a typo ... all other uses are spelt msi_desc_to_pci_sysdata.

c179c9b978b9 ("PCI: Add helper function msi_desc_to_pci_sysdata()")
added msi_desc_to_pci_sysdata().

e39758e0ea76 ("PCI: Use helper functions to access fields in struct
msi_desc") added calls to msi_desc_to_pci_sysdata() in
pci-keystone-dw.c and pcie-designware.c, but to
msi_desc_to_pci_sys_data() (note extra "_") in pcie-xilinx.c.

These were both merged by Thomas, so I assume he and Jiang will sort this out.

Bjorn
