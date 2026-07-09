Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A6830B517;
	Thu,  9 Jul 2026 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626532; cv=none; b=tsEiMYwCBZGtzEyQGah+82uu+bwY0d61py6LU4MIW7IH8Lv9lxuTdtE8bQA51w7/xaAnHVk73WYbvsP8BYVsCFO/cTp04SjS9Ikpp+OZuk8sSzQcAf0m4gLxx5vS5NIcGTHsZKROYM+X+tq+5D/3jaHL71qwy6y94R9HfxckH7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626532; c=relaxed/simple;
	bh=QGreZQMYuWQGjhpYeX1GgYGIltjZrJyY8hM/UUr3L/o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=epDJzp1W+1AHeAA5Ly9Ef49sPC6flENf6vg5+4oeY72c+03OUQOMPJgKOiIMtCYlO80MsVklu7/5ksZhPubLGvpFb0e8qKuNso4r4J3dKqXo+EX14FNw7ErNEMhojyo5Zg6F0eMFE/A2ObEY7/5u6oKgr2/OVGISI8/ABBrpEJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fP/GLwWd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fP/GLwWd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793A11F000E9;
	Thu,  9 Jul 2026 19:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783626530;
	bh=CAwXxWbQYibYKOKHqnHMhN2ZLV7evGoEz5vDHOBcq1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=fP/GLwWdPBJvSxw4dnpXiBzzabe3GV09QBalH4VgBQv6B1EMQX+lqTe74FAiMXJHU
	 om+PGYft11pv7q1rVkkiiugqD6NCOIE8m/96GBpGwqtj/UM7ki80cSVJn4N18ArMl9
	 L4katoOAvn3A2mHfPXJ84fBir8fW4rFfBqSS/Hfkn1N+wEnvf8PikRxU0XjQh2EJa0
	 TcnuUVYodwykfz1wsCMydH2RRTWiWqKJitLzTT/oWXGgIJ5auonuzG4qM9aAtlIlUC
	 gAa041Du6JFYjWEycv6jGzfgnFVqsYfD+ETn2AY9r0+atARErk7th6xXQR4ZmGsvwo
	 tWftBfNsiW1MA==
Date: Thu, 9 Jul 2026 14:48:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: ultrarisc: get and enable DP1000 PCIe clocks
Message-ID: <20260709194849.GA873312@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178297192123.1082377.12406016413212102294.b4-reply@b4>

On Thu, Jul 02, 2026 at 01:58:41PM +0800, Jia Wang wrote:
> On 2026-06-30 11:55 -0500, Bjorn Helgaas wrote:
> > On Mon, Jun 29, 2026 at 01:59:51PM +0800, Jia Wang via B4 Relay wrote:
> > > From: Jia Wang <wangjia@ultrarisc.com>
> > > 
> > > Add the required core, dbi, and aux clocks for the DP1000 PCIe
> > > controller and enable them before initializing the DesignWare host.
> > 
> > > +static int ultrarisc_pcie_init_clks(struct ultrarisc_pcie *ultra)
> > > +{
> > > +	struct device *dev = ultra->pci.dev;
> > > +	int ret;
> > > +
> > > +	ultra->clks[0].id = "core";
> > > +	ultra->clks[1].id = "dbi";
> > > +	ultra->clks[2].id = "aux";
> > > +
> > > +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(ultra->clks), ultra->clks);
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "Failed to get clocks\n");
> > 
> > This would be the first use of devm_clk_bulk_get() in drivers/pci.
> > There are several users of devm_clk_bulk_get_all(), which looks pretty
> > similar.  Unless there's a specific reason to use devm_clk_bulk_get(),
> > could this use devm_clk_bulk_get_all() instead?
> 
> I used devm_clk_bulk_get() intentionally because I wanted the driver to
> enforce the fixed clock names required by the binding.

Seems like a plausible reason that might apply to other drivers as
well.  Any opinions?
