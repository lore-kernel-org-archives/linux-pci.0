Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB37385D7E;
	Thu, 30 Jul 2026 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785397940; cv=none; b=SAonXO91NsbxMCplUg5gZFSti1zcSHLFhcANmN4C2K1Q0Oi2ccJ6uihsbNeOGgyhP2AyCRG9NQ+8I0Y/X4Or6V1lvemqFCCo7ube2eQo23lfpYw98tWkSEIRzTErlBUNp5g1x6CCeMVIJwCz6Bv9YtMPaCparbD46Ze828/0lco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785397940; c=relaxed/simple;
	bh=nBXBEOhZRZ/OXosgqa09e+upRXuh4rgYk5+sS0VTZto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kANb6AfgOiR4PN/WpmXKJdJsBYDSH6bMMaSp7KCfZfhkvN004olsfVXC3E9AkG7i5mUoaL/yk+2m3SLN+3Lnibk4ml+yh+hizIaVqyp9AsOFQ3eH6mlpNOiD0j8cEI9JEIpxpertlgrO8y1h8X2RGzRS2MUlXGQcxrYe3CF6kbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEVxWKs1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEVxWKs1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0A81F000E9;
	Thu, 30 Jul 2026 07:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785397938;
	bh=9uaXjuwWLXSYqTM/7Xuwqd0qqDQar7aWxF1U+BfJ0wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DEVxWKs1dU8bcWDR+kRV2ZEMICMmyHDGniESJv2GHFF7bNYt5p8T69u4gbcwhePfO
	 f56QKjYj8F4AvACCSRHltd3lFM4sw8X5FXNLs5JM6r9CVdspOVCX77UiBnNcKs8K5m
	 K1odOUMgDdkpPozVYjA8sNgPz9AQfVJrasyG/DvHwm01BkUK7Pp3EjdpTexW6AAitH
	 JLcS1gHUXQVlNKPPVhisbWmf2xRQXOo+esVU5R0/u5BsMseARwP7jhvCotoZ3cJX9j
	 TKoDibjLdwNJgy98do/vBHFZ49sOI0IE8YHi4BYEAcaEUIXopZwceq7uwf89eB/TsD
	 +27w7j3evcO2w==
Date: Thu, 30 Jul 2026 09:52:10 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with
 TC9563 PCIe switch
Message-ID: <en6sfnjfh2anntkvwojt23xexkpjov4oiapcgcd4e7sexhdya5@xcohhiftv5b6>
References: <20260730-eliza_evk-v6-0-40ece2d33114@oss.qualcomm.com>
 <20260730-eliza_evk-v6-3-40ece2d33114@oss.qualcomm.com>
 <ofkvwrvfpyhjflrmbyi43gd4mltrqdmf3pzdvxwitrqshtttvo@r3xpfq3m42ha>
 <9a042817-3a3d-4637-8df7-466ffa380403@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a042817-3a3d-4637-8df7-466ffa380403@oss.qualcomm.com>

On Thu, Jul 30, 2026 at 09:42:29AM +0200, Konrad Dybcio wrote:
> On 7/30/26 7:25 AM, Manivannan Sadhasivam wrote:
> > On Thu, Jul 30, 2026 at 10:18:55AM +0530, Krishna Chaitanya Chundru wrote:
> >> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
> >> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
> >>
> >> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
> 
> [...]
> 
> >> +		pcie@3,0 {
> >> +			reg = <0x21800 0x0 0x0 0x0 0x0>;
> >> +			#address-cells = <3>;
> >> +			#size-cells = <2>;
> >> +			device_type = "pci";
> >> +			ranges;
> >> +			bus-range = <0x5 0xff>;
> >> +
> >> +			pcie@0,0 {
> >> +				reg = <0x50000 0x0 0x0 0x0 0x0>;
> >> +				#address-cells = <3>;
> >> +				#size-cells = <2>;
> >> +				device_type = "pci";
> >> +				ranges;
> > 
> > Sashiko pointed out that you are using bridge specific properties in EP node:
> > https://lore.kernel.org/linux-pci/20260730051031.20D8E1F000E9@smtp.kernel.org
> 
> Can we harden the bindings here?
> 

Possible, but overkill IMO. The base dtschema for PCI bridge includes both
'pci-device' and 'pci-bus-common'. So for the Endpoints, we need to restrict
them to use only 'pci-device' schema and that would require adding
'patternProperties' to cover the Endpoint nodes in each binding.

Since this is not a recurring issue, I don't think we really need to go that
far.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
