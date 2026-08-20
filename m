Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54C513D886
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787214115; cv=none; b=XX/ZW5f33M4mWtBrzLXTGu8fkn2Wal+GOr6ZuhjDiQpHIuaSEbG47Bl39G3l4A7NXShOu/OPEG/zUAYIHvwVoH9yFKMsR6PHYkglOcGewFP/UcC5Ho9laFwlZaYNVRkWiSXWkeHf1STciAZtxsFcHhgxiW0FFyyFelKvrcvxq/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787214115; c=relaxed/simple;
	bh=wU4ZPSxWqF2C2mq5lOaN8+dVyTnWkJN9n3Lh54BZF+c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cARfsnBFddudsjaksUPowuc2RNvI+y039MUgJHC6kxr9tlCT3/h9qcop/p1gtedxx1q5ePmhy7WvY53kW5JCOpASWb1tLROofi2XQCzkrJBYz6P4aVlJFhshQVkZaJRgLJSDHSNLvN5gmArEd5pMzgxM17j91UCWfqBaN+6gfXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i7ArsR2Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YFpBxo+U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i7ArsR2Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YFpBxo+U"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K6CXk71354282
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 08:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	COuSjI9sabJvo56/W1RpkiGMQ8nd4UtkCyCgJKdcyDA=; b=i7ArsR2ZFjHvcd5I
	+jncHxsZ/kmV0gNtMi8vB6PwRKRhRnSCXR9JnU5t1opgCcDWSwp2TQHHa2GT+RY6
	xoc79O2y/QzUh53oZZPSiShLYWkH6OW5JTHLg9ZMJjEfLjIZKA3VCIZE+0BloNdC
	VBKZHCCleWr0jPqfJ7AFUG+Fsn4YSbQAFWXvGIocU9L+hs9ZNQKzPatXlzANDp1T
	McEoBfaj7B3uTRIJ0FbYIA3KF/itm+NTDo6kZ9eo679tswOQdcNx0YtGU6EvcT5q
	bmSqbXHfQtKgWHcr8CJc7TdwrpCyta9u8r2ChCu9Jp6S/1GmaL2VtCJZppO3A2uH
	v7zaKQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es5bx1n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 08:21:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e820609d9so223285385a.2
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 01:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787214112; x=1787818912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=COuSjI9sabJvo56/W1RpkiGMQ8nd4UtkCyCgJKdcyDA=;
        b=YFpBxo+U5+5PVdQzLDJSbjqPFIINetNPIY25OP9SuKkbKYKOURMMFeoNi+/zvoRfiP
         AIyRfKBe+rtS2pEHsKlnoD+0P49D950m+ocpGGowry6aRNRlj1E1TMZSD4PYu7QiE2ly
         COJH2MP7pF2QM4m2ZAxoMvP9/IU7HK43U+DNox/J0D/nd6Sm3ykXm1IirBfKu9gjaOCY
         z1kNTKn4d7RaHVgqZ7YWEoNldgDM1u+2TtFwlojAETDOD7lDA3ij/Pj/iyQXdlq4ejhS
         XpZhNml03fQFKttlH4L5ehRR3zw1nwJJlGnhwkBloU44iW4h3ljcArlVSJD/0zvx3MDe
         DejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787214112; x=1787818912;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=COuSjI9sabJvo56/W1RpkiGMQ8nd4UtkCyCgJKdcyDA=;
        b=Bym0CwpYc0enuFC96hHSqnhoPkM1beVupw1FWitRYgueYo6zHp8UC1UmasPJX+xPY6
         NkeA29PB+fBngR6RCGdC5d3xQPVbbLWtrfyN0nJPmcH/mxcDdoR3xYFPHZw4FGQIi6tX
         qyK+mwZ1ZS5vChMOuaTTR8YbsreOY4OOK2U3OxFu++nB5EdfrnCw1/A76auKxip11o4L
         PwYpYHvNmix5LfdBDNktkwC4LlpROYaxySdbMvCnL+PWW/5kHdu1qMqXsAJh+gkQMjY/
         NbgDQ161vVH4rs5Uz8yY6IHIY1VzIxAYBahumeUKs7ofGjQZJmKZdtAsc1ZsIctmQRVS
         xG0w==
X-Gm-Message-State: AOJu0YwWJSu4RSVbolNLXUDcA5DAv3woc6rp7Gd/mkG66zWj1VvMdYVH
	l9TViCg9Q64gvz3F3kpDquWMhSmfSFUXysmzgsR6fBlnoDP0quX+V08snVAo2KXzMcQDjK/mYhM
	FWhS/hS1xeOw8+MLm0jm0tKGr0Ma626m97wyjMe3SUCAErEc9ZTI+7Q5tAKsiXhs=
X-Gm-Gg: AR+sD10yEMjPoolgL6un3SF1MXdFSvEEoPFBAIQaEZps5rqlcTj41QC6Z1nlQuw1t9L
	ZWdE1IHljhAfWhWigMd6xNZg4HGiABeFTzTjUE9g6wWraoO04GteKyJ0w7wssCH9NIcMxSKnDsT
	x4ooqHWef4rD1mWRDP3FbbNm88OiymPaYisH1OCW5Hyq6rc8wGLPuc6Dm/ONnv/k1JkLg8leWn1
	2gXhNo1jq4VuOlHZ7XJWGDrFWqnH2TG1UmbLmTWM8/wjFRQ2SqoxZuiPxUvoUbF4lzz1lx6uffw
	8tNzjJXtuhc8hyWJ0TS8+oDCK/nF5yaNDMydcNS+S3BV0jy7CrtIW8v2qxkfMNkjOKkNfYebVhc
	USilrjedgYmMOV918bbH9DRvZUIjbBFXUPTG/vdY59mbmjyzHaI955CMwB/SEkEC3Mk4I6qwjhY
	zIocce2DEuOxNj3gA0a+kbG2fABWdX8LcEUW7ZgEkfveCAi5VdNdDgAEDWFCSVFmCCo1E=
X-Received: by 2002:a05:620a:45a4:b0:936:e08b:733d with SMTP id af79cd13be357-9371e446cb4mr1001266285a.35.1787214111966;
        Thu, 20 Aug 2026 01:21:51 -0700 (PDT)
X-Received: by 2002:a05:620a:45a4:b0:936:e08b:733d with SMTP id af79cd13be357-9371e446cb4mr1001263985a.35.1787214111558;
        Thu, 20 Aug 2026 01:21:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2458b0933csm41830366b.18.2026.08.20.01.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 01:21:50 -0700 (PDT)
Message-ID: <d5e7e055-f589-41e3-b322-a45cbf3528ec@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 10:21:49 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: Add ACS quirk for Pericom PI7C9X2G304 switches
 [12d8:b304]
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
References: <20260820082041.13470-1-johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <20260820082041.13470-1-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AwW_7Oft15db3ytQr6XtmRhRR_G_9J33
X-Proofpoint-GUID: AwW_7Oft15db3ytQr6XtmRhRR_G_9J33
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA1OSBTYWx0ZWRfX6ULzhYTVPMhR
 InI4jsPXoZyLVdgy97s7p1O/Rc8gSDu1jjq11WG04/Gj5PDtiP0YCgPiJq9e1id8jMzESuH2WLT
 VkJOO1N3sZq5ipQrpvTYHE8MNu4BTtM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA1OSBTYWx0ZWRfX/fy2u+aLdK1S
 Zfo46+QMjYhDK7y73rY7JHnOflOcBajPGTrL9df65k7n0IwpG5L5gpFgfTuM8suffZ1G26PiFfA
 fvTYAdu2dfmu/6aJvlveEN1Xs9I8T2yimm1iO9QQ7djWcyk+qS2YAtyWmvvKbmVzqXyRW/Fnvh1
 9IXfxUsLyt+xPeFmZ3hQmLCdmGsLAFmDXuTYKWhghcs55HbxAMiLwPRKVJWEGlSUahr3njIpi3Z
 deokQdkWftCkANrK/kE+/eLRKBukraK7dn6U9+1l2Z/XnT0DHzkdvP8o/eorAey2+kGUhaaa5wg
 Aqlt5BxZnfdhpZSkzNWh77VuqUbzNns4pnImDRmjMgujbvRQHY8P72wTJsbuHoozRJkZaPlV1CZ
 JhL4nSPqq0Hi5MfBam+BvruRRRgtVl/pGxolLjNbwC/m0pc4V2qKKv9j6VuE2G2n2NoMgOMYNu8
 XejqDYdRCIHJcZ7+MWQ==
X-Authority-Analysis: v=2.4 cv=Oc+oyBTY c=1 sm=1 tr=0 ts=6a86b920 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=VH7LLANK3EC6fIgvtnsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200059

Hi All,

Note this is a resend seems the previous patch seems to have fallen through
the cracks.

Regards,

Hans


On 20-Aug-26 10:20, Hans de Goede wrote:
> According to the existing quirk the Pericom E5 errata for ACS P2P applies
> to PI7C9X2G404, PI7C9X2G304 and PI7C9X2G303 models.
> 
> The Arduino Ventuno Q board has a PI7C9X2G304 switch (verified from chip
> markings) with a product-id of 0xb304. Add 12d8:b304 to the existing
> list of quirks for this erratum.
> 
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
>  drivers/pci/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846f..1b4e15d744e8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6259,6 +6259,10 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2303,
>  			 pci_fixup_pericom_acs_store_forward);
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2303,
>  			 pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb304,
> +			 pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb304,
> +			 pci_fixup_pericom_acs_store_forward);
>  DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb404,
>  			 pci_fixup_pericom_acs_store_forward);
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb404,

