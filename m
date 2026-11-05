Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.150.252.255
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859883;
	b=z4UZyLG0sF7NPk6rioezXlDI3bttBR8tFxxNSbVbu6MuAOM1wf1wGASY7PDRdfaVOMqC
	 6jbMy3tCo9ElAvQfQmbNsSI6kkfJxcIXY/dx0QBKKJIO0sA0W+qTd1tOSQ6J7rOfajJeA
	 1HOFIIc0t+vJCtpRlO+1mdf3JypSydGq1dBb6a+okXSlUvS2lAvTuD4/rmtRrBOJNeeib
	 G4/RtajdHUpuXAQNGEOzcxiWCTrP4a15B2lb+UjiPZX/KL+5sTt8+EZtoKUv5rgLM9HHn
	 zfwh3MxY1rjr8b2uw8DNwVv3wwUNtJaM49Cnbc88e/wRyrk3l9eRV80BWEOjb3c0ZAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859883;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Atmail-Id:
	 X-atmailcloud-spam-action:X-atmailcloud-route;
	bh=hJBpd4KkjRj8+RQGhW1sVcpFG7gcniHHpENlVgG3zqY=;
	b=IK9OaczzmzYnI3YARI+zLyBAuKRKbsMvOAoytWRIp3BrU39B7/OnxKRIXjTQjjAHzVZM
	 dzm53dslIYKLrE91AKtkMNQNys4Hxv1PhchMjP6VqMxbQkKMOrK2EuUvDXw6x2nS8BTcA
	 zvNhcFqnfQCI899xkbamiP4R54Dkx1i9irLn+ENsyiygP9/eFlTkYyqLQMuwy1iMP5r3i
	 qaEjUziBqHx1RJYcZqeQvCZ1L7Jn0zZ6AoQ2XXoK9Kb5KnWXItybxDznmQLVkypWj1kmf
	 5DUVVF4UNS6I1SYWIfKiqT0GOzkprPrBWhZi2UzdvcQvh9tl4dlv5aX2tKkL9itJ6Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=internode.on.net;
	spf=pass smtp.mailfrom=internode.on.net;
	dkim=pass header.d=internode.on.net header.i=@internode.on.net header.a=rsa-sha256 header.s=202309 header.b=UI7deVco;
	arc=none smtp.remote-ip=103.150.252.255
Received: from omr-01.pc5.atmailcloud.com (omr-01.pc5.atmailcloud.com [103.150.252.255])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB135606A31B;
	Thu,  5 Nov 2026 06:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB135606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internode.on.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=internode.on.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=internode.on.net header.i=@internode.on.net header.a=rsa-sha256 header.s=202309 header.b=UI7deVco
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=internode.on.net; s=202309; h=Content-Type:From:To:Subject:MIME-Version:
	Date:Message-ID; bh=hJBpd4KkjRj8+RQGhW1sVcpFG7gcniHHpENlVgG3zqY=; b=UI7deVcoE
	3BtwKcVsem/vkmvG6IQ70dPuZMnUo+ZphMSzolyxjXNyFA1B8+sZ12RJCK1/gcVR1CQX4v15q9YNo
	9gbOmefyVyHy+7R4s9upV1/i27+ujhPUA+qZdCdbH94fMUJfoGeDWLIkTvksWMSrveH7XrwRw5fO7
	rsQftwx9mTLjkMe7NM7kZF1Mso7h2uLHQlbhv2YTW02vpf41ykFryq5J1fetIHbwFqRusXF8vOBoy
	WDZwgDp+tsS7nQ5Io/V7B+Bt2brKb+pDPWsdxtc1JcBiTVYq9yIDIeJINTpneox/IlyKFhHuwxRGV
	UFe7/ngHIe6aVYExoZdvmcFDQ==;
Received: from cmr-tmc.internal.pc5.atmailcloud.com (cmr-tmc.internal.pc5.atmailcloud.com [192.168.1.2]) 
	by omr-01.pc5.atmailcloud.com (Exim/cmr-tmc.i-0248c2ced204c1c85) with ESMTPS
	(envelope-from <arthur.marsh@internode.on.net>)
	id 1xOqti-00000002wTU-1FjL ;
	Thu, 05 Nov 2026 06:24:30 +0000
Received: from 87.121.95.148.v4.dyn.launtel.au ([87.121.95.148] helo=[10.1.1.121])
	 by cmr-tmc.i-0248c2ced204c1c85 with esmtpsa
	(envelope-from <arthur.marsh@internode.on.net>)
	id 1xOqtg-0000000CxmF-0i4N;
	Thu, 05 Nov 2026 06:24:30 +0000
Message-ID: <52e19b20-de2b-4c05-be96-6eb71791eddb@internode.on.net>
Date: Thu, 5 Nov 2026 16:54:19 +1030
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
Subject: Re: [PATCH v2] iommu/amd: Force identity mode for selected GPUs only
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: alexander.deucher@amd.com, bhelgaas@google.com, felix.kuehling@amd.com,
 iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org,
 linux-pci@vger.kernel.org, mario.limonciello@amd.com, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, will@kernel.org
References: <20260824085821.5422-1-vasant.hegde@amd.com>
 <20261105024454.654-1-user@am64>
 <c03d9f24-789a-4f19-b3a1-b189df7b2d2b@amd.com>
Content-Language: en-AU, en-GB
From: Arthur Marsh <arthur.marsh@internode.on.net>
In-Reply-To: <c03d9f24-789a-4f19-b3a1-b189df7b2d2b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Atmail-Id: arthur.marsh@internode.on.net
Authentication-Results: cmr-tmc.au-east.atmailcloud.com; auth=pass smtp.auth=arthur.marsh@internode.on.net
X-atmailcloud-spam-action: 
X-atmailcloud-route: unknown


On 5/11/26 14:02, Vasant Hegde wrote:
> Yeah. Unfortunately this patch introduced a regression. Can you please try below
> patch?
>
> https://lore.kernel.org/linux-iommu/20261103151607.435642-1-jean-christophe@guillain.net/
>
> -Vasant

Thanks, booted OK with the patch applied.

FYI

lspci -nnttv

-[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Family 15h (Models 
10h-1fh) Processor Root Complex [1022:1410]
           +-00.2  Advanced Micro Devices, Inc. [AMD] Family 15h (Models 
10h-1fh) I/O Memory Management Unit [1022:1419]
           +-01.0  Advanced Micro Devices, Inc. [AMD/ATI] Richland 
[Radeon HD 8670D] [1002:990c]
           +-01.1  Advanced Micro Devices, Inc. [AMD/ATI] Trinity HDMI 
Audio Controller [1002:9902]
           +-04.0-[01]----00.0  Realtek Semiconductor Co., Ltd. 
RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller [10ec:8168]
           +-10.0  Advanced Micro Devices, Inc. [AMD] FCH USB XHCI 
Controller [1022:7814]
           +-10.1  Advanced Micro Devices, Inc. [AMD] FCH USB XHCI 
Controller [1022:7814]
           +-11.0  Advanced Micro Devices, Inc. [AMD] FCH SATA 
Controller [AHCI mode] [1022:7801]
           +-12.0  Advanced Micro Devices, Inc. [AMD] FCH USB OHCI 
Controller [1022:7807]
           +-12.2  Advanced Micro Devices, Inc. [AMD] FCH USB EHCI 
Controller [1022:7808]
           +-13.0  Advanced Micro Devices, Inc. [AMD] FCH USB OHCI 
Controller [1022:7807]
           +-13.2  Advanced Micro Devices, Inc. [AMD] FCH USB EHCI 
Controller [1022:7808]
           +-14.0  Advanced Micro Devices, Inc. [AMD] FCH SMBus 
Controller [1022:780b]
           +-14.1  Advanced Micro Devices, Inc. [AMD] FCH IDE Controller 
[1022:780c]
           +-14.3  Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge 
[1022:780e]
           +-14.4-[02]--+-06.0  Creative Labs 
EMU10k2/CA0100/CA0102/CA10200 [Sound Blaster Audigy Series] [1102:0004]
           |            +-06.1  Creative Labs SB Audigy Game Port 
[1102:7003]
           |            \-06.2  Creative Labs SB Audigy FireWire Port 
[1102:4001]
           +-14.5  Advanced Micro Devices, Inc. [AMD] FCH USB OHCI 
Controller [1022:7809]
           +-18.0  Advanced Micro Devices, Inc. [AMD] Family 15h (Models 
10h-1fh) Processor Function 0 [1022:1400]
           +-18.1  Advanced Micro Devices, Inc. [AMD] Family 15h (Models 
10h-1fh) Processor Function 1 [1022:1401]
           +-18.2  Advanced Micro Devices, Inc. [AMD] Family 15h (Models 
10h-1fh) Processor Function 2 [1022:1402]
           +-18.3  Advanced Micro Devices, Inc. [AMD] Family 15h (Models 
10h-1fh) Processor Function 3 [1022:1403]
           +-18.4  Advanced Micro Devices, Inc. [AMD] Family 15h (Models 
10h-1fh) Processor Function 4 [1022:1404]
           \-18.5  Advanced Micro Devices, Inc. [AMD] Family 15h (Models 
10h-1fh) Processor Function 5 [1022:1405]


Regards,

Arthur.

