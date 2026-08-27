Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A384C9010
	for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2026 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855355; cv=none; b=d3GW7Z+qRahr5HEob7A+9Yk7LXPYnRd40qQKm0zwXv/g1tHZAOHOvHQE8QvkI4NL8CHHaeM9W+tEpEYZxFZVq6KltLPNUYPVLn4ekwYdurgZI3wQGffr7SK6hwp8DpVYcwy9CUegYHJBUffckObB9kbLdeXYtfFpIKtzRE03lOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855355; c=relaxed/simple;
	bh=Bvlk6a/+ZYUQ3qd8DQywcR7qXIrmuptJ04plHRpcS30=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=YYo1jG4IRxvYFYCDztUlfnhpmekbkSKxK6L6NaCgERweLKF58t8kikCyj6KHhnCEGhxg0Lua9pGCjnyzNml9f2o51l6uBIMQAJyElHWKdwDfb5LIMfvWlTd94q9rKPDHHtk93/9uNUFfQtb+p/fy4JdWQ3DQRjwIk9vvkyN2du4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=ev41sxC6; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="ev41sxC6"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c25344a8c6cso23474766b.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2026 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787855351; x=1788460151; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uvanX6LwER3+dYc3eyM0edZztrpqWdRZ2jTMJJO+V0U=;
        b=ev41sxC6uAa0y8mFGjPrBybUnoxf0r5qWNSL2x36GqNa9mYdj46UDvqEzpLkd4Ox3n
         enaEJnqbpzXpvIGT09pls3BGOTmjK93xAMRBvTGuizNa9gqPnodajEhPXmdHL/ppMyS+
         uh209Nkkae9raKltbTZY5FCeBYoGMzYt7Hi5YUdq+RpLzuLTFPkJa/749so1TMZpZO3X
         zdCdhSPOcjmmtogS0BJUBEgo0CUAurpU4WzXyPQaTMehA73JDz3P8a89cWSZVszUddvh
         C16YsQBADMZEILSDSAHhHdH+cTFJQUjyQ54WEAjH1KDbPsxCuQd4BkZ8b6Wzppfsr2lt
         VcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855351; x=1788460151;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uvanX6LwER3+dYc3eyM0edZztrpqWdRZ2jTMJJO+V0U=;
        b=mGpvgryabXjnyuFrvd5naqNfMKWoERjG3to7CbBEjQDcFZzGH44M6+aAzwmKK3XX35
         ozDuLy21w6zeSCP+X6rYEoc7ZGSMMkTYhyjLRTqjSf/g4GmtPXKJY9wngTA2KCZushPP
         DSzadnzmWZ/ZR21xdhkktYBf5KZyOnyNdSpZBb/umQjSu125FdTnOQ04c0qlms121ZHP
         rBv5/iN/UZL5rWVJ2AQBYwidfcnbGQsNnfUXEE+W7NhN2zXGObApiO2Jm4IIhEnskJnw
         herb8vf/1+6Cvx0YTcFdOJC6QajUQpdxzDTiYommHlXfF6WPnoriXtgnffbgGhH32+FA
         rgEg==
X-Forwarded-Encrypted: i=1; AHgh+RopsB2lyWvvodyOJtLyUb6cjGKDzRkIcJlx5Kd9muSIl++EZwUL0vUiuf/PASsj0WRU4OySsIs2PBM=@vger.kernel.org
X-Gm-Message-State: AFuF++lX2hH1EqV82Mnq0L8AoHrqdl8LsRBo8sOIEkt1fAM5cbpZFqX3
	y8YT3NLw4+JntGWgLALw5e6VsaE28FFoZoDCy8LF+izOs1LvcwAxhJ94XdEYPbDUNw==
X-Gm-Gg: AR+sD13Z40ZYj35cbNboG5R5cCKtl++MYp7YmmYUkNMxBKPmRqKiw9kCRXCsS5je2Aw
	TdKp0TcsGz+MLPhcdmBhVpetC5hOX0fHLfT22BKTtxrZZyp0IwGSNU4TiEivROiGDOmwZ4NKIit
	wUg2RSvOF25SsXDxu8Ru/eV4DPoNXYVtjOZha6lnQgFBI3o825+XMWzzaAe+3Q66v1iNM6MybtX
	YfwKnqXTzekUMSGFTPKCGtWtA4zSTfZKP4jPbgw6vJPusVrM1+iTSGI+QpNeC4Ysn691JF6nyzE
	jCbJKHS9rKkKAls8hXtdMvtqee1uDRRIOZdxJZ6yuirMr8Yy32Tl4f5pesJj3dn6EyzJJO5+dB/
	WKz9WQohSBpQnnyik53xKdesEpi2SZfFnkl60Z4VCvyhxZxhWJH9VsClsVF7UgI47J9yA2NjQrF
	bt23PTOwY6hKzKQHDyePyT3bja8Q3+bG70O8IyCRp9wfwzpC/1ReP0ZgJ6aGsw+VEQL2Q3
X-Received: by 2002:a17:907:c19:b0:c12:9b93:61fd with SMTP id a640c23a62f3a-c2556c2bea8mr46389166b.6.1787855351489;
        Thu, 27 Aug 2026 11:29:11 -0700 (PDT)
Received: from localhost ([185.213.155.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d68desm1116779366b.10.2026.08.27.11.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 11:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 20:29:09 +0200
Message-Id: <DKZXTSZPJMY8.XM7YYCVPT3EP@9elements.com>
Subject: Re: [PATCH RESEND v2] PCI: imx6: Enable ASPM L1 only iff CLKREQ# is
 supported
From: "Michal Gorlas" <michal.gorlas@9elements.com>
To: "Frank Li" <Frank.li@oss.nxp.com>
Cc: "Richard Zhu" <hongxing.zhu@nxp.com>, "Lucas Stach"
 <l.stach@pengutronix.de>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan
 Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Frank Li" <Frank.Li@nxp.com>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>,
 <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260827-l1-conditional-imx-v2-1-40b324aa2a94@9elements.com>
 <apBvfYOnCHfl7Zu9@lizhi-Precision-Tower-5810>
In-Reply-To: <apBvfYOnCHfl7Zu9@lizhi-Precision-Tower-5810>

On Thu Aug 27, 2026 at 7:10 PM CEST, Frank Li wrote:
> On Thu, Aug 27, 2026 at 06:51:00PM +0200, Michal Gorlas wrote:
>> Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
>> states for devicetree platforms"), ASPM states are force enabled
>> on all devicetree platforms. This causes PCI devices on some i.MX SoCs
>> (for e.g. i.MX 8M Plus Kontron SMARC eval carrier) to enter L1 even
>> though CLKREQ# is not supported (and consequently supports-clkreq is
>> not set in pcie controller node of their DT), which causes the device to
>> never wake up from L1.
>>
>> Hence, disable L1 capability in the LNKCAP register if supports-clkreq
>> is not set in the DT explicitly. For devices that set
>> IMX_PCIE_FLAG_BROKEN_SUSPEND, disable L1 on resume as well, as these
>> skip imx_pcie_host_init().
>>
>> Note, the logic here is very similar to 613f3255a35a, only difference
>> is that leaving L0s enabled does not cause issues (at least
>> I never encountered them myself when testing on the device) as its
>> not dependent on CLKREQ# being physically there.
>> Since there is already a way of specifying its presence in the DT,
>> the driver should be aware and disable L1.
>>
>> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for d=
evicetree platforms")
>> Signed-off-by: Michal Gorlas <michal.gorlas@9elements.com>
>> Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
>> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
>> ---
>> Changes in v2:
>> - disable L1 unconditionally on resume for platforms advertising
>> IMX_PCIE_FLAG_BROKEN_SUSPEND (Sashiko)
>> - typos in the commit message
>> - Link to v1: https://patch.msgid.link/20260719-l1-conditional-imx-v1-1-=
a55a57915c68@9elements.com
>> ---
>>  drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/control=
ler/dwc/pci-imx6.c
>> index 98e1db751132..1fdcbcd2422e 100644
>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> @@ -1318,6 +1318,22 @@ static void imx_pcie_assert_perst(struct imx_pcie=
 *imx_pcie, bool assert)
>>  	}
>>  }
>>
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
>>
>>  	imx_setup_phy_mpll(imx_pcie);
>>
>> +	if (!imx_pcie->supports_clkreq)
>> +		imx_pcie_disable_l1(pci);
>> +
>>  	return 0;
>>
>>  err_phy_off:
>> @@ -1748,6 +1767,7 @@ static int imx_pcie_resume_noirq(struct device *de=
v)
>>  			return ret;
>>  		imx_pcie_deassert_core_reset(imx_pcie);
>>  		imx_pcie_assert_perst(imx_pcie, false);
>> +		imx_pcie_disable_l1(imx_pcie->pci);
>
> Does l1 disable permanent after resume? should it be
>
> 	if (!imx_pcie->supports_clkreq)
> 		mx_pcie_disable_l1(imx_pcie->pci);

It would be unnecessary, the imx_pcie_disable_l1() there is already
guarded by IMX_PCIE_FLAG_BROKEN_SUSPEND, so we know that only iMX6Q
ends up there on resume. And none of iMX6Q DT's sets supports-clkreq.

Best,
Michal
>
> Frank
>
>>
>>  		/*
>>  		 * Using PCIE_TEST_PD seems to disable MSI and powers down the
>>
>> ---
>> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
>> change-id: 20260713-l1-conditional-imx-c2bfd20ae085
>>
>> Best regards,
>> --
>> Michal Gorlas <michal.gorlas@9elements.com>
>>

