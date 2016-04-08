Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH 2/2] pci, acpi: free IO resource during shutdown
To: Tomasz Nowicki <tn@semihalf.com>,
	Bjorn Helgaas <helgaas@kernel.org>
References: <1457389310-3538-1-git-send-email-okaya@codeaurora.org>
 <1457389310-3538-2-git-send-email-okaya@codeaurora.org>
 <20160407160624.GB8780@localhost> <57069CAF.8090803@codeaurora.org>
 <20160407214108.GB24492@localhost> <5707281B.6020805@codeaurora.org>
 <570754D7.3010009@semihalf.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
	agross@codeaurora.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5707EE6F.2050509@codeaurora.org>
Date: Fri, 8 Apr 2016 13:46:23 -0400
MIME-Version: 1.0
In-Reply-To: <570754D7.3010009@semihalf.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tomasz,

On 4/8/2016 2:51 AM, Tomasz Nowicki wrote:
> Hi Sinan,
> 
> On 08.04.2016 05:40, Sinan Kaya wrote:
>> Hi Tomasz,
>>
>> On 4/7/2016 5:41 PM, Bjorn Helgaas wrote:
>>>>> You say this is undoing the effect of pci_remap_iospace(), but that's
>>>>>>> only called by native drivers and the generic (OF) driver, not by
>>>>>>> pci_root.c.
>>>>>
>>>>> See the ACPI root bridge driver above.
>>> If this is a fix to patches that haven't been merged yet, we need to
>>> squash the fix into the patches.
>>>
>>
>> Can you merge these to two patches to your series for the next post?
>>
>> I need to remove weak on the first patch per direction from Bjorn and
>> fix the function comments. You could as well do this while you are merging.
>>
>> Let me know what your preference is.
>>
> 
> Please do necessary fixes for your patches and send me the repo reference link. I will merge these to my patch set. Thanks!
> 
> Tomasz
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I posted the updated patch here. Changes are:

- I squashed these two patches together per Bjorn's request.
- Removed the weak declarations from both remap and unmap calls.
- Fixed the doxygen document to match the actual parameters.

https://us.codeaurora.org/cgit/quic/server/kernel/commit/?h=okaya/pciunmapv2&id=6120a5f0c5e6d757f18a076917fa202e2c9823d0

Sinan

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
