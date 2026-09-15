Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71119488DAF
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 23:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789514531; cv=none; b=GELVnw29TIe29nW4JrPQJsN5p0ZXiJML88WugmxC2Sap0dOzkUuPwx0EProT/Ke5FMoTD0sTp9rIzYo4OwZ6PM8NFPALgw1RW77rXDz4Ei70N3zo+yoXQ5xhMo6HDbWqFWy2Em/99E2C22x8FDKK+EVNkUWD5CqKL7+Va8zh5nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789514531; c=relaxed/simple;
	bh=dTEsVObgRqUWdZPvIxWySL+6nkWC6Ia7ISiB0iANJgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unRo2QzhTCFJj2SySUvEaxzgzNsWJkATkmbRPbxTWHLhX12iG4OT4EgefNiIBTVVRWbfZ/x0CLphU7CBcAS5Zm75wjV6C103RUWOk0dLcPc26YCVhD/EwvBptLvIPuIunqLBJXH+AU8CI9ob0OfmWl8nEelnVJJMEgTOSzt4iJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c1C0ls2r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NGxsXIMB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c1C0ls2r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NGxsXIMB"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLZ0DR079868
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 23:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oXdEkFs+2jBbAlp34VMYxKpRmZ4A7s9s9pc8ZFfcFQM=; b=c1C0ls2rJ6H7oNea
	dYoIXwjesL5h2aMoSihGD7oBDL3G+/FU4H0OjwUDFfMUkKJQK2HpJbexUb+QHrk6
	ZsmDdI6h8XLVUcYR0PDLCFFdh57RprE+LnqaxMjjUQm/QRfGBv1bLHVxasx/XYjY
	UobEYpxjy3G8HmwDazQnArrvtm26NFDYlmm9G27XtZ0DnioZcqaBus4sMWoM6TbU
	h8QyR5TOWAwWpi3/UH5DgSMgejaozBCzOXj54Y9hPFFUAfKAc7UPvMARkXcXZ+ca
	Poj4zo7G64BcOP6MnJQzZ3+rsQ1wBLfTTT6UtgGuxi7b8kXOEsRneyvLoHJkL+Mz
	6VgWxQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqagehc08-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 23:22:09 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso3952069a12.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789514528; x=1790119328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oXdEkFs+2jBbAlp34VMYxKpRmZ4A7s9s9pc8ZFfcFQM=;
        b=NGxsXIMB1Dhj86MwuqCMlD4VIO7LQj17L4xIEIE9CjM1PGJ3pjhsaHf5cuTwk0Lxac
         koP6Tnesul0lx/Po+0csx2WWPzJbDxbn8IGZzz/yISZ2DkwF3fG2kc6vgNtXWMDgE8ns
         /GbqBP89cCAzjyQ+VclGK2TFiMX15GHe3EW0ZgmB5EHYpQffXwMa2bzewT6wSfpwb8Dv
         75on+hPF/EGQHqWYgHyIF1Swe8Un+e3/tRzOX52LFWzV+YnTQ2XFKGOsIvbQGhxrJsNc
         rtfFXO9Hg1QkPh3ilKzgxRAdzwePNHPWxHMuV5bPi6AtVkTOfvkEc1moXgapfP1mHR4z
         Znhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789514528; x=1790119328;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oXdEkFs+2jBbAlp34VMYxKpRmZ4A7s9s9pc8ZFfcFQM=;
        b=CKEP95LY3eMtcCoMH4kgN5VJ0r9YdMEGGRkIjht4dM4I3xtdiryzPCE90V2z5Z3lKJ
         ZIZkPcLKLu6/yuv/pQwz1pAJOzLc7o+YIsMWVXjzIlj4iURfKjMk2xpifcozeuyDiMfm
         XQOmMImcNenrXRR9t8dprIj+3xtmVYNEkPLGMMSI8KHH6h4MqhanNcdlPwq2gT5WgnhA
         69M8b80e99b/YE+5TmpPOtH+uWquE6xHkeqlUMaOmaMisQ1LwmU5et0n96fS/X4cYItx
         xrr2u1ezfCQkEcPrePRM0YPmoVpR8xG3gWjYwitQfslHUM3cbTlcyEbqGSxlB9o+V0Uc
         Ajiw==
X-Forwarded-Encrypted: i=1; AKwUvByxS8ioiisxJHj4SBiuMbjxdyCxXLmV4EAwdLFyHMgdddDIQS7K2qjaQH7jd1TqE94+SpD5wyhImMs=@vger.kernel.org
X-Gm-Message-State: AFuF++mMsLXIHNhThNSOkkODxHSyovQrWr6jPgb3lbuW/cK1tifM9PbC
	RjCvIyfZS0oHxs4NiRka1vH1xH9dQI+maPy4pem/Hs4aIQUQCMWyORqk/D1934jXH8daQrf2fFn
	kzEPaIF5thsdVwG3CxPXivGqCueS9V1EEGoKZENz5wAlJ+HlO1LZstPW3XSZcMbs=
X-Gm-Gg: AYBFou1PQjhUkuStc2exnYTabu/zRgXttuYL2SCDLCVLwgWciGSazt2y3UninaZQEPR
	pWHwKX/A3zNNOL5pf0UpABff8X5lJE/nWVJEBQ7+Ru3Lv9A/h4lIZXSROoy8WSdUl1bsOjvkiR1
	Rwb/qYeR4NnzTVDdYX61vXC8rBqrMGOFo/5xqlsL9pVpkzyfAsmaSCQRKs+Nw8FGzqPZLVXrP60
	Z3kKy2I8rPN06iHXpVcAIiSw6RW04QPwXAkc2utjWA/mV4QtgMp5rNQP8KU8fJdUxuZmF5o7Cuk
	6dqo3yHCXdnwlLXqyoek4CzEfMtabOq+qPLwiuHZQp5MEyL/ZJw1giOYgJSSJeOom2HN7uVmH09
	NghNpPqcvXc/L8YQkWEoxv3MBQAs=
X-Received: by 2002:a05:6a21:9090:b0:3d0:e034:a26f with SMTP id adf61e73a8af0-3dd5f5d8672mr1167663637.17.1789514528282;
        Tue, 15 Sep 2026 16:22:08 -0700 (PDT)
X-Received: by 2002:a05:6a21:9090:b0:3d0:e034:a26f with SMTP id adf61e73a8af0-3dd5f5d8672mr1167615637.17.1789514527903;
        Tue, 15 Sep 2026 16:22:07 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b0520asm2203060eec.27.2026.09.15.16.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 16:22:07 -0700 (PDT)
Date: Tue, 15 Sep 2026 16:22:04 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
        <kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
        <baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jpb@kernel.org>,
        "Eric
 Auger" <eric.auger@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <skaestle@nvidia.com>, <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>,
        <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v5 10/15] iommu/arm-smmu-v3: Support PRI Page Request in
 arm_smmu_handle_ppr()
Message-ID: <20260915162204.000054b9@oss.qualcomm.com>
In-Reply-To: <dd1ee0afb947b5f7c229c21b7fcff5d18f9bc326.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
	<dd1ee0afb947b5f7c229c21b7fcff5d18f9bc326.1789446520.git.nicolinc@nvidia.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDM0MSBTYWx0ZWRfX0zOub/BD1F5M
 CHgHqjPYBq7rIh7kTQFnlJEAOAxr6tjJl1sHY/3Z+V9iKZWfSja3qwXhUg+ARgCPi5H2C1IP8r5
 taRaloVBvUq/ftZVD7uqwg/Le4paBPQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDM0MSBTYWx0ZWRfX7N7b0Qt8hjEG
 vXKQm21LtyboaPO10KUVJidR3cbcvnZYjlGceV/cgzWQlPspfZDzHmOhU5GXF8PEWoWfWZ2FBCT
 mhn5dCGaFiRbeDD1VyuLsaOr+XPZvNluroDI5uoZYRY9MW/cl/z+3snY+UR8RjUzc3j+vU4Pd/l
 k588orPjlE7VXAa+rC/MI/xFEdA6BvHOfn10LojI5UTuwkMYqsZLNuYowZdBklsnZX1avk7q07S
 +/BjpDwphZGOyEkZ/mkkDIKA9PSzWrnX2kH6Nt0aSsQRvC65ro24Tb6LTjLPcohvumGuOziw20t
 ZZm9ENtxsSmDuIILo582VehjXdosoKnATGfcjtCa4GxQMRc4KMHSoLIGYYMy4MbgoVxLJS1s9Q0
 nS5wNRApNzya+FB9RQBkbx0iT2VqBP2NpmI5ZRDNEd5HhMOlRkeVXS2qHeYa1oDdwsVONcGZ47y
 TvwEzHGdzn6y2ToqQTA==
X-Proofpoint-GUID: PDpAh_kfE5S_KpKtJXBqLssH0RTlsfB4
X-Proofpoint-ORIG-GUID: PDpAh_kfE5S_KpKtJXBqLssH0RTlsfB4
X-Authority-Analysis: v=2.4 cv=PcZqFShd c=1 sm=1 tr=0 ts=6aa9d321 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=h35TsNJSbmzmzvWWgmEA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150341

On Tue, 15 Sep 2026 09:38:22 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> For a PRI-enabled master, convert every PRIQ entry into an iopf_fault and
> report it through iommu_report_device_fault().
> 
> For an unknown StreamID or a master without PRI enabled, keep the existing
> LAST-page DENY path. Merge its two messages into one ratelimited line so a
> faulty device cannot flood the kernel log.
> 
> Discard any PASID Stop Marker (LRW = 0b100) prior to the fault report and
> the DENY fallback both, because a Stop Marker does not expect a response.
> The IOPF infrastructure requires the driver to discard it, as per the doc
> at iommu_report_device_fault(). This also matches the intel-iommu code.
> 
> When SSV is clear, the same LRW encoding is a PRI Page Request that expects
> a response, so let it fall through.
> 
> Note that master->pri_enabled will only be set by a later change, once all
> the PRI paths are ready.
> 
> Co-developed-by: Barak Biber <bbiber@nvidia.com>
> Signed-off-by: Barak Biber <bbiber@nvidia.com>
> Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
