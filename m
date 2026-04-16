Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB5F2701BB;
	Thu, 16 Apr 2026 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326538; cv=none; b=WrgEHwyLKpECOvS+YdZVfEKP82O/yLo7aSFBKf+kEeyJYZrLZhEbGgTIs6EO2+n8XsiZ31TRvoyZejP9SYTmWXtpizvivQ9wJWzPRld8KjCJvTlOA+CVJUZxcvR4nsJleCOZRrv8rCnYy08SNQ7UQLsMy/kzCK6F/0hqqxq9/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326538; c=relaxed/simple;
	bh=++J7X9OapmreZjjVgTluDHOIiqGwv5jdF1pv0ir3leY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhVn/LAAg7taojIfs2+9W3RDX1ch/oOAPDZsrL9NflCnTOdYhWhHZnGM6sPV75c1hoPpUW+KqQyxlhxAFOi1jQKbeE/Fm3xGO9DcqXNA2cbhFRNpMANu73IX02A4nBs1ERY/G9tu2FouiKJ0DdNXci60APL4hlF193fnfbYiwHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5b13a2d1.dip0.t-ipconnect.de [91.19.162.209])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C82174C2C37F01;
	Thu, 16 Apr 2026 10:02:00 +0200 (CEST)
Message-ID: <8ae5fb2c-7066-4a1b-9798-020ea3290df8@molgen.mpg.de>
Date: Thu, 16 Apr 2026 10:02:00 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Fix build error when
 CONFIG_ACPI is disabled
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, kernel test robot <lkp@intel.com>
References: <20260416060352.1392139-1-chandrashekar.devegowda@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260416060352.1392139-1-chandrashekar.devegowda@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chandrashekar,


Am 16.04.26 um 08:03 schrieb Chandrashekar Devegowda:
> btintel_pcie_acpi_reset_method() uses ACPI APIs such as
> acpi_evaluate_object() and acpi_has_method() which are not available
> when CONFIG_ACPI is disabled, causing build errors on architectures
> like ppc64le that lack ACPI support.
> 
> Guard btintel_pcie_acpi_reset_method() with IS_ENABLED(CONFIG_ACPI)
> and provide a stub returning -ENODEV when ACPI is not enabled.
> 
> Fixes: 912a499a7955 ("Bluetooth: btintel_pcie: Support Product level reset")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> ---
>   drivers/bluetooth/btintel_pcie.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 076beb45c410..4d136ff342b8 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2280,6 +2280,7 @@ static void btintel_pcie_inc_recovery_count(struct pci_dev *pdev,
>   static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data);
>   static void btintel_pcie_reset(struct hci_dev *hdev);
>   
> +#if IS_ENABLED(CONFIG_ACPI)
>   static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
>   {
>   	union acpi_object *obj, argv4;
> @@ -2333,6 +2334,12 @@ static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
>   	pci_dev_unlock(data->pdev);
>   	return ret;
>   }
> +#else
> +static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
> +{
> +	return -ENODEV;
> +}
> +#endif

Please look into using something similar like the macro `PTR_IF()`, 
defined in `include/linux/util_macros.h`. It’s returning NULL, so not 
applicable here, but all the code needs to be build tested.

Also, if ACPI is not enabled, does it make sense to call 
`btintel_pcie_perform_pldr()` at all?

>   
>   static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
>   {


Kind regards,

Paul
