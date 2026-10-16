Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1421E44E67D;
	Fri, 16 Oct 2026 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140936; cv=none; b=I7pVeQImHgHaFWKRIw/eO20bvsxXCXGAZQ7WaOhRg0yEeqm9UrhxjQshapzYRC2IehLEtS9N3yT3mVF5VVdFe/w4sRb4zzUAh8B13/z/lrGdJDmwAwFxska2VzVW/bEDWUdh4wVDGYyKwC13tNdZ4EA6Uftea4GJL4w2TuAbYL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140936; c=relaxed/simple;
	bh=khkxtZWCOnDlDDJhV4ExhPjS1Qusd0nh6hCeTeRsCXo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=KojcTmvqZwbpgJwDl+rgnUtvaGvQJbqLOw6xmUROPi4Oep/aSSMIxvXrdt9+kw9oflrVC2mWLg5NV6JfXNRFrXEnSotZ5CwT32nKv2jdSUvAxZAZ4ivXvFtdEg3UkLk3pMwaoZKxEa8B7wS4n0dZlyDSDfPQUstxGrdcyDmwG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937AB1F000C4;
	Fri, 16 Oct 2026 08:55:28 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5] PCI: rcar-gen4: Add missing PM ops
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, 
 robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261004013131.0C7D81F0089B@smtp.kernel.org>
References: <20261004011851.866833-1-marek.vasut+renesas@mailbox.org>
 <20261004013131.0C7D81F0089B@smtp.kernel.org>
Date: Fri, 16 Oct 2026 14:25:06 +0530
Message-Id: <179214090624.63727.1877053108500595755.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2086;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=khkxtZWCOnDlDDJhV4ExhPjS1Qusd0nh6hCeTeRsCXo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq0eZuc7B1lcdRwuLAxWowartnfBFByfwhzSYgB
 aMiRiL+orCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCatHmbgAKCRBVnxHm/pHO
 9f/NB/4/euPK6H+vg84xq+Wke5CyWAutjlCCqIvhhZkMSbkPn0CheAK5476VuJhOUkYkLnDbE8T
 Wo8holnuEL1QjuhzpCgFGup6/JKhcbUKTZkiqfp5vC6hMP4Uhha3IJwp81r/daEP9SpKpOZ9Mie
 STavwGzkq01+u9tKlRF5UvwYRHQtph58ISw81dToqzJtHe60UAv9YvaP5j/HjpK14I8ewCgY2q6
 BV0/2sxRaE7W1CfgCYCzpoId/5HJ01MvZ2ajpdMfuPUPIiZaBbRMwXPnN5CdNIRAB6QV2lFodap
 ziswAJK2IDZ3/njqNOFNjUuYSSGoga+2IEYDgqA+l3uQA2se
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-04 01:31 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] pcie: deadlocks due to ioremap and request_firmware in NOIRQ PM phase
> --
> 
> commit e6c055f1eedf6bd5c13e231da24f0c6a76a24ba2
> Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> PCI: rcar-gen4: Add missing PM ops
> 
> The R-Car Gen4 PCIe controller needs to gracefully suspend and resume its
> link across system suspend/resume cycles to support power domains shutting
> down. This patch adds suspend_noirq and resume_noirq PM operations to tear
> down the link on suspend and restart it on resume.
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > index 2e7a8d85c0060..fceecbd16355c 100644
> > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> 
> [ ... ]
> 
> > @@ -1062,6 +1064,26 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
> >  	return 0;
> >  }
> >  
> > +static int rcar_gen4_pcie_suspend_noirq(struct device *dev)
> > +{
> > +	struct rcar_gen4_pcie *rcar = dev_get_drvdata(dev);
> > +
> > +	if (rcar->drvdata->mode != DW_PCIE_RC_TYPE)
> > +		return 0;
> > +
> > +	return dw_pcie_suspend_noirq(&rcar->dw);
>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> [Severity: High]
> Does this code trigger a deadlock or kernel panic during the NOIRQ PM phase?
> 
> Setting pp->use_atu_msg to true causes dw_pcie_suspend_noirq() to eventually
> call ioremap():
> 
> dw_pcie_suspend_noirq()
>   dw_pcie_pme_turn_off()
>     ioremap()
> 
> Since this runs during the suspend_noirq phase with local interrupts disabled
> and the system frozen, ioremap() allocates memory with GFP_KERNEL and may
> sleep, which is strictly prohibited in NOIRQ context.
> 

What? Local CPU interrupts won't be disbled in the noirq phase, only the device
interrupts will be. So this concern is utterly baseless.

- Mani

