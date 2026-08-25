Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9118304BDF
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658110; cv=none; b=sQQtBsZ+TDBE4oMtuwba6JL4003AM9TU6tI66cbp0gSA+SgZsl6xEFl/+4AMVv4/OPOMo4Z06QG5TQzE7GVUST8n71Z3o/IrenWN2UAS50S2886rL8vHB5IqF5WfEZHLiSkqeps/kyiUdY0liU3mOe/UYXXkyuejDtLtWdBMJgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658110; c=relaxed/simple;
	bh=wosuwikMoz3gDvLoC+hERTwDj0vuY/3L2+sga5V0z4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=deMpzUj7TkljtP0epCJFNaW9qPvkimfS5kQ32397rnqMLZtWybRFDwt99nRwJj8Rjd2r25dOgX7iN/0gKTJYLvWUQl2HRFykbzruV7NrXu7JPrPddT/qqCZxyh4CX8c0L+UEq8d37fpsvqxL59hn2u1NvZ/36rIm+AMo9CYuIAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Am4l/S0H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BWynQ+Ju; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Am4l/S0H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BWynQ+Ju"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PAuuig2320722
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 11:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yQKcjQhqJbPmjn8LPqLdh6
	zUEBmJh7PLXDIlBz6jV9Y=; b=Am4l/S0HS7bmVodFScqKwhK4JDEBMkPq0QJ89/
	mgiBRQ4evtSoZ2aD1xhFP5dR+ZBPjxMrA1lCXpDizYiOtQ6X5LpL66RSOBc9Blv7
	nTuif9VcwZX2D4xY8OMKwBAx0p2mh2f0Ime23Nzpz96zoUgMSVZcKL1uda/MSHJj
	wm5Nxh+PxuxUCSOzFLKpNoA5Jakh+1/4LKQSKwZKRgIQ2toXPnx6xusX86lQt6Z8
	RtScNkvG9oSJ0MEcUGW1xUoAabJD13qt8EOmWhDgcJ+UNSsgmBOHYAl3ske7oiZH
	UDXag21S0sWc0cMuTGCchXlWlj5UUa4cAqJej31H8ysylbng==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g92jqsy0e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 11:41:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9372b9db132so448886685a.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 04:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787658107; x=1788262907; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yQKcjQhqJbPmjn8LPqLdh6zUEBmJh7PLXDIlBz6jV9Y=;
        b=BWynQ+JuhKaRXyOLEfZmYvfLqiPPkS1SdJvpoPKEoO5fyORE0Nd3dY5MsfXF0yPyb3
         Kb5YuQzvZn8u+efBuahFqZicvXQUDMPuAcAH1E93KFGgLfWqeAqAnRQjqQeRdrguHAnT
         200mib/F+GDog0wnV0thzJGu9jYxVaNBeFYSQvUoOqTm72SXSJWsq2Yr3kzNzbnAH+lS
         orgFfW+VmzNR6Q0X19cBeivy1x95pmpFPHTb7YJobsjSrZZJJgy5mFcjF2hWOj/2wGEG
         6DOtRvwZybFogVh/efLxiV4rNZhgAc/dElHwsv4nOPqARWyntZnANTCxCdzxXcUk1Z8o
         NeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787658107; x=1788262907;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yQKcjQhqJbPmjn8LPqLdh6zUEBmJh7PLXDIlBz6jV9Y=;
        b=g7Oaf4ZLqCVNdX/CuJNOOEYuD5hTNp+Y3mBvsiUPI5GOXWpEh1PZbqmW8QV+KCW7C6
         vv5FI8NbVdKyDk+EsDBfyjZOSkp+7zpvgqjlFmW1/FtR3UPgjsP3wPAjkGEZrkc0WbEg
         a7h5VZ5v5dD/JT0NI0DbBnda9SCq4fwkjcJf5aLqBKD0u/jc5xbalAmqR5APAViSUIKE
         fAgF2/irANJVHC8mY7P+L+P9k6vOPUiuRKUQcKjKHjKJnURUVt4biOSADuAyo+HhGvcO
         OGyNd3avB9dm4xX2Qs/mod4RjZ9rLxKj8IxOEVBetLlnYGlaVp9HfxLTwI7fSQaz4lwY
         p5DQ==
X-Gm-Message-State: AFuF++kWRywWer4LQVbZzWa2su6NRsoyhagdB4av6aP/Fn8J7VCq8xPC
	8dGKiIQkm7Rbpt1sS7ypQZavfck1sxrU1gAR+pO/N7qbxMzH6IOQR2ZPEplOsoPWhcb9Y5mSa04
	X5V/jAtRB9BvIwrnOb4bbE4KfFuWUPbGksBMKG19h6/7BzqPiz375M9c/gQgzKU0=
X-Gm-Gg: AR+sD11oIdL/td8P1PM69R4UX0C4G5xs2QSi8iD+uL+Zb9JH4wrJEXAIN0ktivR8mWx
	A5a2GsWUxgCifanEX1upfduHXWLi/sJpj1yCq/h2vEXcGUeZJopPOX1f48D8x3QlsltWqD7TqwA
	hWhx4RH6gwEUIJx76s3OBjYZhi0aZ4pAp76RDWQwxMt1CXUj5HrKQp1sZh7PZKnEsoUkCf1nz8B
	z9c0RyCYU7ED2Esh8Bx+hZPsrGz4wPLJzFMnaK04NNFcwJQWiC4r2/fyPf2tlMphSpwYbOIxKL7
	9HdOY0m6ULvGzt1pqCHW3+Mr58DI63YOMHUMoPVgeZ7x6yHFM9Oczb/FJqtMrsQM9toS54UgIKu
	BiDcLAg==
X-Received: by 2002:a05:622a:4d08:b0:51c:805:1be3 with SMTP id d75a77b69052e-52e2f1453aamr61072071cf.31.1787658107112;
        Tue, 25 Aug 2026 04:41:47 -0700 (PDT)
X-Received: by 2002:a05:622a:4d08:b0:51c:805:1be3 with SMTP id d75a77b69052e-52e2f1453aamr61071491cf.31.1787658106527;
        Tue, 25 Aug 2026 04:41:46 -0700 (PDT)
Received: from [127.0.1.1] ([86.121.170.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f809bsm1918957066b.41.2026.08.25.04.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 04:41:45 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 14:41:31 +0300
Subject: [PATCH] PCI/pwrctrl: tc9563: Use gpiod_set_value_cansleep() for
 RESX
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pci-pwrctl-tc9563-use-cansleep-for-resx-v1-1-0dbe7cfd8200@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGp/jWoC/yXNSw7CMAwA0atUXmOpDSR8roJYFOOAUZVGdgqVq
 t6dAMu3mVnAWIUNTs0Cyi8xGVNFt2mAHn26M8qtGlzrQntwHjMJ5rdSGbDQ0YctTsZIfbKBOWM
 cFZVtxhi4i8H73T4S1FpWjjL/TufL3zZdn0zlm4d1/QC1tfeaiwAAAA==
X-Change-ID: 20260825-pci-pwrctl-tc9563-use-cansleep-for-resx-f6e1f65547fc
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-0e65f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=wosuwikMoz3gDvLoC+hERTwDj0vuY/3L2+sga5V0z4w=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqjX93aTtbHW+c5FVSm6Qi/5RABaggkVD9OOoUw
 BGQLXYUdLCJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCao1/dwAKCRAbX0TJAJUV
 VtDfEACIYJ9ZJxpvL+O/tDgWUYRCxg9cVsV/0tXOcQffN0BVrYm4kY8MzTY1o/8r73cdAd/sNil
 HMWvSxziWOObklwqhh7aAJjmEFB4uIrcGTxG1Fv4xJIOcSyRCwQipgnNnmN3nOJd4jb+rB9FgvB
 6OeOafvfYwwWSKFtu6xBwTL/9RRKo1ujiV073YgkxLpI25ceOExTI5I4Bm5rACYQM134O2peTUi
 yamS7YclM/DS2w0Lo59jWh4VLD0OrOBixHvXwnX6+dKU8Syud4JIL2jLk0eYCT2Rba7GbEnUkjm
 ub+00p9afEZHxhJqC3qrwgn/U6YQ9O+X67qKb4n0BgkgVzCejzqaX0pcSLoEeQRpIJyP8LFfXgf
 w94xUs8k65kc+gg9lwL8F7qYAFr3Sfu0nDqDfwdyx0tqC/uutW4ukFZ1CIUSfssPdX22hRzhdMb
 pKdYzwoje5yIB4FwyiWdARAwZlM9amyk+aPdmIFErKnR/bC37V7BHzqOCZ2CHP6Pt2kC6Ff8QXK
 ba1zglehI7x8hXUUfzA5je9Ub0puWiZJBmFtBc1gGWv53knGLiXvflLqcDE5poDRKtfrMAfNidY
 pzJz/mEPtlS+Dmv/W1HeKunDFkVp1n2yN/ZROfkvMuDlzmEp69hkD9VRLAPrAJXchXhuXv8ZYVm
 do5SuruaTE/K7uw==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-GUID: ulVT4g2Hh9wNgeWUhh7_rQAXRp-hBW3a
X-Proofpoint-ORIG-GUID: ulVT4g2Hh9wNgeWUhh7_rQAXRp-hBW3a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA5OSBTYWx0ZWRfX4CuT8oSE+ixl
 HwIAk/ghHOVnU9D6KGfrV6tHyEXeePrQDURsU7+eU80pdlwp52HGRROC7mBUlsVnAsgfR8D25FK
 eU7J0H6KUrcORaj3/K3MZc+ANysXO1ZynR8eH2m0p33xlpHHaaQE3HY7nItQStKm8NIjD59ze4J
 PTdssPd0+jhjBDJDu50OzCQIEeoVpRetxWOGQZRtZilP3ojnvuKy1dVhpfMzYrxNrrFF8LUSl0M
 a3dSNy5wIgdDRUHefx3OnVGEMQM/4Rs3A9ek3cE0sLqNj7kbbrctKm8RVb7CdKqNlfBmTwmIg2G
 duaDXwZh1pdeQMSuBPIabOCk5blzdEP4E1siMmuYENLt1bLdylg+tttd04MTq/vnVtBRyHvcbtE
 0WfB4GhKNouMQyGwrjY8xHGLx3ZuQru3kJahuxBC79uZOJ7cSGfBHM14X9r1ThK4bW8HZBvqU2f
 l30zFok1I+d8Op9KGBw==
X-Authority-Analysis: v=2.4 cv=JJULdcKb c=1 sm=1 tr=0 ts=6a8d7f7c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=clBUptZa5v5FR042Ey+sjA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=zkraGWfKDus0AwAJxKMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA5OSBTYWx0ZWRfX+EKuWbtTLUx+
 lSR1wN5gkzW/M+p45PltT7uEgcTLCOkuKprMDpvm+rHgLWsVbFf0nVIaMmdSZYcLPtOdmClXHEa
 05ryJ3JabSDSnfxcDMkW9J07w4iJX3k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250099

The RESX GPIO may be provided by a sleeping GPIO controller, such as an
I2C or SPI I/O expander. Calling gpiod_set_value() for such a GPIO
triggers the following warning:

  WARNING: ... drivers/gpio/gpiolib.c:4030 at gpiod_set_value()

The TC9563 power-on and power-off callbacks already sleep while enabling
or disabling regulators and while waiting for oscillator stabilization.
Use gpiod_set_value_cansleep() for RESX so it can be driven without
triggering the warning.

Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index fd53a7db9875..1b7718d07d15 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -481,7 +481,7 @@ static int tc9563_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
 	struct tc9563_pwrctrl *tc9563 = container_of(pwrctrl,
 					    struct tc9563_pwrctrl, pwrctrl);
 
-	gpiod_set_value(tc9563->reset_gpio, 1);
+	gpiod_set_value_cansleep(tc9563->reset_gpio, 1);
 
 	regulator_bulk_disable(ARRAY_SIZE(tc9563->supplies), tc9563->supplies);
 
@@ -501,7 +501,7 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "cannot enable regulators\n");
 
-	gpiod_set_value(tc9563->reset_gpio, 0);
+	gpiod_set_value_cansleep(tc9563->reset_gpio, 0);
 
 	fsleep(TC9563_OSC_STAB_DELAY_US);
 

---
base-commit: 4b18edbd8e70f7e6860d56370f13244896d0f95c
change-id: 20260825-pci-pwrctl-tc9563-use-cansleep-for-resx-f6e1f65547fc

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>

