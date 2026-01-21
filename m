Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA17643DA58;
	Wed, 21 Jan 2026 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005434; cv=none; b=GlB6qjuUBGAAMEsdwdYtcgVoT0WvYALNSbbNfiZWrqltMWWunda+/Bp0bBqbglPMdLu56ElhvaWyfhtYa3yv/0gK612aAOziyhba95iJvaxgyTWnHKdDv+yjk1JY2P40kqb9os5ONIL+DWMEAqFVgXG4juOGByX50onW7T00jXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005434; c=relaxed/simple;
	bh=sxHTIMw03RFCJckd+4pEi7ilm3Kjm/7p+fjWD0Hluhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIbruWMDwFazd9t67C+4blqW67AEr7W+0N0EYQaysxFHJbSBxFURLA9zJyA5VXHXR5WbJSZI+A3TQiTf0ZP0dIbZymwJiTGC4cF8Qp5ByaKFNZIOi6mOKXOxRmhiIpod/gWuYoX1jdBFa+1Ay/BK0pRXIJNKN+jZIRXTLRUoYvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJiYyLKF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJiYyLKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70611C4CEF1;
	Wed, 21 Jan 2026 14:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769005433;
	bh=sxHTIMw03RFCJckd+4pEi7ilm3Kjm/7p+fjWD0Hluhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJiYyLKFsLjREdpqwApvrCDlY3lX6DsOoCX1QC0k3lPIzcpq0Jkazx9G0elTxiU5i
	 2c/IRUEusSuVdniTY7uarSrfzwb+pSmQzjD8ebJhHl94LraD67iHZ1CYYDZb2LXdkk
	 wydx1fzPnjkxeynG15gmieeHC9lwrqmcPkVA84POF5/B6By1ZCB5CzIxopU5jwIuJc
	 MyvdShv4+CcWrgxhQ8J86FkJ+K/nloYfwTScrKOVQjDC5Ksm+rBkyp3bY+XwxmY7ZI
	 UKH2oZmXgs/gt9EbbE1xn5iS0YHmT5ff6b7p6SJM//ZciOCOR3oJGbFRT0N9SXtQZ1
	 nSYDj/yu1+PiA==
Date: Wed, 21 Jan 2026 19:53:33 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add ACS quirk for Qualcomm Hamoa & Glymur
Message-ID: <y75u4swg3d5s52eqqdqhm354t6cgyhh6mzilvmcd4cxt5yqrhh@o3olnrpq4fbw>
References: <20260109-acs_quirk-v1-1-82adf95a89ae@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109-acs_quirk-v1-1-82adf95a89ae@oss.qualcomm.com>

On Fri, Jan 09, 2026 at 01:53:32PM +0530, Krishna Chaitanya Chundru wrote:
> The Qualcomm Hamoa & Glymur root ports don't advertise an ACS capability,
> but they do provide ACS-like features to disable peer transactions and
> validate bus numbers in requests.
> 
> So add an ACS quirk for Hamoa & Glymur.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b9c252aa6fe08a864cebe245f5dd7bf41fcc5116..75dee46f474a643cc79d112df1f5a57a9f6b95b1 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5107,6 +5107,10 @@ static const struct pci_dev_acs_enabled {
>  	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
>  	/* QCOM SA8775P root port */
>  	{ PCI_VENDOR_ID_QCOM, 0x0115, pci_quirk_qcom_rp_acs },
> +	/* QCOM Hamoa root port */
> +	{ PCI_VENDOR_ID_QCOM, 0x0111, pci_quirk_qcom_rp_acs },
> +	/* QCOM Glymur root port */
> +	{ PCI_VENDOR_ID_QCOM, 0x0120, pci_quirk_qcom_rp_acs },
>  	/* HXT SD4800 root ports. The ACS design is same as QCOM QDF2xxx */
>  	{ PCI_VENDOR_ID_HXT, 0x0401, pci_quirk_qcom_rp_acs },
>  	/* Intel PCH root ports */
> 
> ---
> base-commit: 623fb9912f6af600cda3b6bd166ac738c1115ef4
> change-id: 20260109-acs_quirk-0f8e83dc945e
> 
> Best regards,
> -- 
> Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 

-- 
மணிவண்ணன் சதாசிவம்
