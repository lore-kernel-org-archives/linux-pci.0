Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795719582;
	b=KHwnevtWGS0ccl3KLgCZ09Yf8yOOEglBpvE1tyIkpji4oz78YGn19zxOVk+a3wHNaLQ8
	 Bb7xGGgYY4JfUQ3+8//FrIGvt71SZRPsvd6s/1oJ8P//xTm0BhgNiWVttBXLdZoIAbxN9
	 9NHnpFe11XS7TvilKO3s5JdwGq8jneumIAtgs6X8L9dOgZysaH+x4cAF+lpogmxTOIk2H
	 QYaM+xMD4/CCsWM3JShJpN96p42/2m/OjE6zIzBrZA2IfWE5PlYqmoM+LayeqtYXnFQ6X
	 Em7cgrfRDCmTt5NJLuP1aMznl4jbBYkvTK2WQdK2GM0lqvoWp81BXc5eQ74SFeHSIqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719582;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PKnwJGn1kbNBw+OYy82caU/JC92cEMMnvBlOquiaj/U=;
	b=LfohUobrdW9xKAr1BMFOLcn64ZSvn9i2WnK81NBfeZwSSTqQw+SHyDggFhDF7xdgMjrj
	 f6aXxtszHgM9J+MAW0DhT9kDiwR6Lgn9hZT0EG6r2h1Pi3wNFW8nVCT1vFuebY6Up6Te8
	 SbNvJibEpzVtD38cHqWCuK+IwsFpZFGryoBKAcosk+azfNq87h7J6zqaxA6KUAqtaag1I
	 23VnVtcmiMPwQBoFBQyHZ3w18IftKosywV3IEMPpwbgtE2tPCj7R9sfKIhfm1ZWVFcTtS
	 7sa4MeEaYW5OrbZtrh5l+A4hualoM3rqHZ9BIHyMv49q39m0DYmwdUwm7LQW3bNvbKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cu9Wzjj7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B2uKOJtf;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034C606A326
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 18:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5034C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cu9Wzjj7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B2uKOJtf
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQFuCZn275314
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 18:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PKnwJGn1kbNBw+OYy82caU
	/JC92cEMMnvBlOquiaj/U=; b=Cu9Wzjj7rorA/u6iXgCIiQ/SUnhbjxcPw6D0t/
	yzeHlTiXtf0S0fhhEG3F6gbCIHuUQlx+i+YHFzCB6PhjrA0adrp8H70mai82PMTq
	3FwFFSniXsdqIDXBFxDPvwHI9e3WK+vS4gL3WWXqmQgf2Fo7O6jXtDDGf8VNDDXM
	dtvdXPnjPDIkHuRb8VD6Q0ie+KWvtyx2r/DSja2F/Q3tyZHKGZ4R1W5at+Ei7KO7
	a9jq2aQN/f8y9gjCmwG4FEV4LcPcrnzKK+G9Z/rHW4hxuS2MIXIS9HZqi11WbM9g
	ZsmoTG8dX+QucmIdvvpczclncmDj77KseVifa0mP9rDtU6Bg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6hm82243-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 18:59:41 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-386177b0516so18281673eec.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 10:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795719580; x=1796324380; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PKnwJGn1kbNBw+OYy82caU/JC92cEMMnvBlOquiaj/U=;
        b=B2uKOJtf1AV0wfvdDz+dei5DW1Kf5asGqvbZKU8kjHeVSiCa7YUZhJBDGZV0YTti9o
         SvF9LDld6HaRVDLQCDT3QlrV8auMvxLtdIxK3jvBs6cRY6JIiaw4t3DNMdTYmsTLLUBM
         hFj/JOHzWxmW0d5D4CF1gesUghyIysv/YVTQbu9pcjq7JO9ECVTCW3hjS9BqgPLCVUpq
         k+l2soD/ZKhn9OyHGmcdueSHXseFDY+bRMVr51cW+ljxWWngJjUe462J/ZCWy+9J6U4V
         vAzC+kAPl0Hc5m44O0n+sKab6Rwy6vmF6Ux0HaiM0ALh3+/XXcBFQfuV2o0RyYCZtyx2
         2BHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795719580; x=1796324380;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PKnwJGn1kbNBw+OYy82caU/JC92cEMMnvBlOquiaj/U=;
        b=Ap7s+Uagq0ogE0e+7Hb92OYJFfMzhKXTPiegUMqQyraG/pc2ZwEK4rJVKtYOLnPfNL
         sv4dwzXazkz3MSYQUB5cqEMX9F6Zl7QjOeEjSa3OmFun/gTzzmdvugzhgs2sSsRO8lXA
         HCv/x8D6dsVKAqWbnD6Ch5bLMqqqlLwXDokYiA8Q5bdaW6CUY3CNOlT1rUX5hlz1QNtQ
         LzRaw7b9WHg+83id5m/EKsSIS4A004KeEK1rvb9OYLnubfEMy4s6wEUBDZiPDbRkwqdJ
         uzoX/HrBKmgh7jZkL2eJFijbvo59Ivy1pwRGi2es2viSkjof4HaQ0wuKMHkPj1eWCUuc
         dllQ==
X-Forwarded-Encrypted: i=1; AL+hErHoqCpU+MGptd1J0X+9GTQgd1gq4O4ZJWTNbfM6m7Go0VV4vzm5y3MNvYlAxAC3m+Ljwlp5k9xZSsU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9yn6iwNbuAlclf+HWXQAldXeWq69ORq98zG8Jh4T2PVHpfqz1O
	IzKg6OhGCl3Ar7btpqTifpZFu4+yEKwnUFH3CYFdpvOz7TvgI8vxGfzo8Yv8U8B+ZkaOlHV643K
	ng1+FmYSL5vowyC32V0npv6CX1EINPv6uEVpOB4fZKSYQno0xtprp3qhR6uxZdkM=
X-Gm-Gg: AZFdTZetzlKW52YExb4i6A+jbq5v024y9ynkQdxhxT2n2wMI5Bdv4Fd9XrEkvpb+o09
	xfG1FohjawEuV1QNuWZg9qToGJOzpprIaMxmGFuoYBX2gx0GAjU64mK5z3IYGcKaL5IRiyjKnjA
	yRjU5L/hRM2frtz98dhqA1RS7fiM+hGbI2ulz73lNT3uP8gZ5FhZeIF+zwat40w70TNLKE0xc9k
	wSBZzjBcRYxbUHtea22fmpOgc/81l2zqrwYlSYqbAmO51BzIKCCxWkEyCjjMr/BmKyNmjxnCwqi
	Ri6Q8kFMSlOFLfuT/v8T/0BXKGvcrMmVbDI8Ck+T7dy4CHK6sbzRnXQaqEvnmqAEbFasTxO+SE7
	htB+zZk55kbLC43YHe+viF4JQ4hwctE/9iN8R9qfstNDrtOFQ2Nm72H273CnCIJd3UVBnHnqAqH
	AqEm2s
X-Received: by 2002:a05:701b:2814:b0:1b5:1a5a:1dc with SMTP id a92af1059eb24-1b5568bcbb3mr25262171c88.12.1795719580016;
        Thu, 26 Nov 2026 10:59:40 -0800 (PST)
X-Received: by 2002:a05:701b:2814:b0:1b5:1a5a:1dc with SMTP id a92af1059eb24-1b5568bcbb3mr25262137c88.12.1795719579488;
        Thu, 26 Nov 2026 10:59:39 -0800 (PST)
Received: from hu-jkona-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm60868190c88.7.2026.11.26.10.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 10:59:39 -0800 (PST)
From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
Subject: [PATCH 0/8] clk: qcom: gdsc: Allow USB and PCIe GDSCs to stay
 enabled across suspend
Date: Fri, 27 Nov 2026 00:27:08 +0530
Message-Id: <20261127-usb-pcie-gdsc-suspend-v1-0-485a08ffdc6f@oss.qualcomm.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAASBCGsC/y2OSQ6DMAxFrxJlXUeEIaiseo+KRQguRC1TnFRIi
 Ls3QDe23pf8/DdO6CwSr9jGHX4t2WmMIG+Mm16PHYJtI/M0SZWUqYJADczGInQtGaBAM44tlPp
 +N6pRaZ4oHm9nhy+7nt5nfbHDJUS9v0I+IJE+9RW75DKTSRaXkIXKSwUSZqcplvC9eD8mIrEE/
 THTMIg4ji+NJoQjsL5iI64e/jULXu/7D8gvyVncAAAA
X-Change-ID: 20261126-usb-pcie-gdsc-suspend-7a99c6b62406
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pci@vger.kernel.org,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Prashanth K <prashanth.k@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: xkdlVnL1jvC2aPs5Xj7GNjUtecy4dsrl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfXzlQDPdrb/ZWD
 YggvZKieXrK3T9D6HmwlNmEPLcpLBK+60zIg773m/IJ5EKnp/5uY6dXIzYpTesrm0OvFS6WoJ1l
 YENtZyG3ZlI/GuWYxWv8ArvZYFFZCuk=
X-Proofpoint-GUID: xkdlVnL1jvC2aPs5Xj7GNjUtecy4dsrl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfXwqpejwi6EDOA
 uicRynmF7yGtybHKISs1cxYLC++P/1Ny8ZCoPlyZX/6ZB4ySJli0cPyswLzi7wzKiRXgMtd9GWB
 1ZPn+bsEdIKztXx2d/hX+kNr4iHm0DyxQn4hap3yHzKwT/LrIy1M699UpwjwweHF4VL6eT4KnoN
 mgCtSa39XlieLi+BoMvX0/v3cGgB3vgpqD7qbx8++oGYfnddbVd+hgTZffMmNwYokHfb2MNtgIZ
 uOzTDngem4AgoE3czeaGpgq6PM+4X7i6xAgQRFBSCUg5qu8RvaPsMUkoqIcMsqdahE/8wGPj3l9
 UfqIqTHGPOwlDsXHtoakB3g76oGusFRe4JXAk/CAFtQ5N7at2vOjYHTxGJELKEMN82RQzmR/Gx1
 3QVosdQDB2CNAzxiaD9qNx/JZ4nJZpQyG02YONY0Jy1VsPXsFBEn70U1VkaqyPcc5CwlugdZ7+E
 MNT+1yGWsoBb1BxWwOg==
X-Authority-Analysis: v=2.4 cv=O/usLx9W c=1 sm=1 tr=0 ts=6b08819d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IPO9h8n_qQbs29NzXk0A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260074

USB and PCIe GDSCs on some Qualcomm platforms need to remain enabled
across system suspend for certain use cases, such as USB host mode and
PCIe non-D3cold. These GDSCs currently use PWRSTS_RET_ON, which keeps
them enabled after their first enable even when consumers no longer
require them.

These GDSCs have a HW mechanism to stay enabled during suspend while
allowing the parent voltage rails to turn off, with HW handling the
parent transition to active voltage rails. Use the existing GenPD
hwmode interface to let consumers request this behavior only when
required, and clear it once no longer needed, allowing the GDSC to be
powered off when unused.

This series adds the set_hwmode_dev callback for USB and PCIe GDSCs on
Qualcomm Glymur, QCS615 and Shikra platforms, and updates the corresponding
USB and PCIe consumer drivers to use dev_pm_genpd_set_hwmode() to control
the GDSC dynamically.

The clock and USB driver patches need to be picked together on Glymur
to avoid functional issues, since the existing RET_ON flag is removed
in this series. This approach can be extended to more targets in the
future.

This series is based on top of below qmp phy suspend/resume series and
depends on it:
https://lore.kernel.org/all/20261113103111.156476-1-prashanth.k@oss.qualcomm.com/

Signed-off-by: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
---
Jagadeesh Kona (4):
      clk: qcom: gdsc: Use GenPD hwmode to keep GDSC enabled across suspend
      clk: qcom: gcc-glymur: Register set_hwmode_dev callback for USB, PCIe GDSCs
      clk: qcom: gcc-qcs615: Register set_hwmode_dev callback for USB, PCIe GDSCs
      clk: qcom: gcc-shikra: Register set_hwmode_dev callback for USB, PCIe GDSCs

Krishna Chaitanya Chundru (1):
      PCI: qcom: Keep GDSC enabled during non-D3cold suspend

Krishna Kurapati (1):
      usb: dwc3: qcom: Add support to keep GDSC On during host mode bus suspend

Prashanth K (2):
      phy: qcom: combo: Keep the PHY GDSC ON during host bus suspend
      phy: qcom: usb: Keep the PHY GDSC ON during host bus suspend

 drivers/clk/qcom/gcc-glymur.c             | 46 ++++++++++++++++++++++++-------
 drivers/clk/qcom/gcc-qcs615.c             |  3 ++
 drivers/clk/qcom/gcc-shikra.c             |  3 ++
 drivers/clk/qcom/gdsc.c                   | 21 ++++++++++++++
 drivers/clk/qcom/gdsc.h                   |  2 ++
 drivers/pci/controller/dwc/pcie-qcom.c    |  6 ++++
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 14 ++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c   | 15 ++++++++++
 drivers/usb/dwc3/dwc3-qcom.c              |  4 +++
 9 files changed, 104 insertions(+), 10 deletions(-)
---
base-commit: 47588e4c16d8876d3058bcec030ed8a016794b9e
change-id: 20261126-usb-pcie-gdsc-suspend-7a99c6b62406
prerequisite-message-id: 20261113103111.156476-1-prashanth.k@oss.qualcomm.com
prerequisite-patch-id: d39d8cf075595b668e85fbc6c3cf7234c318602e
prerequisite-patch-id: 5f7421fa9312a84661ff4a87e946f315e8dc27e8

Best regards,
-- 
Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>

