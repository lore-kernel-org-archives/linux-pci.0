Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB15556BA6
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874078; cv=none; b=EOAiJtN+uamwIYg7WhpzDVVmeBVHNl9nO/4q8I5FIMKFZ8zkhMGEMQQxrQAu18EqhGvZ7Z0W5HdqzgdZnrPgtV4cEtHK4SDHyhnUlZlKSrP0O1L8Rov0i3h/OSVeoQPsRZwk7gTU6uy2Jpmkol+xr0v23/fddsvHgZ46MnE9h8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874078; c=relaxed/simple;
	bh=RQ4g8roiCImK09lGOGkJ6W+2Czo4bfLHxiAgB+DarvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSqtNhbQh4Zjhf0iYjnkPF7F+yO9HpD4xI6JPKdLhZcJc/vWgybvFn9sBTd+srD8Cu527mAE7o1AAky7uZJk/dp9Nk9gWblmef24LJglQuw/ukhGZ4DRQ1GGUzwpKsWZW44Kgowk8gqZ2ByzPIU4eihDYr0EVkqjtbzFj4YNp44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=DXQaEx29; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="DXQaEx29"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-939b8a5584eso108034385a.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 06:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788874060; x=1789478860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ljmgwCAVphhfVW4k+b+cxvt43CtdExVqUZy6qEm1NMU=;
        b=DXQaEx29LC77ZbpreAKGiZc0qi8yflkH2u52JSPemq0owFlnGpGk4R5ITb1+wmcceU
         mC5NifB6mFjtKmrkXkV1XnzoqeKgmb+EtKQeRa7G+PGeDQFixEhY6SDS3J5MN7t1ff+B
         Jlyx1mIsUQrnt4rEA9KvYz9vkD8xYvoNHA/CKXc8n+Xf1+LNLhaqSpr8Dk8VNgk3lapc
         4ybSMPMegdiFbmGH89c2n7IDEuv8ANeFQx0/tmr4GUkzbG5n5+fjDkAjXQHSeXJIA7g6
         T7QQNEvP/Z1bl1XtvKjVCc7uuA6/IJvMmL3CiB7tTUgTNOpXyJWnpdpsncGPGl13EuHj
         t0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788874060; x=1789478860;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ljmgwCAVphhfVW4k+b+cxvt43CtdExVqUZy6qEm1NMU=;
        b=Got0b1SUpGttN4iUB/EOueTRnF70YLCNaqx75/0lISSYnsUJ+IQ8BsYB+VDh/5OXwS
         aWU8DRSIeO1yNEsUu+bnmta3Xd8uESu9GG9pxh8J6DoCzJv03gBobgjiswQ94rRLgWeJ
         pKu1/FbFdGtx8JIiZuOXQ+wd3YzKT8YVC0tlTPNoaEYSObnDMkeQfpzapPCxTF2zlG4K
         8mbMNtIiUNkoTG1LuokiTXlrNbyCuuPLuKB82TfOZfapWAS3Ahrg6TiBtQl1WWUe3aH0
         +mA1MbnBOH6l6uqZkvuEWU8U3OVMVT9wxEAcEJhe+XNWQ014hD7mN8du+iQvxQS0XBTE
         udyA==
X-Forwarded-Encrypted: i=1; AKwUvBzj9m7nsa59bUUyZGIg4U+1ExUkrw4u7I1pzjFgMmrTvJznb91v2208Fe70jl5J92fWs9kFOMD/UCI=@vger.kernel.org
X-Gm-Message-State: AFuF++kyg4plmG0VNBofXZEzRejU6IUF1nDI7LYxmMorBaj0h6rMAXTz
	kuuA5vJ0lMeQE40IPj6lYiqJHcD3FCd7LaSo/42yDY7FZk5dES3D7OpEOIIEVgpAu50=
X-Gm-Gg: AYBFou1VgUvbly18qtm+pcmdRAgZhZsAyGYZ7jxGKNC0U0tyQhWyQzeiI8I1AIa7iWz
	bLFlMs4xmt8PIdRYfAyJ1ffPGQ+eIN01ZxKZrHQUd6Y0l6O56d0BFlxphOp2lzJJvykBa3hFbm1
	fwkXDb+jEL+jGPDGbJtRwjCKVH9F2zp7RCoMEM21wpajKLT7JA/j0l8nO7eOoQXL370H/19jK1V
	HmM/pO5a/3YSPSFgOc7/vsxkIu2bAT4m0VweLax4FISOD7t7xHY2Ui/TU3wVm/FZfEqNAausfQ0
	e0OPoEhF+YjVeHZLJj3gy0z1L/VJAex9N05AzTBPAvlg+RKgG3Ckk4uwJSekVPn2j7t5sBYllGP
	pSs6Z0PIUQZXRRw+PrHNmmNprT+SuGsQiDw7cuxIiPOFHUqaO1C/P1ve1jEzrv2N9sPeymVHVRp
	uMhoxnMx52b8DRCcOtzZQXlSCAJ7RdPPnlHfTcfGQ3cNUTaJHVdqOp1wndi0z8
X-Received: by 2002:a05:620a:8198:b0:939:5cd3:75ce with SMTP id af79cd13be357-93980311c5bmr2025182085a.8.1788874059680;
        Tue, 08 Sep 2026 06:27:39 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939b8fbc1dbsm249492285a.11.2026.09.08.06.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 06:27:39 -0700 (PDT)
Message-ID: <abb6c06b-8e5a-4f05-a49f-2aca6ed0c634@riscstar.com>
Date: Tue, 8 Sep 2026 08:27:37 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] PCI/pwrctrl: tc9563: introduce support for
 embedded GPIO controller
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Michael Walle <mwalle@kernel.org>
Cc: Daniel Thompson <daniel@riscstar.com>,
 Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260904-pci-tc9563-aux-v3-0-5b1449d62ba2@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260904-pci-tc9563-aux-v3-0-5b1449d62ba2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/26 12:15 PM, Lorenzo Bianconi wrote:
> This series is based on pwrctrl upstream branch.

I'm accustomed to a cover page that's a bit more informative
than this about the subject of the series overall.  Your use
of --base (to produce the "base-commit" tag below) duplicates
(more specifically) the above statement anyway.

How about just a little bit of context about how the TC9563
uses an embedded GPIO controller that we now wish to also
use in another driver.  So this series isolates the access
to that IP block in a separate driver that can safely share
access?

You might even highlight that the TC9563 is an SoC that
*contains* a PCIe switch, but also contains other components
(including an I2C interface and GPIO controller).

Aside from that, the series looks good to me.  You just need
approval from the devicetree maintainers.

					-Alex
  > ---
> Changes in v3:
> - Describe gpio-controller support in TC9563 binding instead of defining
>    a gpio child node.
> - Link to v2: https://lore.kernel.org/r/20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com
> 
> Changes in v2:
> - Fix PCI_PWRCTRL_TC9563 Kconfig dependency
> - Move of_node refcounting management in tc9563_pwrctrl_adev_add().
> - Link to v1: https://lore.kernel.org/r/20260901-pci-tc9563-aux-v1-0-dd9b80738e70@oss.qualcomm.com
> 
> ---
> Alex Elder (1):
>        gpio: tc9563: Add support for the embedded GPIO controller
> 
> Lorenzo Bianconi (4):
>        dt-bindings: PCI: toshiba,tc9563: Document embedded GPIO controller
>        PCI/pwrctrl: tc9563: Add GPIO auxiliary device support
>        PCI/pwrctrl: tc9563: Switch per-port reset to GPIO descriptor API
>        arm64: dts: qcom: qcs6490-rb3gen2: Enable TC9563 embedded GPIO controller
> 
>   .../devicetree/bindings/pci/toshiba,tc9563.yaml    |  19 ++-
>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |   7 +-
>   drivers/gpio/Kconfig                               |  11 ++
>   drivers/gpio/Makefile                              |   1 +
>   drivers/gpio/gpio-tc9563.c                         |  99 +++++++++++++
>   drivers/pci/pwrctrl/Kconfig                        |   1 +
>   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 154 +++++++++++++++++++--
>   include/linux/soc/qcom/tc9563.h                    |  19 +++
>   8 files changed, 294 insertions(+), 17 deletions(-)
> ---
> base-commit: 028f86457e822ab9de5b0d6d23efddc1b8b54ae1
> change-id: 20260731-pci-tc9563-aux-66a29d438f60
> 
> Best regards,

