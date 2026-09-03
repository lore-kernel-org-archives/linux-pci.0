Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2624F55CF;
	Thu,  3 Sep 2026 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463156; cv=none; b=f0QVH2ecN3KmUKvKdYE6NOIvQeYb1ru0JDP6/fulX3K6NFKRd4gnWuE2Ycm+Pbk2DHJtgwLze1JsJXoa0K4efyxbat3aoViIa/Yu1ZsP8qktAfkhyfgv6qv7UF+7Ra0BtX3VZ7LUXIWtmWe7nB/8xYpMmE1gQkjsvUP4XQwnlls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463156; c=relaxed/simple;
	bh=hWu1TmsOZXA6FGXM8uploJNTlP9t1J7UILKFBRuT74k=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=R3StKjzeX5wknj+eFKZ6kSTQ/WkpLLInpS6dgu88uEU69sKMZ+3ysLrfkNilzKGkD2I0+jZjgKoh1JdezSey8gJMFBZ7ix1U/2Kq9U1+gRs6pphvzp0OMOi3skfgNwlFkHdnj3zTZm+2/FN5nI8yN8uvX2IXeY3wl3Ef7qpVGOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D+Haq3ar; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D+Haq3ar"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G3FXR417591;
	Thu, 3 Sep 2026 19:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VktLdWvJiYSHU5/AMrDEoquXU3fviXjuJMSKa1znH8I=; b=D+Haq3ar5gd9BrPv
	OmdY2Uyg5EeoGeeoCCEKrlRoP34MhbcgGuOG+plg7ffv+pobXdFA0vqW4Dn04rtH
	G74pwWKbg/3Scg1ZUQBXf1oDKZlsUz+DYpisvbd9V3Mx375PXzcHtPPxnlajqa9e
	j4wiV3JQjiDx1aCYj8yP5Dtuyu/aB8hO4GK1OagsQ2PybLGdTUSw1fdOzLJJIJQy
	S56b/4EnDKwogrACKVdoZQN6B0J4t+UA2Qfj+wvJvv8UeFkWyHMttBcwEDBzhn+3
	dnfrmoZPIRtURYb5ZaMOQLPIeGMLY9ug9k9pl9z9yheZxphWhJ7PmefKnYwmEdF3
	vlAztg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf51m31a1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:36 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 683JIatY3208973;
	Thu, 3 Sep 2026 19:18:36 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 683JIZNA3208954
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:36 +0000 (GMT)
Received: from hu-jcameron-lv.qualcomm.com (localhost [127.0.0.1])
	by hu-devc-lv-u24-a.qualcomm.com (Postfix) with ESMTP id 7163E24DC8;
	Thu,  3 Sep 2026 12:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 11/13] PCI/ATS: Add PRI stubs
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
        bhelgaas@google.com, praan@google.com, kevin.tian@intel.com,
        kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
        bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <f7c924266e6f8d74de4508c812d0e49036fda53a.1788222486.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <f7c924266e6f8d74de4508c812d0e49036fda53a.1788222486.git.nicolinc@nvidia.com>
Date: Thu, 03 Sep 2026 12:18:33 -0700
Message-Id: <178846311319.1308030.16052628703269367709.b4-review@b4>
X-Mailer: b4 0.16.0
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: uP7B1osMXdLjrJeg-418h_Y7vu6SKDt_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfXww+lMLNnQNT3
 GlKgbjIPmVAm7OioOFD7KSci6Iqm1OoLsbPpBVrnvWPztBC92jF4A9+WLD7fj9uEfP8ZwAYqyHq
 Cm+SwJ3YovmQq9bze57oJlGtY5vUfJlJxQkm+MIQXXBLlHWsfX5yN7Y9yE1L/WONrEld39Jx4/j
 RcOATqAZgwjRjijb6HFtJ84nuEYQAWOwy4sUSf2fZpjd3lYHtRAmqDKyIJk7/o/dAnQFJb5j0/i
 xMvm1LGyQ9KX6FRzI+cXXxPYn4lnglb0soisegR4fbMON7K1ggz0LN9i7t3CrwoYsq3MWfx2Aup
 9lEKBbgEK8VPGRibhPyvVekEQx/j3zpP+Qqcf0BOyeovbjb6DSoRFjlAFfxL6zTbHALGzZYB1Hn
 9K3V/DuFukJYlqVUM4hQp5S0+GxG62ENThYvsMZ2VcDDib7TopateStN3SqbdLl01yBrit//w7Y
 9aJmkxwJ58WBL8BriRQ==
X-Authority-Analysis: v=2.4 cv=X8Ji7mTe c=1 sm=1 tr=0 ts=6a99c80c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8 a=QyXUC8HyAAAA:8 a=Ikd4Dj_1AAAA:8
 a=EUspDBNiAAAA:8 a=mYKCapFDX9Uc1BMOXFAA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfX2f1KzRajk/Sc
 rDWbsJWkdB81Hl6YaReHlfk8gnK7yCVIiq3jj/AG7qDrICV3PzmNIZzaNzHWV5HFNASSoKbzYB1
 KN2inD87eZSKOrnQIptYl9CCm51buo8=
X-Proofpoint-ORIG-GUID: uP7B1osMXdLjrJeg-418h_Y7vu6SKDt_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030168

> The SMMUv3 driver, which may be built without CONFIG_PCI, will shortly gain
> PRI support. Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove unused
> PRI and PASID stubs") to re-introduce the PRI stubs, avoiding more #ifdefs
> in the SMMU driver.
> 
> Link: https://lore.kernel.org/iommu/20201112125519.3987595-8-jean-philippe@linaro.org/
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> [nicolinc: drop stale APIs]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
