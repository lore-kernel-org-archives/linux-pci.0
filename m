Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0116.outbound.protection.outlook.com ([157.56.111.116]:5280
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754367AbaJBPX1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Oct 2014 11:23:27 -0400
Message-ID: <542D6DE5.3000205@amd.com>
Date: Thu, 2 Oct 2014 10:23:17 -0500
From: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
MIME-Version: 1.0
To: Borislav Petkov <bp@alien8.de>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<tglx@linutronix.de>, <hpa@zytor.com>, <x86@kernel.org>,
	<bp@suse.de>, <dan.carpenter@oracle.com>,
	<dougthompson@xmission.com>, <m.chehab@samsung.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] edac, amd64_edac: Add F15h M60h support
References: <1411070230-10298-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
 <20141001113235.GC18271@pd.tnic> <542C5995.7050803@amd.com>
 <20141002145201.GF16452@pd.tnic>
In-Reply-To: <20141002145201.GF16452@pd.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/2/2014 9:52 AM, Borislav Petkov wrote:
> On Wed, Oct 01, 2014 at 02:44:21PM -0500, Aravind Gopalakrishnan wrote:
>> The more I think about this, I'm finding it's hard to do this cleanly.
>> I initially thought I'd just cache this in pvt->dram_type the first time I'm
>> doing this.
>> But, the pvt->ops->dbam_to_cs() mappers get called first before
>> determine_memory_type().
>>
>> So, If I look for dram_type in f15_m60h_dbam_to_chip_select() it's ugly as
>> that's really the point of
>> having a determine_memory_type().
>>
>> Also, there's just a lot of if-else statements in determine_memory_type()
>> now.
>> This could benefit from having a per-family low_ops function.
>> And, we can call this early... somewhere in read_mc_regs() so that we have
>> information ready to use in
>> f15_m60h_dbam_to_chip_select() and in init_csrows() which needs dram_type
>> too.
> Right, this is what I was thinking too: somewhere in read_mc_regs(),
> after having collected ->dclr0, you call determine_memory_type() and
> store it into pvt->dram_type.

Yep.
So, let me go ahead and make these changes.
Shall send out a V2 once I have an answer on the LRDIMM question..

Thanks,
-Aravind.

>> Oh, btw- We can do away with a pvt->dram_ctrl as
>> f15_m60h_dbam_to_chip_select() really just needs the dram_type.
> Yes, you make the read of DRAM_CONTROL inside determine_memory_type() as
> we don't need it anywhere else.
>
> If we do, all of a sudden, we'll move it up to read_mc_regs(). IOW, I'm
> trying to centralize all reg reads in read_mc_regs() and use locally
> cached info later so I don't have to access the hardware each time
> needlessly, if it can be helped.
>
>


