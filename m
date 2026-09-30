Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173DF364EB0
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779587; cv=none; b=vDReSE3WNM3LFd0neOiFSVczU+cMuYKV7tnYA8Q2gBw4ZhmCjznzYc/WIKeQsYZK8MUPa8Bq4+0ks5oApHCp7xo5MwErBS4uEZL0vL4tn9ktCJryssfEw/sdOeGJwfO4gl1RNENoBQk8/W6nRyPccQ+KtKI9VK3vp7h6VH7MT8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779587; c=relaxed/simple;
	bh=/tPonSezqD0pF109OBVVQK1etAIG40RxHqGagp/vXC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBuM8jUOogz2a5YVg2pEWNqMrU2LZUpq/nK4BTcKR7w8C0twP4mZlH66L3br0DSmBkR6EsVrKkDNjEyUeROirLqu4/IIPQiB1bV8DudNPFk1N/t4YZVWS3nPE39RuwJd5I6k7YG7mMt35qFS0I6VmKM/hGU3E6ECbnS1JieQ8Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=evvY8ig8; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="evvY8ig8"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-88379342f7fso2256839b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 07:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790779573; x=1791384373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XtrQ0tj7FzMG4yS/5Pbmybyv3bn+aU+u1tYBCpeACnk=;
        b=evvY8ig8+X4458fKBLC3sE72qmIMpJuxgaSRjWLVrx55Gt5d9i0xwPC7Y91S4OUpuS
         dNvmqanphhImJyU/Tp9/H/hxIpavf3B13qT78dE3vZCWkhVxgmS0BUHeSbjXmYZicfqL
         ENnPrOKzSPZvElGovef2gMQRDAbQJvFbZvTuyexnRxgWpApnlT1WSlNYJOkj5qnvZsDX
         VoypnW/+ypnZ/80/GsKPqWljseauQkc7VXOfrBIRPmmxZqHeaIpM9LY+NMwlZagRT6MO
         umP2Mlw1eKak9XGPCbvZ11+ptv6Jo14NjSVI9qW2v4RM+HtzgqO9CKP/rW7ER6K0X/zE
         5aDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790779573; x=1791384373;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XtrQ0tj7FzMG4yS/5Pbmybyv3bn+aU+u1tYBCpeACnk=;
        b=0sM8uZYRwhExB23BHNcIvnWrvOtAaAg64bxKMP8UkPIcnrw0Bw36a7rts1wrxW4HXR
         tf7GW1xb6Ndub8sdpsugQpkAs7ZiVNgsqx0hdKAqXaoK3MhIuFP/0rbZh/tZsk5FFZA+
         nNSgYVZaWo2INPhEN3qjP4HAIBj0giYSR8Gm1lDPo5MWDRgIX915JzVnC9hmkuGyxkUf
         BQq6m8qO/PPl1uKxmGVpfNt+7d0iYfQZTUgaDaQbcu7ZJ5KzIAkRtMtFRIIvE3jbUPrN
         h7ZVm0X80vasyTTw+So+VQ2OtYnFgQc2jTpZqDB8TRrbQOSvMyHnJnVqfYCmC0qasA6e
         wsHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwo/GgJa+GUMU0JrAuvP+XNGqb1FXqpFkt8LUYqCqcsq1Agvnwe+ZfVt3eUSf7jjwYMd0e3tAQui8s=@vger.kernel.org
X-Gm-Message-State: AFuF++m4SG04UQD0bVxgnov16wuPn6J53kYlCJFcY8J1fTeqiYl3PTyW
	lfwoAQkgPD8aDtalZhfB5voShYnattMVDLe5EFMF+9E9S3bgIXlNSjlqMfTYO0v3B5U=
X-Gm-Gg: AYBFou0fBOS9waAKfyadfvhIS+El9pHZtPAaa0IPgElXzLtLJJ0JO9iDo+n/VygzMbx
	wm3pRsrGVxP4f/STSRN5Q8uNE7M8nVN5ZkXSoh+e0MuvjVEjbRjNsMJ+32Jhf+GOIQlNl5apWO4
	MpPaE8CWkAZAdbbFSEbFz6TWYM62PWUm9R7aDiCcaQXlBPZR0pl67ixLqhMdPx7LSF14ermMVHg
	BEm+a7YsZ29ulEABri/Dpgz1szVh0eHgu/kuC/FOwr/AiQFLYofxZLWKme5GAzmK+iN6xTc6iPY
	ZBIe5e3mmtLPWKKXn5r5mtpteFwDoVqRe+pQi09zO1Zgp4cZf4rAYaNz/fFN7susfJdiKOKu8gF
	iXhBhVyEwwG3mf3WOGg5/cWqB/r+3QE2USqQUQGaAtPEoCRz6ZPIqxbEl2SbMAUv+dYeEKknu/I
	09FSTLNzty2J9+12hO0GMsU5Zm26UCOnQS+5aWbp+fYiQ3e7oatXLT/8j0mKUWvx+cnULYxXc1
X-Received: by 2002:a05:6a20:2d2c:b0:3de:73aa:2f34 with SMTP id adf61e73a8af0-3de9e885dbemr1692719637.65.1790779573183;
        Wed, 30 Sep 2026 07:46:13 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:f5b4:4d0e:70d:9fba])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7daafecb3sm1108997a12.23.2026.09.30.07.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:46:12 -0700 (PDT)
Date: Wed, 30 Sep 2026 08:46:09 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	ankita@nvidia.com, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Cedric Xing <cedric.xing@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Biggers <ebiggers@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Kai Huang <kai.huang@intel.com>, Kees Cook <kees@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Lukas Wunner <lukas@wunner.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
	Fang Peter <peter.fang@intel.com>, Petr Pavlu <petr.pavlu@suse.com>,
	rick.p.edgecombe@intel.com, Samuel Ortiz <sameo@rivosinc.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Will Deacon <will@kernel.org>, yilun.xu@intel.com,
	Kevin Tian <kevin.tian@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH] coco/tsm: Update maintainership
Message-ID: <ar0gsWpZH3izCCvw@p14s>
References: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>

On Tue, Sep 29, 2026 at 08:26:41PM -0300, Jason Gunthorpe wrote:
> With Dan's passing Aneesh and Jason have volunteered to take this on, with
> the support of their employers.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  CREDITS     | 9 +++++++++
>  MAINTAINERS | 3 ++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
 
> I've now spoken to all the main companies contributing here and asked for
> volunteers. This is what I could confirm at this point. I'll be at LPC also
> for any further discussion. Regards
> 
> diff --git a/CREDITS b/CREDITS
> index a0bd941ca5dd26..7749f1e477ab43 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -4414,6 +4414,15 @@ W: ftp://ftp.uk.linux.org/pub/linux/people/willy/
>  D: Linux/PARISC hacker.  Filesystem hacker.  Random other hacking.  Custom
>  D: PPC port hacking.
>  
> +N: Dan Williams
> +D: Technical Advisory Board member
> +D: Asynchronous Transfers/Transforms (IOAT) API, Compute Express Link (CXL),
> +D: Device Direct Access (DAX), Filesystem Direct Access (DAX),
> +D: Intel I/OAT DMA driver, libnvdimm BTT: block translation table,
> +D: libnvdimm PMEM: persistent memory driver,
> +D: libnvdimm: non-volatile memory device subsystem,
> +D: Trusted Execution Environment Security Manager (TSM)
> +
>  N: G\"unter Windau
>  E: gunter@mbfys.kun.nl
>  D: Some bug fixes in the polling printer driver (lp.c)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 72294ddfa5b757..729ab465af96a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27788,7 +27788,8 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/trigger-source/*
>  
>  TRUSTED EXECUTION ENVIRONMENT SECURITY MANAGER (TSM)
> -M:	Dan Williams <djbw@kernel.org>
> +M:	Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> +M:	Jason Gunthorpe <jgg@nvidia.com>
>  L:	linux-coco@lists.linux.dev
>  S:	Maintained
>  F:	Documentation/ABI/testing/configfs-tsm-report
> 
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> -- 
> 2.43.0
> 
> 
