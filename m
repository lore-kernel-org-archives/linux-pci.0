Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048302;
	b=3mDpYsWmr6UOQSoWW1U+dGtE7vBXWwcCawGZNUmuJTpu3GTojdsT1I8dYHNlSE15I/N4
	 /4Z5K8oU9jdm8J/n5vGGN1SpCux9kbmBnF7Tr5kPVuAg/T9Xh8ZYMaWTAvz4CigD8rbt5
	 MQyE+NCaimPY6MUguKo16ISZH6rGOtRSQIXTH23epRC73SJWTp3o5Xo8KWkW9vxdYqRYL
	 SHh0OJekT6Ar1ITHKmiIkXV2yX21z+oyPFiuB4CfomxB+Cdm3CuPOg4c9DWdYBUUmo7Vb
	 uvwBAq17RLqWBbzHQ3q0U+3dOe9Ic0J3jjW7cQM3wWkBms7RKyQPxcV4au+IEhTD0iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048302;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=mS6AFM8dfyEXp77ytOM5hV75MBkbYqRSRgafg5R5bBE=;
	b=rm04wukh6EfcE4Kc0dV8n61F/hN+poR26WnQepXN871xwMPQwrTHhPCEuogACz4o3nY3
	 Yawo8Ck8X8QyVbdx53BBn+CQSVxDCZyWvRyp4/6UA9eMwMgQikW0Kj5jJhZoOwq1lJwx7
	 oeaFEZ491tgbkABtJ1wVIrRLJedzPcRqOfs9WDHYZfqr9wfCCp7i12z4+1aDq2bhgo6Zn
	 eULiJvG0eWT0Ibo0U1+ypKIdNrywwUqTNfrTbivukQVzMcjzHHJRV2a6AbEajwzk5blQM
	 Wv8ZQkf3dvDJDvRVWbYYGR0Fbd+4UITYV7zYUVD0FxQlCAeyWzPUOZU7uS2cJ8EISBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Uf4NDLR7;
	arc=none smtp.remote-ip=113.46.200.227
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3502606A32A;
	Thu, 19 Nov 2026 00:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3502606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Uf4NDLR7
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mS6AFM8dfyEXp77ytOM5hV75MBkbYqRSRgafg5R5bBE=;
	b=Uf4NDLR7ECG6sRxoYs8M1iuCd5C3Ge2h6GRqiNHXlZzEZSAIqU86nEFd2nTJmnda2ueYp18oQ
	X+Bwzm+UsOw2KZ55oHuOLWRrmMrvjYDv1qwXGpBfYcrL7reEj7zSrFtGBgDTKoUHABeo5whys5I
	JPiTAsHlYa4tIOB0f0b1/hM=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jVKBR2FNKznTYB;
	Thu, 19 Nov 2026 08:30:39 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 12B8B4056C;
	Thu, 19 Nov 2026 08:31:32 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 19 Nov 2026 08:31:31 +0800
Message-ID: <28055dc3-13bf-49e1-bdbb-e825df9a0c49@huawei.com>
Date: Thu, 19 Nov 2026 08:31:30 +0800
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
Subject: Re: [PATCH RFC 2/3] PCI: Add per-device debugfs directories
To: Wei Huang <wei.huang2@amd.com>, <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <skhan@linuxfoundation.org>,
	<corbet@lwn.net>, <rdunlap@infradead.org>
References: <20261001155551.4182899-1-wei.huang2@amd.com>
 <20261001155551.4182899-3-wei.huang2@amd.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20261001155551.4182899-3-wei.huang2@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 10/1/2026 11:55 PM, Wei Huang wrote:
> PCI features that export debug information have no common place to put it.
> The only existing user, PTM, creates a "pcie_ptm_<device>" directory in the
> debugfs root, which does not scale as more features follow and leaves each
> user to invent its own lifetime rules and leaf names.
> 
> Add /sys/kernel/debug/pci/<device>/ directories owned by the PCI core.
> pci_dev_debugfs_dir() returns the directory of a device, creating it and
> the PCI root directory on first use, so devices without debug content do
> not get an empty directory. pci_destroy_dev() removes the directory
> recursively, so a feature that pins data in a debugfs file needs no removal
> hook of its own: debugfs_remove_recursive() returns only once no operation
> on those files is still running.
> 
> No functional change for existing users; the next patch is the first
> consumer.
> 
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
