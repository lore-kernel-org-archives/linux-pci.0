Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BD336D4F8
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929127; cv=none; b=fhRk/9nVjbInvKbP6veFlN8Ps6V3Vhb1bPi4A8VpxOGELeMFVWbNx2GFYNDbvu3Bi/PCCwj+Hb6KKlGUVJzNT/Z0NswUGgGQRQm7Wkty3gqN07rZgdCpjumgntt82R8FK8RN22XPEoHOzYHl5sytgTRdaDuMqk6jH9TZkXtT95w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929127; c=relaxed/simple;
	bh=3DEBZkXGlWeTEe1QBrT99gAsCgDLC6FM8EAUW9UvXoY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z2cQZjUS2pIZLObd727A0ndwC2sjqzT1b4l7FUWg0fXJTACB/QX1pgU8OM7wDC+1KaunkHD1FH6AVDOCRDe6vOjMTegn2VUm0U6i7S26BgsuEiaL3LjVCLCJEYqEbllUReTJqLigKSvhkLngSxNUiDTq2ex2gyYQNdxNXuBYy5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hDXQSqIc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dOs5iGe0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hDXQSqIc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dOs5iGe0"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFYet2512787
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZnkpqFAwGHUOG+UZQGRNUVosIrCxLVLhMWwiuXlXtAo=; b=hDXQSqIcyJ9v+WGE
	nbAcVCxh3gH0C4VSsbQYlp6+UFctDcFWPZuOSqr+8ttPMXv6btpAX6UVluc5sb9V
	7iD9xLLTl+QlI/nL+LH3lmjbysjR8ZaBEE5qf2ojRU9dQ+7AGrUyOYqW//GEnP6L
	NuLOHx52dwlE/kxYX/NodaaIghBKeYANZvZLu6AACY5ylEpat5VnCuYNxJQtRSzM
	Gpk5sK1+Tf1LJSZIGckd2TwU1C67PwFr8r1AJAmGscTlze/B1ppaY8vGxhE338zm
	StKeBeqVZEtBh/Vmbpf7UFMuzSpVNlG5JE2WV/+Dzo2p04plIp52nXQzNCHoCAg9
	TA5THw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn81bwpg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:32:05 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c6de18907a0so3507641a12.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 02:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771929125; x=1772533925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnkpqFAwGHUOG+UZQGRNUVosIrCxLVLhMWwiuXlXtAo=;
        b=dOs5iGe09UQ1z1OXKZbphMme+SvnEX1O77aauLpVVJFhpByE835dyM9JiKygEOVH5j
         3BAbaibrpV6Y1W+lurlMdhsy6Tyo+LGURk7Girei7LY+ecJizviAkdY+/b+fzdns3ajk
         z8OdCbCLhmylKKpWIgQ+722cC6ii4nU+1bzAix7vC74RjzAOHtem5o97lvFouWsLG7bQ
         mceRiIixzmdkMN863unFYO/fQF9J2o2kjl7bGcsQSvvHxfRSMurRAVyujzI2xLGKDway
         AdmPI2gEHLh4PkX1bwKaF2rc/AJIEi6BbdL0LXVkO06ubED9oh5WFc6Iol2lAOC6SoyV
         u9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771929125; x=1772533925;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZnkpqFAwGHUOG+UZQGRNUVosIrCxLVLhMWwiuXlXtAo=;
        b=jYpJpaO2oo1JUoQ/hVHTMThVTIL4eMr+7IviWVaEKJFhD0aVxBVvJ9ATDQ9jX2JwcX
         DrpLsoSpCrqFmp1o3ZzGws39PICpqLn55/R4GO0BUEpUkXSfK+2kXNJv+wRgJAo2IK6r
         d1iTPU/dQsnGDlHGXXmXleZxJbUaqm/VKeJOmWrMgMz5okGkJYFDBqOffgNPs1jJH1EI
         UrxFtpMJu/N64V+4zJDi9khMQbVpSs6UYXjamq8jhUa0WZDsDBJ2cl+NGaqjZm3P/zKC
         VDSdNEwJNbBC1urG7NDTISjxE1nQDdtXs8O8JWyDQNKOoc/V3WhhgJtDgvfRLQ24Z98U
         v4oA==
X-Gm-Message-State: AOJu0YwFUTjL10eW9qVJomO8qutoHxwbVOhmFSDqzG3/G6G+eEbfLkMk
	2p/EVaN74zzcEQGoA2qD/87m2ccJRtSfz9oq6T9t1BSiMKLP5mENMH8+pS66fwHKymd3fcAvDbw
	7q8t818wpjVVtfXieFk4MmftOWXSvM306Qg+yDBQrjuY3SIR0o4jQSV12gMefEww=
X-Gm-Gg: ATEYQzyzpXGGVIPQDbrvV9gNOhTqj8VOrxPU9UW8ppO0SmvzK2pnwE9ZqUvDb5LqBWX
	aoAi17BujMwA/tt2zNm4t76/AQTk3blVC2QSZgTiHKSLRqbADnz0uvZUSuIyWkcsJEyXgqRf8iy
	VFsqYDdXEbJ3ETsBfZK7hcksHubvDztY8fGL2k6cSmKII94V4jqSFXMh7x3+EWK73RKjMnfwWVG
	/NC8iVJs+vanew74zbooByaSHJq0f3FCnBj+gts1esyE3AwaDZyoDm0mKgaUs81wDox9x+IIQ0i
	bJAIai8EqSqbArTmugpB9YDSN+mSv6kMoA2A0463Y1UPc9wNCqzqWUYSDG5zE5NPdFi0ssvMNQ+
	rV7FjCEKQrgiPmBHZq0cECrg=
X-Received: by 2002:aa7:9a87:0:b0:81e:8e66:38d8 with SMTP id d2e1a72fcca58-826da8d7c38mr9481548b3a.10.1771929124619;
        Tue, 24 Feb 2026 02:32:04 -0800 (PST)
X-Received: by 2002:aa7:9a87:0:b0:81e:8e66:38d8 with SMTP id d2e1a72fcca58-826da8d7c38mr9481518b3a.10.1771929124124;
        Tue, 24 Feb 2026 02:32:04 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:8fe5:3076:bc82:a67f:ae4a:6d25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8c7535sm13166606b3a.56.2026.02.24.02.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 02:32:03 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        shuah@kernel.org, cassel@kernel.org, Frank.Li@nxp.com,
        Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
In-Reply-To: <20260215150334.3391943-1-den@valinux.co.jp>
References: <20260215150334.3391943-1-den@valinux.co.jp>
Subject: Re: [PATCH 0/3] PCI: endpoint tests: Make doorbell test
 capability-aware
Message-Id: <177192912011.11680.1586624827283604642.b4-ty@kernel.org>
Date: Tue, 24 Feb 2026 16:02:00 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: QQ9-jJJkZgUs4QHDOO-cwgs5nieJEWNx
X-Proofpoint-ORIG-GUID: QQ9-jJJkZgUs4QHDOO-cwgs5nieJEWNx
X-Authority-Analysis: v=2.4 cv=CbsFJbrl c=1 sm=1 tr=0 ts=699d7e25 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EWLswNdyUk7addLI1k8A:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4NiBTYWx0ZWRfX6omFhoInLbI6
 a4TV1lGgCVjsdrQN8bZpRhM85hn+IaPtepqIJUGA2saR3C2YiFGv+b8RyibEJZzs/OTfeKyO6Em
 Jw9bnRRvu2JGdxYcE8Iiywrpvj2TNAG6i8dF1+tp1hLIgwDGGlVEe0J5gkNcghc1rBrxW85beXZ
 rGEeRtNFlQ6s9sXNFIU780+IiPlIOrujPwAZFwISW72nLcLZZ1tjMkELfvpGiCB7iVRulAmtKKg
 a5mC/GaAO1t7fpp9358aRevuOMfEIQUi6nTRRFyWkRPZXIoDIipMVjPGptT70rxUD7ZG0107ubC
 XiqlZKaEUxb/ckVLtwomC2rEo9zNjNfSPMXp2ThGAqE5TX9fNyIuqSHLaKsqdrMFV1f3eAL1rdw
 OLygT3ER3dMc1Q4+QWXiZa0G1CBY0J9eZVKAE9vCFNL1wj15RtQnQvr+/uM49hhQmpRRp6M3ZOi
 h2MZAu4zwHBMC9Ls5KA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602240086


On Mon, 16 Feb 2026 00:03:31 +0900, Koichiro Den wrote:
> The pci-epf-test / pci_endpoint_test doorbell path requires the endpoint
> controller (EPC) driver to support dynamic inbound mapping. Without it, the
> host-side test can run anyway and fail in vain.
> 
> This series makes the doorbell test capability-aware by:
>   - Advertising dynamic inbound mapping support from pci-epf-test via a
>     new CAP_DYNAMIC_INBOUND_MAPPING bit.
>   - Returning -EOPNOTSUPP for PCITEST_DOORBELL when the endpoint does not
>     advertise this capability.
>   - Skipping the kselftest doorbell case when -EOPNOTSUPP is returned.
> 
> [...]

Applied, thanks!

[1/3] PCI: endpoint: pci-epf-test: Advertise dynamic inbound mapping support
      commit: 9a940a3d08b25cf8e864785ee06b65756d6e4573
[2/3] misc: pci_endpoint_test: Gate doorbell test on dynamic inbound mapping
      commit: 51fba4aa66192fa65a31f213218167d9af326f1e
[3/3] selftests: pci_endpoint: Skip doorbell test when unsupported
      commit: b4a31737679576dc8aa6de43d3c10bfad7d3f57e

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

