Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914729;
	b=4t+gap+HaKp7y2u+U9DU6ZWRaJJBKqeN7OZi2JAwUJ5tpoVm5NgSzP380GER6W/WyaTs
	 OMTjbiLiH0BqmOVKMf01A1jhONxsyEgIWu3f+XTvRDRf1FtPrpM8cjI+N15b+6f+StLzX
	 7dwVQR+IJcuys4VlJhY9hfwofo8e6nfsLvqk5m3v3tG/ZNejBytipzSBUEMCjT/9VULs0
	 m667nEtSriOlKKfp4rvplgST5px25qy1GhiT8m97v2Ca6T6XstuqNlcnL6JyjSdtAMvPd
	 q0zetu4k9shjj6EbWebauActqrrl4jgTN6C4bFi1pHyHYWU3cw3kNkDe2g69eHNsWgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914729;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OG3uAdRsKsnCgp4y6ps7Sg3KysoNOneAEH7kqGaywLk=;
	b=lsHn6fvrwNZT61aZ+LXhtNS85tSooqTDF4MxEq2iw28zEcDoY4NEYy6bNbjTBnmBafqE
	 26f0LYv+S/zMx9cBzXaoT589TvR4YuZJcXv8PGukyP46SS1mXr/pWEAxeO9G5WgvlZg10
	 9zjCFSXNLxrC3VuPu4tPN5zmwKq9XUVynPACBMDLK2Pv0r0VyPnBKpC5nJ8AxK9WSeQ6w
	 ovEKlTqjejeSphJnfdd8DEzCcsPhNsXH+bQM6STbTAZUfl4x0Mx3LC4+T0lkujsCjNlDX
	 n4wFyZWW/Z6uDCaKmmfgUpx8VBePeHalvRBRsYMzL3Dd5swV9Efx4WL1b7CtYuwWE/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGjc7uJ3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119FF606A326;
	Thu,  5 Nov 2026 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGjc7uJ3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AB71F0089F;
	Thu,  5 Nov 2026 21:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914728;
	bh=OG3uAdRsKsnCgp4y6ps7Sg3KysoNOneAEH7kqGaywLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=XGjc7uJ3Jhwrp/iwFo3hEPaDKdaFdkiYPdKOQDlg6QQS6Xo/1LtSxo6vgDV7jxac4
	 4EH0psVYsPNjiKM7Pk4vtuhYeQ9ILJvrFiK32rvmKXL/YQ/J1KmIBroXbMV+zIPltx
	 ePArzOOdnXK0EeNxfoz9gNbfv1aFUcKL8aUagADAtk0EdCq2fdGXCQWwkvMlGlF7t4
	 7feuM4k6zPQD8jEglIgf1r5qXCkIswlu1OZszqDpWL85RkxWXExapYBrZGAtTX+9+f
	 Bw0DKgQjSc6vXQN8jlma79kTnHD5MnoCNZ4hsixGwpS7JMgmQ+O9zB0fGhTL9I9cBQ
	 Q/kvMzWVmx5kw==
Date: Thu, 5 Nov 2026 15:38:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Bruel <christian.bruel@foss.st.com>,
	"open list:MHI BUS" <mhi@lists.linux.dev>,
	"open list:MHI BUS" <linux-arm-msm@vger.kernel.org>,
	"open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] PCI: Replace chan->device->dev with
 dmaengine_get_provider_device()
Message-ID: <20261105213847.GA1565775@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auz2EAk-b-ZsX6PW@SMW015318>

On Thu, Nov 05, 2026 at 03:33:04PM -0600, Frank Li wrote:
> On Wed, Nov 04, 2026 at 03:27:10PM -0600, Bjorn Helgaas wrote:
> > On Wed, Nov 04, 2026 at 10:01:59AM -0500, Frank.Li@oss.nxp.com wrote:
> > > From: Frank Li <Frank.Li@nxp.com>
> > >
> > > Use the dmaengine_get_provider_device() API instead of directly
> > > accessing chan->device->dev to get the DMA provider device.
> > >
> > > No functional change. Prepare make to struct dma_device private to the DMA
> > > engine.
> >
> > "Prepare to make ..." I assume?
> 
> Yes, Do you need me respin it or you can fix when apply?

I'm sure Mani can fix it.
