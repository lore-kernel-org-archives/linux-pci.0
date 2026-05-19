Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2120395DAA;
	Tue, 19 May 2026 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227545; cv=none; b=c+b6+9R5HJAQdWJk3G6mhWCusZD/xV2EDlmHRDA/QbT9bDtvbljn/Wh0IE+6S1NS+/bonXxosNbpth0X3Tw9RXaLex/81+S/CTP8LNhLW2Q+SiP+YO4m3XSxBGJ7NSXRW+fp9LOxhx+RfwO/ZlY4SI/yEptkh6twrrxNUMvMl/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227545; c=relaxed/simple;
	bh=MoZsOmuW47OYpJJ4yLCIUL/ufJHjeBhhRzuIUGeNSOI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ke5U1sa4TDe5Bo66ty1Nipy5DaI6qEV+Rerfg0sAmiaL7/w7LDA44Gy+/DMtCKGYUY5xU6UoZJ4UEBT0DNOzqC79ZImK24Hy1VD/fl7bdowD2K2UdL8FFZYBvw4Z5nzDuocc6in6pHTlo61/bgGk8VkjoE49SGkUEx4IX/S5Sb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYZb0aeK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYZb0aeK"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3EA941F000E9;
	Tue, 19 May 2026 21:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779227544;
	bh=+EgRr6uYLBJZxjzag9UjRODPlRA2X3MbxClA5xBAP9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=gYZb0aeKE/0pnEJTfpGwR3qnpY5m+HTsmRpPjDfuVZSexD9Ru+n4DHo8hPLbait5f
	 6oAldMXsPpCmxnhoqcwAx8SJfRQ2fhVnTUlyY8MFd9Gc9LkjncJnM8iUrdtD/KNM88
	 ikupHvJaNUmqlatrAADCo2ArtGSlWQ2h2b9PfuCg5EAhmPzOvLif4R+9VipButX3RD
	 ZSz4wMmKEbbuJl2e7iWWwkMZYDbt7Q7uy/ZPoxUuxCQ/okmcNgClpUt+Vs968arwQz
	 rn6piz0kgael8HP8NWHC85wGUVeXFa8cNCRA6Zrl64MW309lo1RWpxHV0tYAU3MHZU
	 cP6gYoU7TvD3A==
Date: Tue, 19 May 2026 16:52:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Ziyao Li <liziyao@uniontech.com>, niecheng1@uniontech.com,
	zhanjun@uniontech.com, guanwentao@uniontech.com,
	Kexy Biscuit <kexybiscuit@aosc.io>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	kernel@uniontech.com,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lain Fearyncess Yang <fsf@live.com>,
	Ayden Meng <aydenmeng@yeah.net>, Mingcong Bai <jeffbai@aosc.io>,
	stable@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v8] PCI: loongson: Override PCIe bridge supported speeds
 for Loongson-3C6000 series
Message-ID: <20260519215222.GA18171@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d815df3b33a63223112b97440c01247935363c1.camel@xry111.site>

On Tue, May 19, 2026 at 10:23:22AM +0800, Xi Ruoyao wrote:
> On Mon, 2026-05-18 at 13:53 -0500, Mario Limonciello wrote:
> > > > Also, the amdgpu driver reads the value by pcie_get_speed_cap() in
> > > > amdgpu_device_partner_bandwidth(), for its dynamic adjustment of PCIe
> > > > clocks and lanes in power management. We hope this patch can prevent
> > > > similar problems in future driver changes (similar checks may be
> > > > implemented in other GPU, storage controller, NIC, etc. drivers).
> > > 
> > > Why is this paragraph here?  Is there code in
> > > amdgpu_device_partner_bandwidth() that wouldn't be needed after this
> > > patch?
> > 
> > I don't think that would be the case as this patch is a pure quirk for
> > one device.
> > 
> > The policy we have in amdgpu_device_partner_bandwidth() takes into 
> > account specifically the topology of dGPUs that have integrated PCI 
> > switches.
> > 
> > We need to look at the speed and width of the link partner connected to 
> > the switch not between the switch and the GPU PCI device.
> 
> Yes, the paragraph was intended to explain why the lower speed only
> manifests on some (not all) PCIe devices, for example amdgpu, with the
> incorrect LinkCap2 from hardware.
> 
> > > This patch updates pdev->supported_speeds, which is used by
> > > pcie_get_speed_cap(), which is in turn used by
> > > amdgpu_device_partner_bandwidth().
> > > 
> > > Is the point just that users of pcie_get_speed_cap() (currently just
> > > amdgpu, radeon, and sysfs) will now see the correct maximum link speed
> > > for Loongson-3C6000 bridges?
> > > 
> > > And the "checks" you refer to would be the tests in
> > > amdgpu_device_get_pcie_info() that use the results of
> > > pcie_get_speed_cap()?
> > 
> > I think I agree with Bjorn to drop the paragraph, it just adds confusion 
> > to the reader.
> > 
> > You can have a sentence along the lines of "Updating the speeds to the
> > correct actual support of the hardware avoids quirks in drivers 
> > consuming the speed information".
> 
> Yes, it will seem better.
> 
> Bjorn: do you need a v9 or would you just amend the message in your
> tree?

I amended the commit log:

  ...

  As a result, since commit 774c71c52aa4 ("PCI/bwctrl: Enable only if more
  than one speed is supported"), bwctrl will be disabled if there's only
  one 2.5 GT/s value in vector 'supported_speeds'.

  Manually override the 'supported_speeds' field for affected PCIe bridges
  with those found on the upstream bus to correctly reflect the supported
  link speeds.  Updating the speeds to reflect what the hardware actually
  supports avoids quirks in drivers consuming the speed information.
