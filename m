Return-Path: <SRS0=4Wer=BP=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=4Wer=BP=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH 4/5] PCI: wait device ready after pci_pm_reset()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org >> Linux PCI" <linux-pci@vger.kernel.org>,
 timur@codeaurora.org, alex.williamson@redhat.com,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
 <1506212218-29103-4-git-send-email-okaya@codeaurora.org>
 <20171011220625.GV25517@bhelgaas-glaptop.roam.corp.google.com>
 <2702792d-e076-45a9-5b8a-82e1499cb624@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <d886e7d4-db9a-9dc9-e8f1-5dd48cb9beb4@codeaurora.org>
Date: Mon, 16 Oct 2017 08:51:49 -0400
MIME-Version: 1.0
In-Reply-To: <2702792d-e076-45a9-5b8a-82e1499cb624@codeaurora.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 10/12/2017 12:48 PM, Sinan Kaya wrote:
> On 10/11/2017 6:06 PM, Bjorn Helgaas wrote:
>>> static int pci_pm_reset(struct pci_dev *dev, int probe)
>>>  {
>>> +	unsigned int delay = dev->d3_delay;
>>>  	u16 csr;
>>>  
>>>  	if (!dev->pm_cap || dev->dev_flags & PCI_DEV_FLAGS_NO_PM_RESET)
>>> @@ -3988,7 +3989,10 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
>>>  	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
>>>  	pci_dev_d3_sleep(dev);
>>>  
>>> -	return 0;
>>> +	if (delay < pci_pm_d3_delay)
>>> +		delay = pci_pm_d3_delay;
>>> +
>>> +	return pci_dev_wait(dev, "PM D3->D0", delay, 1000);
>> 1) Why do we wait up to 1 second here, when we wait up to 60 seconds
>> for the other methods?  Can they all be the same?  Maybe a #define for
>> it?
> 
> I know you want to have similar behavior for systems that do and do not support
> CRS. That was the reason why I converted flr wait function to into dev_wait function.
> 
> However, here is the problem:
> 
> For systems that do not support CRS, there is no way of knowing whether we
> are reading 0xFFFFFFFF because the endpoint is not reachable due to an error
> like "it doesn't support this reset type" or if it is actually emitting a CRS.
> 
> If one system has a problem with pm_reset, this code would add an unnecessary
> 1 second delay into the reset path. If I make it 60 it would be something like:
> 
> 1. try reset method A
> 2. wait 60 seconds
> 3. try reset method B
> 4. wait 60 seconds. 
> 5. try reset method C
> 6. wait 60 seconds
> 
> This might end up being a regression on some system. 
> 
> I'm still leaning towards a wait only if we are observing a CRS. What's your
> thought on this?
> 
> then the sequence would be.
> 
> 1. try reset method A
> 2. if CRS pending, wait 60 seconds
> 3. try reset method B
> 4. if CRS pending, wait 60 seconds. 
> 5. try reset method C
> 6. if CRS pending, wait 60 seconds
> 

Thinking more about this. Another possibility is to have an adjustable sleep time.
Start with 60 seconds for all reset types. If somebody doesn't like it,
have a kernel command line override.

>>
>> 2) I don't really like the fact that we do the initial sleep one place
>> and then pass the length of that sleep here.  It's hard to verify
>> they're the same and keep them in sync.  I think the only thing you
>> use initial_wait for is to include that time in the dmesg messages.
>> Maybe we should just omit that time from the message and drop the
>> parameter?
>>
> 
> This was for printing reasons like you spotted, I can certainly get rid of
> the initial_wait.
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
