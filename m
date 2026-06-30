Received: from va-2-36.ptr.blmpb.com (va-2-36.ptr.blmpb.com [209.127.231.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E12D837C
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 17:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839077; cv=none; b=uyzAlOoljexamRfIEaHgm7rY0cPVzXM5GwMtW2/JaI55D05kf4eJ0F+JBYT0WSUeXnlN2ji76NlE/5C2nYL2w6QwOrjX47Bp+z8oTdcFlhxW6rJifxTfzaEXWIFouFWxj1cAbY4XycSFk0zBuU0PzODzdzZmnWu9EIrtYzGrHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839077; c=relaxed/simple;
	bh=wrhTc0Bpvied3wfmrldhgGh2GuS1oU2lHEV3WIQ1ARs=;
	h=Cc:From:Content-Type:References:In-Reply-To:To:Subject:
	 Mime-Version:Date:Message-Id; b=XZ+nfHrma8Mo/QZojTVhCKK5c0mX8aNRoCEyHxt0W2zhvuu1/9ryuyLC5iQdTNg/uWFMdlg3cfoamjPykrC0XkYWDiklj8fZ18o145fWDGBBjZps18BMUF8pumc8xCLZmOoBo5B+B12uS7RVZwFs5QtGS3cwd9wPMoDkKM4Xd5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=WvS/plME; arc=none smtp.client-ip=209.127.231.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="WvS/plME"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1782839071; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=wrhTc0Bpvied3wfmrldhgGh2GuS1oU2lHEV3WIQ1ARs=;
 b=WvS/plMEtz+G+NL75XYgnysgPBUNHVqIvjK9pc4QtT/f2xD59T5lTVA0LspWVJiyFmDRiG
 qAnVowh3M4bfek/yktWo4T/WkZQg+PCc0DqJrFv+XpmcWFXO9J2GmGC2/ddsHcmYf1d1aQ
 lsPpmUbZOpnvU3hu0ShCUoiA1HCV0n0OxNdfojG7Be7q2s82FoOlXTE0g4X51Ukt6p+9ma
 QY1VAfLdIu0Ve7Uk3s7JMt7SG8bGgHjx6y9vrCD17KUCy4ULuYD0A/7Y8jXEa2+JJDBTPN
 JGC1AfURj77Wn0fUNZF9/VoRMs7qqLUXeId0kG6e1c4azTWMH2SHbOqVvF5t9A==
Cc: <renyu.zj@linux.alibaba.com>, <will@kernel.org>, <mark.rutland@arm.com>, 
	<jic23@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <yang.yicong@picoheart.com>, 
	<jingoohan1@gmail.com>, <mani@kernel.org>, <juwenlong@picoheart.com>, 
	<geshijian@picoheart.com>, <douyufan@picoheart.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Content-Type: text/plain; charset=UTF-8
References: <20260629092717.74946-1-yang.yicong@picoheart.com> <20260629092717.74946-2-yang.yicong@picoheart.com> <2b760949-8004-45e9-a032-e95d4cc27136@linux.alibaba.com>
In-Reply-To: <2b760949-8004-45e9-a032-e95d4cc27136@linux.alibaba.com>
To: "Shuai Xue" <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v2 1/3] perf/dwc_pcie: Add support for Picoheart vendor devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [172.16.14.160] ([219.142.31.218]) by smtp.feishu.cn with ESMTPS; Wed, 01 Jul 2026 01:04:28 +0800
Date: Wed, 1 Jul 2026 01:04:26 +0800
Message-Id: <c6563f6c-ba51-4b11-a294-2bbccbd1af5a@picoheart.com>
User-Agent: Mozilla Thunderbird
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
X-Lms-Return-Path: <lba+26a43f71d+0415ac+vger.kernel.org+yang.yicong@picoheart.com>
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 6/30/26 11:35 AM, Shuai Xue wrote:
>=20
>=20
> On 6/29/26 5:27 PM, Yicong Yang wrote:
>> Add PCI_VENDOR_ID_PICOHEART in pci_ids.h. Update the DWC PCIe
>> vendor table with Picoheart PCIe vendorid to enable the PCIe
>> PMU support.
>>
>> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
>> ---
>> =C2=A0 include/linux/pci_ids.h=C2=A0 | 2 ++
>> =C2=A0 include/linux/pcie-dwc.h | 2 ++
>> =C2=A0 2 files changed, 4 insertions(+)
>>
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 1c9d40e09107..2c17239aacea 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2640,6 +2640,8 @@
>> =C2=A0 #define PCI_VENDOR_ID_SUNIX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x1fd4
>> =C2=A0 #define PCI_DEVICE_ID_SUNIX_1999=C2=A0=C2=A0=C2=A0 0x1999
>> =C2=A0 +#define PCI_VENDOR_ID_PICOHEART=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x20fa
>> +
>> =C2=A0 #define PCI_VENDOR_ID_HINT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x3388
>> =C2=A0 #define PCI_DEVICE_ID_HINT_VXPROII_IDE 0x8013
>> =C2=A0 diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
>> index 8ff778e7aec0..b0ccb2ad74db 100644
>> --- a/include/linux/pcie-dwc.h
>> +++ b/include/linux/pcie-dwc.h
>> @@ -32,6 +32,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_v=
sec_ids[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .vsec_id =3D 0x02, .vsec_rev =
=3D 0x4 },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .vendor_id =3D PCI_VENDOR_ID_SAMSUNG,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .vsec_id =3D 0x02, .vsec_rev =
=3D 0x4 },
>> +=C2=A0=C2=A0=C2=A0 { .vendor_id =3D PCI_VENDOR_ID_PICOHEART,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .vsec_id =3D 0x02, .vsec_rev =3D 0x4 },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {}
>> =C2=A0 };
>> =C2=A0=20
>=20
> Hi Yicong,
>=20
> The pci_ids.h part looks good to me. Minor, the new entry in
> pcie-dwc.h breaks the alphabetical ordering of the table
>=20
> Could you please move the PICOHEART entry between AMPERE and QCOM to
> keep the list sorted alphabetically?

sure, will do. sorry for my careless ignore.

>=20
> With that fixed,
>=20
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
>=20

thanks.
