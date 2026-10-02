Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C938B2EF653;
	Fri,  2 Oct 2026 23:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790983952; cv=none; b=J6dvsk6QvM+al9KuU1x2IGn9wTzz+FOZ6yOq6WMvPa04zOWQYoy/8tWzrF5bXsccVmxKpVfZCyf2cWoCFsyI1Apxj7FnLU9Zq8CFKP2u8UrE07rrrd5k4sV+qByUtHX1RDHbBUOqEBSpQdaJ7/yjFPXdZFMgxEo8CAJHfHv8nk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790983952; c=relaxed/simple;
	bh=9MkzpLv2tCyGVvGtMcaieTLlp3KYsJzOyjcIx83v8V8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZlUPXge6JBarjmZnWL2G5Qm8TdGUvizoQnEUNuPtJiOtA7Lar4LGpcy0ucFIVcbXaEp28s1DjOInIaDhTnEJULK/kN0AxYWpjr4E60L7rsSekvmWwb3Xe9aC9JTaGUbHHx7NHtaAB/C1qK0mptbI/o9RAQlzeGbW+ly+M08oPl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgHp3jMO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgHp3jMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E8E1F008BD;
	Fri,  2 Oct 2026 23:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790983950;
	bh=hkp4GpLvaZLV90kqDlezg/z7sFUUPzjkt6KiMpkqyXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=NgHp3jMOHzjentqXjcWAie69SstGeLGmBAUcJ4epAssn5YFUuFSoQr5AMiHL+7zpp
	 QZ9POZ5t07San8sLmhiL4B3HhjmnAkqpgFTUUlDJGiSS1IhileM5TPfNyMCFcI3upC
	 wxouGWRv4PDt490EwhnyXO+arQh22NsLXE9h6HKJGayyEqCRXnLzHU14mbWopmEK5L
	 wMECpB9dGAwQ2SlSp4XNQ3/e0ig77FBeNrp5i3kQbCf3hITc3y7fPD4t293wk74QK9
	 5h9JwZl9s8A4m2+RZ1/ib9URDMMipuZARTTpB0VeMqcLcTxU7th1YKjDNGwxeglYO+
	 01bRubhH2jA6A==
Date: Fri, 2 Oct 2026 18:32:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2] PCI: rcar-host: Remove unused LIST_HEAD(res)
Message-ID: <20261002233229.GA401322@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521091256.15737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Thu, May 21, 2026 at 10:12:56AM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Remove the unused LIST_HEAD(res) declaration from rcar_pcie_hw_enable().
> 
> The macro instantiation defines an unused 'struct list_head res' variable,
> which conflicts with a valid resource loop-local 'struct resource *res'
> declaration further down in the function, triggering a compiler variable
> shadowing warning:
> 
> drivers/pci/controller/pcie-rcar-host.c:357:34: warning: declaration of 'res' shadows a previous local [-Wshadow]
> 357 |                  struct resource *res = win->res;
> 
> Fixes: ce351636c67f75a9 ("PCI: rcar: Add suspend/resume")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> v1->v2:
> - Updated the commit message to include the warning.
> - Added the Fixes tag.
> - Added Reviewed-by tags for Geert and Marek.
> ---
>  drivers/pci/controller/pcie-rcar-host.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index 213028052aa5..cd9171eebc28 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -346,7 +346,6 @@ static void rcar_pcie_hw_enable(struct rcar_pcie_host *host)
>  	struct rcar_pcie *pcie = &host->pcie;
>  	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
>  	struct resource_entry *win;
> -	LIST_HEAD(res);
>  	int i = 0;

Internal Sashiko feedback while backporting this patch:

[Severity: High]
This is a pre-existing issue, but does this function lack bounds checking
for the outbound window index 'i' when configuring PCI resources?

Looking at the loop just below this hunk in rcar_pcie_hw_enable():

	resource_list_for_each_entry(win, &bridge->windows) {
		...
		switch (resource_type(res)) {
		case IORESOURCE_IO:
		case IORESOURCE_MEM:
			rcar_pcie_set_outbound(pcie, i, win);
			i++;
			break;
		}
	}

If the device tree populates bridge->windows with more ranges than the
supported outbound window limit (RCAR_PCI_MAX_RESOURCES, which is 4), it
appears 'i' could exceed the limit. Could this result in an out-of-bounds
hardware register write during the calculation of the register offset in
rcar_pcie_set_outbound()?
