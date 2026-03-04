Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A8937F8B9
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772606480; cv=none; b=oAyG2GlzkgNzS5BrsnJAn2T+1FPxU5l3wceTz/NZRgNJQKpnc2tGX0P5lmHRgAmW6wpzMA+7Mt4wuyIqkcvktxOOTjrOEqU5Hy90UdzBLIoIe2AXZWZWya1FjtR6QZYulex3TSBrujox4GrEAjE9rPeWjf6aTdEfokQiVzi7XoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772606480; c=relaxed/simple;
	bh=vV5++YtOiEucCma9pwOIeu36F7oCkPpW2c2/tIuvAFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Km7Ip+EOOQOIdHqWM15Bdc7QHXN0doThNJFYSsdTwWOj9gObloEe0CFnSwl5WnYNKRP00+U4XCdZ4l8WQhuZtY3WtqjAk4DN/LVW3BceReXg6b3pY/cnPZTkq+/glnoc1mTvYX2sHENqXTvwp+GEJw5TnglhwNKnCZrNkFZ7EUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e9fHjpGB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CWnsTwBL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e9fHjpGB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CWnsTwBL"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245ST8h2306170
	for <linux-pci@vger.kernel.org>; Wed, 4 Mar 2026 06:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	psb9vaJtJh0tbmEvnCDxeFrNsEYkXYNHoHg/EsRt2nQ=; b=e9fHjpGBcCQl816g
	MSy3YlYY+TjSZ1TdiNGLSvk0TKF8iRQVoCW1Fl9k+1q5yx48TSn3y4ItfD5uqFlh
	uaF5kITlOcjMirh2rAD8htHhmva8kkZHVjrR+LxEDbj/8SU5b1Bl3KZvgnyIHXE3
	ncDOVdSXuAStDIebdSwGzDG9la9oyAF0NBNj0e4PpQR0glsRv4wL6Em/Qr1gRUrj
	mdSkgUdti21fhAs9+XiRPgV3MrjSN48l353IXoADRNVfKAXP+yLAXT1XejO7ise7
	4BF/7mj8A5NvMPmb0MhnTan7ZTV9Jj2gmOPPrGhY1yhNvSVW2wBEEE10853boVzi
	+b0ugg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpau8rxag-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 06:41:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso5391624a91.2
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2026 22:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772606478; x=1773211278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psb9vaJtJh0tbmEvnCDxeFrNsEYkXYNHoHg/EsRt2nQ=;
        b=CWnsTwBLPwATbuGyXGWgRLwIAmBPj/3bY6+5WkMcQcL98VP4Nk3Vanbf22C+RBnl/E
         ubQXCk6mgrNipoBsho/x7LkCpeSyKmtT5rFWyRwQ+Qcse+UIxNqOX360HZHLBqnjY2M8
         rgtTZul9LrsVANkhyNCywb3+oYfFQka9NSgCjRfyYMUZ84zG02MN/ewonvg3DXb68Vqg
         lXqkDQqQQiFyKWjNiUZmeO9//u6woyOIX0BXnIz++rnnonpc/mmyHycM/RA7MiK8rC5t
         xRLvhu+TkmUzK8QyEERrJDK90Qot02cqyCui8JNN8pIfhn4i++f3BDSFzL6Bt+Ospl3S
         Hg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772606478; x=1773211278;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=psb9vaJtJh0tbmEvnCDxeFrNsEYkXYNHoHg/EsRt2nQ=;
        b=KwmPxC/3P2Wl/NHGilitlGpelTx2jrDYYln1dXdsCKXoN/pyDIdJyB6s6FqW5FjJQJ
         OFZMPvnyoyEF5sPdna2DZZWe0i027wsfiAoZCeReudRfWmM01cZOZI7v/JSEi8OdpsNE
         b/96i5riHOabTryPB6vHhp4NkdM9cJYtcSPe4qL3Te6CrLyyFcJ3bdfRY/cJ9jwJJAZz
         H0NlwWCREYwSa7jTYtrEpw7zK6y8xreWyLQrr0R/hp9Sg5fkTiLlgCuPI0FD5+q1iX5x
         cWQQK/U8wf4phYL8Ib7SBVy/2ZA4BzxMDyMnNZYesHjSEHvPSxEQiiUVQw7ptbg/Voga
         Z0Kw==
X-Gm-Message-State: AOJu0YzoBNTTPutixEKD0QvpHf707Oc2DoPBIownnuhqddk30Byebodc
	CMZGIBf1+aC8h0Wup3lAeM4cAJMOpcFdxVe7kz55qluPb86RbvRJT1/hn+/mv3J77VufnzEAS9W
	PaNzJulynVTEjWCW3e6JFiTNF7RoPydY566/GyMwxXo3XwJnOgxRgWQuWkraPGXQ=
X-Gm-Gg: ATEYQzx50t+tBFXl9PMRySLs+oUiNmeUC1VTWZ0vx3YBY4iyiif3QDSQ78Rsv0v73aj
	ZD3IriHcbDkiw0HhoNzfKLYbUiMs1MGdWHDxQEKqr2lt6bzyC763E/mWsKWnd1VQnqGZ4y+ABYE
	vWylYVwRUm/xo/A5n3xy8GPNtx3vsENq4nRY2f07jwocOK1vXsXnr61bzDHNjwlEfzxUWCQGNCO
	Zh0quc6Ii0c0LoBHFm89zc5zhrJfZeXpW8nDhQBidzh9kB3/pWkGTQTMD+xgUmvjp+vjFcFbBt2
	teforlXsQduDLUsz9OKKy+fNnST6tV4XagtaVlViGEQ7zX/Z07jXWpLU5OH/tLOie+xMB95R0Ad
	AzRF2P3I9s7P1PmAnpnPHfw==
X-Received: by 2002:a17:90b:2691:b0:34c:6124:3616 with SMTP id 98e67ed59e1d1-359a6a4cb03mr934484a91.27.1772606478316;
        Tue, 03 Mar 2026 22:41:18 -0800 (PST)
X-Received: by 2002:a17:90b:2691:b0:34c:6124:3616 with SMTP id 98e67ed59e1d1-359a6a4cb03mr934459a91.27.1772606477783;
        Tue, 03 Mar 2026 22:41:17 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:88da:227d:6548:57ab:a3a:47f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359aa2c02casm43011a91.8.2026.03.03.22.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 22:41:16 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
        kwilczynski@kernel.org, Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ye Bin <yebin10@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260226084142.2226875-1-den@valinux.co.jp>
References: <20260226084142.2226875-1-den@valinux.co.jp>
Subject: Re: (subset) [PATCH v5 0/5] PCI: endpoint: pci-epf-*ntb: Harden
 vNTB resource management
Message-Id: <177260647178.9422.9047695520369841203.b4-ty@kernel.org>
Date: Wed, 04 Mar 2026 12:11:11 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=AJS1/0o2 c=1 sm=1 tr=0 ts=69a7d40f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=W7F15ZMq668PpAAtMmUA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: qj7_lPX2NhfY5fHyXQb6K9Urz8UHxcTp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1MiBTYWx0ZWRfX3ouKytkfSy/p
 tLFlr31Yrf+2h0uTduz9JmIT1l+yAucP7QoSLS3rayQhy17gWsdUG2VOmutpOta48+32PaPO5Iv
 WSX7b4NnKI2hKTQH6Z26lE6gWJnEEliEkRTqovtCREpfIGWDPYQMp+4J8I8/K3EdYojz9HXqEU3
 rf9p1uRztlA0ZRWoH9N2MX30my6GZSW/xsRV51tW3mvS60irAcVZUTq/B1wcDn3i1URyCgzxU74
 mQZkgu8H/LL+S9fx/zVAO8lhGJQ6X572pEOXVXapo7QyA+gwNTwGVAtDWh1LI8ILJ+uOX5/aEpj
 uV++Vr7TUunwbVHByYMJfnDqQehZ70rGUc35MVox7lAbsh81AJ9zu028zsORRju9fwp8H7fDA1I
 qyH7hE09OJ4xC4jEiOOpv6LJlTRlaic3XGMXbmlw3okwLjzr/1ebNeufSQMP99tCCuJF+UrPsmb
 3VwGDNYNlM0psC7wrdQ==
X-Proofpoint-GUID: qj7_lPX2NhfY5fHyXQb6K9Urz8UHxcTp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040052


On Thu, 26 Feb 2026 17:41:37 +0900, Koichiro Den wrote:
> The vNTB endpoint function (pci-epf-vntb) can be configured and
> reconfigured through configfs (link/unlink functions, start/stop the
> controller, update parameters). In practice, several pitfalls present:
> duplicate EPC teardown that leads to oopses, a work item running after
> resources were torn down, and inability to re-link/restart fundamentally
> because ntb_dev was embedded and the vPCI bus teardown was incomplete.
> 
> [...]

Applied, thanks!

[1/5] PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
      commit: 0da63230d3ec1ec5fcc443a2314233e95bfece54
[2/5] PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
      commit: 3446beddba450c8d6f9aca2f028712ac527fead3
[3/5] PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
      commit: d799984233a50abd2667a7d17a9a710a3f10ebe2

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

