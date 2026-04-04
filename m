Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D7284672;
	Sat,  4 Apr 2026 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775320877; cv=none; b=JHJGcrMcWOvAksiB5XQxIXXElmr9l2MYR6XEYerhmhj9Hxw8iI5jh/7+B6UUGBQcSITp8eDJJFklzO7yq6gh/jRLRKuPLJIVoAdeo0rl1W/7uA3cSPuyHr20aMThK5kvjyv7QODe7X7WVX5CZa1lnYXDC9IW/fNtgj49CS1Kppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775320877; c=relaxed/simple;
	bh=Ou65aHRYAYcUbqH3XWzBV/snIOcs0H8lpnpGOvkQZG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLEEUxwLquYSgC4BP9hgjRrKV/AwTi0w+X0v/JDFOjevfQa5mtNk2lDmYX24AHbrZMvU3orksKueUGqjRaSPxuZwxSA7rKU2yDW1M/ri4a42RiYM/lfyiNdPs2nzXlNUZqTubUhrDeOPSIokcwK6kLWbzgpqYYH9KiqFE+GqZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OC5Xd/a4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OC5Xd/a4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F747C19421;
	Sat,  4 Apr 2026 16:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775320876;
	bh=Ou65aHRYAYcUbqH3XWzBV/snIOcs0H8lpnpGOvkQZG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OC5Xd/a49eRC89o3mgTqGuM+kSBPhHvOvog6djPNc7ApTlLG+sg3aEG/7BUYp2osv
	 egJ7dLDnhJiXXr9ANypbaZ3z2J88avkiCKgwRDthBrU1SjYJoFsc5+3+RadXbm1TwU
	 1ojJHCRB7FcSMKmnlZwNOW+kNUcCOb6NzqauoNdrUrVncwx3l1foqjr7QKsHQi9Yde
	 GlD60O4cYv2TgZgE0fzhkXFQjqAKFGhTht+x68/VAxzbAWYCail55iisyjtwDxIh73
	 N4WmvqkLhWIexgPe5kRRZR6f1Tjjqu54XOlS0AHpkapIt5uGSEQ8h0NYDTOn1vqnb4
	 JU63/We36eujw==
Date: Sat, 4 Apr 2026 22:11:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] PCI: Remove extern declaration of pcie_link_speed
 array
Message-ID: <jobpwbins7tdv44kkbxnjsrobcqfdgxh7dxbngqwffzu4dutsi@p672ub6575hg>
References: <20260315160057.127639-1-18255117159@163.com>
 <20260315160057.127639-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315160057.127639-4-18255117159@163.com>

On Mon, Mar 16, 2026 at 12:00:57AM +0800, Hans Zhang wrote:
> With all users of pcie_link_speed converted to use to_pcie_link_speed(),
> the external declaration in pci.h is no longer needed. Remove it to
> prevent new code from directly accessing the array and to reduce the
> global symbol footprint.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/pci.h   | 1 -
>  drivers/pci/probe.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 053fc245a1e3..b2f91409b439 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -107,7 +107,6 @@ struct pcie_tlp_log;
>  #define PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
>  				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
>  
> -extern const unsigned char pcie_link_speed[];

What about controller drivers using this array?

git grep -r "pcie_link_speed\[" drivers/pci/controller/
drivers/pci/controller/dwc/pcie-designware-host.c:      enum pci_bus_speed speed = pcie_link_speed[pci->max_link_speed];
drivers/pci/controller/dwc/pcie-designware.c:   switch (pcie_link_speed[pci->max_link_speed]) {
drivers/pci/controller/dwc/pcie-qcom-common.c:  for (speed = PCIE_SPEED_8_0GT; speed <= pcie_link_speed[pci->max_link_speed]; speed++) {
drivers/pci/controller/dwc/pcie-qcom-ep.c:              Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
drivers/pci/controller/dwc/pcie-qcom-ep.c:      if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT)
drivers/pci/controller/dwc/pcie-qcom.c:         Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
drivers/pci/controller/dwc/pcie-qcom.c: if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT)
drivers/pci/controller/dwc/pcie-qcom.c:         freq_mbps = pcie_dev_speed_mbps(pcie_link_speed[speed]);
drivers/pci/controller/dwc/pcie-tegra194.c:     val = width * PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]);
drivers/pci/controller/pcie-brcmstb.c:           pci_speed_string(pcie_link_speed[cls]), nlw,
drivers/pci/controller/pcie-rzg3s-host.c:       switch (pcie_link_speed[host->max_link_speed]) {

- Mani

-- 
மணிவண்ணன் சதாசிவம்
