Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C36F2192F9;
	Tue, 28 Jul 2026 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245139; cv=none; b=l5cAcEU4mka+vuAJHrG69TbJLbSo8nizj5Hj3TxVPy5ku9VjetHuard2dSWGtaePFAZev9Knc4g+/LdHFLAP/hS2PMuFMq1689xApTSTfuw5trIVFeelPMmV59HYm0biPXQnsgvQhtcIIwhnMEN73EWFVZy7SOJ3Rm3Blou9JT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245139; c=relaxed/simple;
	bh=2X1qoA+We9EF9hJ4GRjAIPe121f0pIYmOiVEZe2MmpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow7P9sSgpI2aDdnfMcDLSMXsfKjQRVelWS7XHVda/G+GsRxGKarcepQBUN0hP77H+apDVjk8z4pznE6Nf3auvdj7R2Sz4YqOvuvelM4v+HF5FQwlaGBBiNevCFN+Oguu3Q+21HVly+nLmQpZ6uEeV1RIAJI4xv4pKolR41iVQCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgrusidX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgrusidX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BAF1F000E9;
	Tue, 28 Jul 2026 13:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785245138;
	bh=G3NyROKDDWWavK8r1MKoPBcP39rBC2hL83e23KBn9xA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QgrusidX26p73La9MkoZtvajqp4mJsEqJUNuG5OPF0yJ3uyZSOjmm6fbZxfBWOm0O
	 MWhryxBTSwdKr6+zrJ3d4/dHaiPe/aa+xp/budoPXH+8IqV1/YU+0Eri5uY2DjXSzr
	 uVP26ypF0yPU9gMigfPpluYqh4EBuKLCcBY+fQmBmR7yAiGqeniTrqJFedH1WMF7Qs
	 WewAKx1e2Sc/lHZtBgvUVf8gPMLsuEzNxR8vF3otT0nsov1yVv/x7m8L5Mx1o18B9Q
	 ah8BwUaaVZgUiZ3W+kQ8JwwNfWKsq1vzDSvcSqVAlMVqbDrrsgyphSh05oeUx6gGkF
	 64OX2pTquCW8Q==
Date: Tue, 28 Jul 2026 15:25:29 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] PCI/pwrctrl: tc9563: Skip Tx amplitude and DFE
 tuning for DSP3
Message-ID: <oefxm7olagbd3dby2npgly7ausiz3g6cvls5igaxdzvlbr3wrv@rjlfebi2p36j>
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
 <20260725-tc9563-fix-v1-4-ec4286e31331@oss.qualcomm.com>
 <f9937e7b-746c-486b-b94f-fb3b34a2b0d0@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9937e7b-746c-486b-b94f-fb3b34a2b0d0@riscstar.com>

On Mon, Jul 27, 2026 at 10:59:11AM -0500, Alex Elder wrote:
> On 7/25/26 3:59 AM, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > DSP3 doesn't support tuning Tx amplitude and DFE settings. So just skip
> > the setting if DT has passed the tuning properties. There is no need to
> > error out the whole driver because of it.
> > 
> > Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> So to keep things simple, tc9563_pwrctrl_parse_device_dt() is called
> for all downstream ports but you ignore the setting (with a warning)
> for those that do not apply to DSP3.
> 
> What about tc9563_pwrctrl_set_nfts()?
> 

Good catch! I missed adding the check for N_FTS as well:

```
diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index 9d869483b6b3..978907aa0ce5 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -410,11 +410,17 @@ static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl *tc9563,
                {TC9563_NFTS_2_5_GT, nfts[0]},
                {TC9563_NFTS_5_GT, nfts[1]},
        };
+       struct device *dev = tc9563->pwrctrl.dev;
        int ret;

        if (!nfts[0])
                return 0;

+       if (port == TC9563_VDSP) {
+               dev_dbg(dev, "N_FTS tuning not supported for VDSP\n");
+               return 0;
+       }
+
        ret =  tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_PORT_SELECT,
                                        BIT(port));
        if (ret)
```

@Bjorn: Could you please amend the above diff with this commit?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
