Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606A4433BC8;
	Mon,  6 Jul 2026 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355816; cv=none; b=SfpTplNJRSI5cfapHGba3lVJcejphU9+V+9oxGNMIA0rlVfxZWTnCPhFGJpAZqn7ERIS/od7E3dN+/2uc7mRC0XbEzDlbmDPeQF9agViRVnKxFH2952ZuKBINWfzbR8sWz77XhX3jdJctpDICNW+grLcnlULMBe3wfT+T6XxpyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355816; c=relaxed/simple;
	bh=aQ155oMS1aP+sJU1cZKSwbFH910mTtNPsrItaY8zzSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVy2+hLZOlCpwYMqwsrTIhVsaiJ2y6gMhifkm76h/1XDp7CV/dcYOsW2MkxEwJUUL5a8XO1C7pk/D3wcrCBCbY3nlPox8zi6K8+cFIT4mcIOZHFA3tiHSVLgsyDHnuTbjSJfsaor6IFUHUV/H91fz8uznybNFwTc46mhKGocc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXFMh8Su; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXFMh8Su"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BD71F000E9;
	Mon,  6 Jul 2026 16:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783355815;
	bh=zCwhz7SYOBzlCyq63S3QzaXZnIA6AhTV8JUT7OVdLRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oXFMh8SuHX6p8AYT4D45ZGncYnMZ8zgmBtiO0fs6l3A+K/J7wbMNs1XuDjNlcw6Ol
	 hQrJok8zs4BTv03w1DVwFFjDlvET/xTX3yIIWjjrV2PnN5Kqg1H7XUQbT0B77E4UZR
	 olAfo1CmXXTr0nxInCItcU9UxxtlJ7sqMrdsM+WAeLvUGL/JWK2KeCy5LkwYRDB+7n
	 G/EQyWYj3v+ALcs+1b/uo6umqo9tIbH9Jcgt8fmeXiRfMiGPpAAUVFys/0rqTM/U7D
	 cFacpwcDjISVcoQoZswHZuTidL36gyYMFnFotMMTcoHGX5JZNOeF4r/vG5CxLZFqAF
	 33f18wXKuct7g==
Date: Mon, 6 Jul 2026 18:36:45 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: pci: qcom,hawi-pcie: Add Maili PCIe
 compatible
Message-ID: <yntj62kr7tixc7capwdr6xhv2zpisfrjg62bwftgiuujf4fzt5@cjdrkglo4dv5>
References: <20260703-vdev_maili_dt_bindings-v1-0-c9df0916cd5e@oss.qualcomm.com>
 <20260703-vdev_maili_dt_bindings-v1-1-c9df0916cd5e@oss.qualcomm.com>
 <20260706-pastoral-okapi-of-reading-e5bdb3@quoll>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260706-pastoral-okapi-of-reading-e5bdb3@quoll>

On Mon, Jul 06, 2026 at 08:46:41AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Jul 03, 2026 at 05:38:40PM +0530, Vivek Pernamitta wrote:
> > Add qcom,maili-pcie as a compatible string that falls back to
> > qcom,hawi-pcie, as the Maili SoC reuses the Hawi PCIe controller IP.
> > 
> > The Maili SoC is a derivative of Hawi and shares the same PCIe
> > controller architecture, allowing reuse of the existing Hawi PCIe
> > DT bindings.
> > 
> > Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
> > ---
> > Dependencies:
> > - PCI: qcom: Add PCIe support for upcoming Hawi SoC
> >   https://lore.kernel.org/all/20260625-hawi-pcie-v4-0-1a578603cd86@oss.qualcomm.com/
> 
> Squash the patches then.
> 

But these are two independent SoC additions, isn't it?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
