Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6C132E141;
	Wed, 29 Jul 2026 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338517; cv=none; b=EN1KB0d1OGDIVdQ113UY8aWtlJss2grouxJMSzzx+g6GvoJ9cVp49ccGSiSXnUJSaCFQcxaKpDKAe8uZapuaRXyzq+zitcJ80YxEbxnWwCfIaU6UC4Ox1Qrmk+YIz3s+/w/Q8UdJRlYgF3cXvp3wYWxUf6kDQYwB7grYO5P9CdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338517; c=relaxed/simple;
	bh=Bs84pcFgVlxk3672f9eybsO4n6BmjSyoqyj3ujfJnNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g56OCLlyk9H0txZENQRHHzeYCIOAqsH4U4uML9TtlrQe74AjvinLidte/6Fdjnv/Sb+ojKnYn1rRDcEiJVYVOfGj4JGxMhUcbN+SdyxoaR9kA9hLcov/4c+LeqvoJAopiCX++83vQlI4t7cqm4oVg6dzvRnAmAZPoXbL1Cp9II0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm+Gq5cD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm+Gq5cD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF2F1F000E9;
	Wed, 29 Jul 2026 15:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785338516;
	bh=zL6Hv0PFVPmAnBkkmFZnr0OL+VKp+L9i49IFy2aE60I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mm+Gq5cDv4X8XZHaCBBsX346Ay4A90TxjL3TNuXAJq+l8ymSP9jN3A3TrFSD2TsBB
	 w9B+rVXIBuQ+1yMsQl5/PEsT2SPwn+Y9VGz9rtQYZwVzpMFkqqjrDKBJ9EIiopsO38
	 DcpGx151f8kWD8VDt6Xb63vpaKScNZK3TgWETWA8jwqMKCdBrwcQtF8AFWr5Tk1UQ7
	 mYT0sVhirDxYnKozGCcOHVYEhTDvrwy3CWUgGNW3nxsz/G/BN3ehdwcSPyO2kWGLE9
	 b5/71B2fDQX4aB7aeGjHfccOMTb71vK2fhZdNNHbr8Dc6CDzuNNo1AEiv2pQ/3GhZx
	 hc2GuDLq6UE2A==
Date: Wed, 29 Jul 2026 17:21:45 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Elder <elder@riscstar.com>, 
	manivannan.sadhasivam@oss.qualcomm.com, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] PCI/pwrctrl: tc9563: Skip Tx amplitude and DFE
 tuning for DSP3
Message-ID: <a2v3seclmgu2lqpf7w2icamnz2iwwjahveryjke272nrx2oary@kgq755ojyxdk>
References: <oefxm7olagbd3dby2npgly7ausiz3g6cvls5igaxdzvlbr3wrv@rjlfebi2p36j>
 <20260728160457.GA1316307@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728160457.GA1316307@bhelgaas>

On Tue, Jul 28, 2026 at 11:04:57AM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 28, 2026 at 03:25:29PM +0200, Manivannan Sadhasivam wrote:
> > On Mon, Jul 27, 2026 at 10:59:11AM -0500, Alex Elder wrote:
> > > On 7/25/26 3:59 AM, Manivannan Sadhasivam via B4 Relay wrote:
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > 
> > > > DSP3 doesn't support tuning Tx amplitude and DFE settings. So just skip
> > > > the setting if DT has passed the tuning properties. There is no need to
> > > > error out the whole driver because of it.
> > > > 
> > > > Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > 
> > > So to keep things simple, tc9563_pwrctrl_parse_device_dt() is called
> > > for all downstream ports but you ignore the setting (with a warning)
> > > for those that do not apply to DSP3.
> > > 
> > > What about tc9563_pwrctrl_set_nfts()?
> > 
> > Good catch! I missed adding the check for N_FTS as well:
> > 
> > ```
> > diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> > index 9d869483b6b3..978907aa0ce5 100644
> > --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> > +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> > @@ -410,11 +410,17 @@ static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl *tc9563,
> >                 {TC9563_NFTS_2_5_GT, nfts[0]},
> >                 {TC9563_NFTS_5_GT, nfts[1]},
> >         };
> > +       struct device *dev = tc9563->pwrctrl.dev;
> >         int ret;
> > 
> >         if (!nfts[0])
> >                 return 0;
> > 
> > +       if (port == TC9563_VDSP) {
> > +               dev_dbg(dev, "N_FTS tuning not supported for VDSP\n");
> > +               return 0;
> > +       }
> > +
> >         ret =  tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_PORT_SELECT,
> >                                         BIT(port));
> >         if (ret)
> > ```
> > 
> > @Bjorn: Could you please amend the above diff with this commit?
> 
> It didn't apply cleanly (maybe whitespace damage?), but I applied it
> by hand:
> https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=b859b9366b44


LGTM, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
