Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A022882AB;
	Fri, 11 Sep 2026 00:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085685; cv=none; b=dpw/jrAI3IbyIXwkmnF+GT/0oCg6eVgQjwDU7ebzcClntRSkDMiClRMtf8S7XRGjqJ63sVAh2xkLL1jiLLCpeIVRk99rWmRB6bAoTUmB2r0xrXHXIa2gTJRgg5yUavwgQ+o7LYRwqFovErA5mVen1UoswYCaslMjnuEVg2P1h9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085685; c=relaxed/simple;
	bh=Wez9TJVGvPJLIHHWiNfgCS6Y0XYbnBogf9zm9CDJBHY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=svgJTxA0jsrai6F4XQYYfSGJTTb0wgIk+qDj0defyncFpjDd7bRtbJEfBHdc8WjEAMSU01AyLqZSNpc9yTSXomhUWclLQfaZG2UZwSaNQ6RM/RLgxYcZu3gsFgJ2gCNGZggcecIf9zup2U5O0Se7ceHGsGQNLUSFhuAQuNH4/qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E2YCs76l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E2YCs76l"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ALTZe42708523;
	Fri, 11 Sep 2026 00:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2DK0pXF6/Y8LC4WrV1vhM7upcWFGOf5Niup5GD7tkI8=; b=E2YCs76labSauafr
	+f03OPvUkAaxs80K32WrOfMNMWvbLOcKjKaGCAqm9w3Y6SgwRBHFYqhpnlpzlrGH
	lxvJfgrzNAVEVpp0PhPtB7yIjMFKbaX6bPBVEyjBviY7mclHQ0/K5HCF5R5fEqjG
	k79sMnuncL4K0WNuxAml7mNxyl4z/y09vhUd34/3PFZvBB0PU0854QyrNK1NwkaZ
	c1o+vdVI2xo/+pUdtUobYijuFIkdeZq7sYfBftayHWNfdx8MCpXsN106WyPmnTtf
	osRuFV5m8cSLQJ69HpDXyX9F0CJYJ2vKtXo8SKZW65lgbCvT/HuzA6iB8dbvIQxV
	jUPJWw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm2q10u90-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 00:14:09 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68B0E8Kj2666594;
	Fri, 11 Sep 2026 00:14:08 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 68B0E8wu2666473
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 00:14:08 +0000 (GMT)
Received: from hu-jcameron-lv.qualcomm.com (localhost [127.0.0.1])
	by hu-devc-lv-u24-a.qualcomm.com (Postfix) with ESMTP id 2FA3224CC8;
	Thu, 10 Sep 2026 17:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 05/15] iommu/arm-smmu-v3: Flush in-flight fault work
 on domain detach
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, joro@8bytes.org,
        bhelgaas@google.com, praan@google.com, kevin.tian@intel.com,
        kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com,
        Jean-Philippe Brucker <jpb@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
        bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <848cb4c8a79da1f434966d998be0f4ebddf80fb7.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <848cb4c8a79da1f434966d998be0f4ebddf80fb7.1789081084.git.nicolinc@nvidia.com>
Date: Thu, 10 Sep 2026 17:14:05 -0700
Message-Id: <178908564506.2841562.9173958055564925207.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=d6lgWhjE c=1 sm=1 tr=0 ts=6aa347d1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=E4FLetviulidzL-PY1oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDAwMSBTYWx0ZWRfX/tlbHGCQuzGH
 hoPqAF3VTflM3YKMDeQD8TYxi6hC7Z6R6TBUoOT0OOCKZ1MuFTe87DJakGxVSn+xeUPY/IiVlja
 Ijl/tsm2Wk9kGsM6bHzjihfrZv6ofrLyQzpum5WQY4u9/lfuCi2QK6jvuoTY7c+JFBokKqeg8Zu
 dKC1uq3OO/N7ZJJOXb+fujN7tJ986boY0lPATfKWsXsh3k//8I3ETiwRKpSNzDfyp/D9NVlk8Fg
 pgQcbBQAMSTY2Swp+nIa3SikyOTIE49AAuZsY6+/3/gdGqunD9oyX4RM3n27TBm4v/Iz6vCgG92
 f6fbhONGwt7i4LVepE9iUPfmiDS34p0v9lrPPn/vwtA8R5KCwGIHUv2VqI2k5u8ZZRy9sje7EA8
 ELHjlu8nH3geVLfXbJLsfw0DHsnuk5meui1hCLb4lejyN69mLISKdbgcc+FxoUMY4lGIdUp+Y57
 kiyawDsFbfJno2ElKCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDAwMSBTYWx0ZWRfX/vXk86l8Ej8e
 DfFbSPhzZ/f0oW08596FQLzyfCq+8j1aV4HGPyu8ZJxVjqvmdjBLi55SeRVuAC686sFWPKd3xwU
 rd3yBo8taoFScvaNWsZfZ0YTpDun+9g=
X-Proofpoint-GUID: uVTsGRIfBEZVHFJXrNIk7yIEHMo8gkoS
X-Proofpoint-ORIG-GUID: uVTsGRIfBEZVHFJXrNIk7yIEHMo8gkoS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110001

> After the hardware queue is drained, an event may still be moving from the
> IRQ thread to the IOPF workqueue, while earlier IOPF work is still running.
> 
> Synchronize the EVTQ and combined IRQs, then call iopf_queue_flush_dev().
> This finishes all old-domain work before the IOMMU core frees the domain.
> Skip synchronize_irq() after a drain timeout because a stuck consumer can
> otherwise leave it waiting forever.
> 
> If arm_smmu_wait_for_queue_drained() times out, fault work may still be in
> flight, and iopf_queue_remove_device() would free iopf groups that the work
> also references. Skip the iopf teardown and leak the master_domain, rather
> than risk a use-after-free.
> 
> The skip also leaks the iopf refcount, keeping the device enrolled on the
> IOPF queue, which would strand its fault parameter on the queue list once
> the device teardown frees dev->iommu, crashing a later iopf_queue_free().
> Reclaim the enrollment in arm_smmu_release_device(), where all the attach
> handles are gone so a straggler report cannot queue a new fault group.
> 
> Note that a residual race window remains between an iopf_queue_flush_dev()
> and iopf_queue_remove_device(): a fault arriving in between still resolves
> to the old attach handle, as the IOMMU core publishes a handle change only
> after the driver ops return. This window predates the drain narrowing it,
> and is only closable by an ordering fix in the IOMMU core. Furthermore, a
> timed-out drain shares exactly the same window, given that it must keep the
> device enrolled on the IOPF queue, where iopf_queue_remove_device() would
> free the iopf groups that any in-flight fault work still references.
> 
> Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
> Cc: stable@vger.kernel.org # v6.16
> Co-developed-by: Barak Biber <bbiber@nvidia.com>
> Signed-off-by: Barak Biber <bbiber@nvidia.com>
> Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
