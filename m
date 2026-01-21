Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E6C34CFD6;
	Wed, 21 Jan 2026 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768992070; cv=none; b=XSt+3m1Jp/8xNyHUGLM770gf8fUq6DP1/bvvWZGhBkIFqRMyhHOo9Nf91HOy58IsgsGjz2IAjLhQ15MXzZ0DL+JmvO4N1HR2LoKMccEoQ5BInmEkfSIaaN/eJp0H43CGD0sFqusuA7+E6Gdh7doLmGFPlsFhb4ghWTyA/NI/gpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768992070; c=relaxed/simple;
	bh=bEJkfsgGin856/N+1YngFfoVug+NtpgmRle+eLELJTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evoujxd7FtuZ1yM0C/5bo9cMh0xa5eqN7hie/RjTgYuSzk9bBb9Zp6wrICsjx7XYtnVAX2D/J8gD3omX9izhH6wLjicOvOTOkp9GxuA1RUJNYiLNISYafU516ZSZGhnLhLyGE1kIkhjbfcRjXX0QlP0rbDGN1dgUrvjq6xUguD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPrbfhwG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPrbfhwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFDBC116D0;
	Wed, 21 Jan 2026 10:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768992069;
	bh=bEJkfsgGin856/N+1YngFfoVug+NtpgmRle+eLELJTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPrbfhwGnn3OtJT/af+PKUqyN+t2GRTIaX/KRFmk44jjw9L73+7VkkPgDhKOS8yZW
	 xumxSX7jWQ89EKhZlkjLBdyr7rKvLYsrxVD0BzskiDKhFHYf6xAHP4T88x0aY5A78h
	 HRoMux5TJwP5PSc0Tv3fhsswMJJ2+gtAEMVAnbpT0Ri3E6kJoG5PVHQWu0bp7o4Fmy
	 6L+eapR+GBLhKMAllXZ6LufxD0bxbasDw+EwbwHn02jg+vwxVqzk0ky8NW7Aos/yAu
	 i6gNOCCs2RAwjSIPHTNlB9fTzv1IY4jqvNcbDa/VTRLB2reJfkgRQ83+Y3XrvDH5bC
	 ozGZge7fjBqgg==
Date: Wed, 21 Jan 2026 11:41:04 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Randolph <randolph@andestech.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, robh@kernel.org, kwilczynski@kernel.org,
	lpieralisi@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	samuel.holland@sifive.com, Frank.Li@nxp.com, cmirabil@redhat.com,
	randolph.sklin@gmail.com, tim609@andestech.com
Subject: Re: [PATCH v2] PCI: dwc: Use multiple ATU regions for large bridge
 windows
Message-ID: <aXCtQA5HR60f5a9g@ryzen>
References: <20260109113430.2767264-1-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109113430.2767264-1-randolph@andestech.com>

On Fri, Jan 09, 2026 at 07:34:30PM +0800, Randolph wrote:
> From: Samuel Holland <samuel.holland@sifive.com>
> 
> Some SoCs may allocate more address space for a bridge window than can
> be covered by a single ATU region. Allow using a larger bridge window
> by allocating multiple adjacent ATU regions.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Acked-by: Charles Mirabile <cmirabil@redhat.com>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Co-developed-by: Randolph Lin <randolph@andestech.com>
> Signed-off-by: Randolph Lin <randolph@andestech.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
