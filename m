Received: from mail-m49206.qiye.163.com (mail-m49206.qiye.163.com [45.254.49.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA8C3E9F7C;
	Thu, 22 Jan 2026 03:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769053061; cv=none; b=PXjerQHXW9IpZhln77GiwfaqWvjoJt5gvhFKebapqcWQJvUcDUZ4mj6YmoYKK1Yg4lDtF+DwntoVrx2lTNoAahQjlfMA/hPqA1Luy1CFmLZOdZNnwJZUmM5MP3LerNG81j08x7D1JGvG/X+CcNsjcUylDBJCOiIj4Z13eXUFeZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769053061; c=relaxed/simple;
	bh=FUoCDXEiaRWm2fMs0gL8r1ttELNf4t9E0RbpNIFrhzk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h8SJD47g1WMsDpP8e5wmiw5jzyQj3uEGw2QExA0mdmXR5jVH2ENlU/Q2rp/cy7nXEWmYpzgA/KUiWlgJMYM/EACQhJ8KUEDKf0aTM5tDn+8AkNnX+4RCrBLf6T3u3I4axRJRHcXmqAQaLJIEZftE6+nz1e5sWqMbM1CP1uWtszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=LFzgy5S6; arc=none smtp.client-ip=45.254.49.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="LFzgy5S6"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3188d8629;
	Thu, 22 Jan 2026 11:37:24 +0800 (GMT+08:00)
Message-ID: <ea1b977e-069d-4084-9bf4-d5bd8cd273d5@rock-chips.com>
Date: Thu, 22 Jan 2026 11:37:23 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com,
 dlemoal@kernel.org, manivannan.sadhasivam@oss.qualcomm.com
Subject: Re: [PATCH v3 0/4] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
To: Niklas Cassel <cassel@kernel.org>
References: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>
 <aVezfq-8bTKczYkp@ryzen>
 <b7d7ae6b-d0e7-47f2-ac84-8b0fdb395a59@rock-chips.com>
 <aXDTCQeP3CDv5qv8@ryzen>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aXDTCQeP3CDv5qv8@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9be3c73da809cckunm5443bbe16a1c2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR9CGVZMGkpLGBkdTR1JShhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=LFzgy5S6EkwrryCu1E3CLPpiVTbvq8tAXO/m94eK+M0SqH7ORmYNeJvR8n0Tg59lcc5aHN+nsOyJ2UwLtZmbinPUXqvetOfhFA9T9Qt+/phHseN2vUWrZH4Mm8MGX6gOoxWZYGZypRVffLqZ27r5AVb5Ll/MrkALKLYnjqapXN8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=w73lYkdA/RuL65QGYcGznNf4Js7dRVezdsCF0sV+1E4=;
	h=date:mime-version:subject:message-id:from;



在 2026/01/21 星期三 21:22, Niklas Cassel 写道:
> Hello Shawn,
> 
> On Wed, Jan 21, 2026 at 08:45:39PM +0800, Shawn Lin wrote:
>> 在 2026/01/02 星期五 20:01, Niklas Cassel 写道:
>>
>> Hi Niklas,
>>
>> Sorry for chiming in on this so late. There is a register called
>> PCIE_CLIENT_GENERAL_DEBUG_CON you may find on RK3588 TRM, you could
>> hold LTSSM on EP side in DETECT_QUIET before enabling trainning, by
>> setting BIT(6). And when EP side is ready to go, just clear BIT(6),
>> so the link is able to be established and host side can rescan to
>> find the EP properly.
> 
> Thank you for the suggestion.
> 
> Reading the register description of this debug control register.
> For as log as sd_hold_ltssm is set, the controller stays in the
> current LTSSM.
> 
> We could probably set this on the EP side, and only when starting
> the link do we clear this bit.
> 
> However, I think that Mani's current proposal:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc&id=01d16b8afb7afcc17f999f8b4a9b9cfe6c6fae71
> 
> 
> Will work with more controllers running in EP mode, not just rk3588.
> 
> Also, when powering on both boards at the same time, it is possible that
> the host side driver gets probed before the EP side.
> If the EP side driver has not been probed to set bit sd_hold_ltssm,
> the host will still see a load connected, but link training will fail,
> so it will still jump to Poll.Compliance.
> 
> So AFAICT, Mani's proposal:
> 1) Seems more generic.
> 2) Seems less racy.
> 


Just a update for what I found when playing with the IP
on this topic :)

1. enable PCIE_CAP_ENTER_COMPLIANCE bit for
LINK_CONTROL2_LINK_STATUS2_REG (PCIE_CAP + 0xa0), which forces the RP
into poll.compliance to sumulate this situation, even without devices
connected to the slot.

2. set DIRECT_POLCOMP_TO_DETECT(bit 9) and HOLD_LTSSM(bit 0) to
SD_CONTROL2_REG, and could find it's still in poll.compliance.


3. clr HOLD_LTSSM only, and the LTSMM back to detect.quite and stay
there.

This seems be able to work with dwc with RAS_DES support.But sure,
Mani's approach looks more stright forward and works for all
controllers.


> 
> Kind regards,
> Niklas
> 

