Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093377;
	b=WuA3p7pba/cr7F+VpFEMU4il1FI3RdrFNN1kV3hkIcSFJbreS+VkXiPcI40FP77VNrWW
	 QPGHSwH0LnLvf0FGGIuR7y4NBmVwGoNOMKz0FfwhMzKE4KA5QzJ4W3r5XTy4/YstoYexn
	 Vmu0mcEdYzR4K3ZxFeaOw7syiECaEjM9ozwiVa31ckWq6z109GABLBII+AaA3FNMNZfw4
	 Rm740/K8nI0TV6O24rLTc77G25u7AqGVNT5NL4zXB4KvAceRR9rxUEG5AmDtTjg43P7LR
	 +now5Szaov79CjT3qh0REQV/dwluRRcI1Gk/niYKVDax9LfoZbRD8K4OlJynSh8PVbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093377;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=uJ+jbNesl0zyJWmm5AGbhu8aLECR9IUEzl02fqLtuyI=;
	b=Q4eZyhYqJjqTNi2DraAquIwT47YmSyaWfbRrp2D+LN7AyXhORNKSLkYi8mnZOwUYsXB1
	 FI9eMEMgiJWIlICakpRW/9ckO8fYLLGt57OjRBnganGREaiouWhzZmrk+oCtiRWDgbpVV
	 oy/PEOLLK5g07lpC2RLL1xfQRQUwZQrpmbwfTM7bCdUBAGkuZGaV/IiDleK5gprrxqjU4
	 GqPXYQeMtQcUniMgDULRdfgeL/a9kH4jt4qiFR6Zx6SszdejNxp+dnH724ci/MatboU65
	 Sn4Zm3tGz8bbATvctXofmyogxkCNkW337cPB6mZdvn42Te+BfGp3wNSPCbbkvpJ+IxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bEqrdyfZ;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCA8606A326;
	Sat,  7 Nov 2026 23:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BCA8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bEqrdyfZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=uJ+jbNesl0zyJWmm5AGbhu8aLECR9IUEzl02fqLtuyI=;
	b=bEqrdyfZr/jKPDPTUt9DU2uVF8QYM35EZyevfCiy6eA81kROV7PEfrA9/vsMqC
	IxniGcqQx5G518/IYpBQg5W+GVc9zhGoTeusXW39OoqvM23pNnMcM+mm0/wK40hl
	fQuIQulZzvP41Dyw6kOyUeZ2ROiv7JlsW7MgAgOiWoQhw=
Received: from [IPV6:240e:b8f:91b3:d000:16e4:53b3:9726:5b67] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD33zcase9qq8xCGQ--.49673S2;
	Sun, 08 Nov 2026 07:15:38 +0800 (CST)
Message-ID: <92679da5-7203-4dbb-b00a-ea8ad51be8cb@163.com>
Date: Sun, 8 Nov 2026 07:15:37 +0800
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
Subject: Re: [PATCH] PCI: dwc: tegra194: Clear event counter masks before
 programming
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, jonathanh@nvidia.com, thierry.reding@kernel.org,
 robh@kernel.org, linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261102063835.3831940-1-18255117159@163.com>
 <179408823130.65886.4565928376292834631.b4-reply@b4>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <179408823130.65886.4565928376292834631.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD33zcase9qq8xCGQ--.49673S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyfKr48GF1xtw43Zr1kXwb_yoWkArc_Zr
	Z2krWkCrn5GFW0kFs8Cr4rZr1aga1qgF13Jw48try3uFyfZa1DWFZ5Zr1F93W5Xrs7GrnI
	kr90qan5Gr129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUULID3UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xwKrWrvsRxeYAAA3G



On 11/8/26 05:50, Manivannan Sadhasivam wrote:
> On 2026-11-02 14:38 +0800, Hans Zhang wrote:
>> When programming the RAS-DES event counter control register, the code only
>> cleared the event-selection field before OR-ing in the new group, event,
>> and enable values. This leaves stale bits in the group-select and enable
>> fields from prior writes.
>>
>> Clear all three field masks before programming the register so that stale
>> bits are not preserved across updates.
>>
>> No functional change intended beyond ensuring the register is rewritten
>> without carrying over previous field values.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
> 
> This patch got superseded by this commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc&id=fe84c0b370889bbf65f75bb75a1810227c7ce150
> 
> - Mani
> 

Hello Mani,

This is an evaluation comment from Bjorn regarding me. I didn't notice 
that Manikanta Maddireddy had made the changes. Please drop this patch.


https://lore.kernel.org/linux-pci/20261019171244.GA2200874@bhelgaas/


Best regards,
Hans

