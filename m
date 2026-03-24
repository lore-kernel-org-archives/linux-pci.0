Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681A93C945A
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336903; cv=none; b=k/1ptbX20yPc0JzQFzS+30XA5982GrQtdrz1SA1ZlBU4aCDN4hJrKGXdw9+2FpLNuVFmse98gfPGK8GxqkgTw+ljnTKvjmWugo4/z+VtJ3OTLsTh4zS3Db1Q26o2vh9VIGZUEsTfbu+XsYdstE43tMA4RYYa+6fJIKBHDGTKJvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336903; c=relaxed/simple;
	bh=RiKxWVv/rycnLSwnEp+MoArpvjZSZColpmjaqW1/VIY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tDkiIlRkBaFCWWPi2Qussd29yEmUIqOxlNlep1JzLT+iHvwkwCTJ9kTX3IB+8MfeFdqYRjYLg/pRRnBoCqSImw/Ma1qAFuxm3jT2lMsTALrNOnpcee+PvL3nqdXdG4P8wa5rGos4u47tm9UmqRAM55YcClsVm6Ihns+rN1Juokg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cKs06RGT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ea2JWDo8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cKs06RGT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ea2JWDo8"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O3WUej3903942
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 07:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0vxD7jBk2/0QoVAXJzPuwvrUYXpYIDH69qq/ts4iRug=; b=cKs06RGTyv5KFDf+
	7qnPZ+LPZn3tQhsy2jGyLZqRVugViscbKrAiAvCoVGDxBQDGvOH1qrskWgou9gin
	kMQEIAnT31HYpmmKef0ZOMBXJgapc0bhm3eV+FSEIR8kOfDYHpFSaTWbstAXzUiC
	EEttN9mOs1ZLI+Skzi8WiEMWD5zd43EFH+GEQj2DqAkRINZochvbRNxOlfXR5pLH
	/1jjU09tzhUMdckUPa0gW9c+Z4izkePZgBiexv3jx1sjldOgljQLsB+Sg+awNONG
	1i00fArTKcT3B1ayte6HALg55ayT3tpLtjLjfnl1mf+NVwesnnKcEZkvSxnss+9E
	nBnfSg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3jt0grmv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 07:21:33 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82a82f78a20so18386248b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 00:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774336892; x=1774941692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vxD7jBk2/0QoVAXJzPuwvrUYXpYIDH69qq/ts4iRug=;
        b=Ea2JWDo8gGUUkneT13zYyQ1uRFVnre1EdXFBrCzjTQ7p2HDoHSNC6f27zn4jEaVOn/
         Z7uw6RZE5I6MAgzLkEG+yEeFCXz4BQmnQhZWvXx7CL0FhcOaZVzYt08dgbUJSF4ie8yW
         7MwI8StfclXcYjFgxnWjQW6zOlhuO+FLMpXWAVqVmDrgjtFGIaY+FiDVb3J4TDJ+Rr0p
         E4hBj2IfU41efLboenQ4BWUtRHQ4DH3LfVf3br3h15rwllZ6JdYHlDjU/glKs4tpEvXx
         VmfXYYmM8NlOghrSvSiQxZZByiAPoY9wkkDN6C5U8hbjWMvuBcPIxukFVGJGmFh58zVi
         AZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774336892; x=1774941692;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0vxD7jBk2/0QoVAXJzPuwvrUYXpYIDH69qq/ts4iRug=;
        b=MnRGR2hDBnghcRUKFDG5+1Wa+AL7ME9835PJ+EwuDl62uj3WKW2TA2thKARBK/c6eG
         /15J842vWuQQY/kfhtmQ5Hl0/rSANOqfGWMNUo2T70Hz81dgWg1dYxbpMVy5/s0BvW/n
         v5nCDAzZo7q3Hw7/ING617nbe9RtS+4eMpz83jEQRJJj8U6/VVqvvm8JkzH3Xl8VCBjM
         58Cq3buv5S2iWx630gezlXXnd94w1yR66zVw58a3rWncMWS2o14UA0Msh9Ov6ByTgD3V
         DB4gSR/SpZ+f35xrUhTZSK0ETOsg6L+bLdk1YcEFE0v7P/RxKFh5K2uZf5NF8+dhIywE
         lfew==
X-Gm-Message-State: AOJu0Yzi7gNP8JeLv1cFMUV5HuDCLKkLHxI71F2rG8UJpIMORDwh6u3c
	S1PQ9qT8NgwEADbwcVqDnCkhAmIbK96kSZNCQONVFWZnH+lgzrrX8oAPtm3K/WP6Y3sH5Nym8zB
	1NYVBI+e+9sqQtVbm4xshUd/+lwGYNZJ/5qrU9NvSVIIPiLH2hn3hJMm4Lvm9krI=
X-Gm-Gg: ATEYQzz3fnjUaINdJRA/Mub28+RGU3TPm/mlCvk+7xxVzCHXHpcVKrCAyvZhqQg4fz0
	8INExXQeOhLpAlszVkPsvwNXwJt5CBcGVPl0gdfMSF373BUSvbQJZAzwNQz8jJW9W4eO1hKOAsT
	xxFxhBQVK6wNdlGBhnO+tRofRAz11mvQDMiskAz/hB2KRtHulMbcvyQz/XLHy6q7PC/2Le5cDqX
	UfiR1WHGx6I1EFPiMh0N6b8JD8nC3NKza3HGumBj3+p/agwGp/Y2dWNmjx6GZhGXxS9w16jYnJH
	yuYW30evUGAj1T9ASDjTpn8hN80+1Y3dqeSwB/M7f6YH8L6FMrAZIumCdFuFh1pnOKDK68pvqRX
	9jAWD4qez4BWz+LR+Xw9CdlE=
X-Received: by 2002:a05:6a00:2d29:b0:82c:28de:fa26 with SMTP id d2e1a72fcca58-82c28defcd5mr10195133b3a.36.1774336892576;
        Tue, 24 Mar 2026 00:21:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d29:b0:82c:28de:fa26 with SMTP id d2e1a72fcca58-82c28defcd5mr10195113b3a.36.1774336892045;
        Tue, 24 Mar 2026 00:21:32 -0700 (PDT)
Received: from [192.168.1.102] ([117.193.214.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aa79c6sm12130711b3a.10.2026.03.24.00.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 00:21:31 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <hans.zhang@cixtech.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Felix Gu <ustc.gu@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260324-sky1-v1-1-6a00cb2776b6@gmail.com>
References: <20260324-sky1-v1-1-6a00cb2776b6@gmail.com>
Subject: Re: [PATCH] PCI: sky1: Fix missing cleanup of ECAM config on probe
 failure
Message-Id: <177433688851.20261.7315743280318704387.b4-ty@b4>
Date: Tue, 24 Mar 2026 12:51:28 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-ORIG-GUID: 4v9Sm3q663SQ7v9j1asX2-FnTTTaORxP
X-Authority-Analysis: v=2.4 cv=Nc3rFmD4 c=1 sm=1 tr=0 ts=69c23b7d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=13ILl30Z8QjaXWZz8Pan+w==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=kS9_z_CLsMn72jdNqNYA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 4v9Sm3q663SQ7v9j1asX2-FnTTTaORxP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA1OCBTYWx0ZWRfX+YA4sxOuoE5r
 8iSxAE6qGGM/rRW1KbTI47DKRvSsTd/X8Tyf1PhhPvr6eijci8INALy8N/rmDQPIKQ6EuuYppIN
 Tmzl04o93/XSQB46Vgdw1U65myUxs7a8HACYe6GAeIKlGTF5n19BsBqBSOmfdRVzwfgJDvtMI6c
 hQnw8ymfnCFduq9LqIHcNPxPywfdEIQ1Ex2zbCBZBoUnJJD6CNIdcTbcnweFXAGd/tPK1tEGaMP
 1M+IyVTNjYo64q/fngz0Ul9QoVu3YEhIW/guXA7X5aCQ1WwL0FoM26XEmFkv/HUNHtunMw2X/v2
 W3Y9tFYzJ4cdvJNkRxlqwxsTqHd+XG6iFCXfYf04jS79OYVbJ0tBeAyabHHJLobfoNjVDpgRzFR
 mCzoifcO2rDhrXQUPhHau8HsCkRRxvaoQOEudmUxwvUg16TLYZPEnPH17CgVG3i/ByZgwzaEMIX
 6TTApySekNgJyW18dSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240058


On Tue, 24 Mar 2026 00:41:28 +0800, Felix Gu wrote:
> When devm_kzalloc() for reg_off fails, the code returns -ENOMEM
> without freeing pcie->cfg, which was allocated earlier by
> pci_ecam_create().
> 
> Add the missing pci_ecam_free() call to properly release the allocated
> ECAM configuration window on this error path.
> 
> [...]

Applied, thanks!

[1/1] PCI: sky1: Fix missing cleanup of ECAM config on probe failure
      commit: 72e76b63d6ff6d1f96acccbfc6c118656f63e66a

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

