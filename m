Return-Path: <SRS0=e6tm=7S=ti.com=kishon@kernel.org>
Return-Path: <SRS0=e6tm=7S=ti.com=kishon@kernel.org>
Subject: Re: [PATCH] PCI: endpoint: not need to free epf_test
To: Bjorn Helgaas <helgaas@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
References: <1501728251-196637-1-git-send-email-shawn.lin@rock-chips.com>
 <20170814211222.GI32525@bhelgaas-glaptop.roam.corp.google.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e5535d51-48d6-9925-5e7a-c5520dcee14e@ti.com>
Date: Wed, 16 Aug 2017 19:39:40 +0530
MIME-Version: 1.0
In-Reply-To: <20170814211222.GI32525@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tuesday 15 August 2017 02:42 AM, Bjorn Helgaas wrote:
> On Thu, Aug 03, 2017 at 10:44:11AM +0800, Shawn Lin wrote:
>> It's from devm_kzalloc. so not need to free it when removing
>> the test driver.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Kishon?

While the patch itself is correct, I'd like to make ->remove callback optional
so that function drivers need not populate empty 'remove' callback functions.

I have a few endpoint patches in my local tree which I'm planning to send in a
couple of days. I'll send this patch along with that series while making the
above mentioned modifications.

Thanks
Kishon
