Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42093 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbaAEH5u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 5 Jan 2014 02:57:50 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1Vziah-0007Tf-Im
	for linux-pci@vger.kernel.org; Sun, 05 Jan 2014 08:57:47 +0100
Received: from 173-228-55-65.static.sonic.net ([173.228.55.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Sun, 05 Jan 2014 08:57:47 +0100
Received: from DanaGoyette by 173-228-55-65.static.sonic.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Sun, 05 Jan 2014 08:57:47 +0100
To: linux-pci@vger.kernel.org
From: Dana Goyette <DanaGoyette@gmail.com>
Subject: Re: IOMMU groups ... PEX8606 switch?
Date: Sat, 04 Jan 2014 23:57:33 -0800
Message-ID: <lab391$po7$1@ger.gmane.org>
References: <l9o1h7$33k$2@ger.gmane.org>			 <1388287383.4981.16.camel@ul30vt.home> <l9oj5j$miu$1@ger.gmane.org>		 <1388377005.4981.69.camel@ul30vt.home> <l9t26b$i61$1@ger.gmane.org>	 <1388793837.3169.73.camel@bling.home> <la9n9k$g63$1@ger.gmane.org> <1388866954.3169.77.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <1388866954.3169.77.camel@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(Re-sending to gmane.linux.kernel.pci so the solution ends up there, as 
  well.)

On 01/04/2014 12:22 PM, Alex Williamson wrote:
> On Sat, 2014-01-04 at 11:26 -0800, Dana Goyette wrote:
>> On 01/03/2014 04:03 PM, Alex Williamson wrote:
>>> On Mon, 2013-12-30 at 16:13 -0800, Dana Goyette wrote:
>>>> On 12/29/2013 08:16 PM, Alex Williamson wrote:
>>>>> On Sat, 2013-12-28 at 23:32 -0800, Dana Goyette wrote:
>>>>>> On 12/28/2013 7:23 PM, Alex Williamson wrote:
>>>>>>> On Sat, 2013-12-28 at 18:31 -0800, Dana Goyette wrote:
>>>>>>>> I have purchased both a SuperMicro X10SAE and an X10SAT, and I need to
>>>>>>>> soon decide which one to keep.
>>>>>>>>
>>>>>>>> The SuperMicro X10SAT has all the PCIe x1 slots hidden behind a PLX
>>>>>>>> PEX8066 switch, which claims to support ACS.  I'd expect the devices
>>>>>>>> downstream of the PLX switch to be in separate groups.
>>>>>>>>
>>>>>>>> With Linux 3.13-rc5 and "enable overrides for missing ACS capabilities"
>>>>>>>> applied and set for the Intel root ports, the devices behind the switch
>>>>>>>> remain stuck in the same group.
>>>>>>>>
>>>>>>>> In terms of passing devices to different VMs, which is better: all
>>>>>>>> devices on different root ports, or all devices behind the one
>>>>>>>> ACS-supporting switch?
>>>>>>> Can you provide lspci -vvv info?  If you're getting that for groups
>>>>>>> either the switch has ACS capabilities, but doesn't support the features
>>>>>>> we need or we're doing something wrong.  Thanks,
>>>>>>>
>>>>>> I initially tried attaching the output as a .txt file, but it's too
>>>>>> large.  Anyway, here's the output of lspci -nnvvv (you may notice that I
>>>>>> moved the Radeon to a different slot).
>>>>> Well, something seems amiss since the downstream switch ports all seem
>>>>> to support and enable the correct set of ACS capabilities.  I'm tending
>>>>> to suspect something wrong with the ACS override patch or how it's being
>>>>> used since your IOMMU group is still based at the root port.  Each root
>>>>> port is isolated from the other root ports though, so something is
>>>>> happening with the override patch.  Can you provide the kernel command
>>>>> line you use to enable ACS overrides and the override patch you're
>>>>> using, as it applies to 3.13-rc5?  Thanks,
>>>>>
>>>>> Alex
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe kvm" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>> I'm using the original acs-override patch from this post:
>>>> https://lkml.org/lkml/2013/5/30/513
>>>>
>>>> Kernel parameter is:
>>>> pcie_acs_override=id:8086:8c10,id:8086:8c12,id:8086:8c16,id:8086:8c18
>
> Actually, you're not:
>
> pcie_acs_override=id:8086:8c10,id:8086:8c16,id:8086:8c18,id:8086:ac1a,id:8086:8c1c,id:8086:8c1e,id:10b5:8606
>
> And we register all of them:
>
> [    0.000000] PCIe ACS bypass added for 8086:8c10
> [    0.000000] PCIe ACS bypass added for 8086:8c16
> [    0.000000] PCIe ACS bypass added for 8086:8c18
> [    0.000000] PCIe ACS bypass added for 8086:ac1a
> [    0.000000] PCIe ACS bypass added for 8086:8c1c
> [    0.000000] PCIe ACS bypass added for 8086:8c1e
> [    0.000000] PCIe ACS bypass added for 10b5:8606
>
> However, note that the root port causing you trouble is 8086:8c12, which
> isn't provided as an override, therefore the code is doing the right
> thing and grouping all devices behind that root port together.
>

Thanks for catching that -- I certainly missed it!
I've added the override for that root port and removed the override for 
the PLX switch; now all the ports are indeed in separate groups.

Do we yet know if it'll be possible to properly isolate the Intel root 
ports, without this ACS override?

--
To unsubscribe from this list: send the line "unsubscribe kvm" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


