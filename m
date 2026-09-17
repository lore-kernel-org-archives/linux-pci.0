Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD4254705B
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789665102; cv=none; b=BnR64mkGwoXVFq1n+NVI5zO1GIMyjTqK4gWUT7bNwsYOlFgef08vuXqTUsCL8dx5/PcS42kYAZ873z2gOB6Uj70dMSaojUfaNF+DyVzsAJAt7xd+wCovqHkTQk4bQiN3QOXnH8MrIqodos7S86bG2qyGkA++5B3SoS5z9ekcfWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789665102; c=relaxed/simple;
	bh=hsrMEONp5y1IExMVkG695X37L1XA4lSrGYQQlB2ePC8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cH1otW7Qa2EF5ioJJ3Xki4PkCB6VCcoarVeNHwByG6AQf4ROka7cbbEPEqmE+IrtSFQTPXeWOe/Fr2uyC8b67E9asmEsV9sbOVaXL0gOCJ06F+XY2ddPH838vrXjVKG6ypL18fSkEwIlk1TaOVr2lsvwR51VbDMoCYLO/hoXkWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=F2SStVtQ; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="F2SStVtQ"
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
	by m0050102.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 68HFaM4q2733433;
	Thu, 17 Sep 2026 17:17:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=apr2026.eng; bh=i2DXN4n7YaFaRBP9QD4Y
	zzSXf5Q5ziBmoWwyQVjJRik=; b=F2SStVtQEWElXMOMI3CVMOwW/MOv4QNzj3pk
	yElj2bN5NURLZJDRHXmF/lExVcRrJXLfivu6Wje1QwqCrP2luJyQ/v09QmF56VGP
	B6ZtAmSB/bI55VcOcRIo8DwNxesjkkYzQJV3Z/musmqL8XdoUSyEq9DEfZDU+l6v
	tTdu4zoiUVXHF/7AvDW+1mzZlRVIOwS+A+RAMc2sLueTZyLhURjl+ipSasdCt0GR
	TlrTkAQW6XVTaRMhW3hJRuMYLisjxB2ZGFafUOuBqI2HUH+dQomlrK2wqBk7Vyzm
	NSGPplLOaKnDy4JWcPvsq2PV5E/6Lmx8fH/jH3S1TvX5C/bRsA==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
	by m0050102.ppops.net-00190b01. (PPS) with ESMTPS id 4gr021m45t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 17:17:02 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 68HG6Cl8029301;
	Thu, 17 Sep 2026 09:17:02 -0700
Received: from email.msg.corp.akamai.com ([172.27.91.41])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTPS id 4gn4q7urp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 09:17:01 -0700 (PDT)
Received: from usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 17 Sep 2026 09:17:01 -0700
Received: from bos-lpnz1z1y (172.27.118.139) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 id 15.2.2562.43 via Frontend Transport; Thu, 17 Sep 2026 09:17:01 -0700
Received: by bos-lpnz1z1y (Postfix, from userid 56609)
	id 04138241CAB; Thu, 17 Sep 2026 12:17:00 -0400 (EDT)
From: jlefkowi <jlefkowi@akamai.com>
To: <linux-pci@vger.kernel.org>
CC: <mj@ucw.cz>, <bchaney@akamai.com>, <mpelland@akamai.com>,
        jlefkowi
	<jlefkowi@akamai.com>
Subject: [PATCH 0/3] setpci: variable-length & auto-length read capability
Date: Thu, 17 Sep 2026 12:16:28 -0400
Message-ID: <20260917161631.801636-1-jlefkowi@akamai.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-GUID: pSxumbJ-tXYDC9E0ecV4AFcpGaLForeS
X-Proofpoint-ORIG-GUID: pSxumbJ-tXYDC9E0ecV4AFcpGaLForeS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIzMSBTYWx0ZWRfXxih4rrw0RmDV
 5JoPuvcvMQTfOjZr/u0ECx26P0t6jEnrQQf/H6xyOfo8fGggh/EnXbLfMjrCrmfH1LfiSp+rlqK
 bTiHY0IqmQCSGtuk+Zd2E8cCVLF6pNg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIzMSBTYWx0ZWRfXwUc2AbUtgguT
 g6tsCGJOP+paj+ORHxe5vyLI6l9nXTcZVcQQmQNR23xRhRllYmwA1ICY9nsQzYVWUGH/NzI1YN3
 89uiygCbyeGIg5xPHNzLIXW6FNu39YvJJ0r2YdmyjA7HxMsSuhUQRxtwBaBcJEKGNP+7BgPQ1hq
 VQWSGjkVtOnDUcjrItM9zjg3Zl7dsfJTWccgf0bWUqBJ8FHZOl2Dl/1WCTlzeGyLZveiwYUlueY
 u9tL7uUDszp2dkw+EDwZqQyZv8OT52ukEFCPqu7LUAZUGzq8OeP8nNKR1sQu0r/gTL6RrDrmI8X
 Yc8vlxak6g/vzwbGWZzpY8iApPvOd1cbGc/K75cRyYTzmhxP6YDOSZTI6QcjIJNFEd544jO3YMQ
 Rxw7mH/fEK5BLBUlHh0pn43bCeLRr3BH227E/Z7ntsqTcMvu4QKtB/AOpEh8u5nblxM3HYmYoVj
 hvbNu4GBgKbu9JR63OA==
X-Authority-Analysis: v=2.4 cv=c/g+0h9l c=1 sm=1 tr=0 ts=6aac127e cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=Pq72nHwyFlvh3xMh7ENp:22 a=uEKwMW1o1GMmNkmWuaEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170231

Hi!

This set of patches adds a new operator with two variants to setpci--
.V[N] and .V--with the purpose of making it easier to perform reads
larger than four bytes. .V[N] performs a dynamically sized read of the target
capability, with respect to the provided number of bytes to read, N.
.V operates solely on vendor-defined capabilities, performing a
dynaically sized read just like .V[N], with the added capability of
automatically resolving the size of the read at runtime. This means the
user does not have to know the size of the read they would like to
perform for vendor-defined capabilites. Both changes affect no core
functionality of setpci, with all existing functionality working the
same now as it did before the patch.

This set of patches provides the following (in the order listed):

1. Add a new .V[N] operator.

  .V[N] performs a dynamically sized read of the target capability. As input,
  it takes the length as a hex-value. The operator accepts offsets
  just like any other operator, but does not adjust the provided length relative
  to the offset provided; it assumes the user has adjusted the length
  with respect to the offset so to not read out of that capability's
  defined space. .V[N] returns the requested read in big-endian as one result,
  meaning the user does not have to organize a chain of reads manually.

  Ex: setpci -s 03:00.0 ECAP_DSN.V[14]

2. Add a new .V extension of the .V[N] operator.

  .V requires and validates that the target capability is a vendor-defined
  capability such that its vendor-defined length can be read. .V accepts offsets
  just like any other operator, adjusting the vendor-defined length with respect to
  the offset provided. .V returns the requested read in big-endian as one
  result too, such that the user does not need to know the length of vendor-defined
  capabilites nor reassmble the result manually.

  This patch does not forbid users from using the .V[N] operator for
  vendor-defined capabilities; they are welcome to use either and can
  expect the same, consistent result from both.

  Ex: setpci -s 04:02.0 ECAP_VNDR.V

3. Documentation Updates

  Updates the man pages to include the new operators, including use-case examples.

All capabilities are read specific. If a user tries to use the .V or .V[N] operator
for writes, an exception will be thrown.

This is being posted here as an addition to the PR opened on the
pciutils github due to lack of motion on that PR. The patches added are
already in use for internal purposes.

Background
----------

The reason for the interest in this patch is purely convenience for
reads that are larger than four bytes.

Suppose we want to read some capability that is 16 bytes. Previously, we
would have to perform `setpci -s  bus:device.function CAP.L CAP+4.L
CAP+8.L CAP+c.L`, gather the results, and combine them ourselves. With
the patch, this call + the combining logic turns into: `setpci -s
bus:device.function CAP.V[10]`. This is even more apparent for
vendor-defined lengths, where users have to go into lspci to find the
lengths, perform the read, and combine the results to get their answer;
with this patch, that is condensed into one setpci invocation and no
length-knowledge.

Caveats
-------

As mentioned above, writes are not permitted to be used with the .V[N] or .V
operator. There is no safe way to perform writes this way without the
risk of tearing, and thus the feature has been disabled entirely,
throwing an error if attempted.

Summary
-------

jlefkowi (3):
  feature: add .V[N] variable-length access specifier such that reads
    are allowed within a window of 'N' bytes (inputted as hex)
  feature: add auto length discovery for vendor defined capabilities.
  doc: make the documentationf or .V[len] and .V more concise

 setpci.c   | 172 +++++++++++++++++++++++++++++++++++++++++++++++------
 setpci.man |  22 +++++++
 2 files changed, 176 insertions(+), 18 deletions(-)

--
2.43.0

