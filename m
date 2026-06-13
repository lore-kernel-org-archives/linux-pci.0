Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A725B0B2;
	Sat, 13 Jun 2026 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781337688; cv=none; b=ENxOY9T3ksHgNiWLUX/GEyZ6jhAyxF8p7li+/bSlxCemRbe1omExlBwcmQP+ny6HFz/WPoHPULMb397TONJZVIG062EtiCUIAHtjFcaFE4BGOn9BROz2zEU0fdeXqJE0VNnZJ/m4pNisz77qka+fWs5UHI+2GYUv1FqzoCfPPzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781337688; c=relaxed/simple;
	bh=KQfG/NpRjELQVD4+W+xsLUr5cpqxGBS+rqD/uPwJ1j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA2e2ITpFhbIP3gM3bH8NMEV338EvXUkC03CRrszeerE38EymbeMmQII4T4vrvgBK9Hfdyb50ZRHXT0vShtPbGpkmBA2fSXR016H6ig1ZVsve1EJlgqv8BEeeO5nbcUNbFusypwFCs1KT4yCZ0clUECV4+H65WBO7d71ssaDIWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FM8sJVZ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FM8sJVZ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22ADB1F000E9;
	Sat, 13 Jun 2026 08:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781337687;
	bh=0BJSRzQnA6ADTCO/Lm9I0WXXjok9r2s5p4KFqWB37Gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FM8sJVZ6CGOx96IgayLOwEVQYZHRaro/+SRzXr4V4ugs+pi9Dm2i+M91y3o4QSN9D
	 R8ECY/H2ixJy4KzN0pIe9wqlo0AN2D+zYZos9tUoUWfE2vpDBto65HcD9BXOhbul1g
	 poB3HBuYRhwiEoIC8D6BzuVYofChKhHhEJK7EN7XwNYCX+O/7/RX5ObQQM7Ldi6FAX
	 qrPgXkNZsQqcRQyVLPMa1xQeN5UTisf2ZECBfgn9gji1LdovRtDi+HsrNEa2JEtePZ
	 W3lZfApEWsIiShbtHamDcMrFosv+nd+Q7CWijDQtQS3RUlnmgIQzmAiGWDC8+wmUMu
	 Q0NILsMyLTgag==
Date: Sat, 13 Jun 2026 10:01:13 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mingcong Bai <jeffbai@aosc.io>, Henry Chen <chenx97@aosc.io>, Han Gao <gaohan@iscas.ac.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] pci: loongson: Avoid L0s on LS7A1000 PCIe x8 [0014:7a29]
 Root Ports rev2
Message-ID: <oe6jbxy7m6fzwmzdhrjli5biyss5dx45gojd6vll6o5gwzfinu@ag45ditirz5v>
References: <20260609152511.753760-1-xry111@xry111.site>
 <CAAhV-H4QV=gYQH8+RRL3S8OTR3xq7c0iAUWgJAh0pETVikO-qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4QV=gYQH8+RRL3S8OTR3xq7c0iAUWgJAh0pETVikO-qw@mail.gmail.com>

On Wed, Jun 10, 2026 at 04:21:17PM +0800, Huacai Chen wrote:
> Hi, Ruoyao,
> 
> On Tue, Jun 9, 2026 at 11:26 PM Xi Ruoyao <xry111@xry111.site> wrote:
> >
> > Commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
> > devicetree platforms") has broke booting of a Loongson 3B4000 + 7A1000
> > server with an Intel 750 Series SSD.  We also found a Loongson 3A5000
> > board using the same 7A1000 bridge chip exhibiting the same issue with
> > pcie_aspm=force and pcie_aspm.policy=powersave (ASPM is not enabled by
> > default on the 3A5000 board because it's based on ACPI and the _OSC
> > method has not been implemented in its DSDT/SSDT yet).
> >
> > This seems only affecting the 7A1000 chips shipping the revision 2 of
> > the PCIe x8 Root Port: on other two boards with a (persumably older)
> > LS7A1000 bridge chip utilizing the revision 1 of the root port, the
> > issue does not reproduce.
> Is that confirmed by chip designers?
> 

Will you be able to confirm? Since you are the maintainer of Loongson, I presume
that you have internal contacts.

At the very least, this patch needs an ack from you.

- Mani

> >
> > Cc: Mingcong Bai <jeffbai@aosc.io>
> > Cc: Henry Chen <chenx97@aosc.io>
> > Cc: Han Gao <gaohan@iscas.ac.cn>
> > Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > ---
> >  drivers/pci/controller/pci-loongson.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> > index a4250d7af1bf..dc7cee10643e 100644
> > --- a/drivers/pci/controller/pci-loongson.c
> > +++ b/drivers/pci/controller/pci-loongson.c
> > @@ -212,6 +212,19 @@ static void loongson_pci_bridge_speed_quirk(struct pci_dev *pdev)
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, loongson_pci_bridge_speed_quirk);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29, loongson_pci_bridge_speed_quirk);
> >
> > +/*
> > + * Some devices, for example Intel 750 Series SSD, experiences data loss
> > + * (read timeout) on LS7A1000 PCIe x8 Root Port when ASPM L0s is enabled.
> > + * This seems only affecting the revision 2.
> > + */
> > +static void ls7a_pcie_port2_aspm_quirk(struct pci_dev *pdev)
> It is better to follow the namings in this file, i.e.
> loongson_pcie_port2_aspm_quirk, or loongson_pcie_aspm_quirk for short.
> 
> Huacai
> 
> > +{
> > +       if (pdev->revision == 2)
> > +               pcie_aspm_remove_cap(pdev, PCI_EXP_LNKCAP_ASPM_L0S);
> > +}
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT2,
> > +                        ls7a_pcie_port2_aspm_quirk);
> > +
> >  static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
> >  {
> >         struct pci_config_window *cfg;
> > --
> > 2.54.0
> >

-- 
மணிவண்ணன் சதாசிவம்
