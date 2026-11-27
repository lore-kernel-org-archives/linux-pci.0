Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795332;
	b=XK7KYEfmbgT+RC+fN0FmAcFYPgGSo9Y21cnkCHrBZ0Wg9wv7WpDoNBHLv0FCp9Hfg9vb
	 Qb3z6ZXMx3EYz0cWYL5igD8/7yDuSM/iJLBLUWvLQhuXNVHI4rzXDNnL8M7Rfng6Lx2FM
	 pW3KxPtSW9kYDj3pnfUeQbDk19imw6g3UhjDKjNvcVIzzbyfI14+yVmYQN/JQvAJ/F/cT
	 PMFyCa3qCMczKj7kf0/XdhgciADrvp+7fyfoKhRW9qq6ySBD9IUEGo6+/o94JFwpD9Fdi
	 g65a09N0o0mnbRKuntqQUDr5HVPzjPTD156Mpl2APDQdsrM3Fq0ih2GxWOqUMPo4Yvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795332;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=bRsuVcrQyfmLz+pq40jwwjKSrSxpTonxyuhsiPTJNsQ=;
	b=QIFk64DdNF9NPNvyDFjtSditaW+crqa7l8JJHjU8Y0b0VekNNSzIo0RYRSU0mfSCFJkf
	 k9/r/qClm2eaGliN+7Cs1UT9Ti2fRScUj2rlg46lj9FYlSm26RRP39Ia7EuVmp2T6BhNu
	 ue9tGMfSaTvasXFpX4qY5+z8qvLDALZ3KHPYrcF6p+s153U8zzjk/y9RMbuy57F/N1py/
	 3LSKS6nzQQnsVlPXZnAEcq4Sj3OQvI426LH0iOUrWAfbjOoWO9En0QFW4sq57v2zFK1Kj
	 MHkw/Q9ig3VhomsDcSrwSfWBsVYsCLsNqtInPPTgqCXXGn8pmIK5Z6NA89pkTvKd0aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=iL3iZ2Tr;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB71606A339;
	Fri, 27 Nov 2026 16:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AB71606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=iL3iZ2Tr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=bRsuVcrQyfmLz+pq40jwwjKSrSxpTonxyuhsiPTJNsQ=;
	b=iL3iZ2TrqhQiQMK7KMAOkx5JWJxVgyAO27j7yzgnMZ/cWff6Z4NGLzezIn4vxb
	sA+XkIW8d4r5TzIR8fFRz8bD+/YlaK8gzvs5qAVAkIiZSyaWZQxSMalaeRDRi6cd
	pUMbk3SpB9K8jo7Upc4eI0a2gi3O09uj/HO0bs0P169uw=
Received: from [IPV6:240e:b8f:91b3:d000:4e56:5474:4160:163a] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXtiMwqQlrKSDnKg--.18141S2;
	Sat, 28 Nov 2026 00:00:49 +0800 (CST)
Message-ID: <65f6df0c-1bf2-4a1d-8049-44dea14b70f4@163.com>
Date: Sat, 28 Nov 2026 00:00:51 +0800
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
Subject: Re: [RFC] PCIe host controller async probe vs PHY request_module
 deadlock
To: Shawn Lin <shawn.lin@rock-chips.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, bhelgaas@google.com, mani@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261127074329.747914-1-18255117159@163.com>
 <00ca72a9-ff50-4842-8aa9-d68416212e8b@163.com>
 <2587e8fc-018d-426a-8459-4e88e733a38c@rock-chips.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <2587e8fc-018d-426a-8459-4e88e733a38c@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXtiMwqQlrKSDnKg--.18141S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur18AF1DJr4DXF1rCw47XFb_yoW3ArbE93
	47CFy09w1rKF4j9a1ktrs3urs0qw1jga45Gr92qr43GryrAFZrGan2y3sxXa4xJFZ2kFyI
	qF9Iq3y7tFn09jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjFAp7UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xKTN2sJqTIjHgAA3Z



On 11/27/26 23:01, Shawn Lin wrote:
> Hi Hans
> 
> 
> 在 2026/11/27 星期五 16:02, Hans Zhang 写道:
>> Hi all,
>>
>> The patching process under discussion：
>>
>> https://patchwork.kernel.org/project/netdevbpf/ 
>> patch/20261124070753.25972-1-18255117159@163.com/  (include v3 patch)
>> https://patchwork.kernel.org/project/netdevbpf/ 
>> patch/20261124070753.25972-1-18255117159@163.com/
>>
> 
> This had been discussed for several times and the lastest one I
> remembered  is from here:
> 
> https://lists.infradead.org/pipermail/linux-rockchip/2026-March/068879.html
> 

Hi Shawn,

Thank you for your reminder. I missed the discussion of this series. But 
it seems that I haven't witnessed the final plan being implemented.

Best regards,
Hans


