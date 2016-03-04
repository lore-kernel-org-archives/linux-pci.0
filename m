Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 4 Mar 2016 17:37:50 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rafael@kernel.org, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com, yinghai@kernel.org
Subject: Re: [PATCH V5 00/15] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
Message-ID: <20160304173750.GA15070@red-moon>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <56D49611.2050202@codeaurora.org>
 <20160303112332.GC28359@red-moon>
 <56D84938.6020102@codeaurora.org>
 <20160304105517.GA30693@red-moon>
 <56D97901.7080001@semihalf.com>
 <56D9A121.9080508@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56D9A121.9080508@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 04, 2016 at 09:52:17AM -0500, Sinan Kaya wrote:

[...]

> >> I could integrate the code implementing pci=realloc in patch 11 so
> >> that we realloc by default all resources claimed that failed (which
> >> means that bridges are resized accordingly and you won't be forced
> >> to use pci=realloc on command line).
> >>
> > 
> > I agree with Lorenzo. Just because v3 works it does not mean we want to go this way. Also, I think we should realloc all resources claimed that failed, w/o need to use pci=realloc on command line.
> > 
> 
> Let's give this a try. I have seen the kernel messages with and
> without realloc option too. I don't want to see any kind of error
> messages if it is actually working.

I agree, claiming resources failures are too noisy, it is a pet-peeve
of mine too. The code to realloc resources is in the kernel already,
it is just a matter of defining how to use it (ie trigger it by default
without command line option - actually the kernel can be already
compiled to enable realloc by default, see CONFIG_PCI_REALLOC_ENABLE_AUTO),
that's why I added Yinghai to the thread, Bjorn and him have more
insights on how this has been used on current systems and I am really keen
on getting their opinion, they have more visibility into this than I do,
writing the patch itself should be simple enough.

Thanks !
Lorenzo
