Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7453348F824
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726531; cv=none; b=QgN/YoBjuN8spoOqAeAiMc1W+r8GGF79/qqyky4z262vr/OGZeJHjsoIg0zSYmXrSC6+oUmM0Ido2R/TR2gDCBGKObrvUqmrfsRddW2hAjBPdujoju8aXJWcfooZoJ/fiCnOOnFRKJbw8597LgnvJ6rEh1Up93Mzp8iIyfgOXvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726531; c=relaxed/simple;
	bh=K5dcQJf2Ch/6vpTqCE5mVe/Cn73el9CTj0AfswwkkrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBWwlBEUWW8bzU2/0Ff1HrzdU/R1FdWxcDmXyarzbdbHimPZJuA8sbeCrm3m3gqoqbrK86+p4olx3U8zcSCAurKw9hstuDlXa4OBOKWtw1Ke6cLulZ/lyYJRIEZe4AI3rzLsOHpQUZ+C93NF5nUwstZe84baQqdpev5+1mLS3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=hZl4XSeo; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="hZl4XSeo"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c2a449c57so7674931cf.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786726528; x=1787331328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=anIgQ2iX3wKwO3iZRXoJM1Kp7efYwEyDsRDYZCL7bQI=;
        b=hZl4XSeoJSQ1E5VaDwJCpUi82lFCjvf5F0Qc4TmiLi/n0N5YNnVq0wg/W8oZu42xfn
         Qw/MtJWsT2x+peeaBieNucWefU96eullYWPr5ut7AMvRNE9+kaItWj7KLt3ozSGWjQu+
         mHsElWeA+U7auxXZpBd9Hozvvd2Oio/ijZsyGYU6wbEuxKl9ZgyMU5eyIhgnAyajRX/S
         r3E2QEHU92X8i/STt2500nr9b1jF/n5qz2X4K2+5Hjw8TKviLmw0fCQ18IP++Ee15bkU
         kFcd5b0Xg6cw/Im6eNPbpfPu+YehOJk0FogK6ECA33dtbuCYBeYqaI7D5oCAGVYi9Hpo
         vKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786726528; x=1787331328;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=anIgQ2iX3wKwO3iZRXoJM1Kp7efYwEyDsRDYZCL7bQI=;
        b=Q2zNEGDrZfYFsbdr66CENAYA3Sn9Fw7L6PnCWYaSnnfN/aR3n3zpQcz7OsVBU7Hr02
         c9EMfNpRJq4S3EEfQhuPbrVtTRJgvdEYsd9O0y7mqi9ljgvYBl5VW9MQ27FzNLLsyp81
         RghJL67CJqYnxFnoW9vQxRsOY6wsfTnq3EyKvu4phGr+qnLcIAEc+VMaZbArI7KjuLyZ
         TPsb2yJon+E2Bau49AVQBPOCwMOqwOPUisXagOzSikzmed6HPoFB4xjllnZ9pnv4TV7z
         6EAlfmoYjfVXxzi0yhjBGaiAa0lrNnpAxbUOU7/zGd4MkPtiHsqbXdA8pdZZ2p2ECOQs
         Ba6g==
X-Forwarded-Encrypted: i=1; AHgh+Rpz6dokQWPbxo8V4FOSynk4WG7HeIkerQ3qWomXNs4879TitVcLfarWTqm+7EruRdxfMrh6zFnFREk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+czi7mJsGnTFE2/zkOVF6VxsKmWLeS84UR9jwvpQuiCQ4zu8
	n490/rTFZfizT5aQFgQQw60nTYfyQo6Zog3MRpX2Bur+nN+iemazF14LV8JNsDeMZF4=
X-Gm-Gg: AR+sD11Y8Lxm0lU6ByseAYrP/JhFDezVQ1vnJNwL+Y/AVF+7AX+QPot16J4BJuxkjee
	YuX/ooefWlhPWmiX9ovBXY0vtkg7W33SaQuJscC7+EMUA5cCWGKJsQM2Pm3zkz3dViLQQMaHCfz
	Bci2DxTFpNx6bGz371GVrHz56GGUyXFkI3ePTrDpxiGFCxzwm1r6L/OvPdiTjoMkD5bpyDD9JhY
	+co08N/xx9bhKAOWB5BviACZ92hA3rgMpxl17cQnFFmnPfOMEiyTaFBR3BkkZnV8RMXN6yPgzwK
	eWiwO+MR9Rpo8Fd+ZEmViQpzzQS35rCYTWWjeM7PWxF9zp6sK4Iz6JyqnhbbosGYmzeVqzFwF89
	N4W7JoRTjJ4Av7lXfp6Eddcc3XLr336xOnuon52xfOnVMyCMWGDKwFWglqo4/6PWQZOeK8Ov7BB
	GOpuYXj5TgSE9/7b/Z5WvZf7I7nIXsGKzapSzcX3EdcLFYD8ovSMv5cIL7guNDBL5I7aDX0zY=
X-Received: by 2002:a05:622a:17c5:b0:51b:fadc:ed7d with SMTP id d75a77b69052e-52d855893ccmr86941561cf.44.1786726528261;
        Fri, 14 Aug 2026 09:55:28 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d84071799sm24476161cf.20.2026.08.14.09.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 09:55:27 -0700 (PDT)
Message-ID: <d00b4b0f-5958-4c7d-9f80-7fb283ef90e6@riscstar.com>
Date: Fri, 14 Aug 2026 11:55:26 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] misc: tc9564: introduce base PCI driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, bhelgaas@google.com, daniel@riscstar.com,
 mohdayaa@qti.qualcomm.com, lbiancon@qti.qualcomm.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260813222943.1655453-1-elder@riscstar.com>
 <20260813222943.1655453-3-elder@riscstar.com>
 <20260814-rainbow-alchemical-gaur-9fd8de@quoll>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260814-rainbow-alchemical-gaur-9fd8de@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/26 2:03 AM, Krzysztof Kozlowski wrote:
> On Thu, Aug 13, 2026 at 05:29:42PM -0500, Alex Elder wrote:
>> +static struct pci_driver tc9564_function_driver = {
>> +	.name		= DRIVER_NAME,
>> +	.id_table	= tc9564_function_id_table,
>> +	.probe		= tc9564_function_probe,
>> +	.remove		= tc9564_function_remove,
>> +	.driver		= {
>> +		.name		= DRIVER_NAME,
>> +		.owner		= THIS_MODULE,
> 
> You just copied some old driver. Why do you need this?

What do you mean I "just copied some old driver"?

I do now see that a PCI driver doesn't need to set it,
because pci_register_driver() sets it automatically.

I will remove that in the next version.

					-Alex>
>> +	},
>> +};
>> +module_pci_driver(tc9564_function_driver);
>> +
>> +MODULE_DESCRIPTION("Toshiba TC9564 PCIe Embedded Function Driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 6501c949c5b76..b484f1b1d0e71 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -6388,6 +6388,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, of_pci_make_dev_node);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TOSHIBA, 0x0220, of_pci_make_dev_node);
>>   
>>   /*
>>    * Devices known to require a longer delay before first config space access
>> -- 
>> 2.53.0
>>

