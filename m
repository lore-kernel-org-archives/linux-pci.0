Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35431238C0A;
	Sat,  2 May 2026 00:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777681150; cv=none; b=WYGBWb0d8H/PPdEvdscCC0FqDrlnfOii74b/YQWlo29YZR16KFZcsMHyAC+LyRJrPG9puZ71HnM8H8EJ3fOeEtayOPjl3f7CSJTTZtQnVi4yBXpHfHIDJ+maomw1GLdqVI+nk6FmhXfWySlyuVoe33EibuKL6RCwhRimJYvdH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777681150; c=relaxed/simple;
	bh=AP5JtaG8I7D1v0LgQNhGuJZhUd8kwkp1E37feztWb0M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=h2Qlfj+5AaeaOlq6VjeRJ9N6tooEIr5JZjpu7bWJYk3iwvjL+E3/os1G6ZJLe4u6VTT8OVhx2jrlcD9c0Vk8rpSOlFpW9jYb9cox0nmNf7cpr+tZudiOW+k8WnItEkBG1VmK1RnzkQy0X+JVKMQ2e4nsQ4/Z/Y/o6GGihNXxa6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UR5aMexr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UR5aMexr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479FBC2BCC6;
	Sat,  2 May 2026 00:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777681150;
	bh=AP5JtaG8I7D1v0LgQNhGuJZhUd8kwkp1E37feztWb0M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UR5aMexr6sdKEpwcxwp2PWNNLGHpodQxZUsycKLv5k9Aiwltm4OIgt0Iu2Tggp7NN
	 l4PeqiYs6ppWS/417FP8hl33FbwukLTvJ33RUctkIaLEdFI4gM15w1L/kBrHXAmXJ6
	 UgisGLMMlM3sFFrMupWBS6XMJ90/90yssI3tVIJkBW/qhWFtY3GBNqgT9DEwxN19dr
	 KdMl5Wk3IOJTDI8CtRwsRMdAQ1pcyB4SKiYyFoL8JCamH5TBInEvOtRM0sXMccLvsW
	 LbUsdvSvUFxS8av/iwJOiWRnatx/UXVubRRS2aAfmwUZ3ezemGsVN2UPfLLy3BmD+Z
	 XAIkMNbj0PTlQ==
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6D4DBF4008A;
	Fri,  1 May 2026 20:19:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 01 May 2026 20:19:08 -0400
X-ME-Sender: <xms:_EL1ab8UvC2-9pbbO2KQYSRWWigYdGEX84B4fmvQ_i8d6fw95U6xRQ>
    <xme:_EL1aeKQlj9hLPCJrQgGNG8WqSS5p7etufmdMAUscppgic_Yav88H1XcPxC0eSRkM
    Q26nqQqD3MKoA35QHlE1f3OU7MupB53NNx0PU40x3kUdGI9KSpT_o8>
X-ME-Received: <xmr:_EL1aWhwra82VRDbo5ui8t1JWLDI1_fliQo6rhn3FgwR_-a-hDs8OR5oer8DVyejU2NeA8cyCvVVd-nnzvWRr7ACFRjmZG370VI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeludeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtjeertddttdejnecuhfhrohhmpedfffgrnhcuhghi
    lhhlihgrmhhsucdlnhhvihguihgrmddfuceoughjsgifsehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhepvdegheeikeetleeuffeuheefjeejvdejvdevteefgfffveeh
    vdeuvdffveffvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepughjsgifodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqddujeej
    vdeftdegheehqdeffeefleegtdegjedqughjsgifpeepkhgvrhhnvghlrdhorhhgsehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjghhgsehnvhhiughirgdrtghomhdprhgtphhtthhopegujhgsfi
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitgholhhinhgtsehnvhhiughirgdr
    tghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprh
    hosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghs
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhgpd
    hrtghpthhtohepphhrrggrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsggrohhl
    uhdrlhhusehlihhnuhigrdhinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:_EL1af1ZcO5-YpE38i02isp_4d3w_hFixKhXCSrW96L-ciuBrGBDrw>
    <xmx:_EL1afZPvW9E4Amn80J9eH2GpDZzyt8By6wclunVRO8D0olRXeMtDg>
    <xmx:_EL1aUgUaU-zz0xg4mi6T_A2g8cgIF2nO-JMwfoAIj99ioRfK0Pi2A>
    <xmx:_EL1aXj6EQX90dPENstW4VruevvnCZqNYkgo_1rcL1SHGY71Q0ZM1w>
    <xmx:_EL1aZASdYzR3rwLJK-YLv5dzahm4FdEOnUJs64EcSQObA-3BwprAE-8>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 May 2026 20:19:06 -0400 (EDT)
Date: Fri, 01 May 2026 17:19:05 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>, 
 "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, 
 will@kernel.org, 
 robin.murphy@arm.com, 
 bhelgaas@google.com, 
 joro@8bytes.org, 
 praan@google.com, 
 baolu.lu@linux.intel.com, 
 kevin.tian@intel.com, 
 miko.lenczewski@arm.com, 
 linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 dan.j.williams@intel.com, 
 jonathan.cameron@huawei.com, 
 vsethi@nvidia.com, 
 linux-cxl@vger.kernel.org, 
 nirmoyd@nvidia.com
Message-ID: <69f542f92e36e_3291a910052@djbw-dev.notmuch>
In-Reply-To: <20260501234641.GB1381708@nvidia.com>
References: <cover.1777269009.git.nicolinc@nvidia.com>
 <f6734b9dad0050138676f11ecd14e9db1cf6b697.1777269009.git.nicolinc@nvidia.com>
 <69f3cc82926_3291a910039@djbw-dev.notmuch>
 <afPlkW5zlTSHwQCT@Asurada-Nvidia>
 <69f536ed263dd_3291a910017@djbw-dev.notmuch>
 <20260501234641.GB1381708@nvidia.com>
Subject: Re: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Gunthorpe wrote:
> On Fri, May 01, 2026 at 04:27:41PM -0700, Dan Williams (nvidia) wrote:
> 
> > You appear to be confusing Cache_Capable and Cache_Enabled.
> > 
> > "8.2.1.3.1 DVSEC Flex Bus Port Capability" != "8.2.1.3.3 DVSEC Flex Bus Port Status"
> > 
> > Cache_Capable is only a capability. To check that the device has
> > actually trained the CXL.cache alternate protocol you need to look at
> > the status register.
> 
> The capable is probably a reasonable choice here unless you are
> confident the status will never change after the device is first
> discovered? ATS is being set early in the boot sequence.
> 
> It is pretty safe to be over eager with the ATS enablement, less safe
> to get it off when it needs to be on.

True, a reset could turn on CXL.cache. Ok, stick with what you have.

The present state of alternate protocol negotiation is still relevant
though for distinguishing CXL protocol errors from other PCIe AER
"internal" errors.

Need a bit of fixup work for that to refresh the status bit after reset.
