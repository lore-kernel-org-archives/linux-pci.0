Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6D839D6DA;
	Mon, 20 Jul 2026 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584949; cv=none; b=K9oiteYf90I7TyhmIrFFSmaSpCOYecapjP1MazsOiCN2qGw430iCH5T0HOhFwySsUEhaFJIusjFuyIRZRPO5G5Vf2I/9ncMSynb19K/nVRYCisZQtkedxlmhMWrtU+IDd8IuDCKr/aynSv+vXka7ouC9d+sYW/Fth1fAajcMgi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584949; c=relaxed/simple;
	bh=ElidOuKi/lhVoMHuisWulB2Ej7l5oNTcYCEHGdMRC/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sq6vg7SiziXTwletvG8t23xWYYCUJgULqYFzqzX9uH8TFAFYth2HwKe/hEV6unluHwzj8AhpWBInbpa50RYfni3UMfUAI6HOq9ZaAHQnI5Ayf1ZJIhkjHSyWFIrm3ZKJAmiAAh0RBjwOOLU2gaUdmhI9vkBLFmdouTQpkTgCY4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+2U5CnU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+2U5CnU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AB61F000E9;
	Mon, 20 Jul 2026 22:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784584947;
	bh=6cs7LhaOrHnB/OaGU/+xy3diNyVqHofixZTfSSyjrGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a+2U5CnUbrj+JzvFAXU+vwi4g6TkNykWxDqU1QodrcuosBXdGMdV5IKvLI5ADTTEB
	 ZAXpIVMzHuvIc4ET6+IHyKMbJjYdZFXC/LdVSBIBFTi9ngKoaPF6fyecRUAjO80NHk
	 vv4lQ098TM28m5u8iZzmAy0x/xDaZAO7pvPS0eZnkTnSYFkjOwkYI+JlvoswH0OXSZ
	 pgbNN2KlkFoALigw4h1AbtEpE1WIL8Y0nFBMJUk0w8TEMj4UxvdN+NtSiHRKCWx3Pg
	 TmycMTeyZM1RZEbIULPT/XeBndPmudjGkE5d8RV9gC9oPQQ59hPbdlstiUXLbjK5b6
	 94RCWGg8Vyi9A==
Date: Mon, 20 Jul 2026 23:02:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 "Dave Jiang" <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>, Len
 Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Robert
 Richter <rrichter@amd.com>, <linux-acpi@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, "Alejandro Lucero" <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>, Ankit Agrawal
 <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>, "Ben Cheatham"
 <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>, "Breno Leitao"
 <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>, "Fabio M . De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Gregory Price
 <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>, Jonathan Corbet
 <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Li Ming
 <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Oliver O'Halloran <oohall@gmail.com>,
 Shiju Jose <shiju.jose@huawei.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Smita Koralahalli
 <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v18 04/13] cxl: Rename find_cxl_port() to
 find_cxl_port_by_dport()
Message-ID: <20260720230219.632420c1@jic23-huawei>
In-Reply-To: <20260717222706.3540281-5-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-5-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 17:26:57 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Dan Williams <djbw@kernel.org>
> 
> find_cxl_port() and find_cxl_port_by_uport() are internal port lookup
> functions that search the CXL bus by dport and uport respectively, but
> their names do not make the lookup method clear.
> 
> Rename find_cxl_port() to find_cxl_port_by_dport() to make the lookup
> method explicit and consistent with find_cxl_port_by_uport(). Both
> functions remain static to port.c; the upcoming patch that adds the
> first cross-file caller will widen their scope.

Could have mentioned the __ one, but it is fairly obvious why you did
that even without saying it.

Nice improvement
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> 
> ---
> 
> Changes in v17 -> v18:
> - New commit
> ---
>  drivers/cxl/core/port.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index f90f899c31d07..cadb51f70f854 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1379,7 +1379,7 @@ static int match_port_by_dport(struct device *dev, const void *data)
>  	return dport != NULL;
>  }
>  
> -static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
> +static struct cxl_port *__find_cxl_port_by_dport(struct cxl_find_port_ctx *ctx)
>  {
>  	struct device *dev;
>  
> @@ -1392,8 +1392,16 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>  	return NULL;
>  }
>  
> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
> -				      struct cxl_dport **dport)
> +/**
> + * find_cxl_port_by_dport - find a cxl_port by one of its targets
> + * @dport_dev: device representing the dport target
> + * @dport: optional output of the 'struct cxl_dport' companion of the @dport_dev
> + *
> + * Return a 'struct cxl_port' with an elevated reference if found. Use
> + * __free(put_cxl_port) to release.
> + */
> +static struct cxl_port *find_cxl_port_by_dport(struct device *dport_dev,
> +					       struct cxl_dport **dport)
>  {
>  	struct cxl_find_port_ctx ctx = {
>  		.dport_dev = dport_dev,
> @@ -1401,7 +1409,7 @@ static struct cxl_port *find_cxl_port(struct device *dport_dev,
>  	};
>  	struct cxl_port *port;
>  
> -	port = __find_cxl_port(&ctx);
> +	port = __find_cxl_port_by_dport(&ctx);
>  	return port;
>  }
>  
> @@ -1895,14 +1903,14 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, "CXL");
>  struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
>  				   struct cxl_dport **dport)
>  {
> -	return find_cxl_port(pdev->dev.parent, dport);
> +	return find_cxl_port_by_dport(pdev->dev.parent, dport);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_find_port, "CXL");
>  
>  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>  				   struct cxl_dport **dport)
>  {
> -	return find_cxl_port(grandparent(&cxlmd->dev), dport);
> +	return find_cxl_port_by_dport(grandparent(&cxlmd->dev), dport);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, "CXL");
>  

