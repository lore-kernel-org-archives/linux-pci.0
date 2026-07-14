Received: from mail-qk2-f0.google.com (mail-qk2-f0.google.com [74.125.230.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047C943FD0E
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034206; cv=none; b=Q9oXuVNkpgpJxfsn9f97WmxCyoaV6WjP/QtW/qeNdvEjD8JcYN733Xr6AOtpxU3C3ODguSczHeBhjZP0SQXa9hI3TcNnvHGBLe2IlrHtZPmLp01Eb+2owtGVKrwtkc1n0ceXU8+URpRql6Y96i6gUL7YScyI9eOhP/1V41ONOuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034206; c=relaxed/simple;
	bh=rC2Kqe+sU5PqXGlFedUh2OqBv9Iid7OTb3etgq6VA5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEQbwKOAAaD9UHpi9CToRllGxf8UZBdVTAtmDD9RriOZTG6KDJcRa1IcHfRHxHP7Q6ICV3YdxOK4fuE6dcgFGW8sNdiUN2F90U2ChZzZkvXA7mrfqFunxELIF8buxODkcDdPGZ6q3sKXE28yj5qUI1ipM0yVA3fpUa8J0YmxmdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5nO1cBW; arc=none smtp.client-ip=74.125.230.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5nO1cBW"
Received: by mail-qk2-f0.google.com with SMTP id af79cd13be357-91d4455ff18so39777685a.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784034204; x=1784639004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CfSJmEAZPFbCA1isHeIkUteGlC+Qb4lvv34SMSUfW2g=;
        b=C5nO1cBWSQyr97QPStTj+iSNGp8a4mXZ3x0U0lPw/CakKEPR5izHEL1N71TjCuBbcS
         92r2E11z75GsKn0+T0pWrB6eRGrN2Bz7KQJseqII7EoTDSrdRX0HKNx4uu+4hjn2fExt
         0HZycZ4kgvDK4vm+dC8Z60t7Qjq9AzqL/EvqMOBuFV8Zbfm/YOLyaa6F13FzIRvpGhOW
         QOelQVkyQeFBrgpzO9BczNJAI+tyhnlEMZ9bSNXkAEw+Tm5nRsI7vrQn1vHTb6+XU5Om
         WhPX+tUn+ls4s6j/XKDvSXgEFEfOfTHqqTVr/0ujtea5uid5RauC160BTyusoTZNxroW
         UPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034204; x=1784639004;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CfSJmEAZPFbCA1isHeIkUteGlC+Qb4lvv34SMSUfW2g=;
        b=EzLd5iMK/rJqHCBZZ7m95w0n8509sm+hDdMMvVkpuHr7zZGkXedBZDWpe+Jrq3OPFh
         GWoT+ufm92xa928HqFYE4O23s1ZuZtTsUBu82tABYC0nlr9wHuIq70GIHFjj6Dj78YXK
         hqXw+DfK00hg8DHGUunY5mbZbVsPSbiUCGwqnXeP8pNTEzqvncXcCmcwO5xDwav3bw1A
         hIvpOlNWZCd5FZadJqJQ+4L9CtuNycR2eWC9zm3oTAoKmC0FbBRPOvbnYhNlQ8vQnAh9
         iV+r75a7vYKGyl78+ZBu+fABnrjgrymuXYqEi89pcDnIr0ocOlMlX9QTnUlCkEfRZJcX
         c4AA==
X-Gm-Message-State: AOJu0YycRyNTH9LNS2Fy6lH0otUjG51tyrXMqTq46Kqf+Hlzs5KUYbf+
	uLvvDHoGDV7HrlW0ACjHQQxb6caRCrn0w2WjE2wiATQeN9RSLPfPXZXkTrK2lyUTLqk=
X-Gm-Gg: AfdE7cmDLoQ8iaOS5P9xAjuEVe31AQOuBlmWBFVV3+QI04NJBSblv0NjxAXnfIx3Fk8
	v1eVwE9OT/+EZt/MTIE3ENNRkdzayq4KQHGLnqOZdHUT/cVbS31hr8xzpHw/KxZw56Rih47XLcE
	Fwd74M8MRNwm45BrdXwToetw/TUeYYQV20EAtiFc310ZViPlyJURmWvQVt96ZU2SfdgLefj62Zy
	lmk1LfTbRtGXXtfmyhJTvoutWlAu7aJCrgyTeZtbkBr76KRvcolshH8BRK+dX2EdcmQL20basGO
	4tLSRUaDhGwICuNe+fH0EvrIeZbyRgjXdnOAi+hwS9nVNoxi9iCbs1rSTi0V8hEObEeTPXlB2aZ
	OtRFp8LkWc2vrRKGbHj8WLPabaVehyVL3JWUg2EvJddyBZITMJQJJbHapxHz0Tae5FWQ98Us4dE
	E7AdH/jHUTzqd999x2ncerUg==
X-Received: by 2002:a05:622a:1f8f:b0:51c:7b12:5ff1 with SMTP id d75a77b69052e-51cbf3e12bcmr115593901cf.77.1784034121716;
        Tue, 14 Jul 2026 06:02:01 -0700 (PDT)
Received: from [192.168.101.113] ([45.249.9.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caacad0cfsm117138491cf.8.2026.07.14.06.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 06:02:01 -0700 (PDT)
Message-ID: <4f0c1daa-dbc5-4a3c-8914-253372deec8b@gmail.com>
Date: Tue, 14 Jul 2026 18:01:53 +0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: starfive: Fix unchecked pm_runtime_get_sync() in
 probe
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20260712175427.232234-1-alitariq45892@gmail.com>
 <20260712180440.423421F000E9@smtp.kernel.org>
Content-Language: en-US
From: Ali Tariq <alitariq45892@gmail.com>
In-Reply-To: <20260712180440.423421F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/12/26 11:04 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The driver's removal path incorrectly calls asynchronous pm_runtime_put() before pm_runtime_disable(), and tears down PM references before disabling the hardware.
> - [High] Failure in starfive_pcie_clk_rst_init() returns directly without powering off the PHY, causing a resource leak.
> - [High] Missing return statement after regulator_enable() failure causes a silent fallthrough, later leading to an unbalanced regulator_disable().
> --
> 
> --- Patch [1]: [PATCH] PCI: starfive: Fix unchecked pm_runtime_get_sync() in probe ---
> commit 83a329f8aee98c4aec071468fc96ecc89497124e
> Author: Ali Tariq <alitariq45892@gmail.com>
> 
> PCI: starfive: Fix unchecked pm_runtime_get_sync() in probe
> 
> This patch replaces pm_runtime_get_sync() with pm_runtime_resume_and_get()
> in starfive_pcie_probe() to properly handle runtime resume failures. It
> adds error handling to disable runtime PM and bail out of the probe
> function if the device fails to resume, preventing unbalanced usage
> counters and hardware configuration on an unpowered device.
> 
>> diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
>> index 298036c3e7f94..e9a472985b8ac 100644
>> --- a/drivers/pci/controller/plda/pcie-starfive.c
>> +++ b/drivers/pci/controller/plda/pcie-starfive.c
>> @@ -410,7 +410,11 @@ static int starfive_pcie_probe(struct platform_device *pdev)
>>   		return ret;
>>   
>>   	pm_runtime_enable(&pdev->dev);
>> -	pm_runtime_get_sync(&pdev->dev);
>> +	ret = pm_runtime_resume_and_get(&pdev->dev);
>> +	if (ret < 0) {
>> +		pm_runtime_disable(&pdev->dev);
>> +		return dev_err_probe(dev, ret, "failed to resume device\n");
>> +	}
>>   
>>   	plda->host_ops = &sf_host_ops;
>>   	plda->num_events = PLDA_MAX_EVENT_NUM;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but looking at starfive_pcie_remove():
> 
> drivers/pci/controller/plda/pcie-starfive.c:starfive_pcie_remove() {
>      ...
> 	pm_runtime_put(&pdev->dev);
> 	pm_runtime_disable(&pdev->dev);
> 	plda_pcie_host_deinit(&pcie->plda);
>      ...
> }
> 
> Does this leave the hardware in an active power state upon module unload?
> 
> Since pm_runtime_put() is asynchronous, wouldn't calling pm_runtime_disable()
> immediately afterward risk canceling the idle/suspend work?
> 
> Also, does tearing down the PM reference before stopping the PCIe host
> controller via plda_pcie_host_deinit() reverse the proper teardown order?
> Could this cause the device to power off while still being actively accessed
> by the core?

This is fixed in a separate patch [1].

> [Severity: High]
> This is a pre-existing issue, but I noticed a potential resource leak in
> starfive_pcie_host_init():
> 
> drivers/pci/controller/plda/pcie-starfive.c:starfive_pcie_host_init() {
>      ...
> 	ret = starfive_pcie_enable_phy(dev, pcie);
> 	if (ret)
> 		return ret;

I do not think we need to call starfive_pcie_disable_phy() here inside
the error handling. If starfive_pcie_enable_phy() fails, its internal 
error path already cleans up by calling phy_exit() via the 'err_phy_on' 
label. Calling starfive_pcie_disable_phy() here would cause a redundant, 
unbalanced phy_exit() call.

>      ...
> 	ret = starfive_pcie_clk_rst_init(pcie);
> 	if (ret)
> 		return ret;
>      ...
> }
> 
> If starfive_pcie_clk_rst_init() fails, it returns the error code directly.
> Does this fail to clean up the successfully initialized PHY?
> 

This is fixed in a separate patch [2].

> [Severity: High]
> This is a pre-existing issue, but does this code swallow the regulator error?
> 
> drivers/pci/controller/plda/pcie-starfive.c:starfive_pcie_host_init() {
>      ...
> 	if (pcie->vpcie3v3) {
> 		ret = regulator_enable(pcie->vpcie3v3);
> 		if (ret)
> 			dev_err_probe(dev, ret, "failed to enable vpcie3v3 regulator\n");
> 	}
>      ...
> }
> 
> Because there is no return statement after dev_err_probe(), the function
> proceeds and eventually returns success at the end. Could this cause the
> driver to continue operating with unpowered hardware?
> 
> Later on, starfive_pcie_host_deinit() unconditionally calls
> regulator_disable(). Since the regulator was not successfully enabled,
> would this trigger an unbalanced disable warning in the regulator core and
> corrupt regulator use counts?
> 

This is also fixed in a separate patch [2].

[1] 
https://lore.kernel.org/linux-pci/20260713145014.740898-1-alitariq45892@gmail.com/T/#u
[2] 
https://lore.kernel.org/linux-pci/20260714113029.326207-1-alitariq45892@gmail.com/T/#u

