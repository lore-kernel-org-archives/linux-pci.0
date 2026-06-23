Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C83594A;
	Tue, 23 Jun 2026 05:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782193554; cv=none; b=DW0vx0qkANGdRinq4YeFiYEZUHuEpwXuM0nQuQo1hsydK7yKVLXW05FZ5UN8dgmpSkjd7UZPjcjI1bCoV+nCFDl6wBnsQoeXfcFlzQSyMno+wzT9fLS6jo7BQStSOG48kjo7DUSvWWT4YbIxOMHHDi1zwdGenYCFMRMqAzvV67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782193554; c=relaxed/simple;
	bh=TVNRxqdbvmVS4yKzcWog8ArmXTLj5MhZnYSgOWLqdnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxuJiw+nrC1d6HsGrKu6LS8FLTrfMQcqEyFHp5nUCP1cAjxyrSQxlehOclIE+OTAiKXIS3e++ehoR9pbGhHy5pkNWqZW2hGuH4g/yvAAeO6Kq4Is4H7kpjxj6WHUS8p/cM3Ef4KOf2jAbwiTw5KhJvSIem4ssbCBNCED1VPd2Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qa/BeaHW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa/BeaHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A91C1F000E9;
	Tue, 23 Jun 2026 05:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782193552;
	bh=dWLz/zW9pGxu4MmyMeLIaL8QlovD/EAbOQwnVjK0tNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qa/BeaHWnD+OP69bjLycHVUVXra6sZJV5iK9JntBBfOuED5JtAVeCw58o6uJnrRvi
	 cULVIyuOAAsRkkC/COasS2mMKt4NE3XmNDak8jO/Bw0lNczHMM+qJValCE2JZ3UH23
	 tbbhVdKC5KhO/ti5OsMLaP9L06YZk4UApZKs0s0HtUYWEvFx7AzgZyIMki7VJfv6kY
	 6kjr2LW7g4r4cEVSvzePZ9gIXjI3Ia3n9hVtwYPJpUll1IXCzatilu1XfKHVlMOmUX
	 qAsmTzfyaBFYkT5542j0KI8Hf0Suwxd2l4pClW6VvsWvGow0J/dPFgnIuBxejSLL4t
	 ZQ8POrFrSNMmw==
Date: Tue, 23 Jun 2026 07:45:42 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, vigneshr@ti.com, s-vadapalli@ti.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	mpillai@cadence.com, unicorn_wang@outlook.com, me@ziyao.cc, 18255117159@163.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, danishanwar@ti.com
Subject: Re: [PATCH] PCI: cadence: skip the link polling when endpoint not
 connected
Message-ID: <pocwd4v7iqlixcpaikjo6vqmnwsb7rfjt42qvlmxsn6xnvtrpf@zgch2iwu7itw>
References: <20260605071922.1724499-1-a-garg7@ti.com>
 <4lijgllolvtbvmzmluuslhkc7empdpizxhva6ysau7kssuqd5z@drkzb5afd4ba>
 <1ad01870-e2f9-485c-9206-23ee6de1d1ba@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ad01870-e2f9-485c-9206-23ee6de1d1ba@ti.com>

On Tue, Jun 23, 2026 at 10:53:48AM +0530, Aksh Garg wrote:
> 
> 
> On 22/06/26 20:22, Manivannan Sadhasivam wrote:
> > On Fri, Jun 05, 2026 at 12:49:22PM +0530, Aksh Garg wrote:
> > > cdns_pcie_host_wait_for_link() polls on link-up for 10 retries with a
> > > delay of 90-100ms each (~1 second). A call to cdns_pcie_host_link_setup()
> > > during the resume operation blocks the resume operation unnecessarily for
> > > ~1s even when no endpoint device is connected.
> > > 
> > > Add skip_link_polling flag to track link state across suspend/resume
> > > cycles. If link was down before suspend, skip the expensive polling
> > > in resume since no endpoint was present.
> > > 
> > 
> > Won't you need the delay if a device gets plugged while the host was suspended?
> > We had this same concern with the DWC drivers and we left the delay as-is as
> > nothing prevents an user to connect a device when the host was suspended.
> 
> Yes, that is true. However, the platforms that do not support hot-plug can
> skip the delay during resume since no device could have been connected while
> suspended (only those platform's driver would be expected to set
> 'rc->skip_link_polling) just like what Tegra264 PCIe driver tries to do at
> [1], where the driver sets "pcie->link_up = false" if the link is down
> during the probe and if the controller doesn't support hot-plug.
> 

If the platform doesn't support hotplug, then it is perfectly fine to skip the
delay. But you need to name the flag as like 'no_hotplug' or something
relevant, not 'skip_link_polling'.

> Even if a user connects a device (when the host was suspended) to a platform
> which doesn't support hotplug, the user is expected to run a bus rescan,
> which doesn't call cdns_pcie_host_link_setup() anyway, hence the flag
> 'skip_link_polling' is not taken into account in that case.
> 

This is not about running the rescan, but about initializing the device. The 1s
delay in cdns_pcie_host_wait_for_link() is mandated by the PCIe spec after
starting LTSSM and before issuing the config read to the device. If this delay
is skipped and if a config read is issued to the device, then the device may not
respond and the failure may lead to PCI stack assuming that the device is dead.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
