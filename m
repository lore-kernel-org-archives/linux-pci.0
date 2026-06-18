Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708622E7380
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781811036; cv=none; b=PjM32WeHogsiAtHFtm1AAbjY5/uvWwITKvd75fDBMaOF6it89N00VPK9WPuRrE/634nD04FbMDDW+Ulqi4py4luTRWSabPozL4nem+uO31VE4DJUqipj2+r+SZn+T6WAMDa1KWNXwDojxzkqkk7vOdi2UG5u+cvrPg/NahUqAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781811036; c=relaxed/simple;
	bh=Ecbk1Lu3IUnrxrIZVWJ47mA7s8n0gQkHbqnRzybhPtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mm85k+o+N73V2LZAIE3oym/Vj0rWsHfIY8itlUhIPIZRL6q9CAVKG1qizLH44LQNsX6EX3vVCzzd7iDYQIMrWc2oxnVG3/B7nS4/BALcgBrHHnKW7YHP4jyhsPeXX8F788cMSHTqtKgkOo9idVQ1glfZRO6YntoPSPQjyVLOeQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bphUYH1N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C3laaTnb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bphUYH1N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C3laaTnb"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IHuC362274771
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 19:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=3E6NcbdSihjpMqHd/4mOnh7QXtNBBm7zpFu
	COGSpEuM=; b=bphUYH1N93UvtE2OQzZM6XwxbwsK7Yn8WIxz4VJ0AdU6+k/66dl
	yZey+Syy9BMyApXNlNMQG31HGmJTt/OTXitSt2Mq6gN9XnbtWV9o4chFQKwWLWa6
	A8Dvy3DAhj3ws65FO/zIa/H9ahl/ojDNEQmOl4ZqOPISJL8QHimIgSdm4ITBwM16
	GPIdFSiKN7BsKRUDvMwNjXOK3j9oa6wI+Ume8sgD8O5B0ndfIqbqpzOZz+IH066H
	dntF1pqqO5ZdGi3kmEOycBxL0WcrrAhbQFtLo/HolDrqaYjHCniOQJlaX4SlIhEW
	MGxZKmSoIXyAn1NdgrXVzzrbt6aqzPxR/dQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev1wc4wva-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 19:30:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-91ed0e140c5so419680785a.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 12:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781811033; x=1782415833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3E6NcbdSihjpMqHd/4mOnh7QXtNBBm7zpFuCOGSpEuM=;
        b=C3laaTnb5Q3aqG4gfqGnLpL5mO6G3L3prNQjC1kCh+fj9W4H5Pjoq1cmCQZD8prPSD
         e7G7cEmeFay5d82aXx9D068J8kbUHj8MC3B2EZkuc2cOeBTUkV+e4eGCR58KesGoXBaG
         gPP2A9GPTPmxgTeWKV9vHSGLucqTPLLJjKr7o9+VzS/4+ZnPuMrfmN4PzZIHa07R/2tw
         jUNpmGWhs142TF9F7UuVJnFG1pc5rMkJ8MIVsLHm7m1oifIPSljBxx9pBFgKfURysWK+
         stPIXxONSqJPrs0RNIX/1AH+0qRJFljjAi7MOWNhHjc5gN8nUC0uMnIMzms0w9fapY0p
         tlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781811033; x=1782415833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3E6NcbdSihjpMqHd/4mOnh7QXtNBBm7zpFuCOGSpEuM=;
        b=Bkw2+swcub19pkgARRW3qZHywG+xqB5vovzTad9w+44X0BFYcR53rqI5gOBCDC0BiN
         pd1jE5mFF+L4DmJSst1/2984SZbPmUvLY7k9D643S9Mvv7dykLuWpt4ULhw7Kn0Ct41s
         W/euW4TRB7TXGnVquhoRzGBtD+sp4GwzXKRZQmqqZMoOMzYAlXb/zcWOXL+X8Bhnwksx
         sOdDgtBfMynhkwRv1XdcjxDyYrRoJwSJ0XbYSqSC0ym8jZVIN1rHlj+g3XcuP5+fCxab
         m6KH57Fr0rUOV25+dsqgyERxIz6xCTm7Viu3mZdhqAa6Hi16Z1lcIlB6CfDxqMxjgI/T
         qr6Q==
X-Forwarded-Encrypted: i=1; AFNElJ/kcd5AI+zS5lZmPVHTgHPiWXsiQzUqIE2P05YJzaz0NjgfpfSqGmoWFOFDarKyVHXGNj8wX2869L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwYvmPNTlyglir7gA6wENbDCw6sHf1vkitigfBhuMDJTw2wKSA
	9v0ZnOm4+SdqfHvQaeyDE1djNboD93D6SkGUTtmWuezcAk6pOydP8bl8RRHp2iEN2D0a84FIul/
	znQPNSDD/SlYdvCsaACAkn3p9EUILnq0oakROFhL9Oev5ay3GqEQBxWpJ6TNranA=
X-Gm-Gg: AfdE7cl/g5mcuv/Zixh7wvBbJtjehEDG3GrmmVFS+3kDoYnCw6ICwFNn4Ho4mrF3CUJ
	SyWBRM1F84+gbn4XJlM6eZ/69728NMtIY38jOL7yrQq0fvkcoBMKgSftOSVE5HvPvRSB4qoMXau
	rt99JUYRPlePrxMrftLr0jyPv2Fic6T//u85RTYXOZhJbfs56Ou7kqGsMIZnLoPMKOhU9E38Vsh
	4plzwz10CrJcs1oI1dYsjEIHLcmJbwzB1Y0TiAAbVHMDRY89CBstKFtte0VOt67CX89FOMN0jYK
	hxiDQIf9xXL6ieThJ7RzQzOaNl1R+4Ta3Gej/8T8Cj2nDCKy1r58wbuR7PdfDc4bNR/t0AAHAqz
	cwPrj5zyCQIrD/LUI0Yqj3EvsNJb7ltcWRmNKcpwkKKR3wT+mtkzwvyJ2nRqm7v0MYPHMnA99Mh
	LuVUoHjwUiiSizhLAw8KrjUXDrPQ==
X-Received: by 2002:a05:620a:284f:b0:915:9d08:94d8 with SMTP id af79cd13be357-92092253cfamr55628285a.44.1781811033341;
        Thu, 18 Jun 2026 12:30:33 -0700 (PDT)
X-Received: by 2002:a05:620a:284f:b0:915:9d08:94d8 with SMTP id af79cd13be357-92092253cfamr55619785a.44.1781811032812;
        Thu, 18 Jun 2026 12:30:32 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4420179sm1006471866b.8.2026.06.18.12.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:30:31 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Add ACS quirk for Pericom PI7C9X2G304 switches [12d8:b304]
Date: Thu, 18 Jun 2026 21:30:30 +0200
Message-ID: <20260618193030.69528-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TMt1jVla c=1 sm=1 tr=0 ts=6a34475a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=dA4ySCB3RHXnS2zaP2oA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: CkKujOtSwZDZDhSTP9RTSDwnZdNOj7dF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE3OSBTYWx0ZWRfX2g5CGd/7+/zG
 /JMSbnp3apIzNJSYnIRAvucnNogWh5EeFh6eN0A82Yw0sGpkc3tpnfrLcshHgJO/0TMYi6qqo0s
 i4bn0jSuEMf3aPtWi9ErdJzJFHAQcw0=
X-Proofpoint-ORIG-GUID: CkKujOtSwZDZDhSTP9RTSDwnZdNOj7dF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE3OSBTYWx0ZWRfX4YEuPPFJvioi
 WKu8iHlQBOLoDp853JkysK1vHQtwiB+QtFnnVxyVWlH6ePPaKCZ+xebYx1Gqj7FkdkErZBgDMsU
 e1yiz+UEkWiFGOlYW6RsuN8D+2acgEErq5z8HNDpvGmtZo0onH25znDuL2QDmFdxix4g45XY5Qe
 umbPfzZvXL/znJpiY9Zf5BUgSoDKtn+VWPOqDJHHcwjl2inFj1fcJ2s6hxFgwwwNsR5RpdUH8VT
 G/dnaKMCo+FW0sNEXORGUcuLT7/aGFZn2eQ1j/uP7ePPw3jxxlFsXhwFrvSUiCa9dUaj9fdW5pp
 mco1hMxQnu3g6GPm6lA1GVMa+z3r9+063LeIqs7bJDgil3yVaYPag+vcSrqW5uONAHWLVcvjAJb
 JNusqgR9gOGzv58agiZTAcCvlfvb73TmvHKixr+9SD2JyfbO3mX21QsjmnLNCFBhxm0HWQJybfj
 Cu6QOIUP2ZXikYbO7rw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180179

According to the existing quirk the Pericom E5 errata for ACS P2P applies
to PI7C9X2G404, PI7C9X2G304 and PI7C9X2G303 models.

The Arduino Ventuno Q board has a PI7C9X2G304 switch (verified from chip
markings) with a product-id of 0xb304. Add 12d8:b304 to the existing
list of quirks for this erratum.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/pci/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index caaed1a01dc0..2fd403ea3659 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6225,6 +6225,10 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2303,
 			 pci_fixup_pericom_acs_store_forward);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2303,
 			 pci_fixup_pericom_acs_store_forward);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb304,
+			 pci_fixup_pericom_acs_store_forward);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb304,
+			 pci_fixup_pericom_acs_store_forward);
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb404,
 			 pci_fixup_pericom_acs_store_forward);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb404,
-- 
2.47.3

