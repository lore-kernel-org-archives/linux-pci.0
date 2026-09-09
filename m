Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793E755821D
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 12:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957500; cv=none; b=BL3JFh7ZFWetRHz35JdAiv7rtumyRI5O/nHdRalQcfF8y1ksWcRFevtFzZOfKdiBHxkmQzoqWTcgv3YiLahCcQsaBNb2axQ7ek4drGSwjcnPpxLPpkB3QeA0jgFXh9xxqte9CLINc8qciYPN9fKENxzshQcQjgH2Xp3iG/A1yq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957500; c=relaxed/simple;
	bh=BKzogTZn+EJ5XpNLtcpAdHyL4/z3Wux8oU3vlZWahI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsAn/nvoyjjZcDxkVjk+1E9KTgNN532SFlsSrVeCDRFBmYR9hSCnaYUpPnZfAlxyRxuN28aIfxFi6kwUZTUD/TWCfjYcHvpzOog8DHcee12KcMvf5SfGG6xzF/8r24RJkkk4nR3RvE13pDvYRPd0f6t4Lw0cjTFMMdLqOIioIrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LXoTg1Rz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IWqE+hS6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LXoTg1Rz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IWqE+hS6"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BoX9J2698594
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 12:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7whHKW8iAgsbvfjm2Z5LvT4KF4Z64VMEUZ/xaZ93QCM=; b=LXoTg1RzaUTu3qXs
	f1hHeZ9G4NEQQUs8BC63NZSEkOZT6ayPzxcEs2GeD0ZjBDhf0QhodNxp6Y+gnetD
	o21nIrGYJZOoDfD5LUCIhe7SOnkJWylgWoYFPEI6erpq/RI14LEuNRXkgoNnj7Su
	zRrzFQgBqOEZwAXPNY98G9crsYlgkpyCAgS7jsk9hPLPptZt6xFnxzYcqBjDrGva
	/CxJ5Q1pSzmKqIdSPVmjR0ynehrqZnNOC1v4la+kIdp27JKVJXJldspC2s0S8G3v
	5kY3N0AHLlPFvBd7CXr4fmlVRXktofvrbkBFVUUjmiJ+nySGU/VIw2iJbw7FzJ64
	OrKvxg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk6xh05c9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 12:38:17 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-78a1ec363beso88110137.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 05:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788957497; x=1789562297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7whHKW8iAgsbvfjm2Z5LvT4KF4Z64VMEUZ/xaZ93QCM=;
        b=IWqE+hS6cCV0guJnsxNl2O+ze/gOkGSwfpf5u3yFAnfOU/j5KaOKHuX/bpeiT+KE5J
         c0zg6njjrHEzZOr2uLB9vV6gUmenHm4BRodddnXVNb0KborGDu61pIxdk0vClY509DYV
         J9vAqHBse3zgVCxLi7E5M61JwIoqt/3AlSPZa7EddS4JLTkjWh2fNNQeHqyKDpe11BK2
         R6yq3jF+onbdsi53rVzNIVUbuxtd6CZm8d4BAXchvq7Vtb87dGnLjkLz2Ehmav+R2GaF
         pbMSKq0PbJ0AFSV9fQqlya2oRnZnaHbpaO9L1nWfpt4RkDqPAbBshezAgf7rM8EqJpVD
         jtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788957497; x=1789562297;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7whHKW8iAgsbvfjm2Z5LvT4KF4Z64VMEUZ/xaZ93QCM=;
        b=cZ8T54iW1MTaevbZ2kcdQfeASAbPozoEhB/CtJ6jV1Wd3nEXbr2aBuRR/nG7mj3s2C
         QJiBXP7rKryoHL7IQD4H4XVk5wJS38HA+Al4oSI2elnzPp6SlLgVQay7PVgaPCqruElh
         vMwQkrjkBOocSVRWsa+0fb/HCZyypbyCokMah1TeEAdoz8lolRW4HI7U99l/xM48+0+g
         LGjj60yz4iP020yWDwRffwK5bnLFMQK3wGrpcJXXpii/NFVFbNWpFsERWh8Hr94t6U13
         IprUFlg7NK7wnAFG2aEC80yBB6AvW5DI+KiCyz+TRtqCb7fG14JKS32eX6LDh5KPpC18
         hFAg==
X-Gm-Message-State: AFuF++lVYCjDTCHvOxHRu9oMgrkWmIO2uHfcVqJqEme0adYNztbmDn9s
	UlDEiD9SrEsdwuGsFhJtA3b9An3ytuaBbXP8jUaRoe1TvsiyUI+7/a7BXXx1vGnyzuHstHuJfl9
	PnE7BF1jbr8kkD6yX4lUJMk/Ie2DtEmxHolU3OCqh8bfZH+B+0GkmG7xrUFSyUV4=
X-Gm-Gg: AYBFou0kSsEyMvmZ/Aky0c1A65/TvGChm+EPL1aUMTXsbUJNGvaZRVcdB+b1qyIwGfS
	2619/2k28sDYAwxKDE8Qh8i0rlF+9DXVPA2r/D+BhSF3wsMQSw/EPatiN+4Ge0Ts31Cxb7hndTY
	SohH1Rfe1K/3pEGeidKvaxYhbbewJUmfRRatmIRciuaUl3/T26n5iaZH/DAUL26JPLbEHnzxbaY
	8qJ+X9TgbobpSoYJWSe2cA+bKriZo6PGyEXN3pgzS9KsfCHh6guGxRhCV0jURY1G/yN9NBWsLSk
	lLXX/9T7GMP6pXagsGI6wc/f5k9U4C3x4Uf4DeEXV29LBwcL6wIw3TJKUunad5btg+SDPwt0V3X
	8SXXbjUU7xL4rFZ4jM4OJvw==
X-Received: by 2002:a05:6102:91b:b0:786:c254:b7f6 with SMTP id ada2fe7eead31-78a6082a131mr3898524137.0.1788957496688;
        Wed, 09 Sep 2026 05:38:16 -0700 (PDT)
X-Received: by 2002:a05:6102:91b:b0:786:c254:b7f6 with SMTP id ada2fe7eead31-78a6082a131mr3898514137.0.1788957496296;
        Wed, 09 Sep 2026 05:38:16 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a98641f38csm1237305a12.13.2026.09.09.05.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 05:38:15 -0700 (PDT)
Message-ID: <85ea66bd-65f0-4e05-9928-3cc2e23f02ff@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 14:38:12 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] PCI: qcom: Implement shutdown() to avoid SMMU/NoC
 errors on reboot
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260909-shutdown-v6-0-62b7bd123236@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260909-shutdown-v6-0-62b7bd123236@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE0MSBTYWx0ZWRfX9QuR00dbWCLo
 FneIe4vdjGR9HsX4mhI/xn1WPgUn0B0AdV2WIxUv+S86HAcLQVT9yKuJEJfFE0dLfxHWcF4IHMp
 YK8Alw2apKgTXKkVKegd2iWkPfS95h2iB0EF0zIM5mSbL771Nau3cK/+lOYN3HCgRLusewIslTK
 wW3lgxGuMkIFYcHxcWENfCQTTvisbPlCLtGQRmEGk1Ci4n3Z+0AichQconWAff7VbXyLpf4Rww8
 TwSkEveifQNt5eZQ/GLWtZGaCT8wOWJ6UfP+AEV/swIn09QL2rA2WxMBgqDG8r8S9caAoRHElR0
 NZIIL8cbHRaIIwYMy+I/JQXtllb2MlrFojoOkp9IWAPPDwjN6/jEIDHR8hJqAKFH2Q6jeD0xh7k
 JZpBisOj2AgXzhGB1CHsX7+ikBlmqoOvmaOCJ/qcZU0j2jL7BThOtaGBnfBo0TlqytMVhbPzRr4
 bVptqZhrEFMWh+uq9RA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE0MSBTYWx0ZWRfX5VFcwPt0QG4X
 Ahe4n93sGX5OtbbGtDVyLMs+gEUh3GTlzukhL1XF3vdPWsWc9favDzHavEJlq4WLfXOkP/woxYr
 TAZ0pVJv3LPK8dVQ8c52eD3Gbe61cDw=
X-Proofpoint-GUID: dsjc3T8nl6QelYE6ztwrE8At-YFzGuPN
X-Authority-Analysis: v=2.4 cv=KOlqylFo c=1 sm=1 tr=0 ts=6aa15339 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=SpA6wshyjLPcRYPzmHsA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: dsjc3T8nl6QelYE6ztwrE8At-YFzGuPN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090141

On 9/9/26 2:24 PM, Krishna Chaitanya Chundru wrote:
> During system shutdown/reboot, power/clocks to the PCIe controller get
> removed regardless of link state. If the link is still up when that
> happens, it can trigger SMMU or NoC errors.
> 
> This series adds a shutdown() callback to the Qualcomm PCIe host driver
> that forces the link into L2/D3cold before shutdown proceeds, reusing
> the existing suspend_noirq() path.
> 
> Patch 1 fixes pci_host_common_d3cold_possible()'s underlying bus walk,
> which aborts as soon as it finds a device outside D3hot and can
> therefore miss a later PME-capable device -- something that becomes
> common once patch 3 starts forcing D3cold entry during shutdown while
> endpoints may still be in D0.
> 
> Patch 2 adds a force parameter to  dw_pcie_suspend_noirq() so that callers can
> set to make dw_pcie_suspend_noirq() force L2 entry during shutdown/
> reboot, skipping the D3cold capability check that can otherwise leave
> the link up if any endpoint hasn't suspended yet.
> 
> Patch 3 adds qcom_pcie_shutdown() and wires it up as .shutdown.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Changes in v6:
> - remove return 0 in d3cold_possible() (konrad)

I re-read it once again and I'm not sure my comment was right..

Konrad
