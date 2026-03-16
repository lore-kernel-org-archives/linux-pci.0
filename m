Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D0D22D785;
	Mon, 16 Mar 2026 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773624934; cv=none; b=KzHWrio5RwMzZa4NPKOBnM6xHNOfYs18evq8K8REXUpgNuCbfpZT07ddX0TI5RCKVqzRCJ+GUQM61sKJ0k2V5F2vrGaUCQyRdQ0aHeybGWjwvR+2SMr1xYRkP0ou38/Ys8Z6+r6oVV2DxwN2GqY0qmrsfE0D6GvUltyyJJzQAdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773624934; c=relaxed/simple;
	bh=sBPElqmQmbN/YTfA2OWXczxEcTNSY17JhsazLsAZo8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2aXiRPxByV/ZPOghSTHFei56MWI38zKz9U21ZRwc/YFtYOwcWo1HciYjVyKWIyKAiAX42zkzntI+saqYkRTjxAXRpt5ZUkyMZ09YYKQhz4FKQ9Decc16BwybJgleHYkGPF81Gl44dVKl5I29rK96ftfmwsTe2S73uW4X2HWmKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGVt+qf3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGVt+qf3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10A4C4CEF7;
	Mon, 16 Mar 2026 01:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773624933;
	bh=sBPElqmQmbN/YTfA2OWXczxEcTNSY17JhsazLsAZo8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tGVt+qf3FRDzuYLzy22ekw1/ZN1FH9wYWYcNwNKmuskXikvmu0bWxbsO9NRbRvm33
	 cjKwm7EoCVU5MirZ7TRAUdApmvL6CCTbAcTwiwbv1uXdhqIW59CcyCa6AF8i15frFp
	 i/F5AzLAdmb9ghDAnKFkri1cBgjBF5mmr1/mc/JzAQ6grYNiEssRh6t1qxIsYMVaYJ
	 hlOD2Sef7HbjwXDT6FiTPiEZtb9I0BlnXQmsqssl0KdmSk97iH3nMHsklp6Ok8JnTu
	 X7KHSCuub4luwQmBKv5DifWGb3sZ7cDryYISg1i2Qk0AhrFOI3hOT2haPZO6Za8X3d
	 FjBiwd3pniVPw==
Date: Mon, 16 Mar 2026 07:05:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, 
	Jon Hunter <jonathanh@nvidia.com>, "kishon@kernel.org" <kishon@kernel.org>, 
	"arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"Frank.Li@nxp.com" <Frank.Li@nxp.com>, "den@valinux.co.jp" <den@valinux.co.jp>, 
	"hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>, 
	Vidya Sagar <vidyas@nvidia.com>, "cassel@kernel.org" <cassel@kernel.org>, 
	"18255117159@163.com" <18255117159@163.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 13/13] PCI: tegra194: Free resources during controller
 deinitialization
Message-ID: <p43oadeafmqsunhfp56ssutqjkkmsmtmovkwec7elzkfgwjlci@yka2cbtf7qds>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
 <20260303065448.2361488-14-mmaddireddy@nvidia.com>
 <bbv5jceuy7vj6t6h6ncxfaxgmrb4acuhzkazinwhyf2zru7pvi@f7maptqx6jqr>
 <78c52693-daa9-4a47-8c9d-bb3f4734c293@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78c52693-daa9-4a47-8c9d-bb3f4734c293@nvidia.com>

On Sun, Mar 15, 2026 at 07:46:49PM +0530, Manikanta Maddireddy wrote:
> 
> 
> On 05/03/26 4:13 pm, Manivannan Sadhasivam wrote:
> > On Tue, Mar 03, 2026 at 12:24:48PM +0530, Manikanta Maddireddy wrote:
> > > From: Vidya Sagar <vidyas@nvidia.com>
> > > 
> > > Call pci_epc_deinit_notify() during controller deinitialization to free the
> > > resources allocated by Endpoint function driver. This is safe to call
> > > during PCIe assert sequence because we don't expect Endpoint function
> > > driver to touch hardware in deinit function.
> > > 
> > 
> > Are you sure? The epf-test driver itself touches DBI space during deinit.
> > 
> > - Mani
> Ok, I see epf-test is doing clear_bar which access DBI space.
> But, I think we should give give a chance to EPF drivers to clean up
> resources and stop using them in PERST# assert. Let me know your inputs on
> this.
> 

You cannot control the EPF behavior from the controller driver. So I'd prefer
not changing the flow.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
