Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDA73FF1C4;
	Thu, 30 Jul 2026 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411375; cv=none; b=qEdLXFELrMhGOmybdp1HIhPrNVYeMmzMS+mOh0O2rTWAydUudfE+TB94pkuaGT2qdhR76I2P3MXqbK2MYafGmkEb3qr+X8G4MnmABetgGjvPTDsPjpQ2zyiSNUvqj+0+qcTlzpMX4hZB2F1K9ck2CfJBNraFQXroSBr67ga2T2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411375; c=relaxed/simple;
	bh=74mlVpuMR6pvKWweoSlADGPVASlqp6gXgP0pDmDJbdo=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=HHb1pbJsH0XfPsXz+XdwoGKFj68KHquWtZmLkQKEPZHF9faQNyEF/7CuNg1ono0CLFsoAFh2hNXvMeE4q+LA+o8LWV3M2NohD8uyiKh/3pRSEUWKPqDdQbTA04YTkyQ48vIaOFjAFOsqjVpDmwN+Fr7sXKU12/lXaCJsdiv/rnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dgoebd9W; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dgoebd9W"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LysKpVeVILtmsbm4kIJGuTwWE05GAbR60skuurj/C98=;
	b=dgoebd9WX562KGtM0WXIryOjdK2Q/2vqxv78ak60gtircEBTuYXdDA2w4rM2cOTRe7QHDt2sm
	au9nZbqm8FAPfQ5RSTTyRr5Qv1qsxRH8ilcOMifPNsv8nLZaIVH0EPV9v+qoEKcgh/zuYW/Udli
	5wUKiTKzXJUzb9HL3IYfCfw=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4h9n3B4RRkzpSvB;
	Thu, 30 Jul 2026 19:26:46 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id D930A4057F;
	Thu, 30 Jul 2026 19:36:05 +0800 (CST)
Received: from [100.103.110.67] (100.103.110.67) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Jul 2026 19:36:05 +0800
Message-ID: <7e2c3fd2-6b1f-4ccc-8657-ef94bbc0f86e@huawei.com>
Date: Thu, 30 Jul 2026 19:36:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <bhelgaas@google.com>
CC: <chrisw@redhat.com>, <duziming2@huawei.com>, <jbarnes@virtuousgeek.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>
References: <20260503200256.GA1393215@rocinante>
Subject: Re: [PING] PCI/sysfs: Prohibit unaligned access to I/O port
From: duziming <duziming2@huawei.com>
In-Reply-To: <20260503200256.GA1393215@rocinante>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500012.china.huawei.com (7.202.195.23)

> Unaligned access is harmful for non-x86 archs such as arm64. When we
> use pwrite or pread to access the I/O port resources with unaligned
> offset, system will crash as follows:
>
> Unable to handle kernel paging request at virtual address fffffbfffe8010c1
> Internal error: Oops: 0000000096000061 [#1] SMP
> Call trace:
>   _outw include/asm-generic/io.h:594 [inline]
>   logic_outw+0x54/0x218 lib/logic_pio.c:305
>   pci_resource_io drivers/pci/pci-sysfs.c:1157 [inline]
>   pci_write_resource_io drivers/pci/pci-sysfs.c:1191 [inline]
>   pci_write_resource_io+0x208/0x260 drivers/pci/pci-sysfs.c:1181
>   sysfs_kf_bin_write+0x188/0x210 fs/sysfs/file.c:158
>   kernfs_fop_write_iter+0x2e8/0x4b0 fs/kernfs/file.c:338
>   vfs_write+0x7bc/0xac8 fs/read_write.c:586
>   ksys_write+0x12c/0x270 fs/read_write.c:639
>   __arm64_sys_write+0x78/0xb8 fs/read_write.c:648
>
> Although x86 might handle unaligned I/O accesses by splitting cycles,
> this approach is still limited because PCI device registers typically
> expect natural alignment. A global prohibition of unaligned accesses
> ensures consistent behavior across all architectures and prevents
> unexpected hardware side effects.
Hi Bjorn,


Just a gentle ping on this patch. We have received Reviewed-by tags 
from  Ilpo Järvinen and Krzysztof.
Could you please let us know if this is queued for the upcoming merge 
window, or if you need any further action from our side?


Thank you!

ziming

