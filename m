Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6DD38AC75;
	Sun,  3 May 2026 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777823257; cv=none; b=kY31oPF/L1goseu7DyuQfk4b91HcEfG4R4RV1kTwK/4bmhoaD8xYliDMMWdQFcpPCayvz4wy5G/FUaQLbuyN2KpmHEFP2dHojCWeZ28F6lhM5I7MPrRon6VRtYaq8vS5+gAMRf7cQD8+D+tcNF5Ks85HtZpIseY0B0f1VHv54vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777823257; c=relaxed/simple;
	bh=hMp1u47oFAAcO0vVkjJY4Vr1Gz+E5GZ32BxtpX3Ap/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmMvkJfr3qasSK19eEIjTqEdmfb4kZd3jpKK9Ic3zygP9+orh9mj9iT2PbR7xEuvE0x8SveR1IW96PTsrHtj0llv9ZUfvWB2d4KaOl17Jqb75y2SsESCM5XJjX84u7C7/wCuecP5RVzfj9dHxgcEyrmhm2dWJMBPUwXE53kynZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Wo6wpdMa; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Wo6wpdMa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=fXUtsbdTPP5h/+DpPz67XLTVhEN4uswt4dk5RszFyoI=;
	b=Wo6wpdMa+HLX/r39LtIQRrsokF3uTK2oo8O9FhfIBfa9DheuEttE8m7XQhwngw
	mcssaFbGpDwse1hOneoPV6eBOaVyEHNcIY3m2r39kem8AWWm2bDDiYEhQrIT88O5
	vYdHUXndAI9XwCnr9+7UB89NifgqU6uKPV5OnKp8n0Emg=
Received: from [IPV6:240e:b8f:927e:5900:ed20:7e7a:6456:3b2c] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBXxffWbfdp1t+hCA--.253S2;
	Sun, 03 May 2026 23:46:33 +0800 (CST)
Message-ID: <699bd359-7389-45fa-a79b-10046f73bf12@163.com>
Date: Sun, 3 May 2026 23:46:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: cadence: Ensure that
 cdns_pcie_host_wait_for_link() waits 100 ms after link up
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, vigneshr@ti.com, robh@kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260501153553.66382-1-18255117159@163.com>
 <20260501153553.66382-2-18255117159@163.com>
 <4ce9f13a-b17f-4149-ade8-57519f4a4752@ti.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <4ce9f13a-b17f-4149-ade8-57519f4a4752@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBXxffWbfdp1t+hCA--.253S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFy5GryDJw1xXr4kCF1UAwb_yoW7XF15pa
	yUWFyxKF4IqrWYva1kA3W7ZryaqF95Aa47Gw4kKa4xArnrArWUtFsFgF13WrZIgr4qvr17
	Zw1jqF9rGF1avFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UOYFZUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBnpjWn3bdnkZQAA3S



On 5/2/26 13:18, Siddharth Vadapalli wrote:
> On 01/05/26 21:05, Hans Zhang wrote:
>> As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
>> greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
>> training completes before sending a Configuration Request.
>>
>> Add a new 'max_link_speed' field in struct cdns_pcie to record the
>> maximum supported (or currently configured) link speed of the controller.
>>
>> In cdns_pcie_host_wait_for_link(), after the link is reported as up,
>> insert a 100 ms delay if max_link_speed > 2 (i.e., > 5 GT/s). This
>> implements the required delay at the common Cadence host layer.
>>
>> Currently max_link_speed is zero-initialized, so the delay is not yet
>> active. Glue drivers must set max_link_speed appropriately to enable
>> the delay. This matches the approach taken for the Synopsys DWC
>> controller in commit 80dc18a0cba8d ("PCI: dwc: Ensure that
>> dw_pcie_wait_for_link() waits 100 ms after link up").
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   .../pci/controller/cadence/pcie-cadence-host-common.c    | 9 +++++++++
>>   drivers/pci/controller/cadence/pcie-cadence.h            | 2 ++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c 
>> b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>> index 2b0211870f02..d4ae762f423f 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>> @@ -14,6 +14,7 @@
>>   #include "pcie-cadence.h"
>>   #include "pcie-cadence-host-common.h"
>> +#include "../../pci.h"
>>   #define LINK_RETRAIN_TIMEOUT HZ
>> @@ -55,6 +56,14 @@ int cdns_pcie_host_wait_for_link(struct cdns_pcie 
>> *pcie,
>>       /* Check if the link is up or not */
>>       for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>>           if (pcie_link_up(pcie)) {
>> +            /*
>> +             * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
>> +             * supports Link speeds greater than 5.0 GT/s, software
>> +             * must wait a minimum of 100 ms after Link training
>> +             * completes before sending a Configuration Request.
>> +             */
>> +            if (pcie->max_link_speed > 2)
>> +                msleep(PCIE_RESET_CONFIG_WAIT_MS);
> 
> I think the above could be moved to cdns_pcie_host_start_link() as follows:
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c 
> b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> index 2b0211870f02..0f885dcbdb12 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> @@ -115,6 +115,15 @@ int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc,
>       if (!ret && rc->quirk_retrain_flag)
>           ret = cdns_pcie_retrain(pcie, pcie_link_up);
> 
> +    /*
> +     * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
> +     * supports Link speeds greater than 5.0 GT/s, software
> +     * must wait a minimum of 100 ms after Link training
> +     * completes before sending a Configuration Request.
> +     */
> +    if (!ret && pcie->max_link_speed > 2)
> +        msleep(PCIE_RESET_CONFIG_WAIT_MS);
> +
>       return ret;
>   }
>   EXPORT_SYMBOL_GPL(cdns_pcie_host_start_link);
> 
> This will avoid an additional and unnecessary delay when 
> 'cdns_pcie_retrain()' retrains the link.
> 
> Instead of checking for the link being up using "pcie_link_up(pcie)", 
> checking for 'ret' being zero should also work (ret being zero indicates 
> that the link is up).
> 
> Since configuration space accesses will not be performed until 
> cdns_pcie_host_start_link() completes executing, it should be safe to 
> switch to the above implementation.

Hi Siddharth,

I think this is applicable to LGA IP as per the method you mentioned. 
However, for HPA IP, additional repetitive code needs to be added in the 
following code.

Regarding the "quirk_retrain_flag" tag, I reviewed this submission 
record and it appears to be a workaround method. Can it be considered 
that it is not a universal method? Or is the same processing logic also 
added in the HPA?

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c 
b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
index 0f540bed58e8..65159f52067d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
@@ -305,6 +305,15 @@ int cdns_pcie_hpa_host_link_setup(struct 
cdns_pcie_rc *rc)
         if (ret)
                 dev_dbg(dev, "PCIe link never came up\n");

+       /*
+        * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
+        * supports Link speeds greater than 5.0 GT/s, software
+        * must wait a minimum of 100 ms after Link training
+        * completes before sending a Configuration Request.
+        */
+       if (pcie->max_link_speed > 2)
+               msleep(PCIE_RESET_CONFIG_WAIT_MS);
+
         return ret;
  }
  EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_link_setup);

Best regards,
Hans
> 
> 
>>               dev_info(dev, "Link up\n");
>>               return 0;
>>           }
> 
> [TRIMMED]
> 
> Regards,
> Siddharth.

