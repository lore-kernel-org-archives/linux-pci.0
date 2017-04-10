Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To: Rajat Jain <rajatja@google.com>
Subject: RE: [PATCH V7 0/5] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
Date: Mon, 10 Apr 2017 11:44:43 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B2846676662B@IRSMSX101.ger.corp.intel.com>
References: <1490880636-30542-1-git-send-email-okaya@codeaurora.org>
 <7c48ca8b-b834-3257-91dc-77e9d19def6c@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B28466761383@IRSMSX101.ger.corp.intel.com>
 <92EBB4272BF81E4089A7126EC1E7B2846676271D@IRSMSX101.ger.corp.intel.com>
 <951505b8-9580-7131-2f14-de92817190a7@codeaurora.org>
 <CACK8Z6FG7QHs1kQUoTJTcP3606+xBLFp9RUmLuv0m0X2mxH9XA@mail.gmail.com>
 <92EBB4272BF81E4089A7126EC1E7B2846676309A@IRSMSX101.ger.corp.intel.com>
 <CACK8Z6Fg5fbYYeza2NfMbu5QhegVck0VNuqKKrFUNvAFoSC25g@mail.gmail.com>
In-Reply-To: <CACK8Z6Fg5fbYYeza2NfMbu5QhegVck0VNuqKKrFUNvAFoSC25g@mail.gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "timur@codeaurora.org" <timur@codeaurora.org>,
 Sinan Kaya <okaya@codeaurora.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


>> Hi Rajat
>>
>>
>>>On Thu, Apr 6, 2017 at 8:19 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>>>>
>>>> On 4/6/2017 9:23 AM, Patel, Mayurkumar wrote:
>>>> > Actually, The enabling/configuring of ASPM L1.2 is opposite then ASPM L1.
>>>> > In case of L1, Upstream must configure first L1 and then downstream according to PCIe spec.
>>>> > In case of L1.2, Downstream must configure L1.2 and then upstream according (to L1.2 ECN spec. -> 5.5.4. L1 PM
>>>> > substates Configuration).
>>>> >
>>>> > @Bjorn:
>>>> > I even found that programming of pcie_config_aspm_l1ss() sub-states is done in the opposite way than described in
>>>> > the spec.,
>>>> >
>>>> > The spec. says following and correct me If I am wrong or I misinterpret the spec. :
>>>> >
>>>> > 5.5.4. L1 PM Substates Configuration
>>>> >
>>>> > The Setting of any enable bit must be performed at the Downstream Port before the
>>>> > corresponding bit is permitted to be Set at the Upstream Port. If any L1 PM Substates enable
>>>> > bit is at a later time to be cleared, the enable bit(s) must be cleared in the Upstream Port
>>>> > before the corresponding enable bit(s) are permitted to be cleared in the Downstream Port.
>>>> >
>>>
>>>Thanks for bringing to attention. My understanding / interpretation of
>>>"Downstream port" was the port pointing downwards (from the "Upstream"
>>>component). E.g. when an EP connects to a hub port, PCIe text refers
>>>to the hub port as the "downstream port". Similarly "upstream port" is
>>>used for referring to a switch's port that "points" upwards towards
>>>the root port. Thus, I interpreted the text to mean that I need to
>>>enable it in the "downstream port" (in the root port / switch port)
>>>followed by the "upstream port" (in the device).
>>>
>>>It would have been great if the PCIe spec was as clear for L1
>>>substates as it was for L1:
>>>----------------------------
>>>ASPM L1 must be enabled by software in the Upstream
>>>component on a Link prior to enabling ASPM L1 in the
>>>Downstream component on that Link.
>>>-----------------------------
>>>For ASPM L1, the spec clearly says "Upstream component" which can only
>>>mean the switch's "downstream" port. I'm open to changing it if there
>>>is consensus that my interpretation is wrong.
>>
>> In fact, Your understanding seems to be correct. It was my mistake that I raised it without
>> actually, keeping in mind or understanding port/component difference which I didn't notice.
>> My sincere apologies for that.
>
>No worries, yes, it is tricky and even I had missed it when I
>implemented it first. :-)
>
>>
>>>
>>>I'm actually not sure if I understood what is the problem that is
>>>being seen with L1 PM substates. Can you please elaborate?
>>>
>>
>>
>> The actual problem, what Sinan and me were seeing with ASPM L1 with POLICY_DEFAULT
>> as described in https://patchwork.kernel.org/patch/9548321/
>
>OK, I understood this problem that you are trying to solve. Lets call
>this problem (1). Sorry, I haven't yet looked at your patches, and I
>will take a look.
>
>>
>> Sinan worked out patches to resolve the issue but on my platform now I am starting to see
>> that ASPM L1SS gets impacted by these patches.
>
>OK, lets call this problem (2) - are you saying that this only impacts
>L1SS and not L1? Sorry, just trying to understand because I can't
>think of anyway L1 and L1SS bits are handled differently..
>

Actually, in my platform, BIOS configures ASPM L1 if no EP found during boot on Root Port but
L1SS does not get enabled during boot on Root Port if no device found during boot. So it's bit different.


>> Basically, with his patches, when Policy is set to default,
>> and if no PCIe EP is connected to Root Port during boot up, BIOS does not configure L1SS for it, on my
>> platform. So the link->aspm_default in aspm.c stores configuration without L1SS.
>
>I understand uptil here:
>No Device on boot, ASPM Policy=default => BIOS does not enable any
>ASPM bits => kernel does the same.
>
>> When the EP gets
>> connected afterwards, due to link->aspm_default set to non L1SS configuration, even if BIOS
>> sets ASPM L1SS for Root Port and Endpoint both,
>
>Sorry, I don't think I followed this part. You are saying when the EP
>gets hot-plugged later (after booting up with no EP), the BIOS sets
>ASPM L1SS for root port & endpoint at that time??
>

Yes when EP gets connected at any time(i.e. during boot or after boot), BIOS sets L1 and L1SS both for Root Port and Endpoint.

>> it gets cleared in the aspm driver.
>>
>> Without the patches Sinan has worked, it was a different issue as described above, and L1/L1SS were
>> getting always enabled by the BIOS for endpoint and RP, but kernel enabled/disabled them alternatively.
>>
>> So basically, I am not currently 100% sure, what is the proper fix for this. Whether BIOS should
>> enable L1SS on Root Port no matter Endpoint is connected or not during boot?
>
>I'd think not.
>
>While I don't understand the problem (2) currently, wouldn't you face
>the same problem (2) with L1? Are you seeing L1 & L1SS bits handled
>differently in your use case / problem case?
>

Yes it is indeed, only during boot without Endpoint connected (L1 is set on Root port but L1SS is not).

>Thanks,
>
>Rajat
>
>>
>> Or I am not sure, whether could we should still update link->aspm_default partly for L1SS in the old patch way
>> https://patchwork.ozlabs.org/patch/736771/
>>
>> Any feedback would be helpful then may be if required I can or if Sinan can work out the patches for L1SS also fine for me.
>>
>>
>>>
>>>>
>>>>
>>>> Thanks for testing.
>>>>
>>>> commit a142f4d3e5c54db5e942fa6ee5f3dc0e8c83207b
>>>> Author: Rajat Jain <rajatja@google.com>
>>>> Date:   Mon Jan 2 22:34:15 2017 -0800
>>>>
>>>>     PCI/ASPM: Add comment about L1 substate latency
>>>>
>>>>     Since the exit latencies for L1 substates are not advertised by a device,
>>>>     it is not clear in spec how to do a L1 substate exit latency check.  We
>>>>     assume that the L1 exit latencies advertised by a device include L1
>>>>     substate latencies (and hence do not do any check).  If that is not true,
>>>>     we should do some sort of check here.
>>>>
>>>>     (I'm not clear about what that check should like currently. I'd be glad to
>>>>     take up any suggestions).
>>>>
>>>>     Signed-off-by: Rajat Jain <rajatja@google.com>
>>>>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>
>>>> I added Rajat for discussion on L1SS. I think this deserves its own discussion.
>>>
>>>Thanks, The above commit specifically adds a comment to
>>>pcie_aspm_check_latency(), because I wanted to leave a note
>>>highlighting that potentially, we could add a more stringent check for
>>>exit latency for L1SS. But that has nothing to do with how we are
>>>configuring or enabling / disabling the L1 substates.
>>>
>>>Thanks & Best Regards,
>>>
>>>Rajat
>>>
>>>> I'll look at the other part of your email and move things around a little bit
>>>> less aggressively for the aspm_default.
>>>>
>>>>
>>>> --
>>>> Sinan Kaya
>>>> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
>>>> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
>> Intel Deutschland GmbH
>> Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
>> Tel: +49 89 99 8853-0, www.intel.de
>> Managing Directors: Christin Eisenschmid, Christian Lamprechter
>> Chairperson of the Supervisory Board: Nicole Lau
>> Registered Office: Munich
>> Commercial Register: Amtsgericht Muenchen HRB 186928
Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
