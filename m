Received: from mail-m3268.qiye.163.com (mail-m3268.qiye.163.com [220.197.32.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F843ED13B;
	Wed, 21 Jan 2026 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000473; cv=none; b=PYJ3W8TclO5kJlhoYVxBxAxeucVatQ3KF4WoH5U61gfh3cQ1UUpsFh8j7Hb/9n57mOAzu+ZVEgYpuN0I1U18pkNSTBLlkL++Qvlr/N20EhCe/WjY/e3dxE1aLUBWMIVwI4oC6+xPBnBB4iLK6sJsormBfx9sjFlPkk9A5oIyh5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000473; c=relaxed/simple;
	bh=ZznB9KOxo0AHHc6Xpk9drCHr1+KkAVkWW4MIhGms3Jw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h7nfv73PcvQkDHPFYaI7C7p+855Lx+WEYunxXENUEE9biIfwHbwJ00lEFT52Mocov1S67rrfBUD8BkMXKYNZ5nW5YaJgyy4Gn2nvUnnQAGT29DIeLdCz4swcqdMA7PHBfZkg+IZjRG/YcK1ddDG4mGQKigImgitolUbmGQRVdJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=N5B9KpEA; arc=none smtp.client-ip=220.197.32.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="N5B9KpEA"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3175a674a;
	Wed, 21 Jan 2026 20:45:41 +0800 (GMT+08:00)
Message-ID: <b7d7ae6b-d0e7-47f2-ac84-8b0fdb395a59@rock-chips.com>
Date: Wed, 21 Jan 2026 20:45:39 +0800
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
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aVezfq-8bTKczYkp@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9be096db9609cckunma39f61b2640a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0IeSlZLQ0JMThoYTkMaSE1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=N5B9KpEAWyeF+bGavcuyHSkoAb7YOfkM9DYUik6+pE/6b5TFYuxc0IfT9s7KGOkvwYHjnGvPwasUNsxTEakDji9VSxcbkZ6f/iS7aYVqJWG5wzQOiLynnvLcYqXO+jIaw13kOD9R9sntpLERh2o9zDLhNCdqV5DAj22mOFHgSUM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=szzBGuvFEu3riennh9dSaxRNqjIE5L8uqI/r5LTXaZU=;
	h=date:mime-version:subject:message-id:from;


在 2026/01/02 星期五 20:01, Niklas Cassel 写道:
> On Tue, Dec 30, 2025 at 08:37:31PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
>> Hi,
>>
>> This series reworks the dw_pcie_wait_for_link() API to allow the callers to
>> detect the absence of the device on the bus and skip the failure.
>>
>> Compared to v2, I've reworked the patch 2 to improve the API further and
>> dropped the patch 1 that got applied (hence changed the subject). I've also
>> modified the error code based on the feedback in v2 to return -ENODEV if device
>> is not detected on the bus and -ETIMEDOUT otherwise. This allows the callers to
>> skip the failure if device is not detected and handle error for other failure.
>>
>> Testing
>> =======
>>
>> Tested this series on Rb3Gen2 board without powering on the PCIe switch. Now the
>> dw_pcie_wait_for_link() API prints:
>>
>> 	qcom-pcie 1c08000.pcie: Device not found
>>
>> Instead of the previous log:
>>
>> 	qcom-pcie 1c08000.pcie: Phy link never came up
> 
> Hello Mani,
> 
> I really like this series.
> 
> However when testing my usual setup with 2 Rock 5B:s, one in EP mode, one
> in RC mode, where I usually power on both boards at the same time, but only
> after both boards are booted, do I do the configfs write to enable the link
> training on EP, and then do a rescan on the RC.
> 
> Even with this series, this workflow still works in 8 out of 10 boots.
> 
> 
> However, in 2 out of 10 boots I instead got:
> [    2.285827] rockchip-dw-pcie a40000000.pcie: Link failed to come up. LTSSM: POLL_COMPLIANCE
> [    2.286584] rockchip-dw-pcie a40000000.pcie: probe with driver rockchip-dw-pcie failed with error -110
> 
> In both cases LTSSM was in POLL_COMPLIANCE.
> 
> 
> Considering that things work in 8 out of 10 boots, means that the LTSSM state
> was in Detect.Quiet or Detect.Active.
> 
> I did comment out goto err_stop_link if dw_pcie_wait_for_link(), so I can dump
> LTSSM afterwards, when this happens.
> 
> [    2.293785] rockchip-dw-pcie a40000000.pcie: Link failed to come up. LTSSM: POLL_COMPLIANCE
> 
> Then I do:
> 
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_COMPLIANCE (0x03)
> 
> So LTSSM is still in Poll.Compliance.
> 
> However, as soon as I do the configfs writes on the EP board:
> 
> 
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> L0 (0x11)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> L0 (0x11)
> 
> LTSSM transitions out of compliance, and rescan will find my device:
> 
> # echo 1 > /sys/bus/pci/devices/0000:00:00.0/rescan
> [  246.777867] pci 0000:01:00.0: [1d87:3588] type 00 class 0xff0000 PCIe Endpoint
> [  246.778627] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000fffff]
> [  246.779151] pci 0000:01:00.0: BAR 1 [mem 0x00000000-0x000fffff]
> [  246.779672] pci 0000:01:00.0: BAR 2 [mem 0x00000000-0x000fffff]
> [  246.780192] pci 0000:01:00.0: BAR 3 [mem 0x00000000-0x000fffff]
> [  246.780716] pci 0000:01:00.0: BAR 5 [mem 0x00000000-0x000fffff]
> [  246.781236] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> 
> 
> 
> I understand that in most normal situations, the endpoint is powered on
> before powering on the host side (or there is no EP connected at all).
> But somehow, for us PCIe endpoint developers, it would be nice if we
> could keep the behavior of being able to rescan the bus, even when the EP
> is not powered on before the host side.
> 
> Perhaps a Kconfig or module param? Suggestions?
> 

Hi Niklas,

Sorry for chiming in on this so late. There is a register called
PCIE_CLIENT_GENERAL_DEBUG_CON you may find on RK3588 TRM, you could
hold LTSSM on EP side in DETECT_QUIET before enabling trainning, by
setting BIT(6). And when EP side is ready to go, just clear BIT(6),
so the link is able to be established and host side can rescan to
find the EP properly.
	


> 
> Kind regards,
> Niklas
> 

