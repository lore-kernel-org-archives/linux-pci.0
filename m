Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6690F4AA414
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050876; cv=none; b=cCEXSGf5NEstJWLhA8ZKx+lz/TmAzvvnD1TKI+gcMERq0efzEdLeIymQt0XYMvTSjbvNMjwLaKiYQOhOLq9ijQdtvkMfnpLqjpNl77oQZ6OPxTRfq3KrJuJxsq21/dyBfat5iUj+R+TOhckwZByVxaOKLcbyX3RW9FihwbVjbEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050876; c=relaxed/simple;
	bh=hVteIZnn/KZGhwyV6npF3HFMEF8PGQ8W2HWu0o+zPKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aftpDLB5ulWXxW8kKWYuhKSZB+TlcJXNU1onGqtRgsJwAvnGHmOP28m/zy3D97tX7Gd4gfQ3NUMVQW2Tzyi6vU8mbMg8beWx7Ki2n/4XgDZZQEov2ujkAgojL87CIrbjMgjLb3SQYKzeyrOw7L7Am0EgcR5qOWFgvHM8t1Y0juk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BUOJCsjs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Px6kr8sV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BUOJCsjs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Px6kr8sV"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F65Wkx644567
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 07:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1dJSG07GXyGKGiQW7TmuVDezgqv6wfOW05ypU5gMGE0=; b=BUOJCsjsIAqYjHJI
	AF3wypISTszN5hD+N7W+fcozerWK14lPAXXETxlWb11U5SEVyHO/pcaU2dDcBtfb
	L//nsOQN1X4j1tSgtPbLKcSMbS1eg1p6CmFKJ9BgZ8SgrbHrqEGovvgNS0GszWZW
	K/jrfOmXFu0hg6JvTfXD64s5h9xg7X6BNtG346VVjeHhYMIrUJEsoP0JwsITp6xi
	9tha3OXTg8lKiWDA/TM4hikFaMe2MZKqZ/F4uPgLGVnMRmgtG/JoPRpCQ1uIY+IS
	hIKCshKsh179sXkZwBMGuPNbFnNziTtXIEWzd+R+CkWS9PncY10GOsjoq/BMKATA
	bkP3BA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hajmy9txp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 07:54:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfc52ddc55so19100355ad.3
        for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 00:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792050872; x=1792655672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1dJSG07GXyGKGiQW7TmuVDezgqv6wfOW05ypU5gMGE0=;
        b=Px6kr8sV6z102UhliOUl1fkIIc3wG4qP3hgJ6F1jlXuAmTidRVyHCDFNdgVX7jXp3R
         zpwXHLHpI7dueHMxIS89d2DM0BunsrrVgN+6oGFydby0wcUGxy0k+JlVnZWEZsub46KA
         FufB/pzHmNKnQ+MUTgSU9598rS8yY+Q54IRvw2U91U4mku0Oy7SEBABjkisYndGsxOGt
         GcJ/Qfm1zI+QszJng9ndGhSPcslj15u6vS8VL3pJRgwa7po4eiixcuvI5+ip7+bMoSW7
         dYN9epv7O4n6nh2qXUSeViEsSwL50Wn40EkFRHGrDKvVFEZtC9xJYclMmBT1sW2JnNK8
         PGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050872; x=1792655672;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1dJSG07GXyGKGiQW7TmuVDezgqv6wfOW05ypU5gMGE0=;
        b=zVZQoZb2/qIUMn/G1HF18G6+uN+JSc2h8SIwFVg1/2wHKJsaFV2EmnSvxqsEOTYV2t
         QbrTsCM3shd0qsMbZFmBUFa6U8PKS7q20sN6EE+Pl0jivCzn+Bz2z2RxKbrRSJZtpyZx
         P0GuHXbkSQqR0gwwqhbuhMX36tAFjIduUwsWQxZTjmo/Va0ccokIpCBNGIAr+MqLGYMt
         J+H1wJMEmROvIffEddR5cPVyqbGwv3RlOIbQPIf1vFDcFHHO3rYNoH2xnRgfDd+Aktyf
         SQ+mmUPHAj2UaNBsoWvMU7rFSSRhIYgvWOnf/01x4FemU3wIRcQTstZxAgYUkOLe7AL0
         pKPA==
X-Forwarded-Encrypted: i=1; AKwUvBxn/Dx0f8cf42M0lEapyW0F/uxJjQ34myS2TryE6yJEKy+7tRsdPAVjnVdpOGvdDA6tY41nnqAJYLo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMITKzXKIWBAFYuXQw5Bxhg04/ylVKQG/xX9emIsy0vTsFua5w
	6nHb0xTt3uJcNQ7ZPtuB6xyEUZ1MvG8yEFzi/B4X+hopdOu0QeqWnHNBZTICCWWgq1/eiPUBYbI
	IqfE6Uecyrrv0Hd/S/B6JmLPg5I8GcYdR4meu4H1haIj6lhxraGHXruaR2n2pxGcWXq+57NA=
X-Gm-Gg: AYBFou2UATM7rehYvHgQZljN0J3rwlaC2y5Z/BAWmHWN8p2MSSCLnLAm5Zrd+3vDk5l
	n0AwC/HzOKHxiL1geKz7F5FUAP+Mv+9GOt+7CS5Bosn0OfLBCcavAphMROiBu5kZFRn9SPEfOno
	skX+m++RzqHLkJIwuV3M9alpAsnMxU1UWDMzetdJ10gy5FIbvXG1aDOL9gWlqqWOKo98R8wbee7
	LrvVWEA2kYc7HsRU7Q1W50FzFYdvuV+uPJ2McOXKkmhdimG1PFSqP/IZxf9ayrDhMyPgSdurtux
	uLhNBWamMsHRzlhAJaxzGT8yAddYhKm0nRB30pu52pvK7hKtIsTAOylFzTmwEwFzL9XdDc+up07
	YFxt/ph0lRpIkILB8lNPn+sSDB5xXLaRCeQDP/HH/ZRFwh91+wyYidbz7FP2HMb3W9L+6HFHW
X-Received: by 2002:a17:903:110e:b0:2e9:2a1a:8b69 with SMTP id d9443c01a7336-2e92a1a8ba7mr57665895ad.55.1792050871820;
        Thu, 15 Oct 2026 00:54:31 -0700 (PDT)
X-Received: by 2002:a17:903:110e:b0:2e9:2a1a:8b69 with SMTP id d9443c01a7336-2e92a1a8ba7mr57665605ad.55.1792050871349;
        Thu, 15 Oct 2026 00:54:31 -0700 (PDT)
Received: from [10.133.33.32] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm76306455ad.54.2026.10.15.00.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 00:54:30 -0700 (PDT)
Message-ID: <56832d7b-e7a1-49c6-8995-4b17a442e4e6@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 15:54:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Enable Qualcomm WiFi PCIe passthrough to VMs
To: Jason Gunthorpe <jgg@ziepe.ca>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, alex@shazbot.org,
        bhelgaas@google.com, jjohnson@kernel.org, johannes@sipsolutions.net,
        mani@kernel.org, yishaih@nvidia.com, skolothumtho@nvidia.com,
        kevin.tian@intel.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
References: <20261011074514.515894-1-jtornosm@redhat.com>
 <b1a3f755-19e3-407e-b8f8-b494de83f59a@oss.qualcomm.com>
 <20261012144835.GG14213@ziepe.ca>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261012144835.GG14213@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: n8ZGDdK2wSZzbvF3U07nSO6cJ-0ycK0s
X-Proofpoint-ORIG-GUID: n8ZGDdK2wSZzbvF3U07nSO6cJ-0ycK0s
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzMSBTYWx0ZWRfX4efoLhnRLvNW
 9xHkSNSRrCbhonTOj9KLQC/nhH2dwkUKFpmbMdLWlVSjGH33+sipET4Ht3uzNZkyjosswq85pmB
 JSKXQ04SWFqRIOmXXMTdLJZSPotjsVc=
X-Authority-Analysis: v=2.4 cv=TbQDJhQh c=1 sm=1 tr=0 ts=6ad086b8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=n56IT1IzDtYYEsRGsiEA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzMSBTYWx0ZWRfX2Q/51qCrlmNU
 oTjHlrX2EJVyvf0Kx0Mmx8huMzjLcTfkC6PUxI/wUsvEKi1gZeSsuyNfSImD2HAxfq3e5uQmBgb
 Jkmvdj3AZh836Vm4REyoI9iidM1dMzRcVBU+TQvEQ0j0LQDtC2xY6bQCEiObjP64xyYUWo9kIfr
 F+71X5ouNnCzuCiqcC6GDkfmBT0HT3u55Cp9pCWr64e+oUJGwDciCwKbKek4cCeaWUFcPDAWzAQ
 IhWkeNmBCpuul7BRqGhF0V+2/g20BXGNSH3uVlijHMacJjM+X4BDjPOZaZhwrNWfFixF2hq7qVA
 6EE1S2QstQkh5Oph8c35ClAfzeUj+swsgEqdgNCG3LCKYJdpajkZYpZSbM/svogHU1cCQobHDeM
 SFptjdKJeprPHcp92YePE2KqZcKSo19Lf31mBgRix7H9ixo5ZrT+gjzqLz0oVnJLrSy+3+bjZun
 ggL8SPuG+YFnit/VG1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150031



On 10/12/2026 10:48 PM, Jason Gunthorpe wrote:
> On Sun, Oct 11, 2026 at 11:22:26AM -0700, Jeff Johnson wrote:
> 
>> Thank you for providing this level of detail in your cover letter. I've raised
>> this issue with the engineering team in the past, but I've once again raised
>> the issue with your in-depth analysis.
> 
> The main issue here is the driver can't use a normal MSI-X in the
> normal MSI-X table.

to be accurate, it is MSI :)

> 
> "private" MSI registers don't work for virtualization.
> 
> Jason

