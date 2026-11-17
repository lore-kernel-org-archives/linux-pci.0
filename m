Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915897;
	b=ZQiBm1Nei/VZh0ZCVuhU9M/8OpISTeRvOq+7DEMuv7MSDsljAUdF0GZyRiITa81t1OWf
	 WyovlgOOei/me1aszotfnsBiVVHabE2DjMD7E1E3hDJpBXQfo9tGYrwHIygIszylU0W07
	 K8gF422ZkUkYku1RdzDGhcg27kuIWA/sMfuVE1XL9BGoO8yR9TZj3BzEzWL1cR0frQNyY
	 eBSo/J21l/wM6AWdqInMU9tNt7Tg1fc6cAbSIRtz8oBxlXmpwwUqxQADHWtRYmzmOhpJV
	 cF7EbOC/wxPuWom19zgkrDae50TS5ANJX6KXhLtdWAMi2qGz99StOwhm68unQ8swsTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915897;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=n6w3cO92Rq3N51GC+FtnyfKYSdVpvLf9WR3UZ2ynCHA=;
	b=YdU6sEE8dXbp190teEVF5xgGw85k90ggQ8uWKl2nECtY8WLo6ICFopCDcEoj1QyFuEPc
	 ISpaYSsvPcpUxSGJ3XKV5yCez1efJ5jI1lH1OcNb59EzNoXDJKnwwppfnVl7afoYev1ud
	 OS5tAFaahNG49UcXbXS5ebtkNhQgxHcHS5+z5Nxrh0ZkPgveW75uWPfJemsBrVCcrOm/w
	 fKEzDMm3HrayVFcoFK6rySjgR+FyIUg7mgvWoLKSpAr/VpQImk+FCHRjUuXZM6sD1yWWf
	 29Q4PCfPfqcx+OM6iBCDYUufiXAcIK4E7dvcp0u6jsl58az3FXN8oVxnfruHnBHne9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B489606A323;
	Tue, 17 Nov 2026 11:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B489606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 107EE2825;
	Tue, 17 Nov 2026 12:44:53 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id EFB5E6039C25; Tue, 17 Nov 2026 12:44:52 +0100 (CET)
Date: Tue, 17 Nov 2026 12:44:52 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>, Dan Williams <djbw@kernel.org>,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 05/19] PCI/AER: Embed aer_capability_regs copy in
 struct aer_recover_entry
Message-ID: <avw-NChMgIjwFuv1@wunner.de>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
 <20261117111444.4185512-6-pierre.gondois@arm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117111444.4185512-6-pierre.gondois@arm.com>

On Tue, Nov 17, 2026 at 12:10:15PM +0100, Pierre Gondois wrote:
> commit e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error
> status data has multiple sections") passed to aer_recover_queue() a
> newly allocated copy of pcie_err->aer_info instead of providing a
> pointer to the ghes struct. This prevented corruptions of the ghes
> record (in case the ghes record was re-used for a new error before
> the previous error was logged).

Since commit eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors"),
aer_regs is modified for a recursive invocation of __pci_print_aer().
The copy is necessary because we don't want to modify a buffer owned by
platform firmware.

> +++ b/drivers/pci/pcie/aer.c
> @@ -1352,7 +1352,7 @@ struct aer_recover_entry {
>  	u8	devfn;
>  	u16	domain;
>  	int	severity;
> -	struct aer_capability_regs *regs;
> +	struct aer_capability_regs regs;
>  };

This increases stack usage significantly in aer_recover_queue(),
which is not good.  A kzalloc() allocation may be better suited
for such a large struct, instead of relying on the stack.

> @@ -1374,24 +1374,14 @@ static void aer_recover_work_func(struct work_struct *work)
>  					   PCI_SLOT(entry.devfn),
>  					   PCI_FUNC(entry.devfn));
>  		else
> -			pci_print_aer(pdev, entry.severity, entry.regs);
> +			pci_print_aer(pdev, entry.severity, &entry.regs);
>  
> -		regs = entry.regs;
> +		regs = &entry.regs;
>  		if (entry.severity == AER_CORRECTABLE)
>  			err = regs->cor_status & ~regs->cor_mask;
>  		else
>  			err = regs->uncor_status & ~regs->uncor_mask;
>  
> -		/*
> -		 * Memory for aer_capability_regs(entry.regs) is being
> -		 * allocated from the ghes_estatus_pool to protect it from
> -		 * overwriting when multiple sections are present in the
> -		 * error status. Thus free the same after processing the
> -		 * data.
> -		 */
> -		ghes_estatus_pool_region_free((unsigned long)entry.regs,
> -					    sizeof(struct aer_capability_regs));
> -

So you're removing the call to ghes_estatus_pool_region_free() from the
worker...

> @@ -1441,17 +1431,18 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>  		.devfn		= devfn,
>  		.domain		= domain,
>  		.severity	= severity,
> -		.regs		= aer_regs,
> +		.regs		= *aer_regs,
>  	};
>  
> +	ghes_estatus_pool_region_free((unsigned long)aer_regs,
> +				      sizeof(struct aer_capability_regs));
> +

... and instead call it earlier, before even launching the worker.
So where's the benefit?  You've traded less memory usage in the
pool for higher stack usage.  How is that useful?

Thanks,

Lukas
