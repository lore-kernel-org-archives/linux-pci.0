Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00082231A41;
	Tue, 16 Jun 2026 06:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590775; cv=none; b=D9GXi3VtBIarZmSEuJR2wFhNlLbeZBLm1X/PVLhdwxxwQKLaVCfFXw4bBOPt0fHyQZ/ZSW1nKfYuQdHzu56wv49InQflWIERrJay7fggcEr/zziWsIGV/H23xulkGfqDbmfH0d86CBm2PLld5lER6JWEnayl7uduMP/b/qfmC0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590775; c=relaxed/simple;
	bh=ADBGzy9XP1K2Nq52f/TB17HnKxbUAS1HFXejK/xTlLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSbK8DW0QUBCadap6AdOuzoQXstsNaFPDj5HbTYymws3YeMruQNOTH/BouDBdzMWociiXvM5o+AvhIhzDMLiKifDacMNdQ4xWXaDBAUSQ+wS0+ToatuCMDA/jzmIxLN6tZEaVdJyZM/qqCmroA+81+2wNgw4Pw+pbMohjhgquuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0PDeBZ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0PDeBZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E561F000E9;
	Tue, 16 Jun 2026 06:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781590774;
	bh=U9l2UDzmbwgAF+rN4FBnX/q5SgDOTT2NxviVVoTgSkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E0PDeBZ2sUlNxPKsNZzORywiUJ4fS8OL87rkx2ufcp7EGVxEwsnQPGLNTWSZUiqSy
	 yVv4W2n2lvLax5itgxUxBU6WteXnNxwWTs0lBWGERCgkKva6W7oTpawHbOev1EP2RE
	 b/PQ31P9gSigYLG1tkxbfSfdEGWvzDc0OC4AhixUzmwFkmxi/ill+cbByxmld7ycpV
	 FMAeRZ38BAsvDuD1tra4G6t1DdGc5MciWdutX8j5iIy9A3vyIY8BJptnSbPqBG3Vmq
	 zicULhgc6+UO0etmJkq/USbjKlBxFPn8oGuYkpniDh76rvyPZ0GaW4bdUKtD5tLWfB
	 Jmt6cmhfUy1Gg==
Date: Tue, 16 Jun 2026 08:19:26 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_chezhou@quicinc.com, cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, 
	jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH] power: sequencing: pcie-m2: Sort PCI device IDs in
 ascending order
Message-ID: <2rt76zesdfy55odwxdhltvj3eef2ridnj3uvetzgcrjuv5wkm3@m342xffhjr3o>
References: <hndyeomouu754rwevoigc2ai4ywtz5lhodizj4amjuyn4azjhq@f6ixgilydtg2>
 <20260616025632.3697863-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260616025632.3697863-1-wei.deng@oss.qualcomm.com>

On Tue, Jun 16, 2026 at 08:26:32AM +0530, Wei Deng wrote:
> Sort the entries in pwrseq_m2_pci_ids[] by device ID in ascending order:
> 0x1103 (WCN6855) before 0x1107 (WCN7850).
> 
> Fixes: 2abcfdd91e6a ("power: sequencing: pcie-m2: Add PCI ID 0x1103 for WCN6855 Bluetooth")
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Don't send patches as a reply to other patches. You should send them separately.

- Mani

> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
> index 94c3f4b7ee36..b5ed80d03953 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -186,10 +186,10 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
>  }
>  
>  static const struct pci_device_id pwrseq_m2_pci_ids[] = {
> -	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
> -	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
>  	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
> +	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
>  	{ } /* Sentinel */
>  };
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
