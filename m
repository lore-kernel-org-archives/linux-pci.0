Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.183.30.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795563;
	b=X9M9Cj5+jBueBLR/CZsktNsK+8J/Exf4tz4pG94+jV2/OjxAfQjbP3LheOzp9PBXAwbD
	 wv53E+ehtZeB2u4KPX1IWFNmtVPzCpF0UN01xWsqVHboJOzT5ixxlwHK1HlX06ncy/uIm
	 Ohpw7PBrgQq8OcCa1D2UBgvBtSrfOBdliTxhVtUHpWA0mHPhuDGDCZbe29cXfGK7gM6Sy
	 pzkXaGViSrEbH8JTkLq2Gu7CFnooZimZ3flXkitqWJAdT4knXbvyYMHA5yasfwJDujK6k
	 g1rfTJqt2ARwGqfL7u24QHSGEn8L2LmgU9izaAdox1XO4i4tSJFP27HeU4TjOSuaueA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795563;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Sony-BusinessRelay-GUID:X-Proofpoint-Virus-Version:
	 X-Sony-EdgeRelay-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Sony-Outbound-GUID:X-Proofpoint-Virus-Version;
	bh=ocdg/JbjnDcItI5QAROwLtgPo6FsVy1gaj6z/eWhuwk=;
	b=xRCDDzcEIGAFlfCWUmUWIqfcgDBf/63t/Y9PxnA/cn0YzP/wVhPTwYVDzLzVqFCB67+K
	 WmwOdEDqL3PzWWL9/05PbAmkH7XAwRBTb3vQ+vrftwkOYR0FM3ryyJPqphe0KksW2ClqL
	 8AxKMgz26YvGjbe7b9JdVn3Je8yUtghjuroThlFFzGfFgUL0Q5yBMMvpz3C/2fnv2V7I9
	 Z/SBSjfXiJfElsQF+8it6J9xWah3TVqLBxwKUToWULrG8qmisbK8buivW6N9gXhHhsJsh
	 pZYgkw3AA+GQh53aJ9L1kG5ZHTKOS/E+rFkfiuulbyzxkmPVM/wI9WDHXzw8Q1r0cUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sony.com;
	spf=pass smtp.mailfrom=sony.com;
	dkim=pass header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=p1 header.b=AsC9gyxV;
	arc=none smtp.remote-ip=185.183.30.70
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E369606A31E
	for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2026 22:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E369606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=p1 header.b=AsC9gyxV
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NMj4Wh1420297;
	Fri, 23 Oct 2026 22:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=ocdg/Jb
	jnDcItI5QAROwLtgPo6FsVy1gaj6z/eWhuwk=; b=AsC9gyxVeP9593CY1uUXAGh
	jzX0sFbzBd5hkTLMSxx8xxPsT6YiVQTuxMHDbFv4rQitbI1SDoOIMLfum+V2/v3g
	GH8KHP+gi+PM3jtnY1RU5YRhSYwCQ40QWYUKWfyuWWdll4uj3nH2kIr6qsFr2/3z
	rOCOhTVX+4rCHCuH1NDfwj36+RjEZOcmVELRD2ajFxeNJe1+j0ilGAguKsHE2X/C
	LWwhErSYh3zMjh5s5638U6ilhgScLIqDuf0aVFxsHCBoUyeKXzOnFFHOnjWkvdMJ
	gHpPDD/xiT7CJWxh/OrxehEz9oUN6svz7oJqEVfphEOEt1USjwKiyX2XBvdm9mQ=
	=
Received: from sgppsea01v.sg.gdce.sony.com.sg ([121.100.43.225])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4hdw4yw9xe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 23 Oct 2026 22:45:25 +0000 (GMT)
Received: from pps.filterd (SGPPSEA01v.sg.gdce.sony.com.sg [127.0.0.1])
	by SGPPSEA01v.sg.gdce.sony.com.sg (8.18.1.11/8.18.1.11) with ESMTP id 69NLuUhM1536605;
	Fri, 23 Oct 2026 22:45:22 GMT
Received: from usculxsnt12v.am.sony.com ([146.215.230.186])
	by SGPPSEA01v.sg.gdce.sony.com.sg (PPS) with ESMTPS id 4hc4qag6nu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 22:45:22 +0000 (GMT)
Received: from pps.filterd (USCULXSNT12v.am.sony.com [127.0.0.1])
	by USCULXSNT12v.am.sony.com (8.18.1.11/8.18.1.11) with ESMTP id 69NM71nB2512675;
	Fri, 23 Oct 2026 22:45:20 GMT
Received: from us842f57abef3e ([10.10.10.214])
	by USCULXSNT12v.am.sony.com (PPS) with ESMTPS id 4hdcefxsme-1
	(version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256 verify=NOT);
	Fri, 23 Oct 2026 22:45:20 +0000 (GMT)
From: Maciej Grochowski <Maciej.Grochowski@sony.com>
To: Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Nikolas Joshua Britton <nbritton@exabit.io>,
        Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>,
        Alexey Fomenko <alexey.fomenko@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>,
        Mesih Kilinc <Mesih.Kilinc@sony.com>
Subject: Re: [PATCH v4 0/7] PCI: Resource placement algorithm fixe
Date: Fri, 23 Oct 2026 15:45:18 -0700
Message-ID: <20261023224518.80653-1-Maciej.Grochowski@sony.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
References: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Sony-BusinessRelay-GUID: x5IRshrKW55zRpe9EBP9gsxXITBkjcnL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Sony-EdgeRelay-GUID: xoWvK6l_KKea92Uqu8eIwyrCc8Fm82QX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4OSBTYWx0ZWRfX0vQJbk2C5yKP
 +dcKfNT1ZyAeQMiElcaCPdjoOhEd3zCDaOrjshVg9F2gKOEoiJDgL6dbUqS3lV+9S6mw9ItfDln
 zyQJa2QsVTadY28r3CX/gFjkowu4wtpSaqkxAVmY0BOBYzrL+s53
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4OSBTYWx0ZWRfXzHCYqttqXIa0
 lG8s44JZTA5AssJoVkbwx2I7BKfiO4cwDzQi05QqtaThlYk82x/Ef2KE2VwKbVcxL7beXTOB29k
 cGcuMyukouJsbvL7kjsd7ro1o4PMIz3GxU5vZpkG1gQPSRiNlQ+SzuOLrSughEIXEelC/po+2D8
 cLQbv7dx9T5Ii7LAtJ2H3rEly5Y8Lh/RB/GJysO7ShnyaN1iN7kBBQBg7LkmavAhFlIDVw4GTdJ
 5HTRATDAItZqjzYoxrsHShiLm0PCUj8SJinOIWHb7CJu8VzCISHAr2B6z1kISFIuFsj1OI+Id+F
 BR73L5QLbOU4YqGNszVU10YY8dFMbKtyqqELQLy2hzOhSfH3nqewmXtk+mxDIPYv59gsf4xazqY
 KJ7uM6o1kgHg7U9momb0aTO05KDmOmV9uBg2mt2kY/ByNVEAYmHaJkFQ0kCxOke+eyPBTzEUKzL
 aGTN7lD172BSdqvIw3w==
X-Proofpoint-GUID: kovLTJBzzqaGXWqF__swo3aWy3TtdeI2
X-Proofpoint-ORIG-GUID: kovLTJBzzqaGXWqF__swo3aWy3TtdeI2
X-Authority-Analysis: v=2.4 cv=XK+l2ghE c=1 sm=1 tr=0 ts=6adbe386 cx=c_pps
 a=XNW8778QP6juiAqijDMnrw==:117 a=XNW8778QP6juiAqijDMnrw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KAb5x4SsHD3PzxGk7EmX:22 a=XGr2FpfLDd2dUKU_94WB:22 a=HM1u4s5SZPqGU_3Sr3gA:9
 a=QEXdDO2ut3YA:10
X-Sony-Outbound-GUID: kovLTJBzzqaGXWqF__swo3aWy3TtdeI2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01

Hi Ilpo,

Thank you for the v4 patches, and sorry for the delayed feedback on v2.
Mesih (CC'd) tested your full v2 seven-patch series on our
Switchtec-based platform, with positive results.

The test used a backport to our Linux 6.18.20 platform tree, with
additional allocator prerequisites included and our local
max() -> ALIGN() workaround reverted. This is therefore feedback
on the backported series rather than a test on its upstream base.

The kernel boots successfully, all eight endpoints have
BAR0, BAR2 and BAR4 assigned, and switchtec detects all nine
switches. No BAR assignment failures were observed in the boot log.

One difference from my original report is that BAR4 is enabled in
this test; the earlier report described a configuration with BAR4
suppressed. The total BAR allocation across the eight endpoints
is now 288 MiB.

We also compared /proc/iomem against the earlier kernel carrying
our ALIGN() workaround. The enclosing prefetchable bridge window
is 387 MiB with the backported v2 series, versus 384 MiB with the
workaround, while the total endpoint BAR allocation is unchanged.
So this test shows successful assignment, but no address-space
reduction for this configuration. I do not yet have the detailed
placement traces needed to explain the 3 MiB difference.

We will now also test v4 and report back. Could the changes since v2
affect this window-size result, or is this amount of padding expected
for this topology? Please let us know which logs or allocator traces
would be most useful to collect with the v4 test.

Thanks,
Maciej
