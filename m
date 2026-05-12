Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2D7296BBA
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573467; cv=none; b=ioMc6MXxKcRvOqy6x7NVfcnzS1nW0fO8eSrSSSuYRCiOg3/ewGpwLXlvczb44U3AW91HzXhEpKApguuzSpIVnIW8TXoIPcFe71ZR6rVNxAwVxgzoFyTKFujxgi+CK0XxP4O8A7JzxgEmXv+pYCDtPv8ZUWfcbcaQLc9PXOkE+iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573467; c=relaxed/simple;
	bh=46NLigxrdqsoAoXAUhjQRW7zMHrTQb8RtCDKXZnWwQU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bg4Fz7SpJ/hFooTTT57TDkRPuCtNAHSpdCvtNxOz1MJ3rCXhM67wJS23x7Lugzgs4ozXJvOmiL8awuec7nctSI50rkre4nT9RssJ4hHDTgR1prd/WeXCZr0JZ3tTzetk64oKAfzb3dCI8aHUXvWxnzycXBMMmFTGEsPfUOwnTpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AsRw4AHA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L07C8MDJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AsRw4AHA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L07C8MDJ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C5DoMF2202417
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 08:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ySNWlYVyimMhAUTBRgyBD6ADaxegHx9In1yLQxk79zM=; b=AsRw4AHAblEG01p7
	66+K7V3nDKPy8tP45J8v2/Qx/FdDSoelCLDjlQXRrWz9tPLUG8A1h2FTvq5nH/mJ
	n3RUHD/fzGd7gvLu3Vx4NR5VuhWB3ZilVQHGnNmD3/aOFgtY2npGxXR47aaNgJas
	dL08OPQr0BVkplRyRfpywmLHXqfv0a9HT7UbMM3Hz14yqJs/JP5BQvsUaod9ECLM
	RVfTJzV8c4P/x2iQY7ldXaQ+8XVB7bS/p9IzsKrvta1a43ZoYk9LV0kzppBZyZfN
	E9grbbEvrUShsvbA4faDQFj+MPJDehaXKcgggG5/dL+3nMC9N7on4NiIHKHhe6b4
	6Y/Q4A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nuyj50m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 08:11:05 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-837c4eb3bdfso3590064b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 01:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778573465; x=1779178265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySNWlYVyimMhAUTBRgyBD6ADaxegHx9In1yLQxk79zM=;
        b=L07C8MDJyR/yk9Nfl19/B1avZGlRttJD3HHPLSzCydff5sJ9YFAEYI4NKNe039TzGS
         FQJ/OCgqBdPsU7ybGDEX4Cl5o2ucgPT0Pr+dnJf6bUdAvV/5t6cJj5MPwJPuxuECi3/o
         CDek85ySj42KTKcVMcvNMrHNgEUeawp7sIgl/gtBOBmqZAZa/VV/LV2NsCgcNTH4fO2s
         /e31+NpQzaMeX4jfDT1uQ0IcVEUL01xt/yDnG0InW8m0Qvu0ACLICCKXcCexilUWLgZ9
         OXfRzRTo4vmwCl/c2CqruxL0pY4CKRQv6IzZ0w3wygCDZ2FKgHiUhEP2m658hb1o4EbY
         DRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778573465; x=1779178265;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ySNWlYVyimMhAUTBRgyBD6ADaxegHx9In1yLQxk79zM=;
        b=X/piSypW2e8eh5kSZGusyc4zabodXMJEdKyjsnoGA1A31aP8C9+whksAwJVG3d+cCd
         GyBW2lwy9Zr0YCuJTasnN6M0BTRM3tTDR2eL8L4fnrGej7TldvIKaPcDmmftQG9BZfI1
         n2U8CvGKtlLPWwXuQFDeNIGwKCO8pQnZLdhO+tMy41KNTkcyeXiD/rdrYVtv6xuUno65
         bzOwHgKJ+oW5QhGwP5eoS0K0OJREHjbZScwGJUeZOUhzGCJfoI1odOdQXRR14NgCiMM+
         Nftx7KAgbU5iU7GZoUcRxaWTgPkohSa1ZJsWS8rKp7Mup/0pzAtRWVpKGK+njCAJo+DY
         nk4g==
X-Gm-Message-State: AOJu0YyUrZ1oQXIeTjuF6eFmMDlzHDT/6+eDyjAWSF/XgYHeSSDSJt25
	8o/E7RyJmXZ6Xs+9i6MujgU7gCRMF8KLzIfwZLrIO+Y8L4xvK2qw1ASk3CrIZnNAK3hlujsMxIF
	HxfKFD0jV/lqIIWlrpjm8443nxMVRQsnvFlDC0g26xon8LJ0IBOyst9NOrJkUExe+iDIRyvk=
X-Gm-Gg: Acq92OGxIWU+1+ZdyHnUbcMhl7Sd85HVx2CgjLrN1sIPgX4Nkc97OvjMlCFtlUnHTMN
	xey+VVtOcpIORGpCdbyMBkYMuVb81d6s1L0CQ/cvYYiUkyGto7ccLNusx0k0bcsm1AdTWqZhGca
	GfPKx3wbGR0oGQQOyiAiT9U3+ZSidZdOJO18uX9bVgEiHIl/wVzljNlRdp2QGDUeVg2Zh7wGwev
	aEFmoiWKxhzuR2DFqgAnia6ztcfzb/G7qj7gxP38GzhL9xJ/Q10/0pFnrmxAuOlFyXLo6tkSsrx
	sv+j6ZEFkaLcvTBWtHtsSlse3YEXaXe5Y/1d/qPnjJkm55kSXfOP20jYck0uMhi4Q/VosEXPXxD
	1kLZbctz1zzMFEyPLGhNA
X-Received: by 2002:a05:6a00:3389:b0:837:b97d:2fe with SMTP id d2e1a72fcca58-83a5b9d822amr27741525b3a.18.1778573464373;
        Tue, 12 May 2026 01:11:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:3389:b0:837:b97d:2fe with SMTP id d2e1a72fcca58-83a5b9d822amr27741480b3a.18.1778573463853;
        Tue, 12 May 2026 01:11:03 -0700 (PDT)
Received: from [192.168.1.102] ([120.56.206.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965b333f2sm27843453b3a.20.2026.05.12.01.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:11:03 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: rjui@broadcom.com, sbranden@broadcom.com, lpieralisi@kernel.org,
        robh@kernel.org, Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260430021628.1343154-1-mark.tomlinson@alliedtelesis.co.nz>
References: <20260430021628.1343154-1-mark.tomlinson@alliedtelesis.co.nz>
Subject: Re: [PATCH] PCI: iproc: Restore map_irq
Message-Id: <177857346087.12177.869486974558245952.b4-ty@b4>
Date: Tue, 12 May 2026 13:41:00 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA4MSBTYWx0ZWRfXwpAytenPBBFe
 bOdunBNbZ2UkAwYAyHIIk/OgLsWF36m5/4ZaCHSt1eMGqgkYh5xImh46ZFZRmoMhokD1Mux+cez
 xyAigBIhrql9Gh49EOctzFST0+LM3XwnG8eDU4IsUVDST6EvRbLcnQGz/QA21QfJ7iTIIYP4t12
 tf+wYIjhzf3QxBpjVJ6vE6Mwc3DLggYIcRp+B+1iozGIAEuUI1oqpiQfuAXhXs9lVEvUzY+nybh
 XcAgopdZSUpYRzX9o+rTbTzqwesdbBbvo7d+z7kNqvnvDhl/pFtTjfmDL9LMdZzoaCnyCcfBTl+
 BKDdtPL6MqYGPFNyZwaf3r9DXMjhM8tKhUr0uhtsR/0DyU9z+mgfWJjChjcIV9Cr7bycWV4zQot
 S9xUnTv9GmcuNMO4rcTqexaYbU5iNcRsrvCvnwihF8sugH3xbz80TP8rSadjbA+an2vj0kxXjPf
 XOrqwoYo/prJL4QSwnw==
X-Proofpoint-GUID: KtEs-L8VSixw2GjABOsTfTH93W2Lm0RR
X-Proofpoint-ORIG-GUID: KtEs-L8VSixw2GjABOsTfTH93W2Lm0RR
X-Authority-Analysis: v=2.4 cv=Y5XIdBeN c=1 sm=1 tr=0 ts=6a02e099 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=QuRtzvr4xB5J0le8HPcEzQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=I4-L88zR5dZE0eUWi_IA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120081


On Thu, 30 Apr 2026 14:16:28 +1200, Mark Tomlinson wrote:
> Some time back, the PCI bridge map_irq and swizzle_irq were set up with
> default functions. The iproc PCIe driver was broken by this change, with
> the mapping function ending up being set to NULL. Restore the original
> (and intended) behaviour to use the default functions.
> 
> The iproc pcie kept the mapping function in a private data structure,
> which was then copied into the pci_host_bridge structure. As the private
> data was initialised to NULL, the NULL would end up being copied. The
> fix is not to keep the mapping function in the private data, but just
> set the function pointer directly when needed.
> 
> [...]

Applied, thanks!

[1/1] PCI: iproc: Restore map_irq
      commit: 54d996f57a44f711d4e4012932d09d157d2d43de

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

