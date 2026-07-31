Received: from mail-ej2-f3.google.com (mail-ej2-f3.google.com [74.125.228.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F4843D515
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511652; cv=none; b=coV6jw8Y54gXquHieYs8HLVub28P4hIz3U50/jKyeUSuMi4NRuX980ZJ8cLvgGUsvg1x9RXJJhb6QWvyeX6Fm8/NVFDFQ57h6Nkokpge+R/pvV3gIuTz1wLBOXpXkUz0cmqc93aX6cXM7z64LaA8e7mxcDMqGPVuKeJLO+RDdqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511652; c=relaxed/simple;
	bh=2HCELcOA3DJNbDsYTukshelLlc3dZazcD3VSOVDcQgU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=i+k8704Fp+SC7uVmGNskBV4j6xS7nYH6FvPilDygNVSp17j40+WrRy92TJircoFipR5IqWzCRDeBAMUrAOrfx789U5RKIAbJtO/UtQ4jSrr0TADnfSU9rL63b922R6/z1K/x/fT+QhL2eoAB7YDWCemXpw1AD8XKUqXhQ29jNzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Y+8knFMi; arc=none smtp.client-ip=74.125.228.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Y+8knFMi"
Received: by mail-ej2-f3.google.com with SMTP id a640c23a62f3a-c15ec8d6663so38688166b.1
        for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 08:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785511648; x=1786116448; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aaecu9LLR4tlERpL5fMxh+H29z5ZLQOadDtlIB8YJrI=;
        b=Y+8knFMivLdCWWQukBuMLgMGMNGPaLmZ/C0bfogUhugm6vo7jrZpbX5Il6H/vFq5jx
         kOIQK6jAceiXpwoRWJDsKy1j6ttk0mw3A8byG8zc0x5cKwBU5sqa8dE+5lrhF3EixHtn
         32MaiyRIBp0Qr/LR+8cw650VmQGPI8+JNP4Fg9yQ4BLOo25Rr6OiZmK45ObF5Xf0CC5Z
         mmlhSfcOa1sH63r9Ng+X3iS9cJeIK+kZP6esAQADDvnwbgjUzBq/vh9VyvFIWexjDjk2
         NTlcXLhIXWtc13bxQCMK5v9yNBO2SUEkBlrAYzFDb9NcNjD3QzpYixN3W6S+nyQAxOHL
         N6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511648; x=1786116448;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aaecu9LLR4tlERpL5fMxh+H29z5ZLQOadDtlIB8YJrI=;
        b=VlTV7scj8iChkPo3HqEF0dGESYMyvzMd0ZfZYjj6a1owcO5+JtDCELWRyckJchXycB
         iCpxrKrRrJAAyAW5p2jEwiX1Tcx8oc2SaB/AaAyBNQJ2U0vdTTbJE36A2HjSespYCX+l
         +uwtwQyjm0WWDQnuN2/5xaxPC6MJdMgg+8SCfVlBUFucdxjkUwM3H74J2vfMfE4q2q6T
         Dfm0gMxT6qjcDsvqW1TjpF9jLeV1vK7rRWCdmo/9NN3+9jhaJ0Ynw1/Eo8f05DlKcHUk
         kUD5Fvse3mV4mHd7mgUsJ3sd7dUrUllZNYBBLFkkFwiMIVQk8uN2xUUez81NZNZGBxHK
         I6xA==
X-Gm-Message-State: AOJu0YwEXYmZjYWfz5kPpWtv3ElPcu3wUGV8hDuNGGvGH+/TYFmuzB+q
	VXun0dITN+jvGIDLzkqbxe5PIFBRUUGyX4l0O0yjH6RyMtxCSyco+u08r73rR2fVxw==
X-Gm-Gg: AR+sD12lxDNaW/2kuTGjYBvoaeUTeS6Z6d8YTQ1rqSrxC8de0KUQ22oA8qBzIup0YWk
	mew+mqws0iQndn8GXVdynztygrk3NOMnkBXR+umSI1ZISp7UoZuzXhLx1+uQr1uxOGOlmn8MK7p
	3lnG76Y6YjtHMSV83sr49KG6A12ULc0JYLtu1GZu5aVa7VsEmpC0pdzvCXYvcd4/AOvAXRjeEsc
	/GBEw5saE0brySxwlNIkiqZUdzj9uegdUaslZolljl0usqZhFJ4sEqaO1aNmvbMED4Tf0K+coPI
	qjd8B2ACPABlN2m9xsyRu7OQoXaXabp0bCz1s4H770+0zS6OK/ESeT+mxuKo1zHaTGnYQ5N3Hcu
	5Bzws8Cp+ehAR7yUdnMucsKTGrO1Yj25FzJJb9FvpEMfDAEgu28ednaLp2CHTzsQCFavY39LKQh
	qLJBgZKtlCp/q+qKAlouu1PKxu8y7a4vBfOdqwPdI7+swow4MfAQ9w44/KxU0jWsZ9bvboHw==
X-Received: by 2002:a17:906:1d08:b0:c16:1df9:6eda with SMTP id a640c23a62f3a-c1fe83796femr347266b.49.1785511648121;
        Fri, 31 Jul 2026 08:27:28 -0700 (PDT)
Received: from localhost ([2a02:908:1578:7a40:eb03:fa54:642b:57ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd46836dcsm186119166b.63.2026.07.31.08.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 08:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 17:27:27 +0200
Message-Id: <DKCV1YWVZSTC.I04OWIWKFTUV@9elements.com>
Subject: Re: [PATCH v2] PCI: imx6: Enable ASPM L1 only iff CLKREQ# is
 supported
From: "Michal Gorlas" <michal.gorlas@9elements.com>
To: <sashiko-reviews@lists.linux.dev>, "Michal Gorlas"
 <michal.gorlas@9elements.com>
Cc: <linux-pci@vger.kernel.org>, <imx@lists.linux.dev>,
 <Frank.Li@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260731-l1-conditional-imx-v2-1-6016ee9148b2@9elements.com>
 <20260731135449.7A3B51F00A3A@smtp.kernel.org>
In-Reply-To: <20260731135449.7A3B51F00A3A@smtp.kernel.org>

On Fri Jul 31, 2026 at 3:54 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] ASPM L1 is conditionally disabled at boot but unconditionally =
disabled upon resume, causing state inconsistency across power cycles.
> --
>
> --- Patch [1]: [PATCH v2] PCI: imx6: Enable ASPM L1 only iff CLKREQ# is s=
upported ---
> commit 7a899eb7e9f8116a0334832c7490e52f71ae751c
> Author: Michal Gorlas <michal.gorlas@9elements.com>
>
> PCI: imx6: Enable ASPM L1 only iff CLKREQ# is supported
>
> This commit conditionally disables ASPM L1 capabilities in the LNKCAP
> register if supports-clkreq is not set in the device tree. It also disabl=
es
> L1 during resume for platforms advertising IMX_PCIE_FLAG_BROKEN_SUSPEND.
>
> Link: https://patch.msgid.link/20260719-l1-conditional-imx-v1-1-a55a57915=
c68@9elements.com
>
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/control=
ler/dwc/pci-imx6.c
>> index 98e1db751132a..1fdcbcd2422e5 100644
>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> [ ... ]
>> @@ -1442,6 +1458,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *p=
p)
>> =20
>>  	imx_setup_phy_mpll(imx_pcie);
>> =20
>> +	if (!imx_pcie->supports_clkreq)
>> +		imx_pcie_disable_l1(pci);
>> +
>>  	return 0;
>> =20
>>  err_phy_off:
> [ ... ]
>> @@ -1748,6 +1767,7 @@ static int imx_pcie_resume_noirq(struct device *de=
v)
>>  			return ret;
>>  		imx_pcie_deassert_core_reset(imx_pcie);
>>  		imx_pcie_assert_perst(imx_pcie, false);
>> +		imx_pcie_disable_l1(imx_pcie->pci);
>
> [Severity: Medium]
> Will this cause an inconsistent ASPM L1 state across power cycles?
>
> During boot in imx_pcie_host_init(), imx_pcie_disable_l1() is only called=
 if
> imx_pcie->supports_clkreq is false. However, during resume here in
> imx_pcie_resume_noirq(), the L1 capability is disabled unconditionally fo=
r
> platforms with IMX_PCIE_FLAG_BROKEN_SUSPEND.
>
> If a platform has supports_clkreq set to true, it would retain the L1
> capability at boot, but lose it unconditionally after a suspend/resume cy=
cle.

Platforms that set IMX_PCIE_FLAG_BROKEN_SUSPEND (i.MX6Q) do not
set supports-clkreq in their DTs. So no, such scenario won't occur.
