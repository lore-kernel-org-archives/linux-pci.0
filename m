Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49885 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617AbbGJIn4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jul 2015 04:43:56 -0400
Message-ID: <559F85C8.7000403@arm.com>
Date: Fri, 10 Jul 2015 09:43:52 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Duc Dang <dhdang@apm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: Re: [PATCH v3 14/15] PCI/MSI: pci-xgene-msi: Get rid of struct msi_controller
References: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com> <1436289485-28230-15-git-send-email-marc.zyngier@arm.com> <CADaLNDm9o8XH749ocy4eJO=1T_w0AAFa1UZJLiFGrgR=5Aqjcg@mail.gmail.com>
In-Reply-To: <CADaLNDm9o8XH749ocy4eJO=1T_w0AAFa1UZJLiFGrgR=5Aqjcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Duc,

On 09/07/15 23:12, Duc Dang wrote:
> On Tue, Jul 7, 2015 at 10:18 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> The XGene MSI driver only uses the msi_controller structure as
>> a way to match the host bridge  with its MSI HW, and thus the
>> msi_domain.
>>
>> But now that we can directly associate an msi_domain with a device,
>> there is no use keeping this msi_controller around.
>>
>> Just remove all traces of msi_controller from the driver.
>>
> Thanks, Marc.
> 
> I tested this patch set and it works on my APM X-Gene evaluation platform.

Ah, thanks! I did that as a side effort, but didn't have a chance to
test it (who the *&%^!! decided to mount this board in a 1U chassis
without an angle bracket for the PCIe bus? Seriously???).

> The xgene_pcie_msi_enable (in driver/pci/host/pci-xgene.c), which is
> used to get msi_controller for X-Gene PCIe port,
> also becomes unnecessary with this patch set. I will post a clean-up
> patch when your changes are accepted.

Yeah, I didn't want to touch too much of it without any testing.

> You can add my tested-by if you want:
> 
> Tested-by: Duc Dang <dhdang@apm.com>

Thanks a lot for that,

	M.
-- 
Jazz is not dead. It just smells funny...
