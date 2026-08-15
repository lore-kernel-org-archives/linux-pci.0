Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A6364933;
	Sat, 15 Aug 2026 06:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786774628; cv=none; b=GKgF9iyvhph8uYYMd8gqOLMaDP8hFkC5rlNI1F7K8SlQ4scPCmkQDLp/48I5rNceDAjKu0gyusAdsSceynXM7uLLPoEvjjINBBhv5a/wbJIiI8dTQst1L7oojhJU8LVun7VGVI0ycB2qzLQjy96X8ErGwVB1QM9zVzUE2aN5YZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786774628; c=relaxed/simple;
	bh=SCRZTMpRCMVCX7aT29rm/F9KKLGJBoiVSK93mw3zfMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sisA4LrUEdgvcln8i1HO7l4PT8/l7umTnCGnuVyyyqQ1/QSgfN+oBUEgNg7BEpRt2SxUEkiAXdV4KvxppsKZjQOpWZamlegTXgo5IKS17ZBfZ5t1/2A8tksiVGnLB76MY3TGKDYjoNr5rlTgKO6yAXIMNPcMSO1DRRg954zUaC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SE5wWC5p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SE5wWC5p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8647E1F00A3A;
	Sat, 15 Aug 2026 06:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786774627;
	bh=s4yr7wW7VcW+X5agNdwxWKyh0uAOCgvVx8mINLSy3/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SE5wWC5p2USuy46IKzy+mpsQZguFjUu2Eyy6yBy/hgAKSrV93Imm7JqR0TgWkF83r
	 6+Geh47Ildl9uFYa+jXRJbWlJnjw6lkmWr6FDchOo05gsa6ZYXjMbRTxC4Y/v3sFNB
	 h8a+L1BuO1dVxTs+GDRo8PnWPCj+bdd2ANV6dofQ//2H6pqdReXuOfSet33RzyBBBb
	 DYhXngCLtSnpxEVhZujMW5S15DIFByV1Pb3WjnHCBGMS6PxPTzsjP60ZuHFZPQR5vq
	 hYYReE4mn1gJXxqWJO85+N85jkUkfs9+9PpWzPSUMeEcVg8bkpkbqb4FXOiWTzK2J2
	 5snhNIgyLZp8w==
Date: Sat, 15 Aug 2026 08:16:56 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ryder Lee <ryder.lee@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Jianjun Wang <jianjun.wang@mediatek.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/2] PCI: mediatek-gen3: Add 2-lanes mode support for
 Airoha AN7581
Message-ID: <5qulrgfnwzuo556hxsyg3iweqv6i57ll3chhhb3nxe7lgr6fff@4l3s5rotnpab>
References: <20260806165334.7328-3-ansuelsmth@gmail.com>
 <20260813170820.GA1143871@bhelgaas>
 <6a7e1b73.e11288f4.1351ae.5625@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a7e1b73.e11288f4.1351ae.5625@mx.google.com>

On Thu, Aug 13, 2026 at 09:30:54PM +0200, Christian Marangi wrote:
> On Thu, Aug 13, 2026 at 12:08:20PM -0500, Bjorn Helgaas wrote:
> > On Thu, Aug 06, 2026 at 06:53:32PM +0200, Christian Marangi wrote:
> > > The Airoha AN7581 SoC supports configuring the first PCIe0 lane to 2-lanes
> > > mode (x2 link) by bonding it with the second PCIe lane (PCIe1). This is
> > > done by configuring the PCIe MUX in the SCU register.
> > > 
> > > To correctly configure PCIe0 in x2 link, define in DT the following
> > > additional properties:
> > > 
> > >   - additional reg, 'sec-pcie-mac' for the secondary PCIe.
> > >   - PERSTOUT reset for both main and secondary PCIE0, called 'perstout' and
> > >     'sec-perstout'
> > >   - 'airoha,scu' property to correctly configure the SCU register for the
> > >     PCIe MUX
> > >   - 'num-lanes' set to '2' to enable PCIe0 in x2 link
> > > 
> > > In such configuration the EQ preset are configured to the same values.
> > > 
> > > To permit correct configuration of the PCIe link, additional logic is added
> > > to assert and deassert the PERSTOUT resets. Support of these additional
> > > reset was introduced in Airoha clk driver with commit
> > > 6712f48eb3a1 ("clk: en7523: add support for dedicated PCIe PERSTOUT reset")
> > > and on backporting of this commit also the clk driver change will be
> > > needed.
> > 
> > I don't see 6712f48eb3a1 in upstream or linux-next.  Is this SHA1
> > going to valid if we merge this for v7.3?
> 
> I picked that sha1 from the git pull for the staging clk tree.
> 

Ah, I missed it. In this case the SHA should be dropped and maybe we can refer
the lore link of the patch?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
