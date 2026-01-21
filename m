Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083774611C8;
	Wed, 21 Jan 2026 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037323; cv=none; b=EwR300sDGwpFqFH1U1YhQYWBbiRbeY2FP2pxsD5zHhtu16ygzElNDsa5QHYZ2g1UMUCvtpPnJSVbaveO3nYrQo2T/TxsVw3mwbeleusKb1SKe76c+1C1plBwJFko+DdhUQLNaapRCtZc/aX07c9AsEWEcl3y2ECOf5i2U4zCtpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037323; c=relaxed/simple;
	bh=2rZc2CobKJ2bQoD/hgDVC7Ydo265bvJF3lPw6WZX5L4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QqDXoPcvLjTy5UfgVDVr27voFebAcNnVvhoFCg/m2UuEeAhwn64YRO1QLiLPIeG3yWnh/lS0ppllyMN87xKs8CoL60EC0VzH0UwIOBH0TXs4QuQQHe4daJn7RMWCIuWsSej1rT4Nf2LdEZjgIUQK/5FsBqlB+CJmu2GRe0wWGgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpSj4VMF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpSj4VMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27147C4CEF1;
	Wed, 21 Jan 2026 23:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037322;
	bh=2rZc2CobKJ2bQoD/hgDVC7Ydo265bvJF3lPw6WZX5L4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VpSj4VMFqVGMbzmGMViAl5LDSfcWXL/h2dHAoqaDsNIrcXQmwWrK8Zcb2sf+N2u7a
	 ZHqLqqlZ4F+uHemyycdWQ/O780WPopBDb6tXuPlM8tA0M2ZgkQx35cINO1A3WeV1Eb
	 hZsaK6Hmn4hKs+elZAOSw0UfViZ2MdAru3i+SVkf91PU3qcXC8YH8xQ/WMcxWl+nAn
	 HZGEavfk1LVYp3wFysIUQv823hdcUzS/1BWqGh+8Qbiz7JahmzNdJ6To1t5PCYAawd
	 H0iqZnS3fQLxHbvgmIalYECUK9rmeziD75EOa60eCVhqI5rNPJopXDBNpUGxluzkb4
	 hv0iRsfgSX/Zw==
Date: Wed, 21 Jan 2026 17:15:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 1/1] ACPI: PCI: simplify code with
 acpi_get_local_u64_address()
Message-ID: <20260121231520.GA1221379@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121085105.2282380-1-andriy.shevchenko@linux.intel.com>

On Wed, Jan 21, 2026 at 09:50:49AM +0100, Andy Shevchenko wrote:
> Now we have a helper so there's no need to open-code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Looks like most drivers/acpi commits capitalize the subject line,
e.g., s/simplify/Simplify/

> ---
> 
> v2: fixed a typo (LKP)
> 
>  drivers/acpi/pci_slot.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
> index 741bcc9d6d6a..15234b65ea22 100644
> --- a/drivers/acpi/pci_slot.c
> +++ b/drivers/acpi/pci_slot.c
> @@ -42,8 +42,9 @@ static int
>  check_slot(acpi_handle handle, unsigned long long *sun)
>  {
>  	int device = -1;
> -	unsigned long long adr, sta;
> +	unsigned long long sta;
>  	acpi_status status;
> +	u64 adr;
>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  
>  	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
> @@ -56,10 +57,9 @@ check_slot(acpi_handle handle, unsigned long long *sun)
>  			goto out;
>  	}
>  
> -	status = acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
> -	if (ACPI_FAILURE(status)) {
> -		pr_debug("_ADR returned %d on %s\n",
> -			 status, (char *)buffer.pointer);
> +	if (acpi_get_local_u64_address(handle, &adr)) {
> +		pr_debug("_ADR returned with failure on %s\n",
> +			 (char *)buffer.pointer);
>  		goto out;
>  	}
>  
> -- 
> 2.50.1
> 
