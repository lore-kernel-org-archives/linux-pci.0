Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A307242643A
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413673; cv=none; b=Tw/W+lNEMuQnE8gq25AbXSGDnF+vA9DdNKXvjkRGWr3D/ArU+nJyw1rHrCxVtjrVPyuq1UUjFDRCxWi2qGkV2K0VhpLnJdo7GER1NNXneyeTDPwJo6hQXxLZUt/oyIn+nVrEmKv9wPuZxWYiYZFzY+qAyuNlmz8Ke1IgegDrz3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413673; c=relaxed/simple;
	bh=c747fqvNDgqVLoyxnKPVeIUVwA83B4m/ITNcnGHudIc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bOCnsH9eMbHvsEjzoi8Cuy2GDkWd84jd0nVbVUGvJ5o7FyrbxiY5Xn7rJqXUbeKQ3KyXZmone1jk/R6PWlmC1GyFiSA+Ss/XUoJLwT7cnpIn2LTG1/aST3f96nsGECQwrQ6ODMnTuvaIJex8/LanXHJSEpV5sARPdcwl0XU1pKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=NskyoACr; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="NskyoACr"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-46e747fbf36so797655f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 05:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785413670; x=1786018470; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7eM/+djUdUKJLWwx0zayHVa8z9iYSo8gtg4+aGAkdTc=;
        b=NskyoACr+wxUdZSBWcWCek0Quq44Rjl6ppkyp1lIOr1Gdq7nDR/+HJqmjA31kUFJYY
         AHqqerojWES4AyaowhVSJRM1Hn4XFIR7sT0thWat6Xxg7QNpQZNtrr7X//n+atTlGG9d
         FO5d8XdJSbGjKORdENp1kttoGYYrvB1mJkKsxYLsM54h8MKlVmzjrAb7OruV8XfPJliC
         nvFFD0gC5Seu2mqrp5zZCQadgWYBi5AOMWtRsT2l9mh0ZrWysN6zxvtLNAyzZ7axZFHI
         5pewBUG+v4N6src4D5UUGAPGrG5opacknLtwXvDaoLr0ydJrb/crG0J78Zf5vL5KQY6v
         VfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785413670; x=1786018470;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7eM/+djUdUKJLWwx0zayHVa8z9iYSo8gtg4+aGAkdTc=;
        b=Wpy0G8jYg1UP3P9RwI62yj8VggXVwKJo+SL5RgLeRMA6TGWdu7EvipC4Ny6XzQhc5r
         a/9psIHeHP8vtOENwoa6dIhpclb2OlennpDgVHpKdFFlNHEW+fm5hMK3JqjgukXKsPwv
         fYSdXOtcbBbdw7KwnqaTQgbOQ0HDfDs/Cd1WEpyFBeVQrpDQ9gW61STYwH9gcWrKnR6w
         7gCIiObezmss3q+UQibApGPE5LQJUhgqmPRY0BJ9iJ7eO2v07JCcBbnoGXrJNXQBe2Uc
         KJyaJd29cSR+cOipiXhr/eeG5MNU9aHXJ6zLaLeDpdCHA5gIyUyYxswxzAoyZ03nziZI
         drjw==
X-Forwarded-Encrypted: i=1; AHgh+RogBR3H4AnTWCgBewgR8hzBOntCsCCsxJDY1qxfeBwV9gMKcexIOAzA2wA6h01T8aXsjp1jmQFvqSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGtb0RXIQHY0aEQ3lqkM3HI4K5jMzXMzcq42X8DMijbZ18SeO5
	LpepTqne2PCHydT745C5ndU1L7W3Rnlyn9feUfEFvee1T3b0Gy3eTHm9JBDs2EzQMA==
X-Gm-Gg: AR+sD10Y6uj3CjEX91tjzuE5H909SYtz9iFw/ckRh9cERLHl17QXjApK4stQ8kq0ZF+
	YO5S1KX/DbgwJWL1o0UvFbgF1piWKg723k9eGAc1Q6EdOld/BrtG3t3BNQDdm1BsQuuS72TziAh
	0NMlOn80I4AMDwIF6/fFPWk6Q94GjBDOv+/UaG3cyxmcp9Cpj2OxHWXA+1PIY5/7F+S29BnWfG5
	aNAYfq+jeOc5Hwk+gbCCDKuS7RhDHhglRFY/eUiTV4fES2Ezisdiqa4YPuDzqouNNde2eLCb5cV
	aaLQpSsy4aCywqtfWy4RZZA8vAhrFB2R+70zs15u+Fxx5X9QqXJfofGuHhJHIVDBKjexmLFqxRV
	ETU6r8gW+aXpNP7lwCFz6DzzDJKJ8e221pqT3v7pNjiP8xqw3vvsU5O8SV+BqVTbo3DzLdoOIA8
	fRAgEHHYp5OdgFa5EURHILx6wOxX3a3RZHwXNVVj81QXYJ9D/bK/e814S2VWF2vzaqMA==
X-Received: by 2002:a5d:59c3:0:b0:47f:9283:1fb3 with SMTP id ffacd0b85a97d-47fc806e48amr3531249f8f.0.1785413669775;
        Thu, 30 Jul 2026 05:14:29 -0700 (PDT)
Received: from localhost ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc892cc54sm5743980f8f.21.2026.07.30.05.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 05:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 14:14:27 +0200
Message-Id: <DKBWBNP7VLCF.3FND2WKPV4NWU@9elements.com>
Cc: "Lucas Stach" <l.stach@pengutronix.de>, "Lorenzo Pieralisi"
 <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam"
 <festevam@gmail.com>, <linux-pci@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: imx6: enable ASPM L1 only iff CLKREQ# is supported
From: "Michal Gorlas" <michal.gorlas@9elements.com>
To: "Manivannan Sadhasivam" <mani@kernel.org>, "Richard Zhu"
 <hongxing.zhu@nxp.com>, "Frank Li" <Frank.Li@nxp.com>, "Michal Gorlas"
 <michal.gorlas@9elements.com>
X-Mailer: aerc 0.21.0
References: <20260719-l1-conditional-imx-v1-1-a55a57915c68@9elements.com>
 <t2zu6bv4dqf5znpn5uypkoieltlrzlp4kskt6jwp46xgqajhjp@6g5kiwwn72a4>
In-Reply-To: <t2zu6bv4dqf5znpn5uypkoieltlrzlp4kskt6jwp46xgqajhjp@6g5kiwwn72a4>

On Wed Jul 29, 2026 at 7:01 PM CEST, Manivannan Sadhasivam wrote:
> On Sun, Jul 19, 2026 at 02:47:54AM +0200, Michal Gorlas wrote:
>> Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
>> states for devicetree platforms"), ASPM states are force enabled
>> on all devicetree platforms. This causes PCI devices on some iMX SoCs
>> (for e.g. iMX 8M Plus Kontron SMARC eval carrier) to enter L1 even
>> though CLKREQ# is not supported (and consequently supports-clkreq is
>> not set in pcie controller node of their DT), which causes the device to
>> never wake up from L1.
>>=20
>> Hence, disable L1 capability in the LINKCAP register if supports-clkreq
>> is not set in the DT explicitly.
>>=20
>> Note, the logic here is very similar to 613f3255a35a, only difference
>> is that leaving L0s enabled does not cause issues (at least
>> I never encountered them myself when testing on the device) as its
>> not dependent on CLKREQ# being physically there.
>> Since there is already a way of specifying its presence in the DT,
>> the driver should be aware and disable L1.
>>=20
>> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for d=
evicetree platforms")
>> Signed-off-by: Michal Gorlas <michal.gorlas@9elements.com>
>> ---
>>  drivers/pci/controller/dwc/pci-imx6.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>=20
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/control=
ler/dwc/pci-imx6.c
>> index 98e1db751132..7471501fbf04 100644
>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> @@ -1318,6 +1318,22 @@ static void imx_pcie_assert_perst(struct imx_pcie=
 *imx_pcie, bool assert)
>>  	}
>>  }
>> =20
>> +static void imx_pcie_disable_l1(struct dw_pcie *pci)
>> +{
>> +	u32 val;
>> +	u8 offset;
>> +
>> +	offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> +
>> +	dw_pcie_dbi_ro_wr_en(pci);
>> +
>> +	val =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>> +	val &=3D ~PCI_EXP_LNKCAP_ASPM_L1;
>> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);
>> +
>> +	dw_pcie_dbi_ro_wr_dis(pci);
>> +}
>> +
>>  static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>>  {
>>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
>> @@ -1442,6 +1458,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *p=
p)
>> =20
>>  	imx_setup_phy_mpll(imx_pcie);
>> =20
>> +	if (!imx_pcie->supports_clkreq)
>> +		imx_pcie_disable_l1(pci);
>
> Sashiko raised a valid issue here:
> https://patchwork.kernel.org/project/linux-pci/patch/20260719-l1-conditio=
nal-imx-v1-1-a55a57915c68@9elements.com/#27076171
>
> IMX_PCIE_FLAG_BROKEN_SUSPEND is only set for i.MX6Q, but none of its DTs =
have
> 'supports-clkreq' property. So this patch will impact them also and since=
 they
> do not reinitialize the hardware fully in resume(), ASPM settings will re=
set to
> hardware default.

Right, for i.MX6Q, imx_pcie_disable_l1() could be called unconditionally
in imx_pcie_resume_noirq() after the imx_check_flag(imx_pcie, IMX_PCIE_FLAG=
_BROKEN_SUSPEND)
block, something like:

@@ -1767,6 +1767,7 @@ static int imx_pcie_resume_noirq(struct device *dev)
                        return ret;
                imx_pcie_deassert_core_reset(imx_pcie);
                imx_pcie_assert_perst(imx_pcie, false);
+               imx_pcie_disable_l1(imx_pcie->pci);

                /*
                 * Using PCIE_TEST_PD seems to disable MSI and powers down =
the

Though I do not have imx6q hw to test this, so it would be nice if NXP
folks could give it a test.

Best,
Michal
