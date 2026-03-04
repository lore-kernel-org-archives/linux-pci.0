Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404738C2C8
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668622; cv=none; b=CWFHwDRU0ZJaPBeuf7mp4V3wh058P2K8RFkzi4B4eA/GHRYWFVbEUw6hLXn3pbniCPrnZZjndKKXw24kIq4yUuE3TPxnKCeGb4VPHUGRXF7Z604PRlxYOspcmFYImchG0JK4YlSZ3PQbvUu0wcWuBnbXrWn33oUuW5YjJIPf1QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668622; c=relaxed/simple;
	bh=Q0RmGTaWyrNXkoqSRC4NOGoeVMXVms2krIlt4cMtsHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLR6ObABLiDLlR/dNz7aKkiQ4cMZDnqonp1UrJIdmnYd8LVo3+QQNV8xS/V0/AlsMoSQUH9sL4qTS/S3P6UB5F1AwO/HFh0LghcVXIX03JsLhVhRJG9k9/mOHmzZOkhpG+7NBP16+gYHuSTbZMhot0SXyF5NlyP6olG7O3aH47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M3gyhoDK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gR1vjbCK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M3gyhoDK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gR1vjbCK"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624J4bdH2275085
	for <linux-pci@vger.kernel.org>; Wed, 4 Mar 2026 23:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=La/zyW1kZlkdjuba28Y6cKUE
	jgLjT1PdHqsncSoONxI=; b=M3gyhoDKsD95tRqPBt6AVRtUJ8xAewA9091Llh/v
	3N7WGAoRQBPzVIJQ+qMMIDlNc/bfennDxIAH2TEssBH789bj2CFI/9WHiWumbLtX
	Ql5cWWDkmHK/HrduZFYdFIBCxQbuZCUwt9VpsjOneOKdaQDvPYtLjUV+u71lyXmG
	dmxjU+qXynuSopTYtoQMCaamDnBl8AhwF8OiwiX39d0m+NMjaFXCFWCfbfdsFV2h
	o+l1R38GMJrzXlm7o2GPUvHPn1156OUgdepeJ2YZzwgJPRbOnHzpNxoiQgsN2xDS
	DJcDnZ8howbsvkbWgknRmV8ZQ+d0VG8z+7CPjjKVm1P8FQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpc4muqh0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 23:56:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb4817f3c8so3965280885a.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 15:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772668618; x=1773273418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=La/zyW1kZlkdjuba28Y6cKUEjgLjT1PdHqsncSoONxI=;
        b=gR1vjbCKyyJ3o6dh/LzYtaTxAoe5c/LIKUCblHAON8BYJvNITHkv8oFo/DbiCRUIAO
         Q33H5pvJQ+hJNSyk+JOjoxonBKp56j/eStzc/dlR4xsCa0GWNOgznsm3tOdIopw1Hf98
         jjrnjeVnwm8drXGmiiD5Mkq05MjXvfm1Qnz7GbN9NVyLa9c7OHa9JLKTppRFHXd6eUBD
         BQrdctaQEDOu6udxmmKZcxQx46ouzDeA+QLx6D24K7tad9YN1b0WbcJFEOu2+Koi+bS7
         WTgpDbqdDklDlpFeHqq6sgAIrQ1uahog1mPwNTb6PJFKLBjNLMzIMCOHCGtSSJGCpPEe
         OGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772668618; x=1773273418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=La/zyW1kZlkdjuba28Y6cKUEjgLjT1PdHqsncSoONxI=;
        b=Tws/TQVfWJ/edXmRjXNqCNKo7uHQgGTybD/zwYNKkfywkKyhvgPnZdw2ONVnDZ/Tj6
         XGx4s6u9GXulcOL7n4mPRC8hp3nFI5Rj/DwVHApp6bHXvhKedkpaUFLtWFMgm0f0O5tZ
         C+J4T2uyePbDqQ2Edxp6DaUqwtVdkfdpIFDErrIpQN9LBve8Kvkplhvi0cG2kXKvGd6F
         MStXjTAVkFoc/Xlp3VlP8hw3FEhjtAcEGuRPNfpPipOzRSJS1I3grzlVdU2VixeV3lsi
         AIqQC0BfEi1zqbgEYXlOBXMic2Aqc5VKYedAouY6oBBxRagXyEPBbjFP3vb4zk3DAzAJ
         MQ0A==
X-Forwarded-Encrypted: i=1; AJvYcCUyADv9mJFOvqVGwkhDq8sgIvQYn98MsojGKjPDfup0fxLnSRIZI4YloOnovjXJRkXur2SUjzFLIzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrswO0nYpfGr3eLgs3YHvmbw8Wucm8usTmKf5WXViwDyG6mnrO
	qxeTQZr5NVyvVLdmmgahf3UM0+AtSuNF7MrVCjFvqFAAzQEVvCFSIC3kuX6PHiCBmUfZ9dkbauN
	DsVPm/00D5g/0NJNVKcmgkgRRCD1f5cTTH3FIaVe3ueGzO1Nx2YhzYoQZNWxkD3w=
X-Gm-Gg: ATEYQzwKvb85e9BwVFiR/covfuh+1BLRHD1FBKaR4AebJI9cYOLqtNwqxHatP+kTH9W
	1aa3cn2eift9hfhi2rjhSaYAGvKRz8H5YhZ20TFNIcAuLQQuDy773i3mwgEcmf/Ihd8dI1V8gc+
	h0fD2C7KaCLSVl/+skA1HLKrZJ19EC4ZNnArGjl35HfpHneahV94mYmGjJQ3qi9KPLtKp28uFR+
	P5jsGokbH2C/Woxs7/oQ2nH4YeGhmCnpLjVRyVY5R6TtNvXA/N223eCB3qsHu1GKfssnbkjIPn4
	fzAT/1mJhNzGiJp3k+pJ6P7JdJ5xxLxjwAayXmxMjVsd322CRSYY21RXIxG0WIK3tJ3OwcSriBq
	zELCoFU7FkbxI16scGcPf79LwwbcpjLYJdbpHatn/t0vdkVsqgNLd3bi1i3Dh0y//Rd8LEfeL3i
	iIcTcMhnKBO2MPe45WGUEuS6N49U5fQWOtnWs=
X-Received: by 2002:a05:620a:44c2:b0:8c6:770c:40d8 with SMTP id af79cd13be357-8cd5af775e5mr481318985a.40.1772668618475;
        Wed, 04 Mar 2026 15:56:58 -0800 (PST)
X-Received: by 2002:a05:620a:44c2:b0:8c6:770c:40d8 with SMTP id af79cd13be357-8cd5af775e5mr481314985a.40.1772668617932;
        Wed, 04 Mar 2026 15:56:57 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a123573df2sm1571493e87.65.2026.03.04.15.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:56:56 -0800 (PST)
Date: Thu, 5 Mar 2026 01:56:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH phy-next 21/22] phy: remove temporary provider
 compatibility from consumer header
Message-ID: <o3yvtltydr5hvve2htwgqbp4bfopgu74ft4gnyelmges3hmiaa@wy3brdd5dnek>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-22-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304175735.2660419-22-vladimir.oltean@nxp.com>
X-Proofpoint-ORIG-GUID: dwOqlLIS9O3m4RwcUdx4Z7qGtOoewSvf
X-Proofpoint-GUID: dwOqlLIS9O3m4RwcUdx4Z7qGtOoewSvf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE5OCBTYWx0ZWRfX/21iZoYxv10Y
 dOEH0eQpuveUhSuVZFCUaO0LTMcpk0dobHo04mvHwk11uFXG9BerUJnJ5uFjveC5x7ikgFx8zU0
 duuVvs2gHBXcP/wgm7Vtajcy7BzXgi2BByzAamQ09chJWHBSWNj0DUuA3TpSvXKjFscHG2fQqEG
 RIDfbLTw3OWMuI7gfeika8V3f3cAqEGAFwr5wQhSeyggTHMVPQ0ikjpA2uI6yZtwpsuJJ74eeVA
 a/qamXIbEYsblyIuqsVV1nxagcSLSpbyKfvt8lw9EHVbHxZDsXYIkQDAyfxb4ea5lxV99D298Py
 EPV3FtbRYQ7+zEed3CMoI4htqvzF0aMvHfUaqljqO0xxo2jJzwR9Gexwa2MAqQyhvQCCPQV/tDq
 V7CrfBUJiYJRafR7eiwUwmZlH2mcD+qmZeM1/gVNJKN3Of9WaZIS0f4xprFP9H3c9aTbhy2EJom
 FLTVmxXmSI+7nOJ8jTw==
X-Authority-Analysis: v=2.4 cv=C67kCAP+ c=1 sm=1 tr=0 ts=69a8c6cb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=8AirrxEcAAAA:8
 a=EUspDBNiAAAA:8 a=Ji6k5uvf-STsHdHMmocA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_09,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040198

On Wed, Mar 04, 2026 at 07:57:34PM +0200, Vladimir Oltean wrote:
> Now that all consumers have been updated to no longer dereference fields
> inside struct phy, we can hide its definition altogether from public view.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  include/linux/phy/phy.h | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry
