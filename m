Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795323312;
	b=4DA6YgUltkf2+1WJuraDgcJaGrKrT41QCEzk8NTk6vtQXfSu45HX/CI0+z9SNJ+B2GFZ
	 NaMnX9iSZ9/GaqZs53ozyhDdLjKh0xNDC9EFZrkjj8sq4W2BScSZchjOgByMeiu2C4sP0
	 1YmysSbj5ZW/k/62cwaUMcy1BFcPugb5irwv+uGEfoOnnWmhsTbFylte/5rzksYYSz71N
	 ttgMdGp6RC6KIMrBYcenAlYHAZPAn/cwEQgqwoltvt+MeOFQXGHwunryTmiOFqZJlUQce
	 NmGl8WkCHtuQAPlSSV1FZNmKUaHSr/+O2ZSqZuqWW1PzUZnxFDgzZEA2MOAT5tlBO2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795323312;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sFK/R4c0poG/FG4RxVSocEb5PVecbVCkgzZGZhb62FM=;
	b=OHUvAbAeri+p47fVCu3L2Xcg/WLc9pFrNGx/0mxfJG9FR9623+w2McUnGD24UyKOeCwH
	 yW5sjLHcSlw3DKeDkK+LfgtnqktbK/lgBUoCKKqSMste1Gdd2RnC+/55HjPYhYCHhoL8O
	 0CIvr8v+04uyuSIe1sLSbidUzQCr781lExxySQpAlXw2I4u9JBEX2cgv1R4tewff20QyI
	 0Euj+taE8nPUeEvUc+K5B9A2RXHDfeajVTWOTslI+d4YzfReOOZ+8GV/2VIbyW+3XsVlE
	 DhO+X3gImeO1FgvhO+EAgL5vzENBMOWsyaBdnCuyBCekHD5T9X95mvrFUMo+wfh9CUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ROfVrLnr;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6CC606A32A
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 04:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB6CC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ROfVrLnr
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM44s6G3865827;
	Sun, 22 Nov 2026 04:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sFK/R4
	c0poG/FG4RxVSocEb5PVecbVCkgzZGZhb62FM=; b=ROfVrLnrm0wd1jse7PMcLx
	rh9/mFB58VjTjEmqTqoPXg0tr9mZouUsaUyqRoYcz4p+mL98t9uE1SvNr6WpFSZi
	yZ3Ch6Y1J5mgSwhCqXn/Yom8jnnL7Id4jJoWZxUq1G1wsAeQKUq7/zYG3C3Od4GP
	yMCFSY0f3wjLcKhuYpbdLb3L6NOsbNloc95oxQ74mwNbSfOBK0IAvNZbr3fXAodk
	IvLOBHPyV2Q3FiCv8nB6rmwQsiAf7SwSxS1m2HrJYNJ537WM4gV0fh6PjVIcuD9X
	xvLsw4XGMGmmK2R+3/c+Y3wiJY7m2wmeK3fPgcNg9nX4hi6RwMXKtB/sSTf2lopw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34f9w0rn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:55:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM3nEM33858926;
	Sun, 22 Nov 2026 04:55:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3nmq8srt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:55:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AM4t38D38470004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Nov 2026 04:55:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7017220049;
	Sun, 22 Nov 2026 04:55:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C75F720040;
	Sun, 22 Nov 2026 04:55:01 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.90.96])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 22 Nov 2026 04:55:01 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update EEH maintainer details
Date: Sun, 22 Nov 2026 10:25:00 +0530
Message-ID: <179532322359.92012.9567942230404543929.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261022101342.2962384-1-mahesh@linux.ibm.com>
References: <20261022101342.2962384-1-mahesh@linux.ibm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAxOCBTYWx0ZWRfX9QEX1+Tr7lHD
 FJagXkAS7SRlJQocvgdLNTE7ylaox3C6iuC1v29s9V9IzgElUuHRVyDOB9bq1ba3LECDOgGOU5V
 bWtxgrRk4eru/Qp9GXHcDOVK/FMy1AT3R4cBSi5Cmelxg8LnlDZlhtRTwwtKHQAm5Bj0bMniYID
 AbnqS8gdRWKJ7oZ8wLl3U/WB/0sODr7geFaM7GbicZKRDfTILBuMvTV1yHcp6BSE24hUFRnIeie
 +p4R5zfgQHDqtYv8eOYcergGW8bjpCcHT6AG3s8DAi9+8xJnZ0QQJEySSyKqFDeakHIMPMqyJoX
 IP7DO8kAWFLzHrNIPmgaWcMJTckp/1MKtQRD+LKRMLpmcC+PiWiyWixim9x1g7A21QRvFZznt8L
 1dd9lJcN7V1NiPRmT7buVWKUq/Fegt4Se2V0PoHfBnXb5mMn1VU25wKkRfLe+bj0uPFeoRuF1PV
 6oqhcCyNBd3wbQJP/Fg==
X-Proofpoint-ORIG-GUID: X-2OldH3euhss10HnpfqHDz3ENNpuReE
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b0275ab cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=WJ7z8vSSY5dUVx7f5EEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: X-2OldH3euhss10HnpfqHDz3ENNpuReE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAxOCBTYWx0ZWRfX8IkeL/Dnw8GC
 4ihE5cW0DwlrhBYKlJkbNWD5hpHMdDFVgU86f9Hg4SmPSn/uAWUUlUjB+bAPA5/sRMBenW7J5pm
 ECxjEfjcDMTXqqt9saVWXo8ZQm4viRc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611220018

On Thu, 22 Oct 2026 15:43:42 +0530, Mahesh Salgaonkar wrote:
> I no longer have the bandwidth to maintain EEH. Sourabh Jain has
> graciously agreed to take over as the new maintainer.
> 
> - Add Sourabh Jain as EEH maintainer
> - Remove myself from the EEH maintainer role
> 
> Thank you Sourabh for stepping up and ensuring continued support for
> EEH.
> 
> [...]

Applied to powerpc/fixes.

[1/1] MAINTAINERS: Update EEH maintainer details
      https://git.kernel.org/powerpc/c/80e03f76f00c092377708da697a103b903026452

cheers
