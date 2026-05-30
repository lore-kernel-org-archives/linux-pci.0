Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20992F25E4
	for <linux-pci@vger.kernel.org>; Sat, 30 May 2026 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780158305; cv=none; b=U02dWwz0eMMwBWQ0TM0pdeIH6IQ5mPbGbWL9/t7O1gHIe5JekX7NwgiVfqnlgQCApZ8gRPYOFzPtq+jhJi1q3MhhEV+fxPoJED5Nuj5vN7CXzJo8trIq8KAlsD//FhT4eWYtRij/94v+Ciw+oPc3HQ8gzTa0GZWSLHUEQKG0ZA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780158305; c=relaxed/simple;
	bh=J9K+gPfB+lJ8y/+j7AxJe52XcH2SckBiH9QM07KXdVg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CpGMcI0GElKIlN724beBaxsk6JHKe4A2lq2g8BSgCSMJKXSohoYQqKwmAqlStwKxZsjLlcs+ObI5D/reCJmPnJQEqA98RoxGe9lHfJcPNF+qYCRUWJ1TMYsJP57MGAHXCh+vy3VSQbV06wSdY+t/8sJ+OU84GwTiaXAci7n9T0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDkcWIpj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDkcWIpj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798CD1F00893;
	Sat, 30 May 2026 16:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780158304;
	bh=W4E5yJf25vIZdrLTAWBn8hHUT/iMJv1MprHH5NSq9Ek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PDkcWIpjKAJOJ1VN6Wv8d8/Ep4wxNu0CmmnWWg34T0iDVh2Ii4rijEjBvvsbKRIHw
	 yiz8UTKKlyTsFD9Qw5dR/9YoD+1YAFkt4lsTgBlPswlQOZ6YlRePz1RbBDcbKeYJ6w
	 InXLlFVcdGOLLjdYBIHk6LRJkWNDXiR42GYdjripxpSa2ui4RUbK5Xqm7wm//04qEB
	 cVpN42AN0BgEPfqjkbuzEmmHj16EwkVOTXEuOKBLCeyBINWn9pAE4MCd9MP10+5AtY
	 N8rgj0lnGXN/DkFZ9GlnsgVS7JQEAgjc10G7CF//H1/R5ctM+KKsT7+H8EHW2NyzJa
	 sjg5V2luqocRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/16] PCI: dwc: sophgo: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260530153101.695580-13-18255117159@163.com>
References: <20260530153101.695580-13-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 16:25:04 +0000
Message-Id: <20260530162504.798CD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `.deinit` callback causes IRQ domain leak and leaves a dan=
gling chained IRQ handler if `dw_pcie_host_init()` fails.
--

commit bec8b7e2c9e17ca16137f5895fed067563f850fa
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: sophgo: Use cached PCIe capability offset

dw_pcie_host_init() calls .init before caching, so we must call
dw_pcie_get_pcie_cap() inside .init. The hardware is already enabled by
the driver's own initialization before this point. The helper will cache
the offset and avoid redundant searches.

> diff --git a/drivers/pci/controller/dwc/pcie-sophgo.c b/drivers/pci/contr=
oller/dwc/pcie-sophgo.c
> index 044088898819e..39703d2b7b5f2 100644
> --- a/drivers/pci/controller/dwc/pcie-sophgo.c
> +++ b/drivers/pci/controller/dwc/pcie-sophgo.c
> @@ -164,9 +164,10 @@ static void sophgo_pcie_msi_enable(struct dw_pcie_rp=
 *pp)
>  static void sophgo_pcie_disable_l0s_l1(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> -	u32 offset, val;
> +	u8 offset;
> +	u32 val;
> =20
> -	offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	offset =3D dw_pcie_get_pcie_cap(pci);
> =20
>  	dw_pcie_dbi_ro_wr_en(pci);
> =20

[Severity: High]
This is a pre-existing issue, but while reviewing this init sequence,
I noticed a potential resource leak and dangling pointer on the error path.

If dw_pcie_host_init() fails (e.g. due to a link training timeout), it invo=
kes
the .deinit callback to tear down host-specific resources. However, the dri=
ver
is missing a .deinit callback:

drivers/pci/controller/dwc/pcie-sophgo.c:
static const struct dw_pcie_host_ops sophgo_pcie_host_ops =3D {
	.init =3D sophgo_pcie_host_init,
};

In sophgo_pcie_host_init(), an IRQ domain and a chained handler are set up:

drivers/pci/controller/dwc/pcie-sophgo.c:sophgo_pcie_host_init() {
    ...
	irq =3D sophgo_pcie_init_irq_domain(pp);
	if (irq < 0)
		return irq;

	irq_set_chained_handler_and_data(irq, sophgo_pcie_intx_handler, pp);
    ...
}

Because there is no .deinit callback, the IRQ domain and chained handler are
never removed when dw_pcie_host_init() fails.

When sophgo_pcie_probe() returns an error, devres will free the struct
sophgo_pcie (which contains pp).

If the parent interrupt fires later, could the dangling chained handler
(sophgo_pcie_intx_handler) execute and dereference the freed pp pointer,
leading to a use-after-free panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530153101.6955=
80-1-18255117159@163.com?part=3D12
