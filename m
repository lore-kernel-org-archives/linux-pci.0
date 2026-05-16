Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD943DD866;
	Sat, 16 May 2026 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778942714; cv=none; b=jJ3cqMVfwbK9QKcSwx43jdzwfiiEeyUM/7z1jAhTGkHesx94E1TYJzNcno7BNxtXyq+HPmENgjFjX6qwIMJTFNs48ARIuCIDl8sQOf2tL9qS3j81IZ5vvFw1BIlpfhckSAscpiJFvZjTrMJsXH40o3tQFvQ8CSogpwqkdfL6tkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778942714; c=relaxed/simple;
	bh=epTGRPWzV6+K3O3zcKKOG00QfmV9kCPMEsckxIfQDvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/Y6XzS/2G4GbWWnjkaXxIXpwGLcAHTc8Gjl4zmNe6FPUZTB9m6AsftiF4JVY2VUoE8++zwxy5mekFCm1Bzwcb/cz9xtiyjVdwaqA3aS74vTGOJq8GnI6NKh1tuz+wNOImx6VWn81kLauo1MeHufhajuGCh8Fbob1fdOkNf6JWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qIGAsd97; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qIGAsd97"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=kmvwfkH0kUT4ovZfaf31wcVb+3lCh71uuMmH3at3mlA=;
	b=qIGAsd97WZVWu7srcWt/8pndRoZS8ryWYiTBOG1VBTaQbY4aIDfAOdrFB7l8qy
	IjJn6PHxOHrV4rb/WcCWperB8SQRzGsh8BAYJ4i/VNQP8537vGLcs/bXFxbNCGFm
	XLoRnfNsWis7KWpzjPtjwh6BJ3Fp2n2/i1Y0l6l7LlpLs=
Received: from [IPV6:240e:b8f:91b3:d000:e64f:a9a6:8381:1b5e] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCnVRfNgghqJv1sEw--.40513S2;
	Sat, 16 May 2026 22:44:30 +0800 (CST)
Message-ID: <52130a6a-46f5-4090-b155-2137b5d8cd6e@163.com>
Date: Sat, 16 May 2026 22:44:29 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] PCI: Encapsulate pcie_link_speed array access
To: bhelgaas@google.com, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260315160057.127639-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260315160057.127639-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgCnVRfNgghqJv1sEw--.40513S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrW5KF17Kw1kKFWxuFykZrb_yoW8Ww1fpa
	43Wr4Yvr47Ja1Yya9xua1jvryYq3ZxAr4Igryjgw48ZFnxGFy7Wayxtr45uFya9r4Yvr1a
	qF47t34ruFnrAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziA9N3UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCww9wFGoIgs-bBwAA3b

Hi,

Gentle ping.

Best regards,
Hans

On 3/16/26 00:00, Hans Zhang wrote:
> Hi,
> 
> This series encapsulates the pcie_link_speed array by introducing a
> public helper function to_pcie_link_speed() and converting all direct
> array accesses to use this helper. This improves code maintainability,
> reduces exposure of internal data structures, and makes future changes
> to link speed mapping easier.
> 
> Patch 1 moves to_pcie_link_speed() from pci.c to probe.c and exports it.
> Patch 2 converts the sysfs show function and an inline helper in pci.h
> to use the new helper.
> Patch 3 removes the now-unused extern declaration of the array from pci.h.
> 
> 
> Based on this series of patch submissions:
> https://patchwork.kernel.org/project/linux-pci/cover/20260313165522.123518-1-18255117159@163.com/
> 
> Hans Zhang (3):
>    PCI: Move to_pcie_link_speed() to probe.c and export it
>    PCI: Use to_pcie_link_speed() for link speed conversion
>    PCI: Remove extern declaration of pcie_link_speed array
> 
>   drivers/pci/pci-sysfs.c | 2 +-
>   drivers/pci/pci.c       | 5 -----
>   drivers/pci/pci.h       | 3 +--
>   drivers/pci/probe.c     | 7 ++++++-
>   include/linux/pci.h     | 1 +
>   5 files changed, 9 insertions(+), 9 deletions(-)
> 
> 
> base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
> prerequisite-patch-id: 7b106b4bc491747237b75c9364a500eb8cfd31a0
> prerequisite-patch-id: 0fabd60d739c45e76d4fb87cc008697f92e7164e
> prerequisite-patch-id: 83fa7afd2c83f62058b212e93cfea72596389f76
> prerequisite-patch-id: 145833e2f270b51817275764d5a578addf6f3709
> prerequisite-patch-id: cda29dea578c6213dd799dfd7b5ae5e02c7f455d

