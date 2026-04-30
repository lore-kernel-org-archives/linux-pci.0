Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643A13314C5
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566001; cv=none; b=IWAAr7R77xK1eD46P/875102FCKvn+XSzHC7WWtsqbZZc5IcXAAt9dSPo9WX8FAC5KVtWfB5nxkS5RYFKpdGm4OdWcJ0TytCCVE9vDEn/ONUY8weBEjkSGME4fchIXwfjkfCcKUGKzhZV3ipDziYwbKDYvX53mv86y8x4hR+kzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566001; c=relaxed/simple;
	bh=sYVEglhh1iNm/BMu0UD0diZ0ucnq+TS0soaXV9m6kys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WptOb7bNMO9GS1kYirppr6XoW6TjhQ81VFthvHCTdIA2FMQWP//Y5YqV45mUE2rf9UywcGmDvyi742mrUdwXmITIP3l3zR1tQrcfXbGtADf78AOz9EIfxuAlqGHdthlOT0dupGxHSszd8fRVYhwV2u1ToZe6jf+wjOLD7UORyWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FJRkdYRO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QJUm6WnT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FJRkdYRO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QJUm6WnT"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UEa9SW3729473
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 16:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YadfwvcJLiyVkEHkRErYP1Ha9ZLse3Zysh7HV7GA6cE=; b=FJRkdYROQK43/dZ4
	ZdKz50DvoKZi98DqINCmYbGARyUo4QNDkhq68QMQcrvwKH9G6y9lWezq9+T7KIYG
	/kyzJNp386OZUpQnxVxlHTqhn2ftUQ+D/+ILBy2JCCBamNRq2K54T2Zd+etBnekw
	YJzL+0tTH6UjpNTg6utS9QRl89DANtMh7JmV9ycWvECVxcGB+djRSauYIkg2kOH7
	ttKCWO9xaxv6QqRN0bqeTS8PqCMGnUrYd7JyevlIfwWvICpXam72hjfTOz/FGuQY
	5oved+wqltXguoD6QQe88COzTD7kT31mN6Xvhvd/YbrzGb6IGdYN7IjNilpATLH7
	x5YP6A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duy1wb8yx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 16:19:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b249541063so11092385ad.3
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 09:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777565999; x=1778170799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YadfwvcJLiyVkEHkRErYP1Ha9ZLse3Zysh7HV7GA6cE=;
        b=QJUm6WnTuM30UZvaiqj0XeI4gJ6Qb3u9VqzhKvVLSJcpHeiO1BAhLlLVUvTL3gmFfS
         D5W5EjiSPxvZkCL4FXx+ilWKGPctB/7kUBs8JavYX2JtYzhXz/tW/sYZagVl5uZvPcHA
         S8HrseryqB+MaNAt+OumhEE6fiiuPBzgMXfulf9TJq8QAzPqEn87/jgPs9kHFo1nQZXd
         7vIhpmcQfXuFidkga23SC/XJr62Q8t40uLLQJS1vsFU4NcbUYBBrvhrAGr7nxsUHaOfU
         P+OQKru6Qg5DvMXdh+NYcYdT7FyjgcZESvpXks4y89oewLsNi9qWg9Fwyd7cJKkG3xFs
         GFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777565999; x=1778170799;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YadfwvcJLiyVkEHkRErYP1Ha9ZLse3Zysh7HV7GA6cE=;
        b=Zz4Fxwr38OFb1FbHvZCekxJ16F3R0Z1bPiQAIdVOMQ3AXc/8xEW9iQQc7ZeF+WIAAJ
         rcLY2Izxj52DL7cIwPYAASrvsaK9v6+CqwPWoLWWFKXlhUdIuElnXZ2fCFxBJ8JRVhoX
         KlciazGrUFry90RFupnd/uyeb2w974FrGC8C1k/LDFk/ldvfckH2bcVvSCd6ZKGvyEcf
         griXaDHW5fWpof96i65YpOV4eV7Oo+TKwuwuCzwtI8qya5vtvMLuLBA/iOGfXXqodMgQ
         U8XMwDG0KRnEt5EPCD+L8dg1q7hoNTjCAyEEC54xzfV3QUlC4seEb2kfn3PW/wIBteP7
         IS9Q==
X-Gm-Message-State: AOJu0Ywp2vu/1knPa4v+2BaZg90pNreEf2821bdzAt5hslmt2pSX4AsP
	GGdWpQB42Pm9Fig/kyw7U+NzsojJltR2bDRwzutf+Ywcy1jMGytOmwoj7V9Fs1cts3G1xg2Et66
	4hU5fgd96QUImBra6b+gm5IPpbquo2qqUNdDjmjF2zkKoLc65ch3ZLjI08ldSXMI=
X-Gm-Gg: AeBDies6o26GitEtILWXXsPIekn+kKPmrkwNbNknEVLcgBYEvgE9KhSn1tep6db6g6W
	VjzuGPNPZYwGTWhPFGD/38objOv2Qbut6vO5m7fPDJg3yaSlRL6rAAQHAOhEkgqcLjexKuRQeTj
	CcNHdQgrWEDZ5F77hAf3WznFKJDnpgEgA2z164WJMp8NSOe1zzx4U6uECu0UeGkRYOQyT6XcaCr
	JeTtAkl7EQJuG88eLXol0LxKcYboNQ3mWKSpmwwt3KjCKtLo3kNzHC0w5OVByHcZtOfe+Ei6KEn
	V3PvjslIF8lGfwv4FKBu3q2gT29Hu/D2e/1X2WIWJv7YHT6C8G6xJ3xB9OBr70TW7Kwyf6lUs1b
	nLV/Glq0cpNg0RdupGMQBZZ2y4FPb+uA=
X-Received: by 2002:a17:903:32c3:b0:2b7:af0e:5942 with SMTP id d9443c01a7336-2b9a24c3051mr39358705ad.26.1777565998836;
        Thu, 30 Apr 2026 09:19:58 -0700 (PDT)
X-Received: by 2002:a17:903:32c3:b0:2b7:af0e:5942 with SMTP id d9443c01a7336-2b9a24c3051mr39358365ad.26.1777565998155;
        Thu, 30 Apr 2026 09:19:58 -0700 (PDT)
Received: from [192.168.1.102] ([120.60.79.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caaae66fsm1010505ad.21.2026.04.30.09.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 09:19:57 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>,
        Frank Li <Frank.Li@nxp.com>,
        Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
        Marco Crivellari <marco.crivellari@suse.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev
In-Reply-To: <20260414141514.1341429-1-den@valinux.co.jp>
References: <20260414141514.1341429-1-den@valinux.co.jp>
Subject: Re: [PATCH v14 0/7] PCI: endpoint: pci-ep-msi: Add embedded
 doorbell fallback
Message-Id: <177756599206.13537.12194903673950530578.b4-ty@b4>
Date: Thu, 30 Apr 2026 21:49:52 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-GUID: 4RHwMtltUwmMc7s-BDyRedRnKivBNNft
X-Proofpoint-ORIG-GUID: 4RHwMtltUwmMc7s-BDyRedRnKivBNNft
X-Authority-Analysis: v=2.4 cv=DPy/JSNb c=1 sm=1 tr=0 ts=69f3812f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=o+EpXNgM47EhA9by2x1l3w==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=nuIBDirHvEWTY3k0occA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE2OSBTYWx0ZWRfX1NXe0FEQCFgh
 TJEEXupBtjZ08aMvgzfe4mDoj0JgutW0m8706jymrvrq74Bwhs6eSfQ2LZe+iQp47/3kp3+48v4
 NJOKcV/sUoHUhfVTQZRpJLd/dvcvPehic4NouOwfTZ003Zd/HkgzRXXoYIFKWhkcVnVT9fWOWrU
 8ZcF+aSmOo5t/nIdhjpe50SIDF/CLoqeGXZoYYlHTnT2ggyQTh2EVmHLzMFlCZMPR5b2uBHIdA2
 H9/OJ2+32mOYrRXm783BBYtj4wXzX7u0m2mofw9/g71ErFKHkrd39WVtiQmCnDOMeED0q136LOI
 PA9Vgo8JZ9ilCR5qXt0jpeYpzcqWZGcWgoXe7DzllNEs+ZC78dyM8JyNgQLZCAv8xknxiPdjrdZ
 w6wEmgrEz/5IIpVIhnd8t5Xeh5Sfsc7qkyF7xM5bPz27dRZLLbpgXIY8vMUWawOYW7U/tTP6LLd
 ljWpB0mFRpCx0j41R/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300169


On Tue, 14 Apr 2026 23:15:07 +0900, Koichiro Den wrote:
> Some endpoint platforms cannot use a GIC ITS-backed MSI domain for
> EP-side doorbells. In those cases, endpoint function (EPF) drivers
> cannot provide a doorbell to the root complex (RC), and features such as
> vNTB may fall back to polling with significantly higher latency.
> 
> This series adds an alternate doorbell backend based on the PCIe
> endpoint controller (EPC)'s integrated eDMA interrupt-emulation feature.
> The RC rings the doorbell by doing a single 32-bit MMIO write to an eDMA
> doorbell location exposed in a BAR window. The EP side receives a Linux
> IRQ that EPF drivers can use as a doorbell interrupt, without relying on
> MSI message writes reaching the ITS.
> 
> [...]

Applied, thanks!

[1/7] PCI: endpoint: Add auxiliary resource query API
      commit: cc07b903a646bf6592182b27c63457d92f128125
[2/7] PCI: dwc: Record integrated eDMA register window
      commit: bfb9502651f689c338ba3e8aeb07d31c46e0cdf6
[3/7] PCI: dwc: ep: Expose integrated eDMA resources via EPC aux-resource API
      commit: ec2075cfc629eed09d8865621be76ff2197781d6
[4/7] PCI: endpoint: pci-ep-msi: Refactor doorbell allocation for new backends
      commit: a3a079e5c5b7748f206c4baeb92593f9eca3184a
[5/7] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed doorbells and IRQ flags
      commit: a70c53234f593bfa6d137b50dd49efe0cb49db87
[6/7] PCI: endpoint: pci-epf-test: Reuse pre-exposed doorbell targets
      commit: 5fd41dbd2ddc3607988fabc4836af1c9a2abe344
[7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
      commit: 2071d513cc9b68633138c9b8deab35e32e4c0fd3

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

