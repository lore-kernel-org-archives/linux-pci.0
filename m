Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641423BE155
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882933; cv=none; b=qN+6rqTlpLET2qlRCkIDMBUj2XfUFK8Udmn9sPYhi+regOMwRGFYVGMDeZ/REsEcRdCiGS1KgrBQxJctkuLH4ZSLClcYEy4f9UPAUaao5E8RUYxUsGMR7PMq7kQIuE8kyIKshKuADnLCKNJC/k6DibL3zHez4w+Q1c6GRHJcgnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882933; c=relaxed/simple;
	bh=YoWO1uZ6XfmRu/nuSKAH9yuafS0EX+S6pIOALHqhJqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4va3256l4QUe9GF70q3OHJnVRavxDj8KjipuDE2ektRkXUSwknDQSIe+lSovI2J2HacrEKmYMIo0nJQjx3Cvqoevgf45Ycy1M27LPMhdPXAn095UXCBJZxRd4RQDHJaXEYZzh08rZ34Ozyg36sEtJ/ZTsFu8mpELIjfndTSThw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nP7TA9DM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP7TA9DM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1682bff3cso12917045e9.1
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 02:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791882931; x=1792487731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gMyxaXXvU9op18W95PhIMdi3fsVmWdUMGH6XFjptvKI=;
        b=nP7TA9DMN60winnguVsOkG7OG577yfLaZI/FWTHkTzR+VD0CMag4+f5wjQ1K5XuJBI
         /IoSb+4DdrMV9weUJPGwaFnsUt8Xn+Qx7H/coLIBaghvtyLw61j27pKu0ogWuv2mGsPI
         1g1+HGtEw3U12SHvrz6mGKSXnqGe5lq5b/+m8EUKwsyysJOioPzW+KDryDd+n5hum4vP
         czsD6EiycZAroub7iWh0a1Gfe9O9heaZiVXKLhuhNlJ09HhUyEUrceH9/Ms9QherM2c7
         y+z3mhNzDwOK0clfuQseacH+NOOxQ5FgxjYfMDDbBrQhN3QIAi+HFucGkA+sbSVzYj/b
         jfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791882931; x=1792487731;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gMyxaXXvU9op18W95PhIMdi3fsVmWdUMGH6XFjptvKI=;
        b=1A0GFwAPVv87OMZqjVrhEqliS4lHNAPhyUd/iEn1iBVfSN31WgKTUCzZHoWgqrkvsn
         jJoqpmVgT+FORtYBFqfH6folpYSR5TslBXHLRxRLZHKeF8Xbf0LUqZbqxBWsHa/XYPZb
         12yFAeUXOVD0l/i93mSChlzSGKCDftQzMp0Tlxc1U7+3ON2R32M5WrFA+3Qqbo8L6STd
         8hl03nfyd/CT2PsGMWxwPBXLEqyYCQx04q5f+6qPmReWJUEMS9jQNug6BKd/BYs1isOd
         hVRDW+oCOUBW4EZMlDUUcMHEJMNBn8AS3CYGu5nyDRq+lS0yv4pxYH/xK+JgpC4xukn/
         3v8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwDK3PfsgvI/FBhMKDWbu9CJIcBo/11Zob36O/MZaaRmXeFGfY+EDNHW7BYEOgUyWs7CpsJ6TWuu8Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAFlMwdb69oVbE/OrZ0SWpapgkJhoN/9kGmuQ6ALjI0X6rN/vi
	C+hbHFaySNdy3h0qbavUT8JSWjk0ql98Us4V3Y0MAoAzRTrT4sPJie2Z
X-Gm-Gg: AYBFou30V7JiQMeMEkaz85StRexkEqoljqpq3NwnSg1Vn2UGGErXAH9kaBht9PGWMgo
	ln/13ZdODz/CgMEmT7ELzeLgMpiQ4oBlS58AJXWxwTR1oKSWSKDm5rpjC4PeJQu6DvNpD4Gljm3
	h/cH/I6OTqxkrajv30bzsK/FT2PWrCulzCgzZW9vqR8IJaWcsOjsBSL7U9P9iImjydI5uXnpkB5
	+qvoJWHPpsItg4qrMzUn+jkPr84T1Se+XDio7HiHJ/qZm6F9LeVABNiq+vtw6S+qq/Cpf7ab+Wz
	9L3D52rkZSLsIBbDFqLbe9jkJ/6eW+TnAmwSkmwsxJWpeLtohvXTc6K4oRz2G9dSG0oY8sEmape
	bkTuasHeHR9F7d8+DXBONEN86mRx9w3/LxUH4NH+hDm5rhy+bLqoFlmihaoMi5s720UuDV7KxGs
	bArkYZ7yOQjjSE2s2GOyIsmD2/Ow8K17xcxrkIsHKPjpHIKPGGeSALyzvbnieqh/MynqekZkNI5
	v5IJhG6YzuFNephBAT4OD1WyY+BuwO0JnqcQqbwz4LHWCW2WfJkKLgBza9UWTB1T/zAlKyWE24D
	vrQxSFaL8+dTYhKxtF6FYNBS4QKPOW3dZ45uzCP1lrPPmw==
X-Received: by 2002:a05:600c:4593:b0:4a1:7ed5:99e8 with SMTP id 5b1f17b1804b1-4a18e49bffbmr232748425e9.22.1791882930410;
        Tue, 13 Oct 2026 02:15:30 -0700 (PDT)
Received: from franzs-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19471edd5sm448488855e9.11.2026.10.13.02.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:15:29 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:15:28 +0200
From: Franz Schnyder <fra.schnyder@gmail.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
	Shawn Lin <shawn.lin@rock-chips.com>, Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v4 0/6] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
Message-ID: <wsrntkojtitvhprw7q5sabqcvih24mpfwiwiq5e4fg6d2tkixs@6q2vtdfo4shr>
References: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>

On Wed, Jan 07, 2026 at 01:41:53PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series reworks the dw_pcie_wait_for_link() API to allow the callers to
> detect the absence of the device on the bus and skip the failure.
> 
> Compared to v2, I've reworked the patch 2 to improve the API further and
> dropped the patch 1 that got applied (hence changed the subject). I've also
> modified the error code based on the feedback in v2 to return -ENODEV if device
> is not detected on the bus and -ETIMEDOUT otherwise. This allows the callers to
> skip the failure if device is not detected and handle error for other failure.
> 
> Testing
> =======
> 
> Tested this series on Rb3Gen2 board without powering on the PCIe switch. Now the
> dw_pcie_wait_for_link() API prints:
> 
> 	qcom-pcie 1c08000.pcie: Device not found
> 
> Instead of the previous log:
> 
> 	qcom-pcie 1c08000.pcie: Phy link never came up
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Changes in v4:
> - Skipped returning failure during resume as well if no device is found
> - Link to v3: https://lore.kernel.org/r/20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com
> 
> Changes in v3:
> - Dropped patch 1 that got appplied
> - Reworked the error handling of dw_pcie_wait_for_link() API further
> - Link to v2: https://lore.kernel.org/r/20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com
> 
> Changes in v2:
> - Changed the logic to check for Detect.Quiet/Active states
> - Collected tags and rebased on top of v6.19-rc1
> - Link to v1: https://lore.kernel.org/r/20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com
> 
> ---
> Manivannan Sadhasivam (6):
>       PCI: dwc: Return -ENODEV from dw_pcie_wait_for_link() if device is not found
>       PCI: dwc: Rename and move ltssm_status_string() to pcie-designware.c
>       PCI: dwc: Rework the error print of dw_pcie_wait_for_link()
>       PCI: dwc: Only skip the dw_pcie_wait_for_link() failure if it returns -ENODEV
>       PCI: host-common: Add an API to check for any device under the Root Ports
>       PCI: dwc: Skip failure during dw_pcie_resume_noirq() if no device is available
> 
>  .../pci/controller/dwc/pcie-designware-debugfs.c   | 54 +---------------
>  drivers/pci/controller/dwc/pcie-designware-host.c  | 23 +++++--
>  drivers/pci/controller/dwc/pcie-designware.c       | 75 +++++++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h       |  2 +
>  drivers/pci/controller/pci-host-common.c           | 21 ++++++
>  drivers/pci/controller/pci-host-common.h           |  2 +
>  6 files changed, 115 insertions(+), 62 deletions(-)
> ---
> base-commit: 68ac85fb42cfeb081cf029acdd8aace55ed375a2
> change-id: 20251119-pci-dwc-suspend-rework-8b0515a38679
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 

Hi Mani,

Is there any reason patches 5 and 6 were never applied?

kind regards

Franz
