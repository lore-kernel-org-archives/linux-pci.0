Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832133FD135;
	Wed, 13 May 2026 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684410; cv=none; b=ssGEz2CVUQbwN1hWZpbGIGslrk3uUQc2bhhSa9W70jk47DTFDoh7/8EA7wOLlqA3x1Bzx9TxyjmLchn+7+Rxyz1AxhZNg0CApZlyNKAMe8b96XY/RV8XinLzljrrTjxeF+aVSlYgkq2O76GuEUNXYZJHGZqYvn270grUU/nTr3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684410; c=relaxed/simple;
	bh=/uW52ugSWwtF3Yt2difUPaJV99v9sizQWUARunWAmFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8Y0SFA27X4wkUvwNEZlgcczgPYNk4VUhDuI1TK0LFR796FB5hPdSPkeELGngfXo733XUAQabuQv/e3k6vVYjvgxYJzNzA9RRfMUz1nCspiRRdHe1zc7DtLHRh31vHYU/HSW7OnCqxaeEh/FyHf5nM4UStJ0kt3/+UXEAnQBCjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrei1yAt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrei1yAt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E74EC2BCB3;
	Wed, 13 May 2026 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778684410;
	bh=/uW52ugSWwtF3Yt2difUPaJV99v9sizQWUARunWAmFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lrei1yAtUKzo0amo9A0//XrWbCS3EumS5X8DZfk97DLPG4FF/mwKvZmfcNrwHfi22
	 TLwoNZpB+YAWWgVFEijOVUFHfCOpSaPbQVnekr78I1R5VrMte3m7ZcDacMadqbvcpk
	 RY8HZiCK4y919QSMV/ax4vThVzjydZO2iGqc7BDez+7PFF1fP0phBcT1lWol4fLH91
	 FGSbRWt4x6J3t5eoQVBvqZqwppCsjqGWOTN8Jd7d/Kon5/E8wpH9U062xemFMYW7my
	 zAQ/DHvmyfMOxktWmg+Y2gBrb7iNaaUM87+Ktr0M3O7VAP5dLrVZir3KmkPs88itKC
	 gAnJvsGmpueMA==
Date: Wed, 13 May 2026 20:30:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Steev Klimaszewski <threeway@gmail.com>, bhelgaas@google.com, 
	bjorn.andersson@oss.qualcomm.com, jingoohan1@gmail.com, jonathanh@nvidia.com, 
	kwilczynski@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	lpieralisi@kernel.org, robh@kernel.org, will@kernel.org
Subject: Re: PCI: qcom: Add D3cold support
Message-ID: <22mtoygxvyfaibmfwv5itayhcwwjl2mv6knmdyfiehmebdgg4u@hfooqf6css2l>
References: <dd4dc11e-338a-4d13-9830-095a93187f4c@oss.qualcomm.com>
 <20260504041407.289464-1-threeway@gmail.com>
 <ffd59407-c65c-4f99-a587-3b968f9c82c5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffd59407-c65c-4f99-a587-3b968f9c82c5@oss.qualcomm.com>

On Mon, May 04, 2026 at 12:36:29PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 5/4/2026 9:44 AM, Steev Klimaszewski wrote:
> > On Sun, May 3, 2026 at 10:37 PM Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com> wrote:
> >>> v4 of this patchset *boots* along with Mani's patchset, however, v5 does not,
> >>> and unfortunately, the machine does not seem to get to a point where I can even
> >>> get logs from it.  Do you know what I might be missing?  I have *not* attempted
> >>> to remove the nvme drive and boot off USB to test it.
> >> This series, will not have any impact on the boot, this series comes in to the
> >> picture only in case
> >> of suspend and resume. can you share your platform details and kernel you are
> >> booting with.
> > Oddly, it seems to, because if I simply go back to v4, the system boots.  I'm
> > using a 7.0 kernel on the Thinkpad X13s (SC8280XP).  The sources are at
> > https://github.com/steev/linux/tree/lenovo-x13s-linux-7.0.y (with the v5
> > applied).  PCIE_QCOM is built-in to the kernel.  Not sure what other information
> > is needed.
> Hi Steev,
> 
> I made mistake in re basing the code, can you try below and see if that fixes
> your issue.
> I will send this in next patch series.
> 
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1327,7 +1327,7 @@ static enum dw_pcie_ltssm qcom_pcie_get_ltssm(struct
> dw_pcie *pci)
>         struct qcom_pcie *pcie = to_qcom_pcie(pci);
>         u32 val;
> 
> -       if (pcie->cfg->ops->ltssm_enable)
> +       if (pcie->cfg->ops->get_ltssm)
>                 return pcie->cfg->ops->get_ltssm(pcie);

Squashed this change while applying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
