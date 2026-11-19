Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795047513;
	b=HvPlbEPKLO1RYHS5Cenp5ABFWx/m4gB3KB2SJSlCfeo8XY355t0WzLc8BBi30nbRGF6U
	 C3N/3GRA+kRDZ1h7aoyTzlagngblE8dBzzzpjwZN6Ays2gPOfyzjI9Q1JfNwMeZAU0qbf
	 rtEbTTNtEM1beF2Rpj4IuOp40vf1AQY9hKq6WKGrkPdltTON0ioic3w31Ml1boGAu6iEr
	 J5vfBleekWnfXTEQF23IdsCqqpc7mIiiIV8nBzlXXNXxws6ctd2guk/OxUkuvnKbA+9ng
	 ddw86hwLCccWN+F8iWJGuRt3/CoaL+vD82ivV++gptmE8kpjx9HkkquBPZfDb2Xk6KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047513;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=3nuiJL55J4ZCZAI79sI6l4xLD0umn2jK5X763sqembw=;
	b=jwh2aolwysjNVyGAIo8i9RBB921jAWeMOYtqsiBitYLUE1KLVpaYFmHXrifvf0aFQ9Vn
	 yOkWNfYE93s0W5F6gV1jpOrVS08XQOBb1ymbLmcY6IIyeGW/zxEQGz79jQxDzMi4GwP8q
	 kePrfXqhOE6e0Tt3+rp57Qsw3qeun1E8AC1eBfz3Onzi64/oYZe37bt+10hYfrIcIRxXa
	 jzcgeFg1WEFowC5i3KcCFsTiLRj+El2QjqwJpv3/MQfkI80VjOd9J4YLbWMSaFv2dY+di
	 UchPPIzz/UsQ0KRF0znBioZf2xskCzOd8PZakOiZ0sSf8OlwZ4UTL+Ac7IYNFWdja8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SXef0+nJ;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B667C606A32A;
	Thu, 19 Nov 2026 00:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B667C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SXef0+nJ
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3nuiJL55J4ZCZAI79sI6l4xLD0umn2jK5X763sqembw=;
	b=SXef0+nJtJS+bxci0yRC+A+SZxOKvLmtdu+oAWyZLN31VrCibOAGmIRuhVdQN9YML8Bx6DhRN
	xdd+ZB5s08KBlKERGuce8wiNG4vaX37eIF1PMz2DX9JET6EGYaeL0nO3L6NApTyqr8kLqWmBdZI
	bWhTHvtesiIklYnn8HsU62I=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jVJvb6w39z1T4GV;
	Thu, 19 Nov 2026 08:17:47 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DEC240685;
	Thu, 19 Nov 2026 08:18:28 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 19 Nov 2026 08:18:28 +0800
Message-ID: <96f7b5bd-2295-42b4-89c5-e548cc1791a9@huawei.com>
Date: Thu, 19 Nov 2026 08:18:27 +0800
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
Subject: Re: [PATCH RFC 1/3] PCI/TPH: Factor out the ST _DSM evaluation
To: Wei Huang <wei.huang2@amd.com>, <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <skhan@linuxfoundation.org>,
	<corbet@lwn.net>, <rdunlap@infradead.org>
References: <20261001155551.4182899-1-wei.huang2@amd.com>
 <20261001155551.4182899-2-wei.huang2@amd.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20261001155551.4182899-2-wei.huang2@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 10/1/2026 11:55 PM, Wei Huang wrote:
> The ACPI _DSM that returns the CPU to Steering Tag (ST) mapping is
> evaluated in one place today, with the lookup of the ACPI device providing
> it open coded in pcie_tph_get_cpu_st().
> 
> Factor the handle lookup and the per-CPU query into tph_dsm_handle() and
> tph_get_cpu_st_info() so other callers can reuse them, name the _DSM
> revision instead of repeating the bare number, and constify the ST info
> passed to tph_extract_tag().
> 
> No functional change introduced.
> 
> Signed-off-by: Wei Huang <wei.huang2@amd.com>

