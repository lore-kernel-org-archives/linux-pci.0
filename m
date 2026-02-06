Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4D30AABE
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372043; cv=none; b=V7yJDVGXitahJqTMvH/qwDOUhiSgm4yrK8ZTFEmjry7waZW44x2rH4/XPVvRAesDjoul+kuU9o8tVIhcfnWCokFm3l15MqvQMd6Yf1hJ0eyT2fYzsVzzwhrFUXpJU/vKWIR87oNPtTsdn5c/WXaGo4ydrejhg9s1ET5dtlDXkFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372043; c=relaxed/simple;
	bh=nj3OnUu2My8H7ggzM5BXqLX32ICVuTBKkAg4sGiM16o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qvC+wNU++3ZtYSMU8RILhfHXfkJdCwfKvqjXuTbdiZhs1pey1QxMSS8haNtOf9pm2g+VhZMvJqgqcgul7mpUZN8Yj/e8ADK55GXmw+xXhO1XrwIl5ZH4KiCXkG95aadHfkJooTaiT8CERuDybLHH3Ag6G4Nzxx5hzBh0ToZMlTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NIckCLa+; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NIckCLa+"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tftKTKFBl/Ok5BbE/9r4ZIruNZKPjcPUXp0ynGyi9r0=;
	b=NIckCLa+6WLXgmsy0wDA6VHavLbT1IMXrTPmsdyxK5FRp6lBdMOXs0p8Q404TQMJSiDcHSE+t
	baG+GfzY6nJW9cGuTMQMYUa2hOoOlLHCYEOZnrz8O9nai/yC1Pxqnn4dYCR6rDC6joD5mi0UY0u
	B40wkkH2IRw1R9sKSkFqado=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4f6qHc5dYYz12LCb
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 17:56:44 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id CD1E52012A
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 18:00:33 +0800 (CST)
Received: from kwepemn200012.china.huawei.com (7.202.194.135) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Feb 2026 18:00:33 +0800
Received: from [10.67.120.233] (10.67.120.233) by
 kwepemn200012.china.huawei.com (7.202.194.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Feb 2026 18:00:32 +0800
Message-ID: <714842fb-dfdd-4ea2-adb1-2b44148b57b2@huawei.com>
Date: Fri, 6 Feb 2026 18:00:32 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/AER: Fix AER log missing in DPC case
To: <bhelgaas@google.com>, <jonathan.cameron@huawei.com>,
	<shiju.jose@huawei.com>, <pandoh@google.com>
CC: <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <shenyang39@huawei.com>
References: <20260129140103.712011-1-liusizhe5@huawei.com>
From: Sizhe LIU <liusizhe5@huawei.com>
In-Reply-To: <20260129140103.712011-1-liusizhe5@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn200012.china.huawei.com (7.202.194.135)

Hi,
Gentle ping.


Best regards,
Sizhe

On 2026/1/29 22:01, Sizhe Liu wrote:
> In the current DPC error reporting case, some AER log information is missing.
>
> -- Error log abnormal
> pcieport 0000:20:00.0: DPC: containment event, status: 0x1f11: unmasked uncorrectable error detected
> (------ AER error log supposed to be printed here, but missing ------)
> nvme nvme0: frozen state error detected, reset controller
> {4}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
>
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
> This will result in losing the AER log messages in the DPC case.
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
> -- Error log normal
> pcieport 0000:20:00.0: DPC: containment event, status:0x1f11: unmasked uncorrectable error detected
> pcieport 0000:20:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
> pcieport 0000:20:00.0: device [19e5:a120] error status/mask=00040000/04580000
> pcieport 0000:20:00.0:    [18] MalfTLP   (First)
> pcieport 0000:20:00.0: AER:   TLP Header: 0x00000000 0x00000000 0x00000000 0x00000000
> nvme nvme0: frozen state error detected, reset controller
> {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
>
> [1] https://lore.kernel.org/linux-pci/20260127035405.712271-1-liusizhe5@huawei.com/
>
> Fixes: a57f2bfb4a58 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
> ---
> v2
> - Corrected the format and spelling errors in the commit log.
>
>   drivers/pci/pci.h      |  1 +
>   drivers/pci/pcie/aer.c | 35 +++++++++++++++++++++++------------
>   drivers/pci/pcie/dpc.c |  1 +
>   3 files changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 0e67014aa001..0cbcbcd52354 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -748,6 +748,7 @@ struct aer_err_info {
>   
>   int aer_get_device_error_info(struct aer_err_info *info, int i);
>   void aer_print_error(struct aer_err_info *info, int i);
> +void aer_ratelimit_print_init(struct pci_dev *dev, struct aer_err_info *e_info, int idx);
>   
>   int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>   		      unsigned int tlp_len, bool flit,
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e0bcaa896803..b73915b63327 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -925,6 +925,28 @@ int cper_severity_to_aer(int cper_severity)
>   EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>   #endif
>   
> +/**
> + * aer_ratelimit_print_init - set flag whether error message is printed
> + * @dev: pointer to pci_dev to be rate-limited
> + * @e_info: pointer to error info
> + * @idx: index for ratelimit_print array
> + */
> +void aer_ratelimit_print_init(struct pci_dev *dev, struct aer_err_info *e_info, int idx)
> +{
> +	/*
> +	 * Ratelimit AER log messages.  "dev" is either the source
> +	 * identified by the root's Error Source ID or it has an unmasked
> +	 * error logged in its own AER Capability.  Messages are emitted
> +	 * when "ratelimit_print[i]" is non-zero.  If we will print detail
> +	 * for a downstream device, make sure we print the Error Source ID
> +	 * from the root as well.
> +	 */
> +	if (aer_ratelimit(dev, e_info->severity)) {
> +		e_info->ratelimit_print[idx] = 1;
> +		e_info->root_ratelimit_print = 1;
> +	}
> +}
> +
>   void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   		   struct aer_capability_regs *aer)
>   {
> @@ -990,18 +1012,7 @@ static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
>   	e_info->dev[i] = pci_dev_get(dev);
>   	e_info->error_dev_num++;
>   
> -	/*
> -	 * Ratelimit AER log messages.  "dev" is either the source
> -	 * identified by the root's Error Source ID or it has an unmasked
> -	 * error logged in its own AER Capability.  Messages are emitted
> -	 * when "ratelimit_print[i]" is non-zero.  If we will print detail
> -	 * for a downstream device, make sure we print the Error Source ID
> -	 * from the root as well.
> -	 */
> -	if (aer_ratelimit(dev, e_info->severity)) {
> -		e_info->ratelimit_print[i] = 1;
> -		e_info->root_ratelimit_print = 1;
> -	}
> +	aer_ratelimit_print_init(dev, e_info, i);
>   	return 0;
>   }
>   
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index fc18349614d7..d17adc642781 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -275,6 +275,7 @@ void dpc_process_error(struct pci_dev *pdev)
>   			 status);
>   		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
>   		    aer_get_device_error_info(&info, 0)) {
> +			aer_ratelimit_print_init(pdev, &info, 0);
>   			aer_print_error(&info, 0);
>   			pci_aer_clear_nonfatal_status(pdev);
>   			pci_aer_clear_fatal_status(pdev);

