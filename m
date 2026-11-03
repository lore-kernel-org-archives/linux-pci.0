Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.183.30.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690424;
	b=d6dDiVFeiz+35wIN0QqivH7lmV1vHNysm87PW3imyYMz28eO5E4BV4jVrnBwEY4Dvy52
	 GKFtvqiOj4R23+acifQ00Vda0bnnQnoni9xW0+AVBY1xlAHVX6XXZcCB/vwPRo1PUTfN9
	 EDnLWT0fuK0jHO+4ur6RCOis6xfS0NHTp5YbRbaxagDtVZ4PnqDRd0+5TXidkOnb7Smsx
	 nAIg5vUNV2CdMi/aEj6ibHQHJrbqkw6+QmZ21yLxglJKHirdKSvmhj2tR1dGiCjJIBy6Q
	 gRyTWpvP1Mub6GWMNjnJA+NkO48TOUsSF3nTUCnOVy2xaasXCBiMs0j/CX+tvBdxKjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690424;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Sony-BusinessRelay-GUID:X-Proofpoint-Virus-Version:
	 X-Sony-EdgeRelay-GUID:X-Proofpoint-Virus-Version:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Sony-Outbound-GUID:X-Proofpoint-Virus-Version;
	bh=ONacZA2IlUbb1cp8eEt922uuAV4DZI66JC7mLtN87ms=;
	b=x17TzcRZbfshXrGU9DE3NXg2pqYy8SNs3L+UK8+XZBMo3H1+UMrJzxTFsaaeRjdTmbBH
	 W7S/ChkrcTgdEhBfknXSbUWDq+uq2obmUkiemtGhq/dUOnqSYl/DHXjpp9skhhl/ro3HO
	 whXABwcOtbT7LMlX/JUr2cp0d+rGUO/MsuegVdz7kqODjabxBDglCddkDRxe2FC+5qTE6
	 BZ68oA1DKPunbXD3NAZCnPkiOIaNF6nmw0YPgDWgpyxpF4XVT2ZcrWZq9JIU665AKCtzy
	 WtAx0444HMl1/MzJScrXbXAIUysAQbyCJpUdw5XenY7NqTdZCSmqCKl8YKazfylhEsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sony.com;
	spf=pass smtp.mailfrom=sony.com;
	dkim=pass header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=p1 header.b=bOTzZ3cW;
	arc=none smtp.remote-ip=185.183.30.70
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078EB606A329;
	Tue,  3 Nov 2026 07:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 078EB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=p1 header.b=bOTzZ3cW
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A35vqTM2833910;
	Tue, 3 Nov 2026 07:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=ONacZA2
	IlUbb1cp8eEt922uuAV4DZI66JC7mLtN87ms=; b=bOTzZ3cWwgNvSBOvMFb1xXD
	GUSjJ/8QmFLmAS86MY2UqcGE+5wAjfAtapO9TeUX5If6ZrthTtTKLZ89Qf0D5wSL
	0P83gBv8CgNVebOOecQ0zVUe0v0V7c/yhq0pGwNQQSilhq/OtUFwOG7BONeWxf+m
	pUPshPLTtjYtBSF5pkKrAKZyMKW+E5S14p/VhsQ2yCmMKBG+SexnbeqatZVGf+YX
	csGngGjM0DHbi0XFk2oJoce+dhBl61lzP1CcBPv21rj9ovzRPxNeiBA7UNe9NJzP
	/tz2r0w6OofiIcpsvWpb/2R/jTf/BsbKQMzdV5iJJzLhjoZx3U12zDnPO0U7uVA=
	=
Received: from sgppsea01v.sg.gdce.sony.com.sg ([121.100.43.225])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4hn743baw1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 03 Nov 2026 07:19:45 +0000 (GMT)
Received: from pps.filterd (SGPPSEA01v.sg.gdce.sony.com.sg [127.0.0.1])
	by SGPPSEA01v.sg.gdce.sony.com.sg (8.18.1.11/8.18.1.11) with ESMTP id 6A35a1Wb584139;
	Tue, 3 Nov 2026 07:19:42 GMT
Received: from usculxsnt13v.am.sony.com ([146.215.230.187])
	by SGPPSEA01v.sg.gdce.sony.com.sg (PPS) with ESMTPS id 4hn9dgk8bg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 07:19:42 +0000 (GMT)
Received: from pps.filterd (USCULXSNT13v.am.sony.com [127.0.0.1])
	by USCULXSNT13v.am.sony.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3794FB4053419;
	Tue, 3 Nov 2026 07:19:40 GMT
Received: from us842f57abef3e ([10.10.10.214])
	by USCULXSNT13v.am.sony.com (PPS) with ESMTPS id 4hn7keq5t8-1
	(version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256 verify=NOT);
	Tue, 03 Nov 2026 07:19:39 +0000 (GMT)
From: Maciej Grochowski <Maciej.Grochowski@sony.com>
To: Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Nikolas Joshua Britton <nbritton@exabit.io>,
        Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>,
        Alexey Fomenko <alexey.fomenko@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>,
        Mesih Kilinc <Mesih.Kilinc@sony.com>
Subject: Re: [PATCH v4 0/7] PCI: Resource placement algorithm fixe
Date: Mon,  2 Nov 2026 23:19:30 -0800
Message-ID: <20261103071937.37940-1-Maciej.Grochowski@sony.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
References: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Sony-BusinessRelay-GUID: 4A1t5G8UbwH6zWE8dE2pfmKpipJqoMEZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Sony-EdgeRelay-GUID: Zvqw4pyaadM_KBvCBIlaREh5efCx4pPX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Authority-Analysis: v=2.4 cv=C+Z8WgP+ c=1 sm=1 tr=0 ts=6ae98b11 cx=c_pps
 a=XNW8778QP6juiAqijDMnrw==:117 a=XNW8778QP6juiAqijDMnrw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KAb5x4SsHD3PzxGk7EmX:22 a=cIyGuqrkuvkXWOl_fzuj:22 a=hv4kebVBQj_3QzTFHUsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xNEfkGf9rHyq82-ZwnIK_enn2KT-VdR5
X-Proofpoint-ORIG-GUID: xNEfkGf9rHyq82-ZwnIK_enn2KT-VdR5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyOCBTYWx0ZWRfX3PUr7lPig9Se
 zn16L6Wg55hwTmN0t7ZYilywY3Y3zJlYWMCoknm5y3Ink19etBtNNnOLSzejRQcBIqJct8xYVRq
 IH3Fr0IjEec0/cSc/v/eXoIhzub3ueJYNlh6fD1vmJzoFsJPgUZRA9RuG4VQhAcQZzPaoCvPMHW
 IMB//YZ8Tiy6NB+2tnPwvt9Q7x0M+4zTaVFZoIk8FZpN+bm9uSa+XzGVosHtTg0k7mpQKYurx2a
 elaRAwNyvafmMbCF9hEXiEaeByjcsk9zcsNSqNjEN9CK0nJexzaYafh1HtTcMddMHdt/AElyOwh
 /Fu81GxqB8k24iKuy6xS04QjJDlo6mhdxaL5TY6hVi4RsSZOMNrJwnYg5HlWpgF52U3YTxkMHdp
 +SetR48vSNMMxd+fDJwFCUTdhbm8hf8a9IJVNiFVcwIEtuZTa5rRAdGfqp7Tmj0y7DPI2ItZlzp
 7/Yb5rvb97Ne4coVk1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyOCBTYWx0ZWRfXxqmaFcbHRZ89
 hlMFyHdqKjws20ESyrG6oRJsRzW2zlfg1xyEGjVY9ZgJcWk9APPTqZpGva3vP6z1g+HzBtR05Ui
 MCo4JPH1haiF6y/ceu7nDG55f1L8bCSi+4WcoK7vsasMXZPaSkBG
X-Sony-Outbound-GUID: xNEfkGf9rHyq82-ZwnIK_enn2KT-VdR5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01

Hi Ilpo,

Thanks for the update. We already had the v4 backport in testing when
you asked us to wait for v5, so here are Mesih's sizing results.

Our setup has an AST2720 root complex, a Microchip PM50052 switch and
eight Microchip PCI1003 devices. The BAR resource sizes per PCI1003 are:

  16 MiB + 16 MiB + 4 MiB = 36 MiB

That gives 288 MiB across all eight devices.

The prefetchable bridge window is still 387 MiB with v4, the same as v2,
compared with 384 MiB using our local max() -> ALIGN() workaround.

Looking at pbus_size_mem(), I think the extra 3 MiB may come from three
unused prefetchable bridge windows: 0001:02:08.0, 09.0 and 0a.0. One
branch is empty; the other two have Pericom UARTs with non-prefetchable
BARs.

V4 keeps:

  size += max(r_size, align);

For a zero-sized window aligned to 1 MiB, max() contributes 1 MiB, while
ALIGN() contributes zero. That would account for the difference if all
three resources reach this loop. Together with 96 MiB of alignment
padding, this gives 387 MiB instead of 384 MiB.

pbus_size_mem_optional() returns false when realloc_head is NULL, but we
have not yet traced the resource flags and alignment at each level to
confirm this explanation.

Is that minimum contribution intentional for empty prefetchable windows,
or should zero-sized windows be skipped in this pass?

So far we have compared sizing only. We do not yet have a complete
allocator trace or a verified v4 BAR-assignment result.

Thanks,
Maciej
