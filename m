Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB02E3ACA6E;
	Thu, 10 Sep 2026 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025821; cv=none; b=eyMqHJpJyt0TBi8RnbyVlAVrEPcZA+ObVn0dSUvcrCNU8fX/XcdlxFPBbIJTdyQNK2twdGh6KTN7gRfpZBGrXv9E+HRw5ekkb+8cou1jn3wJrZlqHc34oCD9HWggPAleAZt/GnKlAcNEEQqvqyl10RP0x1a9inCtQWsgSyoOZEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025821; c=relaxed/simple;
	bh=rtrb7fP3Ow4qEe092s3lpBTXp61YR12ggebKe6CRO/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWgGIwE0oMcze8qcaeZ2ozk0n1NicfWBEW894qW9K8qCgqoDMf/NCZaox6zvOqjGhgO6PFPdIH4K+FJ09tNW/RwcpplTM+Gd0TJoAyeaRWSXCPwit00dWScqTEy3yrLm9QouZ0R3cM7WoEw7hE6Qbw4UyfB8Bp0ZG4TEj4AReDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A43YdFy6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A43YdFy6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9BD1F00893;
	Thu, 10 Sep 2026 07:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789025805;
	bh=oyXyxwAzCKEjQAFGJxCF4ZG5LZrRIcmWC36sTNkdHBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A43YdFy61wKlnEfw5kYf6xjULwr2LGtZbxFIfiVe9uvlNEJJ7lZsCNAsqjSmKaZbv
	 N8ZbJAy84wrnhAdaEzTwATPJRBiVRrpufF2HXpfD/LZdfUycfolv+JRegGZdtPHc/S
	 pqas1uisAAM1TCjsEiM6pYDo8OuqZRziMiJ7ey0JM+YyuM/Z3hZGkaa3kQcz54x/La
	 yIJE0UtlEjObDXi6aIg78MpsmH7tt2zq9zKUdpYsm7tOYsWIrjcRdoteDHSGfwJIdv
	 SLgHniBmHlIz1mUpBhYaDm0UUK1ZWCb0HCUO5Dwlw1/DrbY577Gc4a0nv11l18RpYp
	 DVB6jk/3V6uFA==
Date: Thu, 10 Sep 2026 09:36:36 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	shengchao.guo@oss.qualcomm.com
Subject: Re: [PATCH v3 3/5] PCI: qcom: Add CGC disable workaround for Nord
 PCIe
Message-ID: <lkof3a5pamxoveplcw4xffn4dmtgxpqm452ispdydij2g2ouub@4qetlwkngzem>
References: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
 <20260909-nord-v3-3-b0a82721c547@oss.qualcomm.com>
 <smgyk5ray7laj2ltwnmx3r7cfiouj4hyn7tyfmx7rpsrhu7kin@p5pr7wdoprjn>
 <678b6d96-6a61-4689-afc0-363b7a6f209c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <678b6d96-6a61-4689-afc0-363b7a6f209c@oss.qualcomm.com>

On Thu, Sep 10, 2026 at 09:29:10AM +0200, Konrad Dybcio wrote:
> On 9/10/26 9:20 AM, Manivannan Sadhasivam wrote:
> > On Wed, Sep 09, 2026 at 05:18:18PM +0530, Krishna Chaitanya Chundru wrote:
> >> Nord requires a workaround to address a timing convergence issue in the
> >> PCIe power domain. To avoid the issue, set the CORE_CLK_CGC_DIS and
> >> AUX_PWR_DET bits in PARF_SYS_CTRL after controller initialization.
> 
> [...]
> 
> >> +static const struct qcom_pcie_cfg cfg_nord = {
> > 
> > Can you use DWC IP version instead of SoC name?
> 
> I'd say it's fine given other implementations of the same DWC IP may not
> have this clock gating quirk
> 

Hmm, fair point.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
