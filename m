Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B982C3BE161;
	Tue,  7 Jul 2026 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408765; cv=none; b=fHGSFXcS63ecRM4fhSPrrw6SdjYcfpQoZNN6nhauoWP84vDVJbMpb57+6W6ZO80rmAMEAfGCWIK3zd5QVy4NjEXVWKoJ0OZCoCuoThoKsolRvneuVeSGur0Db/7XLHVuKdKnsU3FowG3j/Hbl8cXGmVDcAGAaR9/diChQD3DNdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408765; c=relaxed/simple;
	bh=DibaKV7uEbuP4zobhw0Mr7qzhImC2d2zZetjIL6F+ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgH1Q93PYe/JceXcqvZ6JqCEuHpd/qL821ZbT68z82nxwcayeQn5cAbOl8DJq766MvveXMf06Y9A5DCHkafYuFJ3Y1t+kECmbp22FtLtawxd0N/bEQMjQNK2dHzgMOkqIAtDiK3BwOcMm/PxG0Ox1COOXFByYhzIguLsUGkEaEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVhFohHR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVhFohHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E591F000E9;
	Tue,  7 Jul 2026 07:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783408756;
	bh=Nhjnutzwtwz3q8GwPHJ0ZxGLEwpmozqj79iMSPN6uNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KVhFohHRaEweA2Slii/hMfFQnSN88fx4CX0ZCsb55V87G7cE4LR8oSZEH3Sl5diev
	 tbGgM+jMz3PIn94T3y8FqGbLyZa8kgmTq0z6jp8IjcrJTTbFhZHEPGxkU36gWlFiWa
	 k3YOyG0S3QsIZgsXUyykpQHlFj2aX+RQTLpdD329Gjspe3sWBNoLBkmNi/p4YbMm4n
	 iEy5bDTp6w2S+1z/bYcolRsPojNTrWeVeOiWPtFs1nuzZ0f6zTkPPFnWPwxN7o6VnI
	 CuyT8J/4NvjivdumwW3CqDtBxvKM1/QrOm5qs+T8QDkr5bBqu9p8uYEppXwIhjq4A+
	 owudE6F/UAwBA==
Date: Tue, 7 Jul 2026 09:19:06 +0200
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
Message-ID: <dxtlmourfju7ue6nab2yx5lv6cf2z7w3okdfr6zwxvskday6nt@xnl63h5kojts>
References: <20260703-vdev_maili_dt_bindings-v1-0-c9df0916cd5e@oss.qualcomm.com>
 <20260703-vdev_maili_dt_bindings-v1-1-c9df0916cd5e@oss.qualcomm.com>
 <20260706-pastoral-okapi-of-reading-e5bdb3@quoll>
 <yntj62kr7tixc7capwdr6xhv2zpisfrjg62bwftgiuujf4fzt5@cjdrkglo4dv5>
 <9967f1a0-a9e3-4d62-b5df-7f625610a89d@kernel.org>
 <43b5xhqvnapamfv4aomid647kaxrudgjcbnnca23t3vxitv67t@njdlthj2oisa>
 <92b7efac-32c3-4a89-9b08-55da294a6bc0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92b7efac-32c3-4a89-9b08-55da294a6bc0@kernel.org>

On Tue, Jul 07, 2026 at 07:55:45AM +0200, Krzysztof Kozlowski wrote:
> On 07/07/2026 06:53, Manivannan Sadhasivam wrote:
> > On Mon, Jul 06, 2026 at 07:35:52PM +0200, Krzysztof Kozlowski wrote:
> >> On 06/07/2026 18:36, Manivannan Sadhasivam wrote:
> >>> On Mon, Jul 06, 2026 at 08:46:41AM +0200, Krzysztof Kozlowski wrote:
> >>>> On Fri, Jul 03, 2026 at 05:38:40PM +0530, Vivek Pernamitta wrote:
> >>>>> Add qcom,maili-pcie as a compatible string that falls back to
> >>>>> qcom,hawi-pcie, as the Maili SoC reuses the Hawi PCIe controller IP.
> >>>>>
> >>>>> The Maili SoC is a derivative of Hawi and shares the same PCIe
> >>>>> controller architecture, allowing reuse of the existing Hawi PCIe
> >>>>> DT bindings.
> >>>>>
> >>>>> Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
> >>>>> ---
> >>>>> Dependencies:
> >>>>> - PCI: qcom: Add PCIe support for upcoming Hawi SoC
> >>>>>   https://lore.kernel.org/all/20260625-hawi-pcie-v4-0-1a578603cd86@oss.qualcomm.com/
> >>>>
> >>>> Squash the patches then.
> >>>>
> >>>
> >>> But these are two independent SoC additions, isn't it?
> >>
> >> It's adding a single compatible, no? If a patch adding a single
> >> compatible cannot be done without multi-patchset dependencies making
> >> testing by tooling impossible, then probably that work should not be
> >> sent separately or even as separate patch. And I am not saying anything
> >> new because half a year ago (around Kaanapali and Glymur) I voiced
> >> strong opinion about that.
> >>
> >> But really, you do not need to add two compatibles in two separate patches.
> >>
> > 
> > Ok then. I'll squash this patch with Hawi patch which already got applied.
> 
> Applied? That's not what I had in mind. This mentions external
> dependency, not something which was applied. Should be squashed there.
> 

I merged the dependency for 7.3 before looking at this series. So now, squashed
this patch with that.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
