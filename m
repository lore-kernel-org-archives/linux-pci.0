Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ADD2D8379;
	Mon, 20 Jul 2026 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582786; cv=none; b=jSPTjyIQoUo+tso/hOhGew3C4hzbdVFTB+wl+a6CKwEV9WMLbuCbJDIN6Z3ox/374fqv11NUuzGWByHbLeOA6amBrQh5J9LjLQAEZ7tky2dNLRG9jXW5oBKCrA46J/RvdfJfsvvNROkPSQu29u+Y6amPwXfqgLx1b7tDQHvMznU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582786; c=relaxed/simple;
	bh=VwBOnFkIHuj1oja64Y6Me7RM7wIS0U1e83LuPKLzueo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KacD35mTJoy3yhXoLx1ZZJ+/eETbSaqhNG2I5M7UTWkxNEpoKPWgYdI7QIvXy42cHn5brOWPngHWBE32Lijvf43OiZOJEQqQcUbKirwDaKXZvQHlTFYL7pCe4BsDBZTdfp7MJ0JezDP1dCRcp3klZtRLd/Lsn6G8jtKY8bFgFBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knv+WWyz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knv+WWyz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A221F000E9;
	Mon, 20 Jul 2026 21:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784582784;
	bh=hgzEzv8KzgA973IVv/uKk4z9kYIa69UBaICYLVX6RMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=knv+WWyzLr/C2po5DrcJFrX9FdjRP9H+TlZLo1CLUoIgIpyhO82mKxuQdkEmibVlz
	 jX6p05F1rxsZFJd4bkrUl4RnpeVF2D6iJkvChjuJDDxsw6DxVmXkb1WN1iS4FZJ4E4
	 yFRdFayH9GnyH9dlNK2ROKWXjkRS9klUCMYl2Qjio8Xiq6eZ9wogLMx/jboQKLWWN4
	 kgAZDqRiP2JyGH2uvgQrV6wWsNQWxkkonhwHfFdYV8mTUkG6k/Og/vd/22Z1Gblm+p
	 V7b81n6qwDfZYdZsx64YW+aUgqrb7XeoEggT/vHCrrTiUPoyNKop5lfX9Q6Mq5MMHU
	 eaYv04sBAePUA==
Date: Mon, 20 Jul 2026 22:26:17 +0100
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
Subject: Re: [PATCH v18 01/13] cxl/ras: Fix cxl_rch_get_aer_severity() wrong
 severity register
Message-ID: <20260720222617.29d5676c@jic23-huawei>
In-Reply-To: <20260717222706.3540281-2-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-2-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 17:26:54 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> cxl_rch_get_aer_severity() classifies RCH Downstream Port uncorrectable
> errors as fatal or non-fatal by ANDing uncorrectable status with
> PCI_ERR_ROOT_FATAL_RCV. This is wrong because PCI_ERR_ROOT_FATAL_RCV is a
> Root Error Status register bit (bit 6), not a severity bit. ANDing it
> against uncorrectable status tests a reserved bit and produces incorrect
> severity classification.
> 
> Fix by ANDing the unmasked uncor_status against uncor_severity. Per
> PCIe Base Spec r6.0 Section 7.8.4.4, each bit in the Uncorrectable
> Error Severity register indicates whether the corresponding error is
> fatal (1) or non-fatal (0).
> 
> Fixes: 6ac07883dbb5 ("cxl/pci: Add RCH downstream port error logging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
One trivial thing below, otherwise LGTM

Either way

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
> 
> Changes in v17 -> v18:
> - New patch.
> ---
>  drivers/cxl/core/ras_rch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index 0a8b3b9b63884..44b335d560708 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -80,7 +80,8 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>  				     int *severity)
>  {
>  	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
> -		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> +		if ((aer_regs->uncor_status & ~aer_regs->uncor_mask) &

This bit looks familiar (see line above!)  Worth a local variable maybe?


> +		    aer_regs->uncor_severity)
>  			*severity = AER_FATAL;
>  		else
>  			*severity = AER_NONFATAL;

