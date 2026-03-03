Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8142218ACC
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 01:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772500163; cv=none; b=Ud/YQ5IFxKu02uklXWghmBwCbdHJO+M8FTvHhoR2g7bidToFHyjx+DQBJklKdwcOOGIs2LfzYkGKpPfaS7Z51eUOn/T+Hkc61hTRP0SoxgeMi/j55z5d+CqYgjcdtO+k3oRGS2osAq5opsjBRKOPyNDLAe4/GeUkl2v6uWy2Bos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772500163; c=relaxed/simple;
	bh=w3XJNMngVH9o2x8Fo5Z+SPPnOKYZk1VuCewxXQHywRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHpVhYPqYl1maigkeOGO/o4zdM5peiC63e6bCbsULMJXDQX+jxOvabB1NZ2fIAfY8psDMrzB1/b9imQNKtLiYHUUon0Oh1EarmK8ZI3FZra4o9PJ+/+SgaB6rcLulO26MYgVpUb8KE7oeuT1x4cIRebMPXKIq9iwJLl9eILaOUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dS+LVF8o; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dS+LVF8o"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so2679446a91.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Mar 2026 17:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772500161; x=1773104961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SNfT7rc1kauxFP4QoLAxKKWlk0j1ruWc56+EWObHoAU=;
        b=dS+LVF8ou9Zz93QFikDpAP7pC9t6MOJIxgU5f2273WXXLTLjKe8pM9IOBBxCIAlhcn
         HOuu6YwE3p8U6PQUCYkxTPKlsqouBWk1UYm6kAhmfE5OW8pJp50Mu7rswWilOWbRNk9W
         jwcsldw7G1Ig6r8wRgLXaXYeTpZ33+aGHnmStVAL1JpoDdjZQ58Gt3EENYveR/5CsZzQ
         UMidENnBWqwspNHJFwBPjNWPcgWOd2oz/SoudWyssRN0we3Q3DU23fUSealLNtTHOptB
         CgAEXUiWFHYCtgcbifxpG9X1c0P5BjYcYVLYjIFBsbi9WGOStwHTc6SJsI0PtP38i7WH
         EGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772500161; x=1773104961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNfT7rc1kauxFP4QoLAxKKWlk0j1ruWc56+EWObHoAU=;
        b=Kd++ayPs5aEZqLl5eIbB75B+pTwYVA8n2uFavHq3oQdRG8B7DI8B93F/w8p8TJB2Hv
         TY/fiS/fnSfL0i0typ2PyAxUDgoOd5vIl9YbFrEL3MJmvckj8oMAWNOiZ5+KlXBC83gD
         drXLyJopAZMoqpCCTPz6sIA2CoMlC1Id2PBf1ztSMpsQqrqG11ZJcBuZPQRWDzQ2Baox
         7SRZn+hbqLwuBXuAKzziHQE7UlYgQXBG2aXhfilsLMRqW9FZMoQnpAhMcE+iTQHs3LwV
         aMAOEuZMyk99WuAyW26q+2X+In48OzblEEsdsVCpYqRR/kOVWWYuTIevw4uh6nUwut94
         VkPA==
X-Gm-Message-State: AOJu0YyAefHFznhXy1M4IzV7JLwoRfL2SX04qnfoP5V22YqiOK5oVjTy
	MtdngOvG7Hqw7PrbQ3lVl+rdO03t4Tf2W4SgXek2VYTTBmKccRo7HeVo
X-Gm-Gg: ATEYQzwAVxhoeivFw+ykONRB+y8sj8RHs5meQuSOVaJdSbxQw4TcDrRFgHs7IAKAL/E
	z9oOjThIMsEFCl1nM1wnntE2WBDye3n52frpIz4wfafXlhmC3SXVCh7f6u9sp4nroL7vPLz/zIo
	m0lC0rn14vqYAbZaOzh3cZnv07q7ZXPFWuIJZjO+RsaWWPLu2FyzF60BnAC0PshoVoKV7CzhKVX
	AWXrjKf5Nzzd0Ris7m5oDzqWlS6rQ8WHt6SO8Oh9xswsHUHEpi1nuy2KXmSe3Xxn81VQ2UX6FA/
	SYWpn4RsoVB16I56Vc3AYSdEjzwC4pmbeQkC1GyW7KzaLLwFNO/VzKbO7faQrwRq7t6qayp1HiC
	HXsEJOcg9vt027t2hi+5uO0MA+2LvR9B5+f274PBqmQ8903kHWv42KJscPF4H+rvGlsAsgj1o91
	Q0lLSY1uT1QREz5u3PDwCrWw==
X-Received: by 2002:a17:90a:e18f:b0:340:4abf:391d with SMTP id 98e67ed59e1d1-35965cd0f39mr13847656a91.16.1772500161304;
        Mon, 02 Mar 2026 17:09:21 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c408296sm384302a91.5.2026.03.02.17.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 17:09:20 -0800 (PST)
Date: Tue, 3 Mar 2026 09:08:53 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Yao Zi <me@ziyao.cc>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Hans Zhang <18255117159@163.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Manikandan K Pillai <mpillai@cadence.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Inochi Amaoto <inochiama@gmail.com>, Han Gao <rabenda.cn@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: cadence: Support platform-specific hooks for
 RC init/deinit
Message-ID: <aaY0kWYTZx3zs3o7@inochi.infowork>
References: <20260227181925.52475-1-me@ziyao.cc>
 <20260227181925.52475-2-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227181925.52475-2-me@ziyao.cc>

On Fri, Feb 27, 2026 at 06:19:24PM +0000, Yao Zi wrote:
> Support initialization and de-initialization hooks provided by
> platform-specific drivers. Initialization ones run after everything
> else has been set up for RC, but before it's probed by the PCI
> subsystem, to allow platform drivers to easily override RC properties
> like LNKCAP. De-initialization ones run before anything else has been
> cleaned-up.
> 
> Signed-off-by: Yao Zi <me@ziyao.cc>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 8 +++++++-
>  drivers/pci/controller/cadence/pcie-cadence.h      | 7 +++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 

LGTM.

Reviewed-by: Inochi Amaoto <inochiama@gmail.com>

Regards,
Inochi

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index db3154c1eccb..23ee5a9c240d 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -304,6 +304,8 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>  
>  static void cdns_pcie_host_deinit(struct cdns_pcie_rc *rc)
>  {
> +	if (rc->ops->deinit)
> +		rc->ops->deinit(rc);
>  	cdns_pcie_host_deinit_address_translation(rc);
>  	cdns_pcie_host_deinit_root_port(rc);
>  }
> @@ -316,7 +318,11 @@ int cdns_pcie_host_init(struct cdns_pcie_rc *rc)
>  	if (err)
>  		return err;
>  
> -	return cdns_pcie_host_init_address_translation(rc);
> +	err = cdns_pcie_host_init_address_translation(rc);
> +	if (err)
> +		return err;
> +
> +	return rc->ops->init ? rc->ops->init(rc) : 0;
>  }
>  EXPORT_SYMBOL_GPL(cdns_pcie_host_init);
>  
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 443033c607d7..7d8f8e87915b 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -100,6 +100,11 @@ struct cdns_pcie {
>  	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
>  };
>  
> +struct cdns_pcie_rc_ops {
> +	int	(*init)(struct cdns_pcie_rc *rc);
> +	void	(*deinit)(struct cdns_pcie_rc *rc);
> +};
> +
>  /**
>   * struct cdns_pcie_rc - private data for this PCIe Root Complex driver
>   * @pcie: Cadence PCIe controller
> @@ -115,6 +120,7 @@ struct cdns_pcie {
>   * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
>   * @ecam_supported: Whether the ECAM is supported
>   * @no_inbound_map: Whether inbound mapping is supported
> + * @ops: Platform-specific hooks to initialize/de-initialize PCIe Root Complex
>   */
>  struct cdns_pcie_rc {
>  	struct cdns_pcie	pcie;
> @@ -127,6 +133,7 @@ struct cdns_pcie_rc {
>  	unsigned int		quirk_detect_quiet_flag:1;
>  	unsigned int            ecam_supported:1;
>  	unsigned int            no_inbound_map:1;
> +	const struct cdns_pcie_rc_ops *ops;
>  };
>  
>  /**
> -- 
> 2.53.0
> 
