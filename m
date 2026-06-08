Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D402C15BB
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780879041; cv=none; b=J0BKH6+yP3eabxvtVIY+k0fNNJvXt7pkg3iC5nQw2YZu0GJ4rshTgTjnsJd66gEy4YB4VN59Cb6ucTAZaKeDvzJdIc5bQhhZ5oMG3ZruGL8HsJ63nSL1PaTN11OwRIxDDYwb1cnwQ8mU+LkgDAoVpYm96IwI6F/8fhiun7swCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780879041; c=relaxed/simple;
	bh=cbQSqd5uL2iKZXD9QIiW866G8yMZD7yl2KWSR4aU6x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JtLfdOCESKUuiD03A0uQTy6vAv7AbHq3dZisNYEOszBjaL6xVWKI4PV7OfrI9tTaRj5Tquk7hz0QuKoaG6me3a79yQYh1gufvurmiV5VtvNGcMmCrTZMhOqffIEXFJsDNxaZFe0zBbCtJBj+b2UWk0q/TRbQkpLw8yEFk8J29Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti+ZYGtR; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti+ZYGtR"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-137335bc3caso4415833c88.0
        for <linux-pci@vger.kernel.org>; Sun, 07 Jun 2026 17:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780879038; x=1781483838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rsDQ4UZzRAQ5obFtcMk+V/ytcJzk5rFjcVjggi4FGCA=;
        b=Ti+ZYGtRLhjL8aVorvlO8o2ZpCEQcTqP2lpt9cn4hCJw6sJuOuqCMXBWSZhvYMLE8w
         uUi9sPSe3bV0Py33IqDnsJnXs2wnvpikJX7FWBbNZC/H8fl8W3C0ukmVx9QEXGStj7gd
         xZDLVZMVEFcghdZEbEzNW2lJSGg2zk8sJil+7Dt8MkQMq0UqTWueO9bwyER5U2jzZqoY
         RamrcWoUpia/VgZpElllISVYf+2aQbcM40+97wPIypOhCB8AZOiRPNc1GRDi1e3dYw/q
         uzQgtHoAnL44J1d2cA4FqSv7iF7Xeh3IS366yvLGBh8fKs5zEJXmad4//xLb1uZ6JVp7
         jynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780879038; x=1781483838;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsDQ4UZzRAQ5obFtcMk+V/ytcJzk5rFjcVjggi4FGCA=;
        b=JgqNb1MoqSaJjMY/UAvWm/xrO58lF5ZfvF4sogULhZT3UKCYEe0HAfkg9Rn0XTQ94Q
         bRoOnVPfVLfEMnBz+vbQE0M4O21mZelWqJZf+t7dAXsMRmnSQOO5PE1gLhNAPONsMoGC
         oibUuaf8Cjx8E18eHr8O0QMJUInGiOGzu0p5NOZP1g81OLvf3EihUjKMLScoX2XyHEYo
         HmMm28M/V0ztBQsn1oJgJOtn8zwedH2UnTa53w/9pd2aOfYo0IMGaqFFmqrcoTSomUbO
         Mac3Js7gmdpwKO9iEAiSurvti3FmT8xPLQwfgmrwXuJ89P4JnBD4ffyXcFZVKoH+r6Ja
         Uaag==
X-Gm-Message-State: AOJu0YzDIkjll4MAJ2ueSweJxDaispImg4NKqIrYiVWICKsNgygfqSua
	cWgYtohwX5x4MkJZOpYj8DAbKcGA5sJgz0q0EELSDq1qYUd/oCI09WuN
X-Gm-Gg: Acq92OFm76eJfr7g0T7oPaak0IHNB0EwVTMZ5ozRdgNcHy9jN2uVsF7kP3wGci3KxpT
	jB9kLdAW7hXVfuIuOThqs60OczeSqIdEjEXEt6S4ALEQkl2sldoVd6czC5TuNo6ixOweSDtIs9W
	uJlFdZbE+LVkTBfRNlZRXXwb61AjbnVuo88gp1JusWuvw7jCRg5T2gmrCuSSzM4pRzip79oIpjn
	/XTtKUMEH26OOcI6xHQVrk4zlKwikzYsFEZWzU6l/OPR1t18Swaw0TG6F/yFMqwyLmZYy7fJYJD
	UVn6EVkkPkkO4YQUyH3BADvKD24rRRxl8L6HCty69E/GfMS7d96i4ZTpQuI6d4kcgePLwVE7f24
	7i0OBs7FxCslLu2vKpKT92f4963GR0N1YohlcRJ593Y6s6y3wRQeJ4g2jwVSaxteiMppzkPaP5z
	UGTElrrtxWmA1VHHU1OaB84yEGbKE3NmiLqJfvxLj3HVlU+BUJA713RqFJssElu+AERJzf0xTjZ
	KYbiwIcBOlh1nT9VO0A9g==
X-Received: by 2002:a05:7300:d70d:b0:304:c520:4e14 with SMTP id 5a478bee46e88-3077b32888bmr8065408eec.11.1780879037946;
        Sun, 07 Jun 2026 17:37:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db528dcsm18102986eec.3.2026.06.07.17.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 17:37:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ea12eccf-a35a-4e1d-8837-83d85dc0d679@roeck-us.net>
Date: Sun, 7 Jun 2026 17:37:16 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: (k10temp) Add thermal support for AMD 1Ah
 Family Models 80h-8Fh
To: Muralidhara M K <muralidhara.mk@amd.com>, clemens@ladisch.de,
 bhelgaas@google.com, bp@alien8.de
Cc: linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260529111242.2748206-1-muralidhara.mk@amd.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260529111242.2748206-1-muralidhara.mk@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/26 04:12, Muralidhara M K wrote:
> Add the new PCI Device ID for AMD 1Ah Family 80h-8Fh Models and wire
> it into the k10temp PCI device table so that thermal monitoring works
> out of the box on these processors.
> 
> Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
> ---
>   drivers/hwmon/k10temp.c | 1 +
>   include/linux/pci_ids.h | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index a5d8f45b7881..8e8614cdfcda 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -568,6 +568,7 @@ static const struct pci_device_id k10temp_id_table[] = {
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3) },
>   	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>   	{}
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 24cb42f66e4b..3301224c5845 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -585,6 +585,7 @@
>   #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
>   #define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
>   #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
> +#define PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3 0x1243
>   #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
>   #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
>   #define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a


As Sashiko pointed out, this device ID should be defined in
drivers/hwmon/k10temp.c (unless it is used elsewhere, and then it
should be defined in a separate patch).

Guenter

