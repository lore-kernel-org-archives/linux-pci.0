Return-Path: <SRS0=cNEb=IZ=rock-chips.com=shawn.lin@kernel.org>
Return-Path: <SRS0=cNEb=IZ=rock-chips.com=shawn.lin@kernel.org>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Rename directory from host to controller and move
 back drivers
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1527729157-201428-1-git-send-email-shawn.lin@rock-chips.com>
 <20180606222720.GB128611@bhelgaas-glaptop.roam.corp.google.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <7845016f-0cc8-b4ae-bbfe-af25047f3a7d@rock-chips.com>
Date: Thu, 7 Jun 2018 09:29:16 +0800
MIME-Version: 1.0
In-Reply-To: <20180606222720.GB128611@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=gbk; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 2018/6/7 6:27, Bjorn Helgaas wrote:
> On Thu, May 31, 2018 at 09:12:37AM +0800, Shawn Lin wrote:
>> In early discussion, the PCI drivers were scattered across three
>> different places, including host, cadence and dwc directories.
>> The reason behind that is we thought the name, host, was confusing
>> since it seems contain the driver for RC. And dwc drivers set a
>> precedent for supporting both of RC and EP mode, so that they were
>> moved to a separate directory called dwc which is parallel to the host
>> directory. Then cadence drivers follow this convention, and so on.
>> But this confuses more and potentially make the drivers/pci/ look
>> fragmented if more and more drivers follow this way.
>>
>> So this patch rename directory from host to controller and make it
>> obvious that this is for controller drivers which applies to both
>> of RC and EP drivers. Then it moves back cadence and dwc drivers.
>>
>> Hope all are settled down and all the following patches submitting
>> new drivers could benefit from it.
>>
>> No functional change intended.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> This seems reasonable to me.  It would be even nicer if you had any
> URLs for previous conversation about it.  If you find any, just
> respond here (no need to repost the patch; I can fold them into the
> changelog).

This[1] is the initial suggestion about removing separate directories
for host drivers, and quoting from Lorenzo's final call: "Send a last
version asap and I will try to merge it for this cycle, keeping in mind
that what we discussed above must be implemented as soon as a new cycle
starts."

Then we discussed an option about second PR for that[2].

[1]https://patchwork.kernel.org/patch/10260547/
[2]https://patchwork.kernel.org/patch/10319355/


Thanks.

> 
> If there's consensus to do this, I can so a second pull request for
> v4.18-rc1 next week.  I haven't even done the first one yet, but
> hopefully end of this week or early next week.
> 
> Bjorn
> 
> 
> 
