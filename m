Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE8C33A9FE;
	Thu, 24 Sep 2026 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790279139; cv=none; b=YPkGYZAW782Wk1cpBI+0twXjsf6nTQXEdz1s6/roJPwEUhTPdCZ/l1tsOhCbIK42zQ8/S2ZTIMJdeBJ9nO3ihyMci8Jksdp9Dq3Lv4lvzQu2ujaYWPHYbR6W/bBYdvn7lLRvlewxiazxdcaQWXRgGtB+f/+TEJ4EsR1JblJ4RTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790279139; c=relaxed/simple;
	bh=UCNSDIlulYome+vY3nf3Jy5HSzwP9j412kxfHAtL/EM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dDrUi/5dxkWjY2egD946aDXjp8Ru8wnExZyeS0pWEi4iGW78EpJ/f7L73F6Dlb7xZhbZ/NljPSXE2dfbXla+NCbREwoR1+DOsfDQeFLA0lJFOHzTM9bzb0MO5ZjF21SzoZqYdu9JJc6NiB+NaKfhZytmjH8iEkjhCWSV0T38j1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ae1AkLHj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ae1AkLHj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98EF1F000FF;
	Thu, 24 Sep 2026 19:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790279130;
	bh=TaQpXeqDu4eNv4g0BmK8EJLXBcJuN1+NJessy4FiZQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ae1AkLHj4nD3pqfTzdsRqvo7DSQ/WXft4HC2VmExh7F4A6mrt+tJ+U2LI7wfg9VlU
	 3cpyfiRIeEs86qh6igBtVSd5dj4FkL4ZgelVzduCvRW74Ogo091BHO3s0HPcjwSrYb
	 JJvUR1xkwTOK4AJ7Io8Zj0zx8ISR8U8QfdoPsBMYHt+RxZMkav7TUTaQpho5vp60Us
	 DQfDegzGUXMbAe8grpRDHz1RMDM4meb4/5hD13vKxlCIO7/oQdrG9i5CSh/+NUgoRx
	 8Y0xpwlMGf5AZisKAhfpqz1f5fpqIK8mo6jc8XUeJxv/XxwJ3fUIAJNQu19wqA53Y6
	 wvNkJNRGor/OA==
Date: Thu, 24 Sep 2026 14:45:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew.gospodarek@broadcom.com,
	ajit.khaparde@broadcom.com, fengchengwen@huawei.com
Subject: Re: [PATCH 1/1] PCI/TPH: Validate the firmware Steering Tag response
Message-ID: <20260924194528.GA1999719@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924190543.3424792-1-wei.huang2@amd.com>

On Thu, Sep 24, 2026 at 02:05:43PM -0500, Wei Huang wrote:
> TPH _DSM returns an eight-byte Steering Tag information buffer.
> Checking only the ACPI object type allows a short firmware response
> to be read beyond the end of its buffer.
> 
> For safety, require a non-NULL buffer containing the complete value
> before copying it. Use memcpy() so that reading the response does not
> depend on the alignment of the firmware buffer.
> 
> Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
> Signed-off-by: Wei Huang <wei.huang2@amd.com>

Applied to pci/tph for v7.4, thanks!

> ---
>  drivers/pci/tph.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 655ffd60e62f..4d064b86befc 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -119,12 +119,14 @@ static acpi_status tph_invoke_dsm(acpi_handle handle, u32 cpu_uid,
>  	if (!out_obj)
>  		return AE_ERROR;
>  
> -	if (out_obj->type != ACPI_TYPE_BUFFER) {
> +	if (out_obj->type != ACPI_TYPE_BUFFER ||
> +	    out_obj->buffer.length < sizeof(st_out->value) ||
> +	    !out_obj->buffer.pointer) {
>  		ACPI_FREE(out_obj);
>  		return AE_ERROR;
>  	}
>  
> -	st_out->value = *((u64 *)(out_obj->buffer.pointer));
> +	memcpy(&st_out->value, out_obj->buffer.pointer, sizeof(st_out->value));
>  
>  	ACPI_FREE(out_obj);
>  
> -- 
> 2.55.0
> 
