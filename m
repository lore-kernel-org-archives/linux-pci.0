Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A6D3C8717
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 22:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784239460; cv=none; b=MxI8mWX5hJS3QlEMU3XzNEKv5v4m+kjI3sY8pP1AvDrIS31GCPL8UlIzNcdjehRcx1RL8aUPy8aB0UIbbwp7sVjwv3fATjkWLVDJKla1uQ5K3811LzGINZJQhUdWQiKPHSUi2kUSm1ZZxXQ+Yqn26ZRtKClqiIIj3id0jW4B+nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784239460; c=relaxed/simple;
	bh=sML6CNrAm3EpCRLBLfIIVejmB+S3fs3lUSZmXKTxNmk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gRxexLcLIZxFOJKcDP/NqxegmCFWAvq8P44YnHgkqwA7zpY9KFWFLgJ3nBzx3f0mHlU6K77JBuqh0PnddH8DPguQ3UAGRu3t7m2WiNWxhfNgRSugZvl5UM3SoOOHYxd2suzkPOFXOuuPVfxkqB9VBfNo39xtcWx+6ualv0HgMfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b=DM2I0nZr; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b="DM2I0nZr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784239452; x=1784844252; i=smoch@web.de;
	bh=WLbbABpTHC+mCS6hOlE4pYlTcoUwh2jApXoV39IuihE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DM2I0nZr5faNQGIP3Fi8vhk6edK1eIlZ5pK6w6HYFTHgQYWI8lPUqc7CdERGjlQR
	 J3Ka3QW1+2GueGskKl+c51IW3BBrUXgaozAQ1qLHfOdKOQWJs+598pRo3UZsAFTnk
	 gnGKLvvBTFevA6VnPRuE25xmLtiNiMOTJr/Usszc19D7u4uwxiCuPl+cfjNTPLowq
	 DOCNBXln9uvbDENo4EADU+/kA/qZat6I4IkNgua7bylu7LaoJ0HgTpEEwfMcgE2u6
	 0sD9wyeQ4x5bqChFJfdKKsX+7kN+wNFZSoqmTrkaxkPHj9goyYcTp91O6b6OTUYP9
	 T7xiTFlF79DPYeBT2Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9ISh-1whRNc40gB-007U3U; Fri, 17
 Jul 2026 00:04:12 +0200
Message-ID: <880a7886-e16b-4e98-8f9c-767ee55f0c7f@web.de>
Date: Fri, 17 Jul 2026 00:04:11 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: imx6: Keep Root Port MSI capability also for
 i.MX6Q
From: Soeren Moch <smoch@web.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
References: <20260716214054.47372-1-smoch@web.de>
 <20260716215134.AB4CD1F000E9@smtp.kernel.org>
 <e793aa45-746f-4b49-967d-bb997607ff55@web.de>
Content-Language: en-US, de-DE
In-Reply-To: <e793aa45-746f-4b49-967d-bb997607ff55@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SVoPsPuBzTy5VeXFD2vSNtPBAEFST/KBWvWYpf/U53nXkmEP2Ng
 nMwgx7fdjbPOadQcYiDpDga/TUAp3W8aBvrbD5Nkr/Qlyg4ZiRf7dKGjpbbZelOYL3ssuNO
 mFwppHk8heXSvQyKqMpR5TgRRUxIhT8ycL8rIh9K2H+HS2OA2i4rFbAcc5nOCFV84/A2TiX
 Oa336KjesnY2EzZ4SiLjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bgXE1AIOJCI=;8KZ9d7mUuZwx1+Z74bUC3O6qS81
 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

Resend as plain text.

On 17.07.26 00:01, Soeren Moch wrote:
On 16.07.26 23:51, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential iss=
ue(s) to consider:
>
> Pre-existing issues:
> - [High] The patch applies the IMX_PCIE_FLAG_KEEP_MSI_CAP workaround to =
IMX6Q but fails to apply it to IMX6QP and IMX6SX, leaving endpoint MSIs br=
oken on those platforms.
> --
>
> --- Patch [1]: [PATCH v2] PCI: imx6: Keep Root Port MSI capability also =
for i.MX6Q ---
> commit c39e7347457d41f45ace38b5f670a9cded21c82b
> Author: Soeren Moch<smoch@web.de>
> PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
>
> This commit works around a hardware bug on the NXP i.MX6Q chipset where
> endpoint MSIs are dropped if the Root Port MSI capability is disabled.
> It achieves this by unconditionally applying the IMX_PCIE_FLAG_KEEP_MSI_=
CAP
> flag to keep the Root Port MSI capability active.
>
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/contro=
ller/dwc/pci-imx6.c
>> index 98e1db751132a..8130cf93c2bb4 100644
>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> @@ -1995,7 +1995,8 @@ static const struct imx_pcie_drvdata drvdata[] =
=3D {
>>   		.flags =3D IMX_PCIE_FLAG_IMX_PHY |
>>   			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>>   			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
>> -			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
>> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
>>   		.dbi_length =3D 0x200,
>>   		.gpr =3D "fsl,imx6q-iomuxc-gpr",
>>   		.ltssm_off =3D IOMUXC_GPR12,
> [Severity: High]
> This is a pre-existing issue, but should the IMX6QP and IMX6SX variants =
also
> receive the IMX_PCIE_FLAG_KEEP_MSI_CAP workaround?
>
> Looking at the drvdata definitions in this same file, the IMX6QP and IMX=
6SX
> variants lack the IMX_PCIE_FLAG_KEEP_MSI_CAP flag:
>
>          [IMX6SX] =3D {
>                  .variant =3D IMX6SX,
>                  .flags =3D IMX_PCIE_FLAG_IMX_PHY |
>                           IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>                           IMX_PCIE_FLAG_SKIP_L23_READY |
>                           IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>                  ...
>
>          [IMX6QP] =3D {
>                  .variant =3D IMX6QP,
>                  .flags =3D IMX_PCIE_FLAG_IMX_PHY |
>                           IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>                           IMX_PCIE_FLAG_SKIP_L23_READY |
>                           IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>                  ...
>
> Since they use the iMSI-RX controller and share the same DesignWare PCIe
> integration as IMX6Q, dw_pcie_setup_rc() strips their Root Port MSI capa=
bility
> unless the keep_rp_msi_en flag is set.
>
> Does leaving this flag off cause IRQ timeouts and complete functional fa=
ilure
> of MSI-reliant PCIe devices on IMX6QP and IMX6SX platforms due to the sa=
me
> hardware bug?
>
Unfortunately I have no access to IMX6QP and IMX6SX platforms. So I=20
cannot judge if the same fix should be used for these platforms as well.=
=20
If this fix is required for all platforms that are supported in this=20
driver, why is this added as a special quirk? -- Soeren

