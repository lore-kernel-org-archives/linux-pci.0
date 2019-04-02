Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3477EC4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 14:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC242084B
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 14:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLUxm0Bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfDBOOa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:14:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44960 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfDBOOa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Apr 2019 10:14:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so16846992wrn.11;
        Tue, 02 Apr 2019 07:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=85Yk6Yczkasp7s9xZnRRwnIGvca5/9FEhmRGLpeSEdU=;
        b=pLUxm0Bon7pz4xhBco+gN8HUcQx5id7thgwsTJRTsaXNwq9atZukENnKOzEdvlElLb
         GLJnDY1kVStE4GzR39SeF0or9F5TjWi+59q4o6tgSa2/JpEXOz1oDYVMqRYoDmKOwmVQ
         slYXmlP3WMDxKW/NIGdF2/Au9G7ZetCw1BA+UXOWn4EXmg3/RQkqh3kwaQPI0NZd/qvJ
         amFQmj5drtUX9iW9vP0tViCg0DGKXcSbskJXTWAMVXRsslBgra46Dh/aEt9YGhE1AZQq
         pVUpSl/4Yi/jlF2VNynB1ULsZzNdr+ATyVIyiSN1eNQD7P1Nb35mOkhqNqlCJK9+rg7w
         7osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=85Yk6Yczkasp7s9xZnRRwnIGvca5/9FEhmRGLpeSEdU=;
        b=TEqcDr7YQttWTXNQjQhOmJtZi/hQK10Mb6jyiGY8eOo9a+AwMr+pAU2JNYlexaWu8G
         PEJtKS24LBZdyXtkc5ppfoC5Lnb46JQAHyVXp+3vCJNgiv5Hd/j/erdyDUEpTZtC0DZO
         GmRBR1fCFen7isZOe2iFs3G9nRU2/BYwWtm+LhiHwnT87IIBqLDAH5L/9K7WmGdZbhsu
         7wk3apn3rEhTu434dLfjI0vMygM/6wi1okVjWTItHSMwj+1QRBLARdXdRC/sPhQw+t1e
         gAEf2zuO/R3MxbX1YqEMV7Ue4NO47MBDD9sNwo9/CvFazSTlQHK7S7luGrWO8fxWMulQ
         XDUA==
X-Gm-Message-State: APjAAAXuwq3ZiZezNU2J/AwJvMOHgUIN6BHvtoEY10gonm9cKa/DbUUM
        YOasU8tEjzRuDHKtGOrVeXo=
X-Google-Smtp-Source: APXvYqwY5NrdkoA3BP6qDw9Gnx8kIteI4EglmHm3bRJOO7UQRpSW7ZFjQZr028tVsz9dVI68phxfgw==
X-Received: by 2002:a5d:684e:: with SMTP id o14mr47755478wrw.138.1554214466958;
        Tue, 02 Apr 2019 07:14:26 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id j22sm39632273wrd.91.2019.04.02.07.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 07:14:26 -0700 (PDT)
Date:   Tue, 2 Apr 2019 16:14:24 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        tiwai@suse.de, spujar@nvidia.com, skomatineni@nvidia.com,
        liviu.dudau@arm.com, krzk@kernel.org, heiko@sntech.de,
        horms+renesas@verge.net.au, olof@lixom.net,
        maxime.ripard@bootlin.com, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, jagan@amarulasolutions.com,
        enric.balletbo@collabora.com, ezequiel@collabora.com,
        stefan.wahren@i2se.com, marc.w.gonzalez@free.fr,
        l.stach@pengutronix.de, tpiepho@impinj.com,
        hayashi.kunihiko@socionext.com, yue.wang@amlogic.com,
        shawn.lin@rock-chips.com, xiaowei.bao@nxp.com,
        devicetree@vger.kernel.org, mmaddireddy@nvidia.com,
        kthota@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/10] PCI: tegra: Add Tegra194 PCIe support
Message-ID: <20190402141424.GB8017@ulmo>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-10-git-send-email-vidyas@nvidia.com>
 <20190329203159.GG24180@google.com>
 <5eb9599c-a6d6-d3a3-beef-5225ed7393f9@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <5eb9599c-a6d6-d3a3-beef-5225ed7393f9@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 12:47:48PM +0530, Vidya Sagar wrote:
> On 3/30/2019 2:22 AM, Bjorn Helgaas wrote:
[...]
> > > +static int tegra_pcie_dw_host_init(struct pcie_port *pp)
> > > +{
[...]
> > > +	val_w =3D dw_pcie_readw_dbi(pci, CFG_LINK_STATUS);
> > > +	while (!(val_w & PCI_EXP_LNKSTA_DLLLA)) {
> > > +		if (!count) {
> > > +			val =3D readl(pcie->appl_base + APPL_DEBUG);
> > > +			val &=3D APPL_DEBUG_LTSSM_STATE_MASK;
> > > +			val >>=3D APPL_DEBUG_LTSSM_STATE_SHIFT;
> > > +			tmp =3D readl(pcie->appl_base + APPL_LINK_STATUS);
> > > +			tmp &=3D APPL_LINK_STATUS_RDLH_LINK_UP;
> > > +			if (val =3D=3D 0x11 && !tmp) {
> > > +				dev_info(pci->dev, "link is down in DLL");
> > > +				dev_info(pci->dev,
> > > +					 "trying again with DLFE disabled\n");
> > > +				/* disable LTSSM */
> > > +				val =3D readl(pcie->appl_base + APPL_CTRL);
> > > +				val &=3D ~APPL_CTRL_LTSSM_EN;
> > > +				writel(val, pcie->appl_base + APPL_CTRL);
> > > +
> > > +				reset_control_assert(pcie->core_rst);
> > > +				reset_control_deassert(pcie->core_rst);
> > > +
> > > +				offset =3D
> > > +				dw_pcie_find_ext_capability(pci,
> > > +							    PCI_EXT_CAP_ID_DLF)
> > > +				+ PCI_DLF_CAP;
> >=20
> > This capability offset doesn't change, does it?  Could it be computed
> > outside the loop?
> This is the only place where DLF offset is needed and gets calculated and=
 this
> scenario is very rare as so far only a legacy ASMedia USB3.0 card require=
s DLF
> to be disabled to get PCIe link up. So, I thought of calculating the offs=
et
> here itself instead of using a separate variable.
>=20
> >=20
> > > +				val =3D dw_pcie_readl_dbi(pci, offset);
> > > +				val &=3D ~DL_FEATURE_EXCHANGE_EN;
> > > +				dw_pcie_writel_dbi(pci, offset, val);
> > > +
> > > +				tegra_pcie_dw_host_init(&pcie->pci.pp);
> >=20
> > This looks like some sort of "wait for link up" retry loop, but a
> > recursive call seems a little unusual.  My 5 second analysis is that
> > the loop could run this 200 times, and you sure don't want the
> > possibility of a 200-deep call chain.  Is there way to split out the
> > host init from the link-up polling?
> Again, this recursive calling comes into picture only for a legacy ASMedia
> USB3.0 card and it is going to be a 1-deep call chain as the recursion ta=
kes
> place only once depending on the condition. Apart from the legacy ASMedia=
 card,
> there is no other card at this point in time out of a huge number of card=
s that we have
> tested.

A more idiomatic way would be to add a "retry:" label somewhere and goto
that after disabling DLFE. That way you achieve the same effect, but you
can avoid the recursion, even if it is harmless in practice.

> > > +static int tegra_pcie_dw_probe(struct platform_device *pdev)
> > > +{
> > > +	struct tegra_pcie_dw *pcie;
> > > +	struct pcie_port *pp;
> > > +	struct dw_pcie *pci;
> > > +	struct phy **phy;
> > > +	struct resource	*dbi_res;
> > > +	struct resource	*atu_dma_res;
> > > +	const struct of_device_id *match;
> > > +	const struct tegra_pcie_of_data *data;
> > > +	char *name;
> > > +	int ret, i;
> > > +
> > > +	pcie =3D devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
> > > +	if (!pcie)
> > > +		return -ENOMEM;
> > > +
> > > +	pci =3D &pcie->pci;
> > > +	pci->dev =3D &pdev->dev;
> > > +	pci->ops =3D &tegra_dw_pcie_ops;
> > > +	pp =3D &pci->pp;
> > > +	pcie->dev =3D &pdev->dev;
> > > +
> > > +	match =3D of_match_device(of_match_ptr(tegra_pcie_dw_of_match),
> > > +				&pdev->dev);
> > > +	if (!match)
> > > +		return -EINVAL;
> >=20
> > Logically could be the first thing in the function since it doesn't
> > depend on anything.
> Done
>=20
> >=20
> > > +	data =3D (struct tegra_pcie_of_data *)match->data;

of_device_get_match_data() can help remove some of the above
boilerplate. Also, there's no reason to check for a failure with these
functions. The driver is OF-only and can only ever be probed if the
device exists, in which case match (or data for that matter) will never
be NULL.

> > I see that an earlier patch added "bus" to struct pcie_port.  I think
> > it would be better to somehow connect to the pci_host_bridge struct.
> > Several other drivers already do this; see uses of
> > pci_host_bridge_from_priv().
> All non-DesignWare based implementations save their private data structure
> in 'private' pointer of struct pci_host_bridge and use pci_host_bridge_fr=
om_priv()
> to get it back. But, DesignWare based implementations save pcie_port in '=
sysdata'
> and nothing in 'private' pointer. So,  I'm not sure if pci_host_bridge_fr=
om_priv()
> can be used in this case. Please do let me know if you think otherwise.

If nothing is currently stored in the private pointer, why not do like
the other drivers and store the struct pci_host_bridge pointer there?

Thierry

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyjbj4ACgkQ3SOs138+
s6FqBg//e+LtM3aVwWkdREy2jMKhFXulfL4u8/6AulA3u0t5RPr6NbybR5Vi/rTD
s7IqkhsYiSmF5TGt7XMPZlgY7pQhLhf6w6+sv/8U0O7wLlFWC95k6QFkR5xgcH7M
CTzRZgPbKKv8AlK/c3u9lTt5rwIDLbtiuB4ccFoZ6J5vRgrZm9T4l+LzQtKp1Omd
dtdafHT93mb2g9w9XrY9iI4bCUqXl/ewWhsd/AVG3naNfgx2Aq3Lm995SPrTHb1r
RP4cnKjBxAMF0d+t1pSO0efQEMIgHdGFn4Eptas9+sKMrrmvmRhdukhKJ0PxKEwN
alLjBle/jGYfn0Y2jzZSGU+9u7oeD7XZs6fZSfkfZjgt/2hN35tTwAkMzKpD1HLV
60mXxgwn/YLbGx130sYew8F/NZnvQ/NIFKyFIzuZdvDDBGlE76SbXHfEqcBt55o5
tVWxAmzKSXs+e06HfGzD4DINyWCc7MHrq8dQRiqzZ7UA++r6LOwy1PayULCqs4cs
kOdly/eHEHZ8315UOPUW4wmUb1wdJfnNRrz9TxyhTfItlFelZpmCvjTO2LkHcJkp
N5xUtWm+25Qltd4N+CGGgsRW5o57AGq6LhMGNm0kMf8a7V1iPjQhewmwBE0EMZfc
KIPi1/8bAE8kNrHF5fAz7btmGwAoXUsqoxC3t5s9WeOjgriZ9ss=
=VRvU
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
