Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88FD3CE0B7
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368222; cv=none; b=a3hiw3k4rg9uaIhffMA6AXF9DAUChS8cUoGkO+wPL2ZlW2wd3SH45LOAi0ZDRyWr5nD+i/V8eplBY+daOWM5Fgpqow8Nhc/z861KiFtQaOKNDzP2TsZ4Ltbg+XZ8X9yiLxG+3LhTjWStR6yN8AG13Oht65HwE1zoMaUI+TUKYcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368222; c=relaxed/simple;
	bh=5/2BYjXjluc8EIuTVwI/UNkQU9qRZBXpI4urNoHwCAw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d57ZNWDMd6/JtS8G1Eop2CrLUZEnk5H4jlAhDIRj6RgVZ5GiQ9hDHDUZ5QGQkgvANzdl9gpR+UWChRhJ2C5I+vH5a6vq6TxFMzOE8YWcyFNJN5I3N69cJ4EEwalP2OUpBKlCkYxTqCnjid6BYdGdZVVs9E7ZJLkOwWk9GPbxYN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X0rwvwAq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MBc703VD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X0rwvwAq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MBc703VD"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99new3009513
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 12:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=piaeLJyu++WVR0SFsnTfn4
	SSjmjG7Pb+pUvnQO6EiOQ=; b=X0rwvwAqKisht7gptSDWXp0UW0GtMZ444zkaBh
	0CTWo44j5eoBSnCDBNeY6tr1TPOcBXkyR4IMDBKtGxkzCfQuIjS3McxALljMe+iW
	4a8kuC7foVQrIuQlK3HQvIU/AhoXxIrLyoeMdy0Ux5S1dfhpo61rQTul9cS6T7aN
	G7s9jUVXQbSAOGljv48TjodyWHWR2+TFS+oNjKYX0nV/2RNwivr5cCI6bCocsNyi
	QIZxhq+s+LKGI6X+MlSf/w3El+KjHjkRjq6s/rsVWRtxUV/OsIdz7W1CJpoW4Y1U
	MuvfWo3i0EzHwPT0KTaLOlq+PgGSl9qprOxSUE2kMK3QqlRA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9sr328bx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 12:56:59 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8276c91addso3413185a12.2
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779368218; x=1779973018; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=piaeLJyu++WVR0SFsnTfn4SSjmjG7Pb+pUvnQO6EiOQ=;
        b=MBc703VD/MiL7sx7fbd8+pAyAJ79xrXPEAvoFV5ivTPVdGEqR8CMi2t47+EXa9zTH8
         bED0H18m7WzoN4Hz//rxUsZATVUa8wWgzHkuYWPcUprf04kKAmOHbjZCsUFEOohAXlkM
         MjApcGKq8BhK5fvMGW3j20HzvXcDFgS3wiZKzgI5n7+1iidiaaIW5gxXj0+tVyYcf2jj
         STWfGzS3zXyHBhKHv24ngiKMVDWlHd7ST7Rv7/ENltGps4mVRPhCQf3BNnpqvnWFlAv4
         mg1W1gQyIkp6gfKVLmnVHl+QKLgWPl/MhU0KCpdsyjzviZiuNx4NPO4CH0YZ5VT/w44T
         QB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368218; x=1779973018;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piaeLJyu++WVR0SFsnTfn4SSjmjG7Pb+pUvnQO6EiOQ=;
        b=cvW/Sd82tmbeQgkpQHKxdtuCx0GI2Opi5Z66jpysmxDgAcX4ba8hsebCS0PDcDlOiI
         vJalvZF7nwZqLpDP74AfLq5jMHPM2nKH7p1jBDp83Iwj/DZrekbzaox8EXx/knKEaMEu
         joP+WORr47jqI0JxbSXu3Bex+lovOd75svNUb2TTTRB5YT3D7TTBY+BDZl5NOgq8EwnN
         wnPmo7lBfXEBRtxwIC6oBNdpiU5Ow09lh9yKVhlaJ3Z+grvulPRLecAuCMh/7Z8d4/gQ
         tkvSdF9ETtYyEPasR4uILx5pXKE0t8XfmxcI5kVVRgqD55AnrGYyfHv8g4njsbiCyJYG
         cR9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8U2nMacjU43MPM6pFBf5ZyHx/xoKd5+5NLw9Q4NhQBEIAy9jx/p+nBsXCHRBDKP5DPAmL/DMQ2oQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+sW+EqehiY05Jez57wBpH52Kam8q+ce1HGAls6B22zdkCZNKT
	z9I3jgvld59yQaeQURDuNZ2SGVt26zmyosjNrFYPALi7ULyYutZ3sPT2JqknvN01gzdYiJ2mJxI
	NLFvFnorXCNJ9gjoWP43fPYpn00gwrhYdyp+pRMnC95DyLSCWOZwGQD87l23pLdM=
X-Gm-Gg: Acq92OEBWs+yykMuuUHjlJNwv1Lfg/5Kpx/W8La2+WFN9yPlqR2cbf3IjFCiI6vTtGw
	7YCVR7hEmGwEWArQoQTyLLf7Nfu7l6DDZZVwW81KOoQBbzHEYtsEvu6f2cSc32QCCjyOjQ9SxK0
	NlIi7qbjZbNpCgBzgFWCxS6/AAn2wvgp0jLnPDj1TU47IntllpsfPUcaYzw3bpxzUvMiPEkaQIt
	uhiApPCw2/raDmTPHABkDH1qfKPHlTcwGovDZXK7EDroGy4lPea5Hp3McaPcTM18tHbXMAzwZ3f
	iPA36EiTK/xK/2jnvO05Km2fmFyeOUaFu/MB6ykl/7A9MUqoHBqSlt+60ELO2YRzKOrwxjYTVSk
	Y81bOT/tygg4SJhFL7qINzjMw34mLzsZt1asjbIYCkXrf6zpmIdv8HvGg
X-Received: by 2002:a05:6a20:430c:b0:3a1:90ef:7e46 with SMTP id adf61e73a8af0-3b308859fb0mr3466660637.33.1779368218421;
        Thu, 21 May 2026 05:56:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:430c:b0:3a1:90ef:7e46 with SMTP id adf61e73a8af0-3b308859fb0mr3466631637.33.1779368217903;
        Thu, 21 May 2026 05:56:57 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85198f508bsm357984a12.20.2026.05.21.05.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 05:56:57 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/4] PCI: qcom: Add link retention support
Date: Thu, 21 May 2026 18:26:32 +0530
Message-Id: <20260521-link_retain-v2-0-08ed448b081c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAEBD2oC/1XMwQ6CMAzG8VcxPTvSDmTgyfcwxCAWaYRNNyQaw
 rs7uHlp8m/y/WYI7IUDHHczeJ4kiLMx9H4HTVfbOyu5xQaN+kCIpHqxj4vnsRarWiooRVNmhjO
 Ii6fnVj6bdq5idxJG578bPtH6XZ0cCcs/ZyKFynBuCq1TbLPryYWQvN5137hhSOKBalmWH9md+
 8StAAAA
X-Change-ID: 20251001-link_retain-f181307947e4
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779368212; l=2776;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=5/2BYjXjluc8EIuTVwI/UNkQU9qRZBXpI4urNoHwCAw=;
 b=EOSZDRFne1tilI/fYA+ZUVIeA0W/JA7+2Mrt2wzPNN41PyaduACfm5ow6izeQ3wbs4Un5xqeu
 6+6WRklFAFACnMq0cwp0OlHO6NGAzqqZebY9N9n7KcWnkMY6+aBd3yu
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: GBs0W7sQou3XNbr2iV1Dp_01EOaqQrW0
X-Proofpoint-ORIG-GUID: GBs0W7sQou3XNbr2iV1Dp_01EOaqQrW0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEzMCBTYWx0ZWRfXyoHHVlJgRwYg
 a2f1QAl5/vTf5kjSMRmMGViUdYO0UWMM/shsAoNRQkUBQpSkSt1jVRPztA7CyfaBp4gAWw9Agfh
 7a4gLleecrZxxRjunmiSxjRER+Z3T/kT5fln0HRPy/abjHoSe1isjB+T7IwwPhErkc0Dn699i9P
 eCAuN+cZ8FrC7FYWhyKPZ7jRN/H0sEITeDlXWJ5ZJZnVES1p797OqI3nrAu9P5OXiXpTyYlSi2j
 4UoZuKIyMpACwBr59zZMvG+4SWatb7EsQGxWOs7DOgcyJbXDIGCVjfGsbU+7fN0ClPyzmOS886Y
 411QItSfgN4Uobja/pKxofZupYOVhSb1ujd6FOB7ibL+un0rwdSu7IxlPNis5zKV0wHnEBEgQ5A
 VcdhuptsZoF4uIDAnQYr0+rfM+rAS/o7mcRs2eMI453sLrMOFvoI/n7ILUJPNCCmBNLyJMHYmlf
 xBWqKxmnPHwdweTxoeg==
X-Authority-Analysis: v=2.4 cv=L+YtheT8 c=1 sm=1 tr=0 ts=6a0f011b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fuwIWhs0SkhWFt5P5XoA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210130

This patch series introduces support for retaining the PCIe link across
bootloader and kernel handoff on Qualcomm platforms, specifically
X1E80100. The goal is to reduce boot time and avoid unnecessary link
reinitialization  when the link is already up.

We are not enabling link retantion support for all the targets, as there
is no guarantee that the bootloader on all targets has initialized the
PCIe link in max supported speed. So we are enabling for hamoa & glymur
target only for now based on the config flag.

If the link is up and has link_retain is set to true in the
ithe driver config data then enable retain logic in the controller.

In phy as we already have skip init logic, the phy patch uses same
assumption that if there is phy no csr and bootloader has done the init
then driver can skip resetting the phy when phy status indicates it is
up.

Problem:-
1) As part of late init calls of clock the framework is disabling all the
unvoted resources by that time and also there is no sync state to keep
them enabled till the probe is completed. Due to dependencies with
regulators and phy, qcom pcie probe is happening after late init which is
causing the resources(clocks) to be off which causes the link to go down.
To avoid this we need to use this kernel command line argument
(clk_ignore_unused) to skip disabling clocks as part of late init for
initial version. Once it is resolved we can avoid those kernel command
line argument.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v2:
- Rebased with latest changes
- GENPD/power domains are not longer getting turned off with the latest
  kernel, only issue is with the clocks.
- Removed the patch [2/5] PCI: dwc: Add support for retaining link during host init
  as we are not seeing much difference with this or without this (Bjorn).
- couple of nits in commit & prints (Mani).
- Remove skip_reset for the long term (Dmitry).
- Link to v1: https://lore.kernel.org/r/20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com

---
Krishna Chaitanya Chundru (4):
      phy: qcom: qmp-pcie: Skip PHY reset if already up
      PCI: qcom: Keep PERST# GPIO state as-is during probe
      PCI: qcom: Add link retention support
      PCI: qcom: enable Link retain logic for Hamoa

 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c       | 74 +++++++++++++++++++++++++---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c     | 31 ++++++++----
 3 files changed, 88 insertions(+), 18 deletions(-)
---
base-commit: 8bc67e4db64aa72732c474b44ea8622062c903f0
change-id: 20251001-link_retain-f181307947e4

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

