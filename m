Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268D23254BB;
	Thu,  7 May 2026 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177705; cv=none; b=OLtHlrY3E3ts9vfavL5uNLXeI9tOk+NtY78ylZ9Jlq7ZmHeycbzVe0hhisZ67epBdJhEaOVBtvll2zqrihvGLxTQmwcHySnSpIBdRA5KBqlU1W4IThV1bm2VJXraMv6diKTz/kUhOh4imFoIkcwXi5AmiWQkH1a5cDLCFbDRHCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177705; c=relaxed/simple;
	bh=1ZHpkraCUVfj/DVCsCLxIvmiS48UB4Veqo9jiYhmobk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1Ef5L1tg0XvoUGNYaD6qk3krmMqdNzA9kmY+sGwJSWORCreMsaEPAQJy1bPkJnziIBwrUYzhTdHW29xaITzLlsGiUVyr/4A5YrQPy1EMR0SB9Z2pkDP8lioHdIF/rR9zrYmpcuIJrtKVYrxZV3zozlghgcCNkHBGJNwogutWqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odT3AOTy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odT3AOTy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F234C2BCF4;
	Thu,  7 May 2026 18:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778177704;
	bh=1ZHpkraCUVfj/DVCsCLxIvmiS48UB4Veqo9jiYhmobk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=odT3AOTyYMwi0Ux+dDOMJroN1MjBQkY1pJLUSScRDC0Wxig7lWZ0XN0Trg1fPCFAC
	 BuoXyfMnAqUzYJhqvaLVpsskP9pBTJsoJzAJGcdJYkYhTOi2AnkcLIDuCUTDrblTSV
	 8YmI+clFFR2hUgsQTMU98ab5VxOa8hIOSo7Gd7w3p8XktEn/ny/FV8TeSNNHI6zTFZ
	 JoRSi7iy7QvgPKLaZ6mii9hYc50IIZiqMBpgOC9Uy3n+8SGhyw9Nqng3fQVy/Hzfqn
	 LV3WzLvNhTJ/nqjWSRCUrM2e4nxQbNGpwsLKehRdXNem8dG7f8B5t+MlsDy6I/NZ8g
	 VyZiUbM3V5tAg==
Date: Thu, 7 May 2026 19:14:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: <dave@stgolabs.net>, <dave.jiang@intel.com>,
 <alison.schofield@intel.com>, <djbw@kernel.org>, <bhelgaas@google.com>,
 <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
 <Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
 <dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
 <lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
 <sathyanarayanan.kuppuswamy@linux.intel.com>, <vishal.l.verma@intel.com>,
 <alucerop@amd.com>, <ira.weiny@intel.com>, <corbet@lwn.net>,
 <rafael@kernel.org>, <xueshuai@linux.alibaba.com>,
 <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v17 05/11] cxl: Limit CXL-CPER kfifo registration
 functions scope
Message-ID: <20260507191450.45bc94c9@jic23-huawei>
In-Reply-To: <20260505173029.2718246-6-terry.bowman@amd.com>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
	<20260505173029.2718246-6-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 12:30:23 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Dan Williams <djbw@kernel.org>
> 
> Some CPER functions used by CXL drivers are exported using the
> EXPORT_SYMBOL_NS_GPL(fn, ns) macro. This doesn't provide compile time
> enforcement or visibility of the consumers.
> 
> This can be improved by using EXPORT_SYMBOL_FOR_MODULES() instead.
> EXPORT_SYMBOL_FOR_MODULES() explicitly names the modules that can access
> the function. This provides more precise control and visibility of symbol
> exposure than the namespace macro. It also provides compile time checking.
> 
> To improve control and clarity, update cxl_cper_register_prot_err_work(),
> cxl_cper_unregister_prot_err_work(), and cxl_cper_prot_err_kfifo_get()
> to use EXPORT_SYMBOL_FOR_MODULES(). Also, update the register and unregister
> functions to return void type.
> 
> Update the CPER kfifo unregister to cancel work while using
> synchronization.
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>
One suggestion on simplifying the code by removing any assumption that
cxl_ras_init() can fail.


> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 56611da8357a..9193dac4e507 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -68,13 +68,13 @@ static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
>  int cxl_ras_init(void)
>  {
> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	return 0;

I'm lazy and haven't read on, but if this never gains a failure
path can we change the signature whilst we are here to stop
pretending it does?

>  }
