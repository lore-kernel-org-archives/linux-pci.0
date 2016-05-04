Return-Path: <davem@davemloft.net>
Return-Path: <davem@davemloft.net>
Date: Wed, 04 May 2016 00:17:05 -0400 (EDT)
Message-Id: <20160504.001705.2292678530932661059.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: yinghai@kernel.org, helgaas@kernel.org, bhelgaas@google.com,
 torvalds@linux-foundation.org, weiyang@linux.vnet.ibm.com, linux@iam.tj,
 wangyijing@huawei.com, khalid.aziz@oracle.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH v11 04/60] sparc/PCI: Use correct offset for bus
 address to resource
From: David Miller <davem@davemloft.net>
In-Reply-To: <1462322260.30470.76.camel@kernel.crashing.org>
References: <CAE9FiQU_XSMfxFPSOrMjQ2DGnrM0D5T=0ORfDEBxqWggGrzc+Q@mail.gmail.com>
	<CAE9FiQX_8oXj=FD8pKe=eBL=YWZY-=C8sZ6yMbmkwegLVOR-fA@mail.gmail.com>
	<1462322260.30470.76.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-pci.vger.kernel.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 04 May 2016 10:37:40 +1000

> On Tue, 2016-05-03 at 15:52 -0700, Yinghai Lu wrote:
>> BenH and DavidM,
>> Are you ok to let /proc/bus/pci/devices to expose resource value
>> instead of
>> BAR value?
>> powerpc already expose MMIO as resource value, but still keep IO as
>> BAR value?
>> 
>> Or can we just dump /proc/bus/pci support from now?
> 
> The problem tends to be old Xserver expectations...
> 
> That stuff has been a can of worms over the years and we did things in
> the kernel to work around X limitations. I'm not that keen on touching
> /proc at all in that regard. Leave it there do what it does today, it's
> a user visible ABI, don't change it.

I agree with Ben, whatever procfs is exporting in the past is what
the Xserver and other things expect on sparc64 and therefore is a
user facing ABI that can't be changed.
