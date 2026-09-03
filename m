Received: from mail-m3284.qiye.163.com (mail-m3284.qiye.163.com [220.197.32.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44FC46A5EB
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426150; cv=none; b=sA99C2XIRBvDYTdRpY0AXOy7WPOT0bz1x+S6czjd9FViyYRfwN+Dx3X2RoJPbCJnnSo3vkn9ekEtmGu0YHTPkFdk7Rd8VgFc4wdLFOer1X8o+1Fi4hI74GkBMgtWgAYR81KsDr8LXVi4tX4ZAVTqiE0cqYtHDwWV+4xz8WMS638=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426150; c=relaxed/simple;
	bh=+xhlkyyUMGQGdG5rZCfQX+1NidOn/t+7KHSC2MKrWco=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hgyp9zaGIMKvby/NPJqa7bx8QAhE/yUM8WApMZMuTT+hIzw1pPBnlInzJQ7P2LOgZ9plhH472TMoo/ANHME+7LvGZ/MzSpWCORAUvhQfPumy4DP/1mNuKR/d4zyMCE9Pck0juHGaV6wkhZ60K8A9Q+cs3j+mMZBe9DQbedGL3s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jaamjoFU; arc=none smtp.client-ip=220.197.32.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jaamjoFU"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c64fdfbf;
	Thu, 3 Sep 2026 16:26:51 +0800 (GMT+08:00)
Message-ID: <aa7c0d0b-7522-40e4-9249-4cf220fce3b7@rock-chips.com>
Date: Thu, 3 Sep 2026 16:26:50 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivam <mani@kernel.org>, linux-rockchip@lists.infradead.org,
 linux-pci@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH 0/2] Two small INTx fixes for Rockchip's dwc based PCIe
 controller driver
To: Niklas Cassel <cassel@kernel.org>
References: <1788403477-71491-1-git-send-email-shawn.lin@rock-chips.com>
 <apktsxxgZ3yFclo0@ryzen>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <apktsxxgZ3yFclo0@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa06660c06b03a4kunm327acd4f9a4d1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSE9IVh8ZSk8fSR1OHUMYTFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=jaamjoFUreTM837YI2TiFdKX4zFjHp4FDU4+iM2jOSmW2cyUwPrFsBafMj14Xg8Ym+itKEJDQEFLt6DRkmEyK1tBl4JmzlrH6Dz4GSljNajtb+JQHvy1fltoVtwBcdfvinSAIR4r7uvUCRrD+QBuHAlFLcYBVk6jsxSkOVJ/heI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=/UhlaAB1/S1eXNI2E1Gi/N3a6HvqV7vxHRIaDiB8rOw=;
	h=date:mime-version:subject:message-id:from;

在 2026/09/03 星期四 16:20, Niklas Cassel 写道:
> Hello Shawn,
> 
> On Thu, Sep 03, 2026 at 10:44:35AM +0800, Shawn Lin wrote:
>>
>> This small series fixes two INTx related issues in the Rockchip
>> DesignWare PCIe controller driver.
>>
>> Note that patch 2 depends on b376b3ff9cb0 which is not yet in Linus'
>> tree, so this series is based on linux-next.
> 
> $ git tag --contains b376b3ff9cb0
> v7.3-rc1
> 
> FWIW, the commit you are referencing is in Linus' tree already.

Ah, a few days ago I didn't send out the patch in time, but now it is 
indeed on Linus' tree.

Thanks.

> 
> 
> Kind regards,
> Niklas
> 

