Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B34F32570E
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327060; cv=none; b=Nm3haL1TvdhigYUT8Qa8Gx2f30e/YT3ol5ppPd/n26oQHb/EC/zKz2SoMcuV7xYyxJ6SH54lZCpun+trnDFY4NmOfc5sMXQ73ayiqo0gLE8+omV2GANZ8svIgjAl0oI5r/btM9T0HptV7wB/IQm89cVjRmAluikPntL7MLCQcQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327060; c=relaxed/simple;
	bh=pnt9mYho1OLYYq8z1R3WqkcE9Kp1+7U4fT2eQICoqEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CN2sTyI8GtnjqAU2k5r+qWdFAshxLFmImAYx6lUo0e++6faF92W7aZnxP+W+E8PQ0Lh0hPulH9VsdmZNQLaE8HGEym0O09Kg57395ZvwRXKFPD/8lmBlIIYAnRNHdO7CE8G5DgOHf4AfffU6g9Pg7bUB9+NmgzZJXXqo0sJnceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TGDily55; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gBWZvBc7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TGDily55";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gBWZvBc7"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H6sZvc3393929
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bXzcNQ5nKcUIvQIjNa5pva4Vrg4am8MfgQQDhgWftsI=; b=TGDily55yVYZ//mU
	7MgomBhR+Orhy4k2PcISO0BgYb3SK3/QVaOZ+yUOzUBJlVRy3P9+FYfvCY/xO7o5
	dcVD8d65Xr1TUjTP9LbYqc/J2W4/L33hdT5FMfBvxFN1DTGfQlAL1d3bor4nbl1O
	sWSQkjgsUIWQJnPmHkUnqbpIdHmx+AY8VBG8XdEp5Tah81NB19mqB4fPyBAlf4L5
	//x0WojAruEqN4MNKvu+48ZEgdgVYzTKOhowR9HpyPsZcQ7kL2md0CNIUWbHVGRE
	PLop0u8tOHBenW5EJFbWmwK7KVg4k+iKjbZQHF/oVhHeMNLpe2Rc2hAfL5SPz+bH
	BT8yFw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc5kha963-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:17:38 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aaf0dbd073so50969375ad.3
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 03:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771327058; x=1771931858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bXzcNQ5nKcUIvQIjNa5pva4Vrg4am8MfgQQDhgWftsI=;
        b=gBWZvBc7RSAyMCYKs5N8wUMq01/uOzkdvExAsSKW0s9l7CgGzv3SFCUddLHduNtgHf
         Z3oisQQdcK7yE5ycno+LLPhNxahqoR+hPFufrBpZIDv/5nkZZQcF7U/8U+6vXkHVDjkg
         YsLp3k1gCf7Ghj4u/GBq1jSAq2TkJlB6X0O+8bfoDXVMzfwQHP37PuMQM11jr2Dmsqwp
         2/Hq2l4rqCMQ7PhOIRXS6n0A08kbenck2OucAE8TVST+MBCyX13cpyrAYSxSb3llkm2F
         XY0OdopWBBeA05+96j/A7ujs+h2SXPYl1ZhaNgx2J1IyDwoWiRGxuFBUSEp/B6T5tG66
         Y1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771327058; x=1771931858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXzcNQ5nKcUIvQIjNa5pva4Vrg4am8MfgQQDhgWftsI=;
        b=vR/qwA7tQQ+xLr5+VUt7RpsrBTZ0036kJwpQGjrN+0B1DU6TaYEmXYh7GHpPS548OV
         pI6BlcraEqSbqNvcmCi0D3j2UgmejGbhNkvq7jguiysehrO7gr7Pxao1xnv8gTwgqgwV
         tyCXFU7Agyqf1fN5QZpfUJn0KfaReACGxRpr77NhdcRDUZlphZNk+y527BmI7FiyFPUR
         8XUcCxRZNL51ELBhvBRcEFEeWbJS+xXUaV2krj+j3aYVnqYnEnf3Okpip7FIW4Gruw49
         8RvD2UjB/X66uE7KUtwP6vrfq479QzjcOdce+jf6Pz/UO/EStWFJzcQ0RJY4qtv+kEVL
         gQ5g==
X-Gm-Message-State: AOJu0YzZDtgQNhPRDD7HwTThYLrWG5baaXW5OhblZdHTB2pcQ7stBn7I
	NkIIIVlh/j65prMuHm0RkKnqdIsmUfisSUzc50kbBFoIlaljRtGZZFInpQfrjDczL1LUfbEiufL
	rhMwuPfa/96+uciX3jVD6RI8oML6MU/cMWqXL81BUlGUEShzMcb6m5MuA5/pIMcA=
X-Gm-Gg: AZuq6aJLOcw6fEK7mnXuuAvmqd39OXwm3oOdDmXV7bCDjIqaRv5P0e9jSJHE+/dj4ME
	6wDkGb70Pm4kxsK+iU/nprOeV3h3am88st8MBx+zUSl2jL76DO2o9T2eQPDKGvqccV62S0ZIS7l
	6z11Vkh98lQL7G8xvgd0exeXWfFg930Q+9ElSeCwaXw5HtWhFNUBGGDKoeGMsfwFOTLh3RllJVN
	nw75HBadLVpa2nh8TuE5nZdiIUKRso3U+tw79h+xbS2oxvcd2t24MgSSit249N4hACVdeGOxLC2
	F+7fQ8iYVsMFPq36eRMSBry3kOSq/4F+ix+b9hC+Ra/xkm6n2vpsB9DB5IRi4iN4TNBojrm2Zda
	GdzTZGHRI3eNq0YxVDNOxHMbGVEMNgdKq3FWW4gUIOFiEozqfNvFC5A==
X-Received: by 2002:a17:902:d2d1:b0:2a9:4bd9:bb8a with SMTP id d9443c01a7336-2ab505791ebmr117887035ad.25.1771327057569;
        Tue, 17 Feb 2026 03:17:37 -0800 (PST)
X-Received: by 2002:a17:902:d2d1:b0:2a9:4bd9:bb8a with SMTP id d9443c01a7336-2ab505791ebmr117886855ad.25.1771327057036;
        Tue, 17 Feb 2026 03:17:37 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e6d098sm22136069a91.8.2026.02.17.03.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 03:17:36 -0800 (PST)
Message-ID: <a9b5bbbc-a16c-451f-bfc3-806300f8b544@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 16:47:31 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/pwrctrl: Ensure that the remote endpoint node
 parent has the supply requirement
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
References: <20260217-pwrctrl-fixes-7-0-v1-0-b5671e58934f@oss.qualcomm.com>
 <20260217-pwrctrl-fixes-7-0-v1-1-b5671e58934f@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260217-pwrctrl-fixes-7-0-v1-1-b5671e58934f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Coyys34D c=1 sm=1 tr=0 ts=69944e52 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=K8oNYYlGQmOBDLWB964A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: WvuMjf0X5JwrgEYxDbbQ4NkIKV-QaWLd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA5NCBTYWx0ZWRfX2PPHcPi/0+vU
 9C6sJmoeTxrvQ8BlDRMwC0mPLfcsEej1KvXD2+ifl8pBiPHbh15kZRUHGvbGmvFze6qXnf9QfRC
 ceHZTlH+sQXN30HfsuN7wgBoVvEE59arEprEmhVHkhofIjTDQZtWJ3dXRs8nT8z2VyTEufp9nPR
 UDS6AKIsPVOFbGz4mhduUnCoTWVRFy2EOBbd4SB/xJsy0pcYSQZ2UbsModJCPIdbZ+T/VoiQZGU
 3Bf/xyL5CDcmeOlV07+Cm36G5UqTti6g6jpb7VavAgVkpvBwM8zcAgDBktjaMobMDMe86PLOYDZ
 BeMGfAd/LZTpd8tVyFlZVryCPnQxPmw3l3IipGHdwO2cjxrWVE78Ix9GxSWRAhqttaI51vNBctx
 Hf8eoGK7MRbHuIOiWa0T9GGOC05bM2kltl16rQR0O7wizPaNYsKVnFpf2fOs31fpUrCfc16wU7T
 D/wlnYkH55e0e3cHEfg==
X-Proofpoint-ORIG-GUID: WvuMjf0X5JwrgEYxDbbQ4NkIKV-QaWLd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170094



On 2/17/2026 3:48 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> If OF graph is used in the PCI device node, pwrctrl core currently creates
> the pwrctrl device even if the remote endpoint doesn't have the power
> supply requirements. Since the device doesn't have any power supply
> requirements, there was no pwrctrl driver to probe, leading to PCI
> controller driver probe deferral as it waits for all pwrctrl drivers to
> probe before starting bus scan.
>
> This issue happens with Qcom ath12k devices with WSI interface attached to
> the Qcom IPQ platforms.
>
> Fix this issue by checking for the existence of at least one power supply
> property in the remote endpoint parent node. To consolidate all the checks,
> create a new helper pci_pwrctrl_is_required() and move all the checks
> there.
>
> Fixes: 9db826206f9b ("PCI/pwrctrl: Create pwrctrl device if graph port is found")
> Reported-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Krishna Chaitanya Chundru<krishna.chundru@oss.qualcomm.com>

- Krishna Chaitanya.
> ---
>   drivers/pci/pwrctrl/core.c | 47 +++++++++++++++++++++++++++++++++-------------
>   1 file changed, 34 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 6f7dea6746e0..8325858cc379 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -268,6 +268,39 @@ int pci_pwrctrl_power_on_devices(struct device *parent)
>   }
>   EXPORT_SYMBOL_GPL(pci_pwrctrl_power_on_devices);
>   
> +/*
> + * Check whether the pwrctrl device really needs to be created or not. The
> + * pwrctrl device will only be created if the node satisfies below requirements:
> + *
> + * 1. Presence of compatible property to match against the pwrctrl driver (AND)
> + * 2. At least one of the power supplies defined in the devicetree node of the
> + *    device (OR) in the remote endpoint parent node to indicate pwrctrl
> + *    requirement.
> + */
> +static bool pci_pwrctrl_is_required(struct device_node *np)
> +{
> +	struct device_node *endpoint;
> +
> +	if (!of_property_present(np, "compatible"))
> +		return false;
> +
> +	if (of_pci_supply_present(np))
> +		return true;
> +
> +	if (of_graph_is_present(np)) {
> +		for_each_endpoint_of_node(np, endpoint) {
> +			struct device_node *remote __free(device_node) =
> +				of_graph_get_remote_port_parent(endpoint);
> +			if (remote) {
> +				if (of_pci_supply_present(remote))
> +					return true;
> +			}
> +		}
> +	}
> +
> +	return false;
> +}
> +
>   static int pci_pwrctrl_create_device(struct device_node *np,
>   				     struct device *parent)
>   {
> @@ -287,19 +320,7 @@ static int pci_pwrctrl_create_device(struct device_node *np,
>   		return 0;
>   	}
>   
> -	/*
> -	 * Sanity check to make sure that the node has the compatible property
> -	 * to allow driver binding.
> -	 */
> -	if (!of_property_present(np, "compatible"))
> -		return 0;
> -
> -	/*
> -	 * Check whether the pwrctrl device really needs to be created or not.
> -	 * This is decided based on at least one of the power supplies defined
> -	 * in the devicetree node of the device or the graph property.
> -	 */
> -	if (!of_pci_supply_present(np) && !of_graph_is_present(np)) {
> +	if (!pci_pwrctrl_is_required(np)) {
>   		dev_dbg(parent, "Skipping OF node: %s\n", np->name);
>   		return 0;
>   	}
>

