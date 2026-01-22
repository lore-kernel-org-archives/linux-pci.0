Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643BE30B51B;
	Thu, 22 Jan 2026 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087413; cv=none; b=sKa/t89lTLEPa+LTQdnmPzkFQN6mum8sdc6IeeV5IMv+HmbmeRrh1ZLhjSiFTSDifONQ0gZEPLnfIbPPpjCdxau/X4hWFYPpSnIvWhKedehpqSjy8LoTmKU0d/arT3KRaNeP602d5Vd1hJONpMcPs2EXW1MI+wDPsjqU0Klk1Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087413; c=relaxed/simple;
	bh=pMpdP5SinbAsaNuaWXp13NM9iASPjyiYunyct2sqq8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BIHqHHmBj9MQO4Obcw1rq02vpFd/h4aIaqAIpwxDzKa4gby4tw69ZvM2QXW54POmacsV1Bh/rI177D3yn/+qp8zCbw2hftcjolv/dMDPmR7zYUobAT9lEpztgOoZEVS9btB+bIBsmOZ/z83/4rm6+5UtIo+cJgbSzf0lYYOp4mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eRfrW5s5; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eRfrW5s5"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LNgtBo421232;
	Thu, 22 Jan 2026 13:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=vnVmhXIynuK+0t2d
	cgR6QrLyesw1hHUMFESvRmPN/Nc=; b=eRfrW5s56dyhbSV8pbRJXeljV02GyaXk
	r0exz7ySiUWOjZ900OrMiHwaCuz/B9oPS+DyufxTDqbM6NlMWE7t1mvsrPehuCGw
	3F8LJiTfTt8nqToin9bvz7pBlgEBhzduOaSh6Ef2FrSVFEbQV2DOEbJfCaCQXVYH
	kkwIdX0l+PkLdyXppy/Y+2WzrZHbx1A0xyBN5mSKIT3I6mBvJgCD4qy3FdciHCj3
	MaaUHPOtvRLUMwSHEUUWoPWzBg/w/Dc6Ve2UxYFMnqq6uHcV5uy6K/+3mxdHToLp
	ySdbzLQnJiJAm7Ke4ho6M5MR9S6jUrsDLHHT35YGfiRK9O14zkIG7A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagcv8c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 13:10:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MBDrrV018159;
	Thu, 22 Jan 2026 13:10:05 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4br0vctgdy-1;
	Thu, 22 Jan 2026 13:10:05 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Alex Williamson <alex@shazbot.org>,
        Johannes Thumshirn <morbidrsa@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v3 0/2] PCI: Init RCB from pci_configure_device and fix program_hpx_type2
Date: Thu, 22 Jan 2026 14:09:52 +0100
Message-ID: <20260122130957.68757-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=765 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220098
X-Proofpoint-ORIG-GUID: edicuYCRVOpVBgjT1_qhgRy4KOQu4wvv
X-Authority-Analysis: v=2.4 cv=IsYTsb/g c=1 sm=1 tr=0 ts=697221ae cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=3OD1d0GEu3Xej3sCmiwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA5NiBTYWx0ZWRfX3Cnpvo5owgsc
 jeq/1REKfpDODd7MIXW48/7+VK9huUCCYZx/mviaY+MD6ZD8i22dN7xuDj4n6WUbEcZUc3ns0q8
 jzN2f00fTpPJuBkf2PJanC7MOMhGECSwnGnmoax+QezZMbc2SRtt350ld+KzLBWcpav0MrHnACm
 AlRJhNSbgu7k4H/bsBED8BU00ooyypWUuPGcdjAzb8jnZmP2FKnolmnhNyJIKJlbK1VL2uKoVuT
 DSizumOamdBoTx/WxwQkb+ZeLt6uRVak9i4elql1K6I9jHCzrmrh40EuQrsCY+327rsQuOv/dI+
 hsq6AMryHRvQb0ePYf20Y9zrsHwPiMyt7V7nbjM1O0f37S22kA/UtPpbvb4F8Vh9nOvLCNUbtlr
 MBuZptx8VW+wdRh1LBK1/WWg3Fm6xjIu+O72TXybpz4IS9M1wG3QeOi+O0pRDp/YZPwYFdIqCc0
 2z3hKUuCRkT8/1Hdj+A==
X-Proofpoint-GUID: edicuYCRVOpVBgjT1_qhgRy4KOQu4wvv

This series add the initialization of the Link Control register's RCB
to pci_configure_rcb() called from pci_configure_device() and also
cleans up the incorrect program_hpx_type2():

1. It should only be called when we own the PCIe native hotplug and
   not the AER ownership
2. It should only manipulate the AER-bits

In addition, the second commit adds a warning if the _HPX type2
record attempts to modify the Link Control register.

The programming of the device's RCB is constrained to the device types
where it is applicable and also skips VFs. If the Root Port's RCB
cannot be determined, we also skip the programming of the device's
RCB.

Then, we program the device's RCB according to the Root Port's setting.

Håkon Bugge (2):
  PCI: Initialize RCB from pci_configure_device
  PCI/ACPI: Confine program_hpx_type2 to the AER bits

 drivers/pci/pci-acpi.c | 61 +++++++++++++++++++-----------------------
 drivers/pci/pci.h      |  3 +++
 drivers/pci/pcie/aer.c |  3 ---
 drivers/pci/probe.c    | 53 ++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 37 deletions(-)

--
2.43.5

