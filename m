Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795050003;
	b=POuIfYu04Zg1lab8I25jylSlp0mMD61MMLPNACVYnIHYXvtvyfgJzoLX6GOLiDz1QNaQ
	 PJOt/DeNAW7kt9LwfjE+6RXEzNEzgayKMi+jiVFanr1TKwEIGG84f6T4bizZXQRf3jQzF
	 s3GfCIBB6z1e8WFykiS1c5mBs8JnLELEKguVuNzneRlyOkeZGronmqJUw4cx+ISk3VB3y
	 D+GRUm335QSrhfzmD+9Hf/RU2BWWEjqKkERR9OJ02VQlgNyOO3DrAOELRm0VrSGhsq+G3
	 yo6Q1HXJwOOaAFr4dawpigo3D0I3fD/kiC0j/EAGs5GicsEKBT3qs8uhJ1wtHiG6ICw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795050003;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=gYBZLlT9+eTfIVcY4yw0H/nwcJfUCT3G192Af+Y5LkY=;
	b=mvGw2SZodZSBzS39TNL3PM55vSQB6HAvFPMTpjzrJxZQygqwO9pI4CHSYyVvXj89RnpV
	 2iAatqZFCqhHbVSNOdFCJamIgAnz8OCIszDGkS2s777iTPSXADo1S+1mAR7VfhsIw9fgM
	 sGi4HXo3jmpaCymKhqNUvp0me60GxEDmBJBVvcvMZ8dhE3uojb9eRoCwfwJDP+fnwB8Di
	 xTBzdbwLb/Vpc5409Le54ZFqzFWmINP6GOOqku3noQWHsnRnRSsbQsGwSbk3dguIqqfeX
	 EbTCtnQ8ou32p8wZkF8zyKMcJS1sl66q7hKc7S4ai/c6CiVl57zleKMFHWpD2EBppTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=UZC09U8v;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE35660A2604;
	Thu, 19 Nov 2026 01:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE35660A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=UZC09U8v
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gYBZLlT9+eTfIVcY4yw0H/nwcJfUCT3G192Af+Y5LkY=;
	b=UZC09U8vbHHntx9+CYN+9GShw4Lvxg7P8md4490ra3mANpr3fdoeEpVvrsXgMszlm3kIjE1mf
	byzScLfs0mfjheiPsgmlonur5bZ1vq3zKoQfTnBSnDQRri8RwetaU8zONOUGvKC9qzIqSdXZX00
	TDVrbVodF8GSxmBgvv7k4IU=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jVKqw1SJ3z1prMf;
	Thu, 19 Nov 2026 08:59:40 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E98B202E6;
	Thu, 19 Nov 2026 08:59:53 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 19 Nov 2026 08:59:52 +0800
Message-ID: <975e32a9-357f-4550-8309-54259b78c26a@huawei.com>
Date: Thu, 19 Nov 2026 08:59:52 +0800
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
Subject: Re: [PATCH RFC 3/3] Expose the CPU/Steering Tag mapping via debugfs
To: Wei Huang <wei.huang2@amd.com>, <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <skhan@linuxfoundation.org>,
	<corbet@lwn.net>, <rdunlap@infradead.org>
References: <20261001155551.4182899-1-wei.huang2@amd.com>
 <20261001155551.4182899-4-wei.huang2@amd.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20261001155551.4182899-4-wei.huang2@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Wei,

1. Should we consider cpu hotplug ? How about add cpus_read_lock() in start() and
   release it in stop()
2. Does this support RCiEP device?

Other LGTM

Thanks,
Chengwen

On 10/1/2026 11:55 PM, Wei Huang wrote:
> Steering Tags (ST) are opaque, platform specific values obtained from the
> ACPI ST _DSM, and are only visible to the driver that asks for them. That
> makes it hard to validate whether firmware reports a sane mapping at all.
> 
> Expose the mapping read-only in the debugfs directory of each Root Port
> that has ST _DSM support:
> 
>   # cat /sys/kernel/debug/pci/0000:00:01.1/tph_cpu_st
>   cpu  vm_st  vm_xst vm_ph_ignore pm_st  pm_xst pm_ph_ignore
>   0    0x03   0x0103 0            -      -      0
>   1    0x03   0x0103 0            -      -      0
> 
> Each line holds the raw ST info the _DSM returns for one online CPU;
> invalid tags and failed queries are reported as "-".
> 
> The interface is per Root Port because the _DSM is evaluated on the ACPI
> device of the host bridge above it. A system with multiple host bridges may
> return different tags for the same CPU, and the value that matters to a
> driver is the one for the Root Port its device sits below. Root Ports below
> the same host bridge report identical contents.
> 
> The file is created during enumeration and removed with the device's
> debugfs directory in pci_destroy_dev(), which returns only once no read is
> running, so the pci_dev the file refers to stays valid.
> 
> Signed-off-by: Wei Huang <wei.huang2@amd.com>


