Received: from mail-m49201.qiye.163.com (mail-m49201.qiye.163.com [45.254.49.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D179E32C929;
	Wed, 11 Feb 2026 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770795151; cv=none; b=K7DDQ6VvB7k+2GEeGl9452QNUxqQYDpckXjTTJANod6YRsikW901zfnBWlVBxMyFxZw25m9GDcBiVnkAtIXvs9TppGB4NGmjVfVR3zq/bNRX9ZfoD5aj1ylz7gv4kBToqU3BVDRJCLu/ALwr+/+KG90+hRxRG7b6KKvDL2sPKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770795151; c=relaxed/simple;
	bh=41FlcwNioZ88g31eXuDyQVh3Dqp0ef6QyLPNmyndQdQ=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YgoDWL2BGm5dfap+1yXaOGkoS7wjthXVXo2knlgqn5rgsZYQFyFL0tZUeEP+kvGsjDAZbVTwWxsFSJTUXLMojHp8dFzm1a8UQH3E+RziC58dilO1upE+450hF3ywr4Tb/MgvbjhwTEYCekFuPpWd3a7SGFFzdIHTBcw1tg1oo74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ame38AOD; arc=none smtp.client-ip=45.254.49.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ame38AOD"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 33d65732f;
	Wed, 11 Feb 2026 15:27:12 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] Documentation: PCI: Clarify pci_free_irq_vectors() usage
 for managed devices
To: phasta@kernel.org
References: <20260206223304.GA99007@bhelgaas>
 <5fb5bc0ecbd4f51791b6c330088879588a1518ac.camel@mailbox.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <68347b24-fb59-eece-2b48-0fd90917c75b@rock-chips.com>
Date: Wed, 11 Feb 2026 15:27:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5fb5bc0ecbd4f51791b6c330088879588a1518ac.camel@mailbox.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c4b98d09109cckunm8a859971d6021
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ04ZGFYZQkhPGR9DTU5MQklWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ame38AODlW5B+VxaoNlZ1HjbV6FATMDpX46nJY6FMcrGxlEGqtd5a1JgLW5+/3lIECDDp8RyzJabDRfWk6Ls9YH4hN+Eienu4HAZNhIKdMt7TLlaHqrMZpKn02GRfzCOYH5uw5ROcqd1HVdGUG7QuQpdyiBESbZCW0DD6yJP+hU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=lHoajEgjenqD27eClZ8ttgA/7VF9D+tkev7LFV+E/XM=;
	h=date:mime-version:subject:message-id:from;

在 2026/02/09 星期一 16:05, Philipp Stanner 写道:
> On Fri, 2026-02-06 at 16:33 -0600, Bjorn Helgaas wrote:
>> [+cc Philipp, any comment? would like your ack if possible]
> 
> The patch is a good idea and desirable. I think, however, that it
> should be a series with a second patch informing about this behavior in
> pci_free_irq_vectors() docu, too. I think that more people read
> function API documentation than the generated full docs, especially
> when hacking something together quickly.
> 
>>
>> On Mon, Jan 26, 2026 at 10:57:13AM +0800, Shawn Lin wrote:
>>> Update the msi-howto.rst documentation to clarify that drivers using the
>>> resource-managed function pcim_enable_device()
>>>
> 
> pcim_enable_device() can be called a "resource-managed function"
> because itself is managed in the sense of it setting up a consequence
> for its own actions, which is automatic device-enablement. I.e., after
> calling it, calling pci_disable_device() becomes obsolete.
> 
> That's, however, not decisive here. What is decisive is that it also
> switches those MSI functions into "hybrid mode" so that they suddenly
> have side-effects. So pcim_enable_device() does *two* things.
> 
> Depending on what you want to achieve with your detailed commit
> message, you might want to point that out. Some inspiration might come
> from my commits in various drivers. To make it bullet proof, I would
> say sth like:
> 
> "For legacy reasons, pcim_enable_device() switched several, normally
> un-managed, functions into managed mode. Since various cleanups, the
> only function affected in such a way by pcim_enable_device() today are
> callers of pcim_setup_msi_release(). This behavior is dangerous and
> confusing and should be removed from the kernel."
> 
> depending on how verbose you want to be. This could be merged with the
> below, of course.
> 
>>>   must not call pci_free_irq_vectors().
>>> This is because such devices have automatic IRQ vector management via pcim_msi_release(),
>>> which is registered by pci_setup_msi_context() when pdev->is_managed is true.
> 
> There is unfortunately also pdev->is_msi_managed in addition to
> is_managed.
> 
> I think you don't need to hint at the internal implementation in the
> commit message – but a separate patch with a code TODO in pci/msi/msi.c
> where you point out that this is broken and should be removed sounds
> like a good idea to me.
> 
> Could also be put on a PCI TODO list if there is one (Bjorn?)
> 
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>> ---
>>>
>>>   Documentation/PCI/msi-howto.rst | 7 +++++--
>>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-howto.rst
>>> index 667ebe2..dc85f1e 100644
>>> --- a/Documentation/PCI/msi-howto.rst
>>> +++ b/Documentation/PCI/msi-howto.rst
>>> @@ -113,8 +113,11 @@ vectors, use the following function::
>>>   
>>>     int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
>>>   
>>> -Any allocated resources should be freed before removing the device using
>>> -the following function::
>>> +If the driver enables the device using the resource-managed function
>>> +pcim_enable_device(),
> 
> Same, "resource-managed" is not the decisive criterium. I would simply
> state "pcim_enable_device() activates automatic management for IRQ
> vectors".
> 
> (I'm a bit nitty; here it's not that important, but in the commit
> message I would address this).
> 
> 
> You can keep me on Cc, I can do a review for the next revision.
> 

Thanks for these helpful review, will work on v2.

> And thanks for picking this up!
> 
> Philipp
> 
>>>   the driver shouldn't call pci_free_irq_vectors()
>>> +because the IRQ vectors are automatically managed. Otherwise, the driver
>>> +should free any allocated IRQ vectors before removing the device using the
>>> +following function::
>>>   
>>>     void pci_free_irq_vectors(struct pci_dev *dev);
>>>   
>>> -- 
>>> 2.7.4
>>>
> 
> 
> 
