Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F0F33F588;
	Tue, 28 Jul 2026 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254700; cv=none; b=S8t2+b2PXuXAKe/H5JtRsozPql7MeM162kQ67bObV03wzZ1Sd2f9Xqi/8DMxAgOH7oC9s64YLPHoBnVFrAz4EZ5sPatHW8JcSJIU4MiOfII0orlskl2jYlpOXyOVng+Gzf/uDuqzp5acJZwcEmeenjhmtjdnyo2b80rMl19jVBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254700; c=relaxed/simple;
	bh=CMWvIrclDQSsdA+6BYLRb6Lt3zv1XS3lSNZBvnXLdUs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JPzklW/jI4W9sJ9OnjvuTjOYGpCGego5zR7VNzh7vERSgMyZB2XdDppjCW4twzKwZlE7NaH0kbArbb1ZenRbO+iYamkKHfG3A60KHzlNgtLzXTqgkjQVH5vEbPmUBojbmsPKTsHCYupxQYT7RggYrxmtgIG8c8Rty7FdR3f1bVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZ/YjqvG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZ/YjqvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702CF1F00A3E;
	Tue, 28 Jul 2026 16:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785254698;
	bh=DjqNI1wU5JMKwBFt8yKOLhjjaeWTrzshQutENKjjkro=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=dZ/YjqvGGD/guacJDNhFJtlAMXq/qWqaQpysACSIHNNTkX93Rtb/e/xlmRcRRaKWN
	 ABAHU7GSJaAs7OFYnmGMDiiRX+TCG8kCdZCd7XRQT9pekGpOC5yIs2394+tVJZKA8J
	 y36+ZpkdRMY/Jp6lrceP1NTmiDjJSE+yr5KPCm/8BwLWIumdKkJLfhNJxXQdxh5f58
	 fmMh9mitKzYwxxpyZgVJzvCW7+U6XVp+1zvXGCKn/KfucuAKPrztT3Qo/M/7sTnUSL
	 5WQrNG3XoO/ZV6NF3qcIUd1RU3XYWF2LdziBz5D4kG83H0TMN+ut+T6VyTT8cc3INw
	 ocu2tPnNcOgVA==
Date: Tue, 28 Jul 2026 11:04:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Alex Elder <elder@riscstar.com>, manivannan.sadhasivam@oss.qualcomm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] PCI/pwrctrl: tc9563: Skip Tx amplitude and DFE
 tuning for DSP3
Message-ID: <20260728160457.GA1316307@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oefxm7olagbd3dby2npgly7ausiz3g6cvls5igaxdzvlbr3wrv@rjlfebi2p36j>

On Tue, Jul 28, 2026 at 03:25:29PM +0200, Manivannan Sadhasivam wrote:
> On Mon, Jul 27, 2026 at 10:59:11AM -0500, Alex Elder wrote:
> > On 7/25/26 3:59 AM, Manivannan Sadhasivam via B4 Relay wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > 
> > > DSP3 doesn't support tuning Tx amplitude and DFE settings. So just skip
> > > the setting if DT has passed the tuning properties. There is no need to
> > > error out the whole driver because of it.
> > > 
> > > Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > So to keep things simple, tc9563_pwrctrl_parse_device_dt() is called
> > for all downstream ports but you ignore the setting (with a warning)
> > for those that do not apply to DSP3.
> > 
> > What about tc9563_pwrctrl_set_nfts()?
> 
> Good catch! I missed adding the check for N_FTS as well:
> 
> ```
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index 9d869483b6b3..978907aa0ce5 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -410,11 +410,17 @@ static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl *tc9563,
>                 {TC9563_NFTS_2_5_GT, nfts[0]},
>                 {TC9563_NFTS_5_GT, nfts[1]},
>         };
> +       struct device *dev = tc9563->pwrctrl.dev;
>         int ret;
> 
>         if (!nfts[0])
>                 return 0;
> 
> +       if (port == TC9563_VDSP) {
> +               dev_dbg(dev, "N_FTS tuning not supported for VDSP\n");
> +               return 0;
> +       }
> +
>         ret =  tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_PORT_SELECT,
>                                         BIT(port));
>         if (ret)
> ```
> 
> @Bjorn: Could you please amend the above diff with this commit?

It didn't apply cleanly (maybe whitespace damage?), but I applied it
by hand:
https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=b859b9366b44
