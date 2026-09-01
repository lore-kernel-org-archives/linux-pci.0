Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EEB401A38;
	Tue,  1 Sep 2026 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273951; cv=none; b=LuYo0SCGsiy/dN4s9C3udUtcT7SNpMMTec22XyeaiyGb3o5l4Y8ajisTHRRe6cYJu0YfoCJX/Az+mNTwq2MRyp4H/4CoVeVTrhaa6iWYAYGuQpUB/7txkXdIHqaOxNBong6vegc01HPTT9qSd23aGDQQfWljiluwGqKkStT/VG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273951; c=relaxed/simple;
	bh=Wdca5yyGAEFhiWnDNW0FBSaBvXbn0UZ/blm2rcwiiqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/9G+mXtKm33hIlxFu38Z9Hg4Dw1ZzR0U6xe1mxIt5gQN7cP/D1rvLHF5RG/Q4U8gpdTFaqGkUVUhxzdUDSP1wRZCshlMS8vjUA96p+73+PlDbTU7M7BsLLrQg84yyrB9JMnN/2l+f9IkYXR5hCq7IykOieg6wVNeh9n80EW2Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hy9B3VIK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hy9B3VIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3CD1F000E9;
	Tue,  1 Sep 2026 14:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788273945;
	bh=YhIHMa6p+Z/XPhouIai7y+gBsYQjo1DnXwNfv+n1aZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hy9B3VIKtQPHA7C32yAuoIe2iZqJ0yzieuQdNG+1fYQkMjq2BEEH85WATSYkZGRUU
	 zgQV3bi+rHC5ioE/kQ97H9sDUqgeiS+j33hevMvFq881dGWKtqO6i69fXYz0amUCx8
	 TEhU4LY1fMwFia8VcdhSPWZaDyfCkDCp3KWPaaByhyrWB/fq70IamdiEcujbpFASx+
	 JgPmWJWo4K79FZ937SnXpXEFfNDUKanxeixkD/m+s/yuJwADu+/lHyyHa8kWbHypPD
	 nHHad/7uRCCob821jpC/7f6vAqws/kMrX6iKYPf/HPSqr+s2rpurYMXSEhDr0wQNR1
	 EZvIiL3p6lwGA==
Date: Tue, 1 Sep 2026 16:45:33 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: Force L2 link entry on shutdown/reboot
 without D3cold check
Message-ID: <mgng4jh6srizcutwb4yesrdtkfxwpwg37bnimi466fpdkndhlj@voscdgulnwlm>
References: <20260822-shutdown-v2-0-520a68f1b4a5@oss.qualcomm.com>
 <20260822-shutdown-v2-1-520a68f1b4a5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260822-shutdown-v2-1-520a68f1b4a5@oss.qualcomm.com>

On Sat, Aug 22, 2026 at 11:04:17AM +0530, Krishna Chaitanya Chundru wrote:
> dw_pcie_suspend_noirq() normally calls pci_host_common_d3cold_possible()
> to check whether every downstream endpoint can be put into D3cold before
> bothering to move the link to L2. If no endpoint supports it, the
> function returns early and leaves the link up.
> 
> Querying D3cold support during shutdown is actively harmful, not just
> slow: pci_host_common_d3cold_possible() requires every active endpoint
> to already be in PCI_D3hot, and returns false otherwise. If any endpoint
> is still in D0 -- which is common, since endpoint drivers aren't
> guaranteed to have suspended by the time the host's shutdown path runs
> the check fails and dw_pcie_suspend_noirq() returns early without ever
> moving the link to L2, leaving it up right up to the point where the
> system cuts power/clocks to the controller.
> 
> Detect the shutdown/reboot case via system_state and skip straight to
> forcing the link into L2, the same sequence used for the D3cold-capable
> case.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 06722259d2e3..98cd9dd2c7d7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -13,6 +13,7 @@
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqchip/irq-msi-lib.h>
>  #include <linux/irqdomain.h>
> +#include <linux/kernel.h>
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> @@ -1222,16 +1223,29 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
>  
>  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  {
> -	bool pme_capable = false;
> +	bool shutdown = system_state == SYSTEM_HALT ||
> +			system_state == SYSTEM_POWER_OFF ||
> +			system_state == SYSTEM_RESTART;

Instead of poking the system states, you should just pass a flag like
'force_suspend' and set it to true in the shutdown path.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
