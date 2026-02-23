Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E079309F00
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862509; cv=none; b=u80YtaSWRyyUf3pfZeePmx66NdPKvr6ftEg1DSsC77oAeRdo7Vx/Uj6wu6sOTUWgW/rc87QacOwdjxFzCH1Z0w39XlsYiyTd7BVKfdez5X3OLtMNA/yo6eHYJpVG9ZFXVSujjotyvqAU5BQ66YfnDpbtn0sbNuKRSP0PRjBGycM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862509; c=relaxed/simple;
	bh=ak2WGfg2GCfPz1h6kRe2vLGGuPlnnjvMG40wOlzZYkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgBRsoYcrY/0vKkXXKB0TtEtqXtv52PDPAFkNR0V8D8MXHQYTLr7MoZmfe9vopjarz8sJ5LzDut6dG5slobnEkkp5puH5BExAsMRC/yHAe7gU2uhMuoRX2JWobk/n+eZcQlFtjulLi6yDdydvPWuOmwrL3zZhcOLRJma/VuP6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SU0HyF/I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xmv3Gk2A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SU0HyF/I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xmv3Gk2A"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N8ajsh1971340
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 16:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vB57/lyfKRXlbv2ojASFy7z0cDL7Clc/mnkKCE2srms=; b=SU0HyF/Iha5/1/uV
	QT0RPU4GePtTQFeUAXyZKosiNPGlzWEpjMQUrncfxIDT4bh7rMJqdupNxb1KvxNS
	TmdzhCE26CUMgeKc/oHZsIsZp8Po33YnLkuV2ewNnzVBTCJ5hePVM+UvzKlNq9ol
	4cXzS8DNebdcrTVthkKfBRmNuyYa/GRsE+g93LcGsYJE1E5+CkbShwC5M5+taHnr
	RKWkzTkNMnzMj7xHTvM+yRFfwibPPKIadzuKLSQrT1zTDDvbjbiuI3hOR8QSXADk
	BTj3qiSuUArbAkZ6Dhjn6niMGn3IGOzq5mJdLT2hw1pahRe0z/PUDIPOMa5dxSyC
	YGji1Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5vgwdyn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 16:01:45 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so4957115eec.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 08:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771862505; x=1772467305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vB57/lyfKRXlbv2ojASFy7z0cDL7Clc/mnkKCE2srms=;
        b=Xmv3Gk2AIGocljPyU7AAc5JyDoHejgaj1WcaxbC7FYMtCQAuHZ8N+aOzRpdCP2gIc6
         jz7o5rUmjdrqGIw1AK48bWcMXQTQwgHTPj9Sqf8VmDhcWRFzbwcdnSvAqjWTZkpAv8ZE
         x/vt1CfAjz0y0ij77MFCFE+Q9+zYqaKqKwYAe74SrwXsjDM42SrDC5jf+jo7obc24hHv
         fKLbjnoGuN9S3Ts7YYy+0Pc/6XnXRqncOUCYGc7wRn0jugZksVaofGviJ1hed3lQKhDx
         Mo+8yFsvq5gVxa9B3LIXDWa0DO28i9Kt6uGj60Y1hFjKd0n+ezg2lvKIE9pm2bM5VDbk
         g2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862505; x=1772467305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vB57/lyfKRXlbv2ojASFy7z0cDL7Clc/mnkKCE2srms=;
        b=JidtTW8qI6ldhbkkU3Q4FcQhxx4IUFOsQ07QbtY5PzyyqjWm1NFojEUL4DZL57gogN
         f5d0oflllNakCsvcJkr97FTRLqGYvcbjYBxygZyrEcCq6gLOgERcP/+1RS8wc+/M0NtX
         2UZ9ejYQvvq75dNxv7aese5+3bKQlzxQgBt2kykOg0nYX4g2ecxKQWn/spprOL2ZP2yH
         rjeUIbeM5aNL3i58Lb/zNDmaAQ03nYn1/KgupkffaYUcH/88gPVzPYZdkshw9OB/mAp1
         dtI3DZSr0Ze8uUgrEUd5nrgiYaMQIjXwM4vWaqnNzUv0k0dFTJOacI0Oc42CafLLn4Vs
         ZO/A==
X-Forwarded-Encrypted: i=1; AJvYcCW8Lie23v1vRX8I25ovVX3+DYBKZf2H8y/ytSDkbBIN78+SFhRrDamX/o48ZkJ2A+wzRvMKh4I0ueQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBQIm7pntSS9bGN2O3HO+gC3iTEkyFW7HXsqrsfQG7ntYf74LI
	3SEBQcKMOBglSwqzSJmJPtkdT0cyn94ckFRtRWSc7PvjLR0pp53YDaez7l99+e1s4uH5pt5Ue7l
	qAnpvm3//9gE3wulMSfkyCszA+4KxBW5jfYoj+tF5dm85hcl43aoah0hVeKWdXxM=
X-Gm-Gg: ATEYQzyYvkF6CyBbXv7JsQVBSX+7opnmNCSe/M+TVrBODR2cWGOEJ3M8sHufIdpKvhH
	NZXJHUEQ7xfuTZgIrRiR9jAm5BFaBHv2bDArLrpH/8PEpX+/4lSt+qQYRmZVpKBUNKiLzAPdEh/
	+7lHkHfYnBalK2sHhZv40Q0MV0KUDkbK0nW2HF4xf6/rCpeCZpR5y5yeoJdVDLiOABtd3OXHn+R
	6caMfQGqXen1SyTWkG3EyOjBjUmVVc/x1J2BTwsNLGpoORBenXwGaV4Jl2ReM4ka5OP570mX0wV
	7zZw/Js2NobfSK0+Q4DqFM0GwwezhXlytezWaaVolJjW0zuELddWKiBPqD2pUvX2XIeuefctY5R
	UBEXGiqiipPieMhEHUoUQGUJKmiz1MMwdw5kVZKRklCTborla96eGKqEywri9roDrmjSPmtwj6E
	U=
X-Received: by 2002:a05:7300:8cab:b0:2ba:a075:5422 with SMTP id 5a478bee46e88-2bd7bd33409mr3422960eec.34.1771862504302;
        Mon, 23 Feb 2026 08:01:44 -0800 (PST)
X-Received: by 2002:a05:7300:8cab:b0:2ba:a075:5422 with SMTP id 5a478bee46e88-2bd7bd33409mr3422925eec.34.1771862503206;
        Mon, 23 Feb 2026 08:01:43 -0800 (PST)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daa37e9sm4957889eec.11.2026.02.23.08.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 08:01:42 -0800 (PST)
Message-ID: <41d7d63f-bcda-4182-9340-54d480473586@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 09:01:41 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/37] accel/qaic: Replace pci_alloc_irq_vectors() with
 pcim_alloc_irq_vectors()
To: Shawn Lin <shawn.lin@rock-chips.com>, Oded Gabbay <ogabbay@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Stanner <phasta@kernel.org>, linux-pci@vger.kernel.org
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
 <1771862143-89507-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <1771862143-89507-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEzNyBTYWx0ZWRfXwzijWAui1VpP
 LnYij+NUynborozgt6N1O2wGyFRiKeR/K2TDX+vdbANwhGGchtWM6+tp4AWOvkQvK2cBrhJKU61
 tdTHQF7rc10y/2DZxG4YxMqrhXc2lxPtqOn60ze/Y0WBxCDs6hFH2fW9F2Ar8zGuPOWwxDmEelp
 7H4vWBpXNk/bMG9+rftPZy+AxwxREHaEobuOsnWqXVNGP94OF0jJpZ8ZyNhPfhq/vK5EUg2FZTj
 nYK+f/q6R1dhkxlmF+BioOlND48Q/SXjhw1kwvBXFtqfL7cPjGj3URHsox/w0nawlfz1205oPd5
 v9bu2J6VpzX/erLXxcijFKGuwRZWQjfDLonGLZiIRUryXodVUoo7kt+a1CyI63w159MBmJFZ0Lq
 APT2DCR4ghHuUhkRJihSu2BL8NlKcg==
X-Authority-Analysis: v=2.4 cv=W+A1lBWk c=1 sm=1 tr=0 ts=699c79e9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=S6WfLNs1AR-HUFovPioA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: kKmJV7DzKJybFTMzK1pWmtRWLzLakduK
X-Proofpoint-ORIG-GUID: kKmJV7DzKJybFTMzK1pWmtRWLzLakduK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2602130000 definitions=main-2602230137

On 2/23/2026 8:55 AM, Shawn Lin wrote:
> pcim_enable_device() no longer automatically manages IRQ vectors via devres.
> Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
> pcim_alloc_irq_vectors() should be used.

This seems to break bisect.  Surely you should update drivers before you 
go changing behavior.

-Jeff
