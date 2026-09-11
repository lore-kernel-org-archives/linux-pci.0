Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F1C1C8604;
	Fri, 11 Sep 2026 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085673; cv=none; b=TqXdF654ImHgrRn04hgl1jZ5HrOb6TyO9wyXMpEfWqzPvz5WZmYwsPXDe4nPd3DhIc+slU3Wp7iuX+4usiQLYHQyBYifbdwh45Y5Vd7yEKZHAOyvisHqvr/BnVB4ml/JKDdINsurKMIkhNgPl0+9V2OoiFYfpjnpEDz/ZgWuyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085673; c=relaxed/simple;
	bh=TH42WDxjltlUxAA/cvvEHv2SwHhIvCsGR90SP2I7vv4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=OIsSofSJJKxJptJWoOEY2gZYqKMBK3/brewwlXa5rnV15PAT9gFSOA2EpU1f6GLgu7o0keg6qihdTVJJlyP5HOKd/7AayrFsM0iRqGOBAgL4cDEdvkyqmQTMqu1yX3e1mUNXD/3scD3W6FzXifazLLmHlgHfNCCvcQBOjEJq5+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BpLOR2wT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BpLOR2wT"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ALVEFY2353510;
	Fri, 11 Sep 2026 00:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jg/8xg4bow1aEyJmcVDTXTgB+iZzab8k0/5aOKqs2t4=; b=BpLOR2wT570l83jg
	CEtuIPHZKumFh3BsTToaTZiJzts6Npsj8c7fgDGuLc5vbKvUVKf0bCpqhXzp3cyz
	c96tHErIS9siZaIH2ef5RKj5MUhD76jkJrCL6C8l4X14zmiXSMfqUXpwfc/U77w5
	G2Q34C+XH7uObgHnSmtVLAfFPheyDkNiCgxjUEaOJrd0ZNfkFybCMqjfDF0L1QNS
	2U3anRsF+EcXBOjt7TWBmn5wREXhrGNwnmYaaZYvdNBRNKEcAlzBQWjdaoaPx96i
	5dNB7St4bwZ2hM/ixJfGykPkus9ilFKV4wHkgw57IO82yB5ur/eIBm9alXZ+s/fx
	OGpTMQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwx9tn69-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 00:14:09 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68B0E8922725886;
	Fri, 11 Sep 2026 00:14:08 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 68B0E8rj2725855
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 00:14:08 +0000 (GMT)
Received: from hu-jcameron-lv.qualcomm.com (localhost [127.0.0.1])
	by hu-devc-lv-u24-a.qualcomm.com (Postfix) with ESMTP id 2DFD324CC7;
	Thu, 10 Sep 2026 17:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 04/15] iommu/arm-smmu-v3: Drain in-flight fault
 events on domain detach
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
In-Reply-To: <e98a3f1b8964c9f4785ec6dd6c001b7aba4f1cdd.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <e98a3f1b8964c9f4785ec6dd6c001b7aba4f1cdd.1789081084.git.nicolinc@nvidia.com>
Date: Thu, 10 Sep 2026 17:14:05 -0700
Message-Id: <178908564506.2841562.11593770023237754382.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDAwMSBTYWx0ZWRfXyw+XbBozRF4N
 +ngZfSfrgrsOn3x9ZuV3LHd7UVpCwTMK6sTl4LmDTdw+2i1+aO63lkLe+onALMPdA5+C0r9LNu+
 sYtqO2N/eYILpbM7ToDBRJLB4XXemVFnDzd0GWtBl2VeIMiob5FgLGKyzRSziCSAw3Zpzsjhqq0
 E/miEyZS/HvEUgSKEy+G8zzyRqo+AQ3g3YvZg8zaphUqKPGycvybmGwXl2P0F07J/oh0ad0AXl4
 wWBtgmI/+ie4k/ft1nNwkbVHmnBVzXtq1In7voaq4yzmvqij4zmdIB/MF8bWPsM5IsgOH58inlB
 6IMtWgNioPdGk8ZJVddh8MK4q+YKfwypt5WD6/mjSzFND8dFY55j24+TK3KiBKSl/O0P5+I6sKl
 5nDbkVWf/WcKihoB+Q5WgiVCcFUsNwlSW39sdEAdXi0z76Rs1NkDxLx6JIfESQPxYoRKyKM+0Uo
 KzA7ekCdItWp1G/WwFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDAwMSBTYWx0ZWRfX/p6BCHe12hwc
 TDcqiX0XGJM2HfWjsZl3GhbYqtuGrw57wxY6ALLYDhL09zedDPulZIjcaStOp1ASqWGwWWCHcc0
 4ea40pffnikfOkG5iSrOMXQA9CRCyWw=
X-Proofpoint-GUID: KaW3cK03BJqR0WKHCItXk2mJE6X9v1ZM
X-Authority-Analysis: v=2.4 cv=TupzFzXh c=1 sm=1 tr=0 ts=6aa347d1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=J2RtMCibTQM2n6bBHuMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KaW3cK03BJqR0WKHCItXk2mJE6X9v1ZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110001

> When a device leaves a domain, fault events for the old domain may remain
> in the SMMU event queue or the IOPF workqueue. If the IOMMU core frees that
> domain before those events are handled, the work may use freed memory.
> 
> Start with the hardware queue by using arm_smmu_wait_for_queue_drained() to
> count entries consumed by the threaded IRQ handler, and poll the EVTQ when
> an IOPF-enabled attachment ends. This prevents a pending IRQ from queuing
> old-domain work after the drain. Its until_empty mode can drain the CMDQ as
> well during suspend and runtime PM.
> 
> queue_poll() cannot be used because it is an atomic busy-wait that expects
> hardware to consume entries. The EVTQ and PRIQ are drained by threaded IRQ
> handlers, so a busy-wait could starve a handler sharing the same CPU on a
> non-preemptible kernel. The new helper sleeps, and might_sleep() catches an
> atomic-context caller even when the queue is already empty.
> 
> Note that a drained event is dequeued, but not necessarily handled, since
> queue_remove_raw() moves the MMIO CONS before the threaded IRQ handler gets
> to push the event onto the IOPF workqueue. A subsequent change will invoke
> synchronize_irq() and iopf_queue_flush_dev() to close that gap, and it will
> act on the errno of a timed-out drain too.
> 
> Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
> Cc: stable@vger.kernel.org # v6.16
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Nice - I always like patches with diagrams ;)

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
