Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE2828AAEE
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529420; cv=none; b=eg+97EsER3L931SM/ljoXFkMis5lCo5EBoXhz4oTdtUx1VZeVICd8Si+kRGI8oHew9ie5rqCd2dNBqI8nrA7ojmZdd7kxGmCmoTQktV/yG+6DQeUata5tf5Bg8+TamSKRbXwq376fb32bW+MxV+mmssCqYTjmWyrecmE5o4gAyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529420; c=relaxed/simple;
	bh=T/xf1x3wH2GOcECBoheOSuq002BHVp+ADXz0G5VL5jM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+dSu+Lrh3Nu2MGaYbsm6cBPRR7vT60CZjpC14hOwt+gpe2pURHUXfwWALes8Bk9fifA/ZzLWAntbdkTG/kEJb2OFpXSf1MxJ358LPntoGW+3/ABsW+H6ad1IBu84L7fsGFNCVqjHwejbvO6UsCHUArNZPFeb9ihDCxvlL98Zr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f0ql63bpvzJ46gt
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 23:56:18 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F4CC40571
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 23:56:54 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Jan
 2026 15:56:53 +0000
Date: Tue, 27 Jan 2026 15:56:52 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Sizhe Liu <liusizhe5@huawei.com>
CC: <bhelgaas@google.com>, <shiju.jose@huawei.com>, <pandoh@google.com>,
	<linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <shenyang39@huawei.com>
Subject: Re: [PATCH] PCI/AER: Fix AER log missing in DPC case
Message-ID: <20260127155652.00006bc1@huawei.com>
In-Reply-To: <20260127035405.712271-1-liusizhe5@huawei.com>
References: <20260127035405.712271-1-liusizhe5@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 27 Jan 2026 11:54:05 +0800
Sizhe Liu <liusizhe5@huawei.com> wrote:

> In the current DPC error reporting case, some AER log information
> is missing.

Wrap commit messages up to 75 chars, this is about 65.
Only do that for stuff where the formatting isn't fixed for other
reasons, such as the log below.

> 
> -- Error log abnormal (line breaks adjusted)
> [  976.604003] pcieport 0000:20:00.0: DPC: containment event, status:
> 0x1f11: unmasked uncorrectable error detected
> (------ AER error log supposed to be printed here, but missing ------)
> [  976.604030] nvme nvme0: frozen state error detected, reset controller
> [  977.812932] {4}[Hardware Error]: Hardware error from APEI
> Generic Hardware Error Source: 0
> 
This, but do remove timestamps as those don't matter to anyone.
Not wrapping helps if anyone is searching for this later.

Abnormal error log

  pcieport 0000:20:00.0: DPC: containment event, status: 0x1f11: unmasked uncorrectable error detected
(------ AER error log supposed to be printed here, but missing ------)
  nvme nvme0: frozen state error detected, reset controller
{4}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0


> Cause:
> In aer_print_error(), PCIe AER errors is reported, and is rate-limited
> by info->ratelimit_print[i]. There are two entry points for
> aer_print_error().
> 
> 1) Native AER
> aer_isr_one_error_type() -> aer_process_err_devices() ->
> aer_print_error()
> 2) DPC
> dpc_process_error() -> aer_print_error()
> 
> The value of info->ratelimit_print[i] is initialized correctly in
> the native AER case:

> aer_isr_one_error_type() -> find_source_device() ->
> find_device_iter() -> add_error_device()
> 
> In the DPC case, info->ratelimit_print[i] is not initialized and
> alloc by 0 , so in aer_print_error(), it will directly return at line
> if (!info->ratelimit_print[i])
> This will result in lossing the AER log messages in the DPC case.

losing

> 
> Solution:
> 1. Move the initialization of info->ratelimit_print[i] to
> aer_ratelimit_print_init().
> 2. Add aer_ratelimit_print_init() in dpc_process_error().
> 3. Replace the initialization by aer_ratelimit_print_init()in
> Native AER case.
> 
> Test with AER inject:
> Set the DPC reporting priority in the BIOS and send
> MalfTLP(AER FATAL ERROR) to device.
> 
> -- Error log normal (line breaks adjusted)
> [ 5366.943807] pcieport 0000:20:00.0: DPC: containment event,
> status:0x1f11: unmasked uncorrectable error detected
> [ 5366.943826] pcieport 0000:20:00.0: PCIe Bus Error:
> severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
> [root@localhost ~]# [ 5366.943830] pcieport 0000:20:00.0:
> device [19e5:a120] error status/mask=00040000/04580000
> [ 5366.943833] pcieport 0000:20:00.0:    [18] MalfTLP   (First)
> [ 5366.943836] pcieport 0000:20:00.0: AER:   TLP Header:
> 0x00000000 0x00000000 0x00000000 0x00000000
> [ 5366.943843] nvme nvme0: frozen state error detected, reset controller
> [ 5368.156778] {2}[Hardware Error]: Hardware error from APEI Generic
> Hardware Error Source: 0
Reformat this and drop timestamps as well:

Normal error log

  pcieport 0000:20:00.0: DPC: containment event, status:0x1f11: unmasked uncorrectable error detected
  pcieport 0000:20:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
  pcieport 0000:20:00.0: device [19e5:a120] error status/mask=00040000/04580000
  pcieport 0000:20:00.0:    [18] MalfTLP   (First)
  pcieport 0000:20:00.0: AER:   TLP Header: 0x00000000 0x00000000 0x00000000 0x00000000
  nvme nvme0: frozen state error detected, reset controller
  {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0

> 
> Fixes: a57f2bfb4a58 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Otherwise looks good to me.

Thanks,

Jonathan


