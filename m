Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from numascale.com ([213.162.240.84]:45485 "EHLO numascale.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbaKFLK4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 6 Nov 2014 06:10:56 -0500
Message-ID: <545B5735.8000401@numascale.com>
Date: Thu, 06 Nov 2014 19:10:45 +0800
From: Daniel J Blueman <daniel@numascale.com>
MIME-Version: 1.0
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Yinghai Lu <yinghai@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Steffen Persvold <sp@numascale.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] x86: Drop redundant memory-block sizing code
References: <ojh5M-xh-17@gated-at.bofh.it> <1415249414-20888-1-git-send-email-daniel@numascale.com> <20141106094007.GA4849@pd.tnic> <545B4E84.7050707@numascale.com> <20141106104034.GB4849@pd.tnic>
In-Reply-To: <20141106104034.GB4849@pd.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/06/2014 06:40 PM, Borislav Petkov wrote:
> On Thu, Nov 06, 2014 at 06:33:40PM +0800, Daniel J Blueman wrote:
>> As the first check for 64GB or larger memory returns a 2GB memory block size
>> in that case, the following check for less than 64GB will always evaluate
>> true, leading to unreachable code.
>
> I'm reading this as this code is never running on systems < 64GB. Why is
> that so?

Let me clarify that "Leading to" didn't mean "executing":

"As the first check for 64GB or larger memory returns a 2GB memory block 
size in that case, the following check for less than 64GB will always 
evaluate true and return MIN_MEMORY_BLOCK_SIZE, leading to unreachable code.

Remove the second and unnecessary condition and the code in the 
remainder of the function, as it therefore can't be reached."

Sheesh. Even Shakespeare would have trouble writing a exemplary changelog.

Thanks,
   Daniel
-- 
Daniel J Blueman
Principal Software Engineer, Numascale
