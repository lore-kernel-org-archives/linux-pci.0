Received: from mail-m19731115.qiye.163.com (mail-m19731115.qiye.163.com [220.197.31.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CA42D2495
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 02:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776826653; cv=none; b=KAfkZjAoE/l4+7A0Pyg3KFW/+G6FyZs9DTfPJRcqnTdyqzOaeq1Bc25iK9Nm+ZLg3IImT5GcNuuUHcEriAbkuuatWvE59RO+JMxTRoTmqLsAutSQdxgErc2Q/31cAOVttlYGcC3HE+1qI13qcyS+h78+kVe7UzNajPh8JtXndxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776826653; c=relaxed/simple;
	bh=2B4w35GtL9z7YSKWMQwRgmGH8qdtgdF1Pp92YtZYAi0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OKHvRejWy7CdF5SwBj/gSvcSkwJ9mCSwBtFXD3/KGuhYH0ZNmix/5KFq9Kz0FxcfTC/KTVuXmmq7qEbbb0T6Eov3AwG44yRta/tr3tAUe0hzqG5eyL5DV/nc5WMiWkSz0gTlqq3PkCeabg0jRdRh9qyqw9JS6uAe/qUKLtTe7Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=b7CDvHiB; arc=none smtp.client-ip=220.197.31.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="b7CDvHiB"
Received: from [172.16.12.17] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3ba45a8e4;
	Wed, 22 Apr 2026 10:42:00 +0800 (GMT+08:00)
Message-ID: <aed1f6ae-543b-c3de-8dcc-45ad28234127@rock-chips.com>
Date: Wed, 22 Apr 2026 10:42:00 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: shawn.lin@rock-chips.com, Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Logan Gunthorpe <logang@deltatee.com>, Philipp Stanner <phasta@kernel.org>,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add Devres managed IRQ vectors allocation
To: Bjorn Helgaas <bhelgaas@google.com>
References: <1776821127-234830-1-git-send-email-shawn.lin@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <1776821127-234830-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9db310de8809cckunmebabe8cd16e8c9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGkxPVktNQh8fGE9ITU4eTFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=b7CDvHiB8rGLvA60mPpXkipn+NMl6Bwyjiq2qpZvEeclP042aQIDwukWb2VBGQ7VOOPp06Y9dQsUiOIcr/gcUxecJmzJo60D0PBuYpmj76ExiH0Z41RRoJ+N7xrLfpkUlxa5mfm+zMQU/cOrA9wbmmoS604YD8+TPjFdm48SVqU=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=CwGfpgukQvI/lK4JOSDnxUsx/L8Vk1WTkVon+cdP3Eo=;
	h=date:mime-version:subject:message-id:from;

在 2026/04/22 星期三 9:25, Shawn Lin 写道:
> There is a long-standing design issue in the PCI/MSI subsystem where the
> implicit, automatic management of IRQ vectors by the devres framework

Sorry, there seems something wrong with my local mail settings, so I
resent the v3 series.

> 
