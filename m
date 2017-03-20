Return-Path: <SRS0=CwFM=25=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=CwFM=25=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V4 0/3] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1489438085-2055-1-git-send-email-okaya@codeaurora.org>
 <20170313214616.GE8232@bhelgaas-glaptop.roam.corp.google.com>
 <c6b78903-ea09-9719-7073-c679b0b64a05@codeaurora.org>
 <20170313230855.GG8232@bhelgaas-glaptop.roam.corp.google.com>
 <b44fa6b3-7db5-bea4-7f2e-7f880362d171@codeaurora.org>
 <20170314192138.GA26264@bhelgaas-glaptop.roam.corp.google.com>
 <8fa282de-9896-0e2a-01cb-7146817268e6@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-arm-msm@vger.kernel.org, mayurkumar.patel@intel.com,
 linux-arm-kernel@lists.infradead.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5049bf09-6283-b617-2c21-acf56a1faab3@codeaurora.org>
Date: Mon, 20 Mar 2017 13:43:52 -0400
MIME-Version: 1.0
In-Reply-To: <8fa282de-9896-0e2a-01cb-7146817268e6@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 3/15/2017 10:33 AM, Sinan Kaya wrote:
> On 3/14/2017 3:21 PM, Bjorn Helgaas wrote:
>> On Mon, Mar 13, 2017 at 07:21:42PM -0400, Sinan Kaya wrote:
>>> On 3/13/2017 7:08 PM, Bjorn Helgaas wrote:
>>>> On Mon, Mar 13, 2017 at 06:05:55PM -0400, Sinan Kaya wrote:
>>>>> On 3/13/2017 5:46 PM, Bjorn Helgaas wrote:
>>>>>> What is this series based on?  Unless they depend on other in-flight
>>>>>> patches, I apply patches to branches based on my "master" branch,
>>>>>> which is typically -rc1 or -rc2 (it's currently v4.11-rc1).  These
>>>>>> don't apply to either.
>>>>>
>>>>> It looks like I am on 4.10. I can rebase and post again. 
>>>>
>>>> Rebasing would be good, but I can give you some comments on your v4,
>>>> now that I can apply it and see what it looks like.
>>>>
>>>
>>> Thanks, 
>>>
>>> I'm mostly done with the rebase. I'll have to retest tomorrow morning and
>>> then post.
>>>
>>> I had to drop this
>>>
>>>    - for endpoints, have pcie_aspm_init_link_state() do the actual ASPM
>>>       setup of the link as it currently does.
>>>
>>> during rebase.
>>>
>>> The reason is that the clock configuration needs to switch to common clock
>>> mode across all the devices before any ASPM latency is read/configured.
>>>
>>> Common clock configuration seem to be trying to walk the device list.
>>>
>>> Here is the untested version. It might not even compile.
>>> I'll wait until I receive your comments.
>>
>> I had already started looking at v4, so these comments are based on
>> that.  Your v4 is a great start and these are all general comments so
>> I didn't try to match each one up with the code.
>>
>>   - Goal: retain BIOS ASPM config of bridge even if children are
>>     removed and re-added.  Is there a bugzilla for this problem?
> 

Is there a common place to add code after the bus scan similar to pci_init_capabilities(). 
I really don't like the ASPM call in the middle of scan function.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
