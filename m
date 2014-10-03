Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0141.outbound.protection.outlook.com ([157.56.110.141]:32922
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752224AbaJCOkG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 3 Oct 2014 10:40:06 -0400
Message-ID: <542EB53E.30507@amd.com>
Date: Fri, 3 Oct 2014 09:39:58 -0500
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
 <20141001113235.GC18271@pd.tnic> <542C1EAA.4050408@amd.com>
 <20141001154523.GF18271@pd.tnic>
In-Reply-To: <20141001154523.GF18271@pd.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/1/2014 10:45 AM, Borislav Petkov wrote:
> On Wed, Oct 01, 2014 at 10:32:58AM -0500, Aravind Gopalakrishnan wrote:
>>>> +			if (dcsm & 0x3) {
>>>> +				/* LRDIMMs */
>>>> +				edac_dbg(1, "  DIMM type: LRDIMM %dx rank multiply;"
>>>> +					 "CS = %d; all DIMMs support ECC: %s\n",
>>>> +					 (dcsm & 0x3), cs,
>>>> +					 (dclr & BIT(19)) ? "yes" : "no");
>>> Why do we need to iterate over the DRAM CS sets? Just for the rank
>>> multiplier, apparently. We dump those normally in read_dct_base_mask(),
>>> though.
>> It's not just for rank multiplier.. we find that it's LRDIMM only by
>> examining dcsm. Hence the iteration here..
> So we can look only at the first DCSM, no? Or are there systems with
> different types of LRDIMMs on one DCT?
>

So it seems we can theoretically have systems in this manner, but that 
is not a common case..

So, shall I just use first DCSM to keep it simple for now?
And find rank multiplier iteratively as and when need arises?

Thanks,
-Aravind.
