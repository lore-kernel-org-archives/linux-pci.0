Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55B82DCF57
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788619608; cv=none; b=KkYA/eo5epfvLRn35srQOWmvcqibOSCXdeiQgSQkBXSM68PUGPSI7aTh6JQV0OAXhwpwMcs7ITbmliPczjUgmy+grYsNly1reecR1SDrLiNHoAPQCXf3w31oZ/a1q5kL3+2f13TbiVSmYAH9oiw6NrzjLWskq4BjUVK5F3Ku9fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788619608; c=relaxed/simple;
	bh=KhV/sExtmXB6UlADh0yOfIqRP3nAvtEhErCcazy8J5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHWDgSuZmNUi6updr/0UiSvMC7GFY0OO0YsTdWNohndlUu7mfmhyCXkqmlvUjZKnL5TZojp9DKzAFpPvmXsbvgliC2Ig2WpiZIKiBpJlXLtvtE+JktZUNtKjmFheZ3ODLTdYeHxAjaeabi97vzEAW63Q0kqNIc4GjjwqBhEqQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0RQCtVU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0RQCtVU"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so2398774a12.0
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788619607; x=1789224407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5lIUHrxpa8LGuaDX4+74JSWWI9JDXZlTSaRdKXqmY6I=;
        b=D0RQCtVUZ0R66JVPMRj228CAFTWiGudK/I0oI1KeMQFoBAUS6jI4/Rxuy3+I0lFn2s
         Hr8qO+VzhMPTJm4MZEJn85XdJm/aNRgCTcUOF01hKG04cIfCul32H3jikO7oAHZ9N+RX
         O9kfjAyOMzsKN6oR2leTLNJnJhaqccZ+lbKIXfqbgZYdKfGFZf6Hf7t4hLBJV81N5/TC
         Ufv20jz1emh/xMdnr2k7BJl1vAHknspdZbQrDTeps1KNXO8BvkOXKnR6rY/Q5a9mUzT3
         WjOic63jRzGXUQVUZyLYIjrOuiHGGLzgz66KlAPjaTLaGJl2+gLKJBpk097dM2pvTXsc
         m+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788619607; x=1789224407;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5lIUHrxpa8LGuaDX4+74JSWWI9JDXZlTSaRdKXqmY6I=;
        b=D0LxT4v9IQ+QCAGOdo/ZwGrTSaVCxNny8ot3nn6kQsFtppKIKnlksXnVc3hUTseRDn
         qlyaWad8iyltznJ8fdDycj8dL02A+GvMZ6SkXiktAYalP8sTOjTR9Os3DlrwXMD4SHi2
         OXZFTghponqEZ9Mru/pW4Dd4EqFLVtcSwPfQ98iZj4jvKko+KuSYLr7bC7Hf1bQjVSXj
         crcA0Y8cYNvqaPE4ry6yk3UqU1MzxJZNBVYPp92+AZKzGP+P77lMwdSm3BToP39aExwY
         UIWQ5e+ffNNKgZzaDlLRONiB+Fk/WGvFwLjCQlsrgbXDN+BbevjTLUS1eocZ3Fff7N59
         r21A==
X-Forwarded-Encrypted: i=1; AKwUvBwNcnmIagArvubcFmChYTl/B6YdcKnT9SC0JJ5mZM6mfoumdpCtkCymA3lmRuiDey6+RerngHOWAgo=@vger.kernel.org
X-Gm-Message-State: AFuF++mXOXNrVlaTZJnEnIiEqihrAXW4Y6N2Hu3mUu1UvI0BccAkXH9J
	rb93PhEnYns/rs1qndCBuRXfgvUfmK1YEf48RukS24MxSF99Kw+ZzUcY
X-Gm-Gg: AYBFou0ZOqehd6eyTYULCQKZaNK83opyAzGHWP7P3ZQzhnMvaokM7NtVjXLdQ7r/jjD
	w1yinv0vh91PATsffh9mhweItNpIVDE2b1AcQn/HTz4yRsc0NEulbM1UMfRTMJOajqAQyxXQESq
	4ZUlR6Crp9U0Jj+wI7qreX1tSAQjjMVP1siOEqtl5vVcGcsNwy2jUCcrrbH+b15Sut1w+5AkBgc
	VcG9epiE3/VKL6/KfiphZWe84Fw6+tlat/SbcQ24VNpjNLe9WTljBv4rnqvx56hmKZPlLlKEHYY
	MgFiV1FfGO+hc8anabbjGmHweGjhCizWZOmODcJ8uy0SsCPX4yqMfZ8PnsS2wWLgocQXP2LeAmj
	70WGuFV2QLEVlCkc4SrRqLinzTdMlJ1M2W1vu9POo9GUCkWRxlcFX+mtS0sw/u+x34ZFAfTXKrl
	cQtRdFhX3u9g+m/mEfMZmKWLZnrVRosrPaZFy0vtCvxyAG20QLMwYNXfmITNwPONrlaW41f+Xq8
	sq4WbLekA4riVLTLPmoWZ3KUUZ0p7RsgmvPNa/CvDd2Jm3hNBvD5Wgu8eVO7oX2qNvLmH89zRj2
	f7Y5568+kek=
X-Received: by 2002:a05:6a21:487:b0:3cb:8810:631d with SMTP id adf61e73a8af0-3da39b58320mr21305071637.1.1788619606891;
        Sat, 05 Sep 2026 07:46:46 -0700 (PDT)
Received: from nickhuang (2001-b400-e2da-caae-e718-2aad-4c92-5b14.emome-ip6.hinet.net. [2001:b400:e2da:caae:e718:2aad:4c92:5b14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc467df7beesm843306a12.7.2026.09.05.07.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 07:46:46 -0700 (PDT)
Date: Sat, 5 Sep 2026 14:46:41 +0000
From: Nick Huang <sef1548@gmail.com>
To: "hpp.iscas" <hppiscas@163.com>
Cc: Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yu Ning <ningyu@eswincomputing.com>,
	Yanghui Ou <ouyanghui@eswincomputing.com>
Subject: Re: [PATCH] PCI: eswin: Publish the platform driver's OF alias
Message-ID: <apwrUYd3VybxbAm7@nickhuang>
References: <20260905134251.67210-1-hppiscas@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905134251.67210-1-hppiscas@163.com>

On Sat, Sep 05, 2026 at 09:42:51PM +0800, hpp.iscas wrote:
> The ESWIN PCIe host controller is a platform driver matched through
> eswin_pcie_of_match. PCIE_ESWIN is tristate, but the table is not
> published for OF module autoloading.
> 
> Publish this platform-device table. Do not change the RISC-V host
> initialization sequence or PCI device matching.
> 
> Fixes: b593c26d081a ("PCI: eswin: Add ESWIN PCIe Root Complex driver")
> Signed-off-by: hpp.iscas <hppiscas@163.com>
> ---
>  drivers/pci/controller/dwc/pcie-eswin.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
> index ce8d64f..1bb4469 100644
> --- a/drivers/pci/controller/dwc/pcie-eswin.c
> +++ b/drivers/pci/controller/dwc/pcie-eswin.c
> @@ -388,6 +388,7 @@ static const struct of_device_id eswin_pcie_of_match[] = {
>  	{ .compatible = "eswin,eic7700-pcie", .data = &eswin_eic7700_data },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, eswin_pcie_of_match);
>  
>  static struct platform_driver eswin_pcie_driver = {
>  	.probe = eswin_pcie_probe,
>
Hi hpp.iscas

Since this driver uses `builtin_platform_driver(eswin_pcie_driver)`, it
appears to be built-in only. In that case, `MODULE_DEVICE_TABLE()` seems
unnecessary.

Regards,
Nick Huang
