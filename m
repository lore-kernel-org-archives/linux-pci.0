Return-Path: <SRS0=T4LS=ML=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE276C43143
	for <linux-pci@archiver.kernel.org>; Sat, 29 Sep 2018 21:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E7B20880
	for <linux-pci@archiver.kernel.org>; Sat, 29 Sep 2018 21:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E7B20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rockbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeI3DhM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 29 Sep 2018 23:37:12 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:59118 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbeI3DhL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 29 Sep 2018 23:37:11 -0400
Received: from smtp1.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 0D05E490D6;
        Sat, 29 Sep 2018 23:07:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id m_t92aZELB9q; Sat, 29 Sep 2018 23:07:06 +0200 (CEST)
Subject: Re: [PATCH v3] PCI: Reprogram bridge prefetch registers on resume
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Daniel Drake <drake@endlessm.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, linux@endlessm.com,
        nouveau@lists.freedesktop.org, linux-pm@vger.kernel.org,
        peter@lekensteyn.nl, kherbst@redhat.com,
        andy.shevchenko@linux.intel.com, rafael.j.wysocki@intel.com,
        keith.busch@intel.com, jonathan.derrick@intel.com,
        davem@davemloft.net, hkallweit1@gmail.com, netdev@vger.kernel.org,
        nic_swsd@realtek.com, rchang@marvell.com,
        linux-kernel@vger.kernel.org
References: <20180913033745.11178-1-drake@endlessm.com>
 <20180918213244.GE13616@bhelgaas-glaptop.roam.corp.google.com>
 <20180927205247.GA18434@bhelgaas-glaptop.roam.corp.google.com>
From:   Thomas Martitz <kugel@rockbox.org>
Organization: Rockbox
Message-ID: <3f8efcd6-7cd2-b41a-d984-28c9e1740d6c@rockbox.org>
Date:   Sat, 29 Sep 2018 23:06:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180927205247.GA18434@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 27.09.18 um 22:52 schrieb Bjorn Helgaas:
> [+cc LKML]
> 
> On Tue, Sep 18, 2018 at 04:32:44PM -0500, Bjorn Helgaas wrote:
>> On Thu, Sep 13, 2018 at 11:37:45AM +0800, Daniel Drake wrote:
>>> On 38+ Intel-based Asus products, the nvidia GPU becomes unusable
>>> after S3 suspend/resume. The affected products include multiple
>>> generations of nvidia GPUs and Intel SoCs. After resume, nouveau logs
>>> many errors such as:
>>>
>>>      fifo: fault 00 [READ] at 0000005555555000 engine 00 [GR] client 04
>>>            [HUB/FE] reason 4a [] on channel -1 [007fa91000 unknown]
>>>      DRM: failed to idle channel 0 [DRM]
>>>
>>> Similarly, the nvidia proprietary driver also fails after resume
>>> (black screen, 100% CPU usage in Xorg process). We shipped a sample
>>> to Nvidia for diagnosis, and their response indicated that it's a
>>> problem with the parent PCI bridge (on the Intel SoC), not the GPU.
>>>
>>> Runtime suspend/resume works fine, only S3 suspend is affected.
>>>
>>> We found a workaround: on resume, rewrite the Intel PCI bridge
>>> 'Prefetchable Base Upper 32 Bits' register (PCI_PREF_BASE_UPPER32). In
>>> the cases that I checked, this register has value 0 and we just have to
>>> rewrite that value.
>>>
>>> Linux already saves and restores PCI config space during suspend/resume,
>>> but this register was being skipped because upon resume, it already
>>> has value 0 (the correct, pre-suspend value).
>>>
>>> Intel appear to have previously acknowledged this behaviour and the
>>> requirement to rewrite this register.
>>> https://bugzilla.kernel.org/show_bug.cgi?id=116851#c23
>>>
>>> Based on that, rewrite the prefetch register values even when that
>>> appears unnecessary.
>>>
>>> We have confirmed this solution on all the affected models we have
>>> in-hands (X542UQ, UX533FD, X530UN, V272UN).
>>>
>>> Additionally, this solves an issue where r8169 MSI-X interrupts were
>>> broken after S3 suspend/resume on Asus X441UAR. This issue was recently
>>> worked around in commit 7bb05b85bc2d ("r8169: don't use MSI-X on
>>> RTL8106e"). It also fixes the same issue on RTL6186evl/8111evl on an
>>> Aimfor-tech laptop that we had not yet patched. I suspect it will also
>>> fix the issue that was worked around in commit 7c53a722459c ("r8169:
>>> don't use MSI-X on RTL8168g").
>>>
>>> Thomas Martitz reports that this change also solves an issue where
>>> the AMD Radeon Polaris 10 GPU on the HP Zbook 14u G5 is unresponsive
>>> after S3 suspend/resume.
>>>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=201069
>>> Signed-off-by: Daniel Drake <drake@endlessm.com>
>>
>> Applied with Rafael's and Peter's reviewed-by to pci/enumeration for v4.20.
>> Thanks for the the huge investigative effort!
> 
> Since this looks low-risk and fixes several painful issues, I think
> this merits a stable tag and being included in v4.19 (instead of
> waiting for v4.20).
> 
> I moved it to for-linus for v4.19.  Let me know if you object.


The latest iteration does not work on my HP system. The GPU fails to 
power up just like the unpatched kernel.

[  516.833580] amdgpu 0000:01:00.0: Refused to change power state, 
currently in D3
[  516.912885] amdgpu 0000:01:00.0: Refused to change power state, 
currently in D3
[  516.929175] amdgpu 0000:01:00.0: Refused to change power state, 
currently in D3
[  521.932435] [drm:atom_op_jump] *ERROR* atombios stuck in loop for 
more than 5secs aborting
[  521.932440] [drm:amdgpu_atom_execute_table_locked] *ERROR* atombios 
stuck executing C392 (len 62, WS 0, PS 0) @ 0xC3AE
[  521.932442] [drm:amdgpu_atom_execute_table_locked] *ERROR* atombios 
stuck executing ADB8 (len 140, WS 0, PS 8) @ 0xADD3
[  521.932444] [drm:amdgpu_device_resume] *ERROR* amdgpu asic init failed
[  522.883309] amdgpu 0000:01:00.0: Wait for MC idle timedout !
[  523.831676] amdgpu 0000:01:00.0: Wait for MC idle timedout !
[  523.832931] [drm] PCIE GART of 256M enabled (table at 
0x000000F400000000).
[  523.836807] amdgpu: [powerplay] Failed to send Message.
[  523.836862] amdgpu: [powerplay] SMC address must be 4 byte aligned.
[  523.836863] amdgpu: [powerplay] [AVFS][Polaris10_SetupGfxLvlStruct] 
Problems copying VRConfig value over to SMC
[  523.836864] amdgpu: [powerplay] [AVFS][Polaris10_AVFSEventMgr] Could 
not Copy Graphics Level table over to SMU
[  523.836908] amdgpu: [powerplay]
                 last message was failed ret is 65535
[  523.836924] amdgpu: [powerplay]
                 failed to send message 252 ret is 65535
[  523.836949] amdgpu: [powerplay]
                 last message was failed ret is 65535
[  523.836965] amdgpu: [powerplay]
                 failed to send message 253 ret is 65535
[  523.836989] amdgpu: [powerplay]
                 last message was failed ret is 65535
[  523.837006] amdgpu: [powerplay]
                 failed to send message 250 ret is 65535
[  523.837029] amdgpu: [powerplay]
                 last message was failed ret is 65535
[  523.837045] amdgpu: [powerplay]



> 
>>> ---
>>>   drivers/pci/pci.c | 25 +++++++++++++++++--------
>>>   1 file changed, 17 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index 29ff9619b5fa..5d58220b6997 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -1289,12 +1289,12 @@ int pci_save_state(struct pci_dev *dev)
>>>   EXPORT_SYMBOL(pci_save_state);
>>>   
>>>   static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
>>> -				     u32 saved_val, int retry)
>>> +				     u32 saved_val, int retry, bool force)
>>>   {
>>>   	u32 val;
>>>   
>>>   	pci_read_config_dword(pdev, offset, &val);
>>> -	if (val == saved_val)
>>> +	if (!force && val == saved_val)
>>>   		return;
>>>   
>>>   	for (;;) {
>>> @@ -1313,25 +1313,34 @@ static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
>>>   }
>>>   
>>>   static void pci_restore_config_space_range(struct pci_dev *pdev,
>>> -					   int start, int end, int retry)
>>> +					   int start, int end, int retry,
>>> +					   bool force)
>>>   {
>>>   	int index;
>>>   
>>>   	for (index = end; index >= start; index--)
>>>   		pci_restore_config_dword(pdev, 4 * index,
>>>   					 pdev->saved_config_space[index],
>>> -					 retry);
>>> +					 retry, force);
>>>   }
>>>   
>>>   static void pci_restore_config_space(struct pci_dev *pdev)
>>>   {
>>>   	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
>>> -		pci_restore_config_space_range(pdev, 10, 15, 0);
>>> +		pci_restore_config_space_range(pdev, 10, 15, 0, false);
>>>   		/* Restore BARs before the command register. */
>>> -		pci_restore_config_space_range(pdev, 4, 9, 10);
>>> -		pci_restore_config_space_range(pdev, 0, 3, 0);
>>> +		pci_restore_config_space_range(pdev, 4, 9, 10, false);
>>> +		pci_restore_config_space_range(pdev, 0, 3, 0, false);
>>> +	} else if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>>> +		pci_restore_config_space_range(pdev, 12, 15, 0, false);
>>> +		/* Force rewriting of prefetch registers to avoid
>>> +		 * S3 resume issues on Intel PCI bridges that occur when
>>> +		 * these registers are not explicitly written.
>>> +		 */
>>> +		pci_restore_config_space_range(pdev, 9, 11, 0, true);
>>> +		pci_restore_config_space_range(pdev, 0, 8, 0, false);
>>>   	} else {
>>> -		pci_restore_config_space_range(pdev, 0, 15, 0);
>>> +		pci_restore_config_space_range(pdev, 0, 15, 0, false);
>>>   	}
>>>   }
>>>   
>>> -- 
>>> 2.17.1
>>>

