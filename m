Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054CB14BF92;
	Fri, 11 Sep 2026 00:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085669; cv=none; b=px04wGbARBGJJgRYMINHPazd8JMrnm0FGVhc0qVajRq19aX3I0s4Dt+qZzadS5AW0AdWl66aISeMTo55jps///PnarCs0rLYh74GJDeAEwYTFmy0epl0suSl7RvfPf7hy/nLq3l39l2PbbSn53GiU3t7EOrd2v76UljbNDHe6yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085669; c=relaxed/simple;
	bh=+t/syTYEzLWUjcuaQdxqawBBW8k2hFhZbEocqa1Cmrg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=cEjhyg7Pd99LVbmpWkupdwGexzYOXMJzVu0M6zlMMQUA9Vu4/vaIvTi1UIk+hWV0z3PrJdpJWVfjxDdx5cFWnEN1rbefpWm0z0XG0wXBPU8X5QKq6r78f3v8DubeWFKU8eTLcN31Qkaq+H6EvwPedOFjMWMauFzOhfxc/Xcg5jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aD3rI2mN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aD3rI2mN"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ALULN8973405;
	Fri, 11 Sep 2026 00:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P/grFDF/E0YgDVEuey0dP1cPJx+sI2Xli3pWuRteO6Q=; b=aD3rI2mNmSZc5SXr
	mbR1rG+fi+dTN5Aa0S1Q5NnO8yWWbFWVf9LiBd5bpUjp/kIWzfOW8jo3+d1sbC+y
	BgkM7Vl5761+Tyj2oAi4WSbpKEHH5azd5OmCqrTdn3NeOnRNHtzwGlrEMRbBXZ5E
	oMagj34TKMjkDRx0Vler/aTHSIGHxSv+NflYaX66vUJeMBGg390szzr4Is9mxDgU
	ZHOhHmamFdvM9y32ga7kzM5RKATLe5hDlyRdMu3N+e3A6Qk+/JXAmMmk4xq5Fzna
	xLtfBmF1q/eKphnaIyf7qJHS1nKbwm7+FlkT/6SR8WYDfNAOvfKPILGCRBrNh/GS
	Mc86vw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gksh8ur47-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 00:14:09 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68B0E9WX2625512;
	Fri, 11 Sep 2026 00:14:09 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 68B0E84K2625417
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 00:14:08 +0000 (GMT)
Received: from hu-jcameron-lv.qualcomm.com (localhost [127.0.0.1])
	by hu-devc-lv-u24-a.qualcomm.com (Postfix) with ESMTP id 3456F24D76;
	Thu, 10 Sep 2026 17:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 15/15] iommu/arm-smmu-v3: Enable PRI for PCI device
 in arm_smmu_probe_device()
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
In-Reply-To: <7bab940a52ba306f7199108987fbcc165db92c81.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <7bab940a52ba306f7199108987fbcc165db92c81.1789081084.git.nicolinc@nvidia.com>
Date: Thu, 10 Sep 2026 17:14:05 -0700
Message-Id: <178908564508.2841562.1611618783813647686.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: ueBoQK1VcF9bVtKYhy1IR4Z6hi2Ioaog
X-Proofpoint-ORIG-GUID: ueBoQK1VcF9bVtKYhy1IR4Z6hi2Ioaog
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDAwMSBTYWx0ZWRfX2/MUlciSEo3s
 8Ca6reAKyGHGpfMLwH5IWYK36mmXj3sRbSnc2XJHzsLkFYxHZqgBC8hErLWh0d950fwUQ4Mj6WH
 g+OG3NoCkDr9Bl9APqjeukUzi5y5j2HZBX2yHbTUGCtArEVQzOb3Q4EhjR3aNxeXENHXOXlb2N7
 VYLAWq4XCDspp74u4gf8XKztk6iiVOf4MtjtjVxvtH4fWyqI2h86QaiAJrd3l1kiOZqtAP+RO0x
 jZM7/BUAFZ/0P7twDYtqDzmNX7GRxu39nfj4wQqDK2rBbdCdS/q9O3DTzGPoNCeCseVgLH7zOUd
 PP6bZpswJTU9Pn8TngnJUb+1urIZJoXnJTKUEHE5hhcYYXcqsrFNxKmzbPmW/lrfOQhYCvCOnuV
 ylO7+ZIFgQxQbPEnj1zvOsp8G1aoCgQOlzWRRGKTfWyC5jol2el30vuzEPFqWuCxG/YcnAXGzBv
 ISYrYlFfS2QLQ+H/rUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDAwMSBTYWx0ZWRfXw1qZ21/rpbAk
 KoXqeXB9Xl4QWSNvK/k+izJ4UAHokz/CYWzCZH09fRJTXHHjshl/s685ywvAA93iesqpA98BeBR
 q6QOslcz45Vs6VZ6cWNTSnm+cH2o1ZU=
X-Authority-Analysis: v=2.4 cv=a56lZkSF c=1 sm=1 tr=0 ts=6aa347d1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=Ikd4Dj_1AAAA:8
 a=EUspDBNiAAAA:8 a=FIfcXtglR4HY9Oc7seAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1011
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110001

> PRI handling is now ready. Enable PRI when probing a PCI device, and drain
> the PRIQ with the EVTQ when an IOPF-enabled attachment ends. Queued fault
> work may still refer to the old domain when the detach call returns.
> 
> Note that PRI is enabled at the probe time, while ATS gets toggled by the
> attach/detach routines, so a master could have PRI enabled when its ATS is
> disabled. PCIe (Base 6.3, Table 10-14) sets no ATS precondition on the PRI
> Enable bit. Its only ordering rule is that the interface must have gotten
> successfully Stopped prior to an enabling, which pci_enable_pri() already
> checks using PCI_PRI_STATUS_STOPPED. Also, a PRI-enabled device would not
> issue a page request until it starts to use ATS.
> 
> Set the per-device outstanding request budget to the full priq depth, same
> as intel-iommu's per-device PRQ_DEPTH choice. A fixed per-device cap won't
> prevent multiple PRI-capable devices from potentially exceeding the priq's
> capacity; priq overflow is recoverable per the SMMUv3 spec, and it is rare
> in practice.
I'm faintly amused to see in the ARM spec
"Note. The PRI queue does not overflow with correct software usage and
 endpoint credit management ..."

Ah well.

> 
> Select PCI_PRI in Kconfig like other IOMMUs, gated on PCI so the build can
> stay clean for non-PCI ARM SMMUv3 configurations.
> 
> A stalling master resolves its faults synchronously, so it has no reason at
> all to issue a page request. Refuse to enable PRI on such a master, so that
> page_response() can keep dispatching on the master state unambiguously.
> 
> Refuse to enable PRI as well on any master reporting num_streams != 1, as
> arm_smmu_enable_iopf() rejects multi-stream masters, so IOPF cannot be set
> up for them; keeping PRI enabled would let a PRI request arrive on an alias
> StreamID and get a PRI_RESP_DENY issued against streams[0] by the driver's
> error-response path.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
