Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29C937F8BA
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545064; cv=none; b=kAc2qo9J7+M64Mjleudsg/39PQ1DtV7pemcioXfWKZ8FY6ei90Z8G1t80alclgjjRIaXzNb+3k8q2sQRLTWfbZGqZz/NzPc7VhaebmocduBLI5VATm5a/6qR9snh9nYAbrNIiRgEiy78gwH/u9+BolK26CROvcd0RaTdWdBoocA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545064; c=relaxed/simple;
	bh=9Zcc9PB5heGh3bqpNEXEPdbmsyQdoCi/SiuNt0ko7zU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=stGJ+a713q/Bb/9U2Qgf3qFQuY9FaTsPKYL34UMKRSoZ9tPKHd/HwMM11Zz31iWcC307Gu97akB1RKr84A1DctM6GjpAJLj0VuOQ1L5idKBAQj2mJQozpR6bUR021OFnsJSzepjooz9ZpNjUq4SeYjXTPczVcjIVpNGdyatrPZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PBa/VAJK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TYQe15N7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PBa/VAJK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TYQe15N7"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QF9gld1088109
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 17:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b6r224pc1M7FavILiplRKh/EJYto+mOVLIPyko1UisY=; b=PBa/VAJKDWUOVCJh
	SAvo7r2AaI20OYOCQ7eTqtY9mvLEFxSfMDJD7Z3vDyx+1pMoOmncEOiPnCHj2k3W
	NukrL5O2dkgG5oE/xLDVfAtwp2aYBhYO1vmyJti1+5/7XpAI4NFvlC0IQYp6BAt/
	K3skqdl9V6Wbq0HaXfEsAFsLan2xW93/LGIC7Z24w31nqwgJ2hYGABRG/xs+Q2kT
	62LoDxOSEC1QPY++z2QkBK62abEbU5MpcTO2cE6BCE9IcSU1iL0J1jrRzbZi0uvS
	coT/62eWrjLUQ6w8ydXqm6LDjZIIOOB3XASWyBqYcqVHK513h6nZ5SMHSQXfWCzH
	4goNQg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4rcn3jv7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 17:11:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b06c242a34so37140985ad.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774545059; x=1775149859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6r224pc1M7FavILiplRKh/EJYto+mOVLIPyko1UisY=;
        b=TYQe15N7LU26IsQu/k7lUh7AJP17gb+4tJ0CY7/7/yCrxZGWOno0A92NnUQr9/SgfC
         tl79Fge1LLH+46NVX+EQ7B/PuVJyIahMXJGO9XkPpXpSFe+pm89JAtLGE/0JdClQPhoz
         Kc9mNjuJQ+Q05tqoZG90y81imr2ErQ3bEpkBSsufnHt3ZMrxPXfKnHDsJmgt4dzC5GK9
         wzi8Rwzu300x3tiHyytS6KmFjFgpPld5wTJ4sywe6xDmHqbKuFusKKfxisvA1/XmL96o
         AYTmMI2jSPWhBlm48Uk7IY8HI2CWP27EDvGqOOBV8QHrsstxuZSZAEjak1PzhytIgt8L
         lssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774545059; x=1775149859;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b6r224pc1M7FavILiplRKh/EJYto+mOVLIPyko1UisY=;
        b=L21QGGTXbAPZqP2wRkvUnL3wHiD9m7ACGrJY2XTp0aEyyuk547w0e/4MxUANJcDp5G
         pJbg1yf8HSkRc+KOSCz/gYoZ/yeJBD2aasFF1RQr+oqZK3uQq/64IAHfoGgpugYioke8
         yXSYJngUAU1UECJ3rrRxNjcEPmsEARQe2BTF1yey+S1DabmHpsO37MznOFutv9bnY9iD
         qLOLddGTWxsussGHrq3YrtgVt0U7NOTtd1KSxQ3m8VcyFvHaoRajYZt3BZIRbzcKdubo
         2Jd0U9sDTpi13pFzMSaPnWeHOAqrQiUoPS8XdIrkZxFrdRwwsHWl5S4oG+yHoA5bUs4t
         nyHg==
X-Forwarded-Encrypted: i=1; AJvYcCVNtSMARapPpCrNKV0ER5eJs+7SwmFx2+G8bEFkWXHMQpse7JCurpcs6MG42UpjICwl0DvUJXDMTvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrGo2G6HDuE4kuBp4h7NoONP5wUWEV6P/ylr6n7hxS3X01KF/J
	pxEawXC1rpzzlG4JilP/Yp7SWMnneeZJX0R6EBczcSKvb3gOCohJ1ESPiGvb0N2B78kxwR3bram
	bKXcvOUhxLzZ7bfBfWUVZwUBZ8zk5kQZVQF2kHRSBOMoons4eMifHgZO+EtV4VVA=
X-Gm-Gg: ATEYQzzo7jA6jI8Wl5brL1tZLHDEWXuDqkeTfxKDCxysKeeLllsyfuWAs51mLY5LCFd
	/HPW1UeOGTJwLFCQzWoUpoxFuZX8vaI+/9flpB1Z4QdGGCtTAJHtepm2qHpk1qKvfLq/fbCY31F
	W7Zf5M4wQso3pbUA8qaFr1Ua7SBmFkzM8ilgBNWqWw3Feby2zI511pCisbtezQY0uD8JScqEdxZ
	m7FuFcliYXQ6OlPcVhz3ApyBj4sZHnUFPfsBAWAHAwrj/Gp6ph9cPMH/RWv6JHcBR50Ry9iBlib
	rvx/9nmN+f0LF8/WISqUdbu35XTzBOdVmwXbOM+2XamWai+8TPuVR+K1Uo+GPcMuvz6832ZbP1K
	Qc+e1DPqqhmKt0/aczNprpuY=
X-Received: by 2002:a17:903:1b08:b0:2ae:567f:fd7f with SMTP id d9443c01a7336-2b0b0b5cb06mr95354015ad.53.1774545059095;
        Thu, 26 Mar 2026 10:10:59 -0700 (PDT)
X-Received: by 2002:a17:903:1b08:b0:2ae:567f:fd7f with SMTP id d9443c01a7336-2b0b0b5cb06mr95353615ad.53.1774545058539;
        Thu, 26 Mar 2026 10:10:58 -0700 (PDT)
Received: from [192.168.1.102] ([117.213.101.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8c4bd3sm37507945ad.63.2026.03.26.10.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 10:10:57 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: hongxing.zhu@nxp.com, l.stach@pengutronix.de, Frank.Li@nxp.com,
        bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, Sherry Sun <sherry.sun@nxp.com>
Cc: imx@lists.linux.dev, kernel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260306021247.991976-1-sherry.sun@nxp.com>
References: <20260306021247.991976-1-sherry.sun@nxp.com>
Subject: Re: [PATCH V2] PCI: imx6: Change imx_pcie_deassert_core_reset() to
 return void
Message-Id: <177454505296.455880.9671929759521493742.b4-ty@b4>
Date: Thu, 26 Mar 2026 22:40:52 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=Vdr6/Vp9 c=1 sm=1 tr=0 ts=69c568a4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=pjPfvbXasfe8cMZvnaMi6g==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pYN8Ckv6pxGYxkbxldgA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: gApL6dnuTwj8w-az0xXZOtuISBgEkDPb
X-Proofpoint-GUID: gApL6dnuTwj8w-az0xXZOtuISBgEkDPb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyMiBTYWx0ZWRfX8PpWIw07cCia
 HGhmFdn3j+U61EVXp5rQNHqxlly1Mp8LnCExlxZ9uMyLgV3HlIq6LVq8I3oHDfya7g1cRtGG9Lf
 n+L6ZO4nXweWLuAmQGOfjwunb9cLWuD2VNkH6XqUYBD5OjHHCqjWZeICM09b3vth873Zt8NpS+j
 56CXvmcjV6yxWMDWuLRERyf/mJzy++OuPM5OSEj8GCMOsXYCdwmrvYmayrijSn7U88PbPYEreWA
 PxKWDJQhmp4afnyqir28FOfFRu/Folz5MQnnU43ebfI5eJNZx0aNuUvi11gMWGfyeyx+7uj5RqH
 IpxEielvgT+xR5fAbjuhnCwTCoH7aHxj6McFTsQTevWOm4GvhrO+d3TkQ6j+0qwBZRbfmX9rE9e
 JPfqTQvVnBKnAG8nISAG/4NVbknlzL7pvzORZxTKRVP5ur5dumUtCrLzUG6hSYTsSw9KgVPRmWq
 lHjF5e1/vK0qVCoJmpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260122


On Fri, 06 Mar 2026 10:12:47 +0800, Sherry Sun wrote:
> The function imx_pcie_deassert_core_reset() always returns 0 and the
> return value is not used meaningfully by its callers.
> 
> Change the return type from int to void to simplify the code and
> remove unnecessary error handling paths. No functional change intended.
> 
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: Change imx_pcie_deassert_core_reset() to return void
      commit: 192b8a1bf81c17852b6cf540c95b0a3bcc9c58c4

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

