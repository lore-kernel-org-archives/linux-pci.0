Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C4F4E3769
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663160; cv=none; b=jeLRcovGPvY6txZCHh6leueQoKCKIMlMFWiNAqYmaAzMSA9mLw/UlxzlLzGhYPIEP0yiWrOhJ5UpwAcQdANu70EUJAt3Qp6h/ELm8PYXo1kWcyrdY/vRbcoJD0AjPhNVEIwMmEJ+zKtPEcT8iiFs31NjiYJcK8ZO6LrWoftv0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663160; c=relaxed/simple;
	bh=WPm+JeMA5bnr3Y8GwDozRhRLEnd0yTAg4HGkUhgNUzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qX3inKSzZv+OHLK6Bn6UAZ5U6C1mKzXPGKySMZrrM8hLEZ+LYovnSUJa5qWp5+4lXf3Ko+zZOaeLlfJFCrNBjpkNe9V5t4U/9XJuOvfXtDc5g9nBhrWIyUKDWNyTG0hvSKWEJcs7EJ8cxcx/R1hcf8EB4x8ys9cN285kThDwjK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=kGB6CNj2; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="kGB6CNj2"
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HFa3982423365;
	Thu, 17 Sep 2026 17:17:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=apr2026.eng;
	 bh=lXpZq4IrFb1XNILkhyM45GFG2R5DSig5pPKJZ61pWAc=; b=kGB6CNj2jP3V
	FSr+9aZrMCJ9L3KVpvsSzvBrc9hzhhbq3ZDqPTQ+4m1biqaU9biZsX2QhoJg9XP0
	cueitiGUKnbdhctQpsX8129b/ZFJ1yw6heaMTm/iGnjt4FfDRkQttqnSchUWNCXh
	tFeITs9ODhukWgmE+i376XXnIrAbawKGBGw5ETUX72QND0Zju+2S8J1SzcWXpNMM
	uycA4N0A8dXoH2Hgc2Scaw9oX4SEWb2JlN0y0M86cvcW3ZZrSPGX75XNKEi27v+V
	/syVbbsvIoWddJFdE0lacTJ+PVOU4aeSQBvxi27k/NskXpW1OIdgO6EQegw5/eRu
	S/WdX8IpvQ==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4gmy5mnyek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 17:17:06 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 68HG6QTj029344;
	Thu, 17 Sep 2026 09:17:05 -0700
Received: from email.msg.corp.akamai.com ([172.27.91.41])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTPS id 4gn4q7urpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 09:17:05 -0700 (PDT)
Received: from usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 17 Sep 2026 09:17:04 -0700
Received: from bos-lpnz1z1y (172.27.118.139) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 id 15.2.2562.43 via Frontend Transport; Thu, 17 Sep 2026 09:17:04 -0700
Received: by bos-lpnz1z1y (Postfix, from userid 56609)
	id 6C86A241CAB; Thu, 17 Sep 2026 12:17:04 -0400 (EDT)
From: jlefkowi <jlefkowi@akamai.com>
To: <linux-pci@vger.kernel.org>
CC: <mj@ucw.cz>, <bchaney@akamai.com>, <mpelland@akamai.com>,
        jlefkowi
	<jlefkowi@akamai.com>
Subject: [PATCH 3/3] doc: make the documentationf or .V[len] and .V more concise
Date: Thu, 17 Sep 2026 12:16:31 -0400
Message-ID: <20260917161631.801636-4-jlefkowi@akamai.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917161631.801636-1-jlefkowi@akamai.com>
References: <20260917161631.801636-1-jlefkowi@akamai.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2609040000 definitions=main-2609170229
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIzMSBTYWx0ZWRfX4jHGJBzOZ6FB
 BWWNXqOCIRvGhZ1WwygZT3GvOGZuoq9LL2Y+YyApq88/GsjEIsh+yiZ73g7Lqg5MUU/R0mx2DGs
 P9enaMR+ok05LlQY/86pnPsL4I2mFLA=
X-Authority-Analysis: v=2.4 cv=NdtzRGD4 c=1 sm=1 tr=0 ts=6aac1282 cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=4xFXqd-_BHBjZVyr95gr:22 a=X7Ea-ya5AAAA:8 a=Yr43Cvk7q4EZdo6qg7MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIzMSBTYWx0ZWRfX1w140SZphUTq
 nnhtgS4cbZB2W2cE8kY1j8uqkMliCkgJcqSPgO2aAFSz9kb45C36O3xU2JlPB3WU0t5iLMsMlDA
 sD2FouC3Wbnd6ZLfId8F0fjexIhRDvJFelZUZwpy6C7si+luVvXjor5UBc6eS0a1qPjoQpoe4I1
 BLhkED7vR3LTBO8lW03S5wRq+29+C+tlgcow67Mvwbp7csoUlMdjjicrQV5TXpV9HfDAYwnrgY4
 BIgSTSNBYCdIvo/uRF0ziZRDxPuB9GQNvhboRj5WcT7jqHXvJnn8tGBwDOywwIspnGS3NrFbJUk
 cnHRAKH7m/row840/d7jOxoOHBXUSqn08rgI7EwCb7ZAdLsWmETgtIu9z4IdLgFfljVRBorIQx3
 JSZbQymwnQ8t6OqTsFgCT2tDnnSz5zf3lSsQX3JOlA7owEEqP9+qJf15+pp6wvBy7p/wEElJBhO
 u5nGvjltFlCaJIHE89w==
X-Proofpoint-GUID: dMVuYvXzbapq7kWCxXWgnWzsGq_6Qwc6
X-Proofpoint-ORIG-GUID: dMVuYvXzbapq7kWCxXWgnWzsGq_6Qwc6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170231

Update the documentation to be a higher-level overview of the two
functionalities, providing detail into how they work, but removing any
detail that specifically mentions internal functions as they are not
needed.

Signed-off-by: Jacob Lefkowitz jlefkowi@akamai.com
---
 setpci.man | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/setpci.man b/setpci.man
index f39b87e..0e7c1f8 100644
--- a/setpci.man
+++ b/setpci.man
@@ -158,22 +158,14 @@ specifier \fB.B\fP, \fB.W\fP, or \fB.L\fP. The width can be omitted if you are
 referring to a register by its name and the width of the register is well known.
 .IP \(bu
 To operate on a variable-length window larger than a single access, append \fB.V[len]\fP,
-where \fBlen\fP is a hexademical byte count set statically within setpci (4). The window is read
-as a sequence of aligned long accesses, low address first. Each chunk is assembled in
-little-endian, but the final result is in big-endian. This is the opposite of other operations.
-If there is a misalignment, that is fixed in the first couple reads: we will do a two byte and
-a one byte read or one or the other to reach four-byte alignment, and then continue to read four
-bytes. Because PCI configuration space has no atomic access wider than a long, a
-\fB.V[len]\fP operation is \fInot\fP atomic: if the underlying field changes between the
-individual accesses, the value may be read torn.
+where \fBlen\fP is a hexademical byte count set statically within setpci (4). The requested
+number of bytes is printed out in a bite wise fashion with read width and alignment
+being handled internally. Note that this is a non-atomic operation and the result is printed
+in big-endian--opposite of all other operations.
 .IP \(bu
 To use a variable-length window larger than a single access specifically for reads on vendor-defined
-registers / values, you can use .V. In this mode, setpci will, at runtime, dynamically
-determine the length defined within the vendor header. Note that this only works for
-vendor-defined registers like ECAP_DVSEC or ECAP_VNDR. Note that the way in which reading is done and
-the output is produced is the same as the non-automatic variable-length window. That means the
-result is returned in big-endian, which is the \fIopposite\fP of all other operation sizes.
-
+registers / values, you can use .V. Setpci will determine the length at runtime, adjust for any
+offsets provided, and then perform a read with the same semantics as .V[len].
 .IP \(bu
 Finally, if a capability exists multiple times you can choose which one to target using
 \fB@number\fP. Indexing starts at 0.
-- 
2.43.0

