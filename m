Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.224.83.189
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793061866;
	b=0fWHakblrSm30dCEo5BI3eoYmCPYyVev4NQ4o/2aqlWCKS+7xnGCjyCJp6DRdwQ/UPRh
	 lXhN/eAkJJkOflBUmP70PoJgNYFpnoCr49oVs+AvwD5t7+7KTHgYMwLeCbNzwsbe76hC4
	 z0W8xyFE3Wk1MiyQdrWbSp3N+GK22dyIYE1hXGxeo93yrTw+GTWzhSmYlXgdumHcxtqJW
	 mr9XR1ki7sWke2aLi5gASbryk6qZu3j5CPll5wEZjbsRenf4DZ2YQcBroVfwhyY0NTSzt
	 9RA7yJdjbsIFy+/GCIE7xtXieGCHbTiWFfKZMGnUgmNyCmXjWHJRxDPbaxtDhRNuP6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793061866;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=5/VwNhxDqFDjAFzXiE0EgjT10Of3veuyQvr8j5Q5Fl8=;
	b=J6rYea9syoYaAtkKVZE2/ZG/7LrEoCC5IZWfKHDMytZIIvWXa9GsXpTfCZqNsZTJtM0t
	 k76Uc1I2t8f/Cf2oS1XYGJDYyFo7aL3zRCOqtYGKHKa6RArRhv0iGLsOiresiSH8K6bU0
	 4ZqjFSfoTg1iXjXXsJ5BBr/1qveGJeYTkSLnBDQMptCDYlvmccN702xGey4dcaBuEj1w+
	 f/JD4yTXeNiCvMwFpW/MAxFoNnfkt3hqGZR7aABYdKgkFHSyguJjL50GYWR5OWMwO74O3
	 wUiMrZLoNZ089DuU9Cog5WFh+AMfp97IOAVTJOyMZZkV506FZmfPh+ysBTJMQ7YusJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=DzxT93fh;
	arc=none smtp.remote-ip=156.224.83.189
Received: from mail-m83189.xmail.ntesmail.com (mail-m83189.xmail.ntesmail.com [156.224.83.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F20606A31B;
	Tue, 27 Oct 2026 00:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33F20606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=DzxT93fh
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 526dfc65c;
	Tue, 27 Oct 2026 08:44:12 +0800 (GMT+08:00)
Message-ID: <ff204558-dc22-4d38-b0dc-2c727f983f9f@rock-chips.com>
Date: Tue, 27 Oct 2026 08:44:09 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] PCI: rockchip-host: Retry training and hot-reset
 a JMB585 on RK3399
To: Igor Velkov <iav@iav.lv>
References: <20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv>
 <4316c1da-f7ff-4fa5-a330-512800474e45@rock-chips.com>
 <20261026-rockchip-pcie-shawn-reply-1@iav.lv>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261026-rockchip-pcie-shawn-reply-1@iav.lv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa17ad0966603a4kunmdefc543f472a32
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGkJLVk9LH0IYHUNPSRodQlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=DzxT93fhhkUwadv+bNoSjWR3pa5Fg+2lO5H9x8aSzNv8PZ+Qij6U/dj5xWoWHaGEJ7t4dnDPK6w9r5pe6dQJwgGwOTd768UARevM+xTQPOP53tGaz1hrcKKHOiDtaMitWBQMU76SNQ0Dbod6URXqogHljnpFuJAa1C0tI+KJP2I=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=5/VwNhxDqFDjAFzXiE0EgjT10Of3veuyQvr8j5Q5Fl8=;
	h=date:mime-version:subject:message-id:from;

在 2026/10/27 星期二 2:28, Igor Velkov 写道:
> Hi Shawn,
> 
> On 2026/10/26, Shawn Lin wrote:
>> The host cannot distinguish this case.
> 
> The controller seems to tell before the config read. On 26 Oct the
> link came back 2.9-4.5 ms after a hot reset in ~50 cases, all fine,
> and 10.9-35.4 ms in 8, each followed by an abort on the next config
> read. PCIE_CLIENT_BASIC_STATUS0 read 0x240 after each of 4 slow links
> and 0x1240 after each of 16 fast ones. What does bit 12 mean, and can
> the driver rely on it after link training?
> 

I have no idea about it. The PCIE_CLIENT_BASIC_STATUS0 says:

14:12  	RO  max_payload_size

So you are saying different MPS in different cases, not linking status.


>> You've tried PERST# with the patch 1 applied. So perhaps it's doesn't
>> help.
> 
> Patch 1 pulses PERST# only after a training timeout. With PERST# in
> the DT a slow link still occurred (25 ms, then an abort).
> Re-initializing the port, without PERST# or a power cycle, brought
> each of 4 slow links back in 2.9 ms with the endpoint answering.
> 
>> I've attached a vendor's debug patch, perhaps you could try it without
>> your patch.
> 
> It hooks do_serror() only and registers after pci_host_probe(). Here
> both SErrors and synchronous external aborts occur, at probe and on
> resume (the cover had that wrong), so we will move the hook before
> pci_host_probe() when we try it.

Yep.

> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 

