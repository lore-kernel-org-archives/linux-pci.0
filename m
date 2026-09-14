Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF783F9278;
	Mon, 14 Sep 2026 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393292; cv=none; b=JRLGOAstoXBxfSVLkghdh4AiPSJs/hHh62B0dcWxNSy/xt300AAeIaXzxq7zmrl0ZAJh8ZxPxM/DZYP7nR7bxiRF8vOSf68/ZoCJ+zBeUVyXzaV3YYON/rDDD6ar5xFx4YYBzuBLpQjan0r8ZWJJnMEWbsEf4jYdLjjzxg7HFqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393292; c=relaxed/simple;
	bh=rfgUu0BqcvYeY/h4T3mk7c47S6wJXmaDfGyicvf/tOU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aPNqAhMCf6mQHIN4zFVK/d0WrLBJneXvSqJ9dqmUAfJxrh93I4dLqhF5niFh2nT6FK6PG/gUFNZWqCQW6r68EsOZ7Pfn+NDV90F/r+ZeqJnsFp+WS3EB7b9qnj2aCMWxyHK7em5GfPq9vSVIn0I76PPPlmelRQvdoFcLmU2zbtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MKjh52x7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MKjh52x7"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED23YH937666;
	Mon, 14 Sep 2026 13:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dCKmLw
	fF09GDXc9LfjMQPJn2gLpX2JuXRKt38Dm6hLI=; b=MKjh52x7BE1YhmPIp1LuAO
	HxsNnY/WV8rhdBdkxWKCAOX9+QMAQ13QUDO2HPC9Nf7eeQoN1TW75bcXJ5Icm5aR
	aRWhACqdPVFbasczwA+eLiemtJELFf9kH585CCauLCRYDotyjf2aElF54gryOxyV
	n8CC6lAFqOqnbgHZVVQScP4rmyLLD1+7ZfFWplahx14zpIuJJ8DPgNYecrWTjqRz
	ie6tB8qzuZzDrdwkw1FqVJr9EYhV2GHGzW+2Qqyz4CY35Dn4QkbXNUimy3PPVOPq
	zhBrAM8IevZbA7vCm0vyYXcRzKMRGmOa9Zz9bPAztQ//xYGy3qAkkwhvbOBuJZaw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5dspaw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 13:41:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED57sH2333688;
	Mon, 14 Sep 2026 13:41:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnjjgp78f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 13:41:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68EDfLch32440766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 13:41:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 191792004D;
	Mon, 14 Sep 2026 13:41:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E29F02004B;
	Mon, 14 Sep 2026 13:41:20 +0000 (GMT)
Received: from [9.224.92.241] (unknown [9.224.92.241])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 13:41:20 +0000 (GMT)
Message-ID: <85a220af90568124bd4e7d354a8741b612955595.camel@linux.ibm.com>
Subject: Re: [PATCH v2] PCI: Accept AtomicOps already enabled by the
 hypervisor
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Nikola Prica <nikprica@amd.com>, bhelgaas@google.com,
        Niklas Schnelle
	 <schnelle@linux.ibm.com>,
        Alexander Schmidt <alexs@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        jerry.jiang@amd.com, haijun.chang@amd.com, andy.zhang@amd.com,
        christian.koenig@amd.com, jim.chow@broadcom.com,
        matthew.mcclure@broadcom.com, Nikola Prica <nikola.prica@amd.com>
Date: Mon, 14 Sep 2026 15:41:20 +0200
In-Reply-To: <20260907161701.454364-1-nikprica@amd.com>
References: <20260903121217.23F751F000E9@smtp.kernel.org>
	 <20260907161701.454364-1-nikprica@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE5NCBTYWx0ZWRfX/To0vT7eI8Xj
 /AXhhkTPKeopM/FlX/dVRP40ROhnZ4wVU78DcwXzCRv9effaSPgnB9exHpAknPLnxLVcyVi631P
 JW7+Ww4ROouK6xLzdeakXm/8jRwWL37ebkkZYR4SKsavWhyBOyhoRX7UVYNllCTTTRiUK/Eb/kb
 4fNSfeKbLKPbP/U3IEQ/LoI8kBm4nwh1g+lyjLX5kPzR9kkaerP8zKiKeTdXvAoQCE70iIfNUIB
 CZQkiLSzk6MUy7rGFFpn50br+JE1/4KNYXuH7OdlwSDaa4Y5jlERxhuGFR8kOUZxsPt0NxADeYX
 x8Qb8f+utayj5P+x9mJMwxbRFVE4tv4EKAe82+DpQoNR69q6D0BR4sn4bnf1ujAygUR19Iv/EwT
 wHZt29TMm3Q10De85+VS7m186tp2qNiYMLrx5xq1mTcWvxkCt8vJbKZqVO0p1ig6c0kS5614yTw
 J6ow6TZrYtFuLosyOOA==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aa7f986 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=zd2uoN0lAAAA:8
 a=VnNF1IyMAAAA:8 a=1R_boaI8g_krCSEjMdcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: B4bWnlHlQTz1rqvMfuvL3nXXAiI4nlrk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE5NCBTYWx0ZWRfX4+TEVBkebBPG
 kmQK7NqC5XY6N8lFsA5xPel4OJTRo3kHH8Jkc3Aexf8GyTmYECRdX9JpwMwweN0gjr8WZ9DYd8I
 5T4x6Pag2F0THPsWR6dSSxQsOrQzk8M=
X-Proofpoint-GUID: KyT-ygwBS2-MlHOnKXlWyV9wKUJ9yQBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1011 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140194

On Mon, 2026-09-07 at 18:17 +0200, Nikola Prica wrote:
> From: Nikola Prica <nikola.prica@amd.com>
>=20
> pci_enable_atomic_ops_to_root() currently fails when no root port is
> visible. That is common in passthrough guests (ESXi, Hyper-V): the
> endpoint is assigned to the VM, but the guest topology has no root
> port above it.
>=20
> In those setups the hypervisor may already have enabled AtomicOp
> requester enable on the device. If PCI_EXP_DEVCTL2_ATOMIC_REQ is set,
> treat AtomicOps as already enabled and return success instead of
> failing the Root Port walk.

Hi Nikola,

your patch got me interested, since it touches those parts of
pci_enable_atomic_ops_to_root() that commit 1ae8c4ce1570 ("PCI: Enable
AtomicOps only if Root Port supports them") has modified.

I like your solution for putting the hypervisor in control of the
enablement of Atomic Ops on root-less PCI functions and did test your
change on s390/Connect-X, successfully.

> Signed-off-by: Nikola Prica <nikola.prica@amd.com>

If that commit of mine regressed your use-cases, you might even want to
add a Fixes: tag?

> ---
> Changes in v2:
> - Be more strict and only apply logic in headless device case.
>=20
>  drivers/pci/pci.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..62729ade496f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3769,8 +3769,18 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *=
dev, u32 cap_mask)
>  	}
> =20
>  	root =3D pcie_find_root_port(dev);
> -	if (!root)
> +	if (!root) {
> +		/*
> +		 * A hypervisor may expose a headless topology with no
> +		 * visible root port.  If it has already set AtomicOp
> +		 * Requester Enable, there is nothing more to do.
> +		 */
> +		pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
> +		if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
> +			return 0;
> +
>  		return -EINVAL;
> +	}
> =20
>  	pcie_capability_read_dword(root, PCI_EXP_DEVCAP2, &cap);
>  	if ((cap & cap_mask) !=3D cap_mask)

At any rate, feel free to add my

Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Tested-by: Gerd Bayer <gbayer@linux.ibm.com>
