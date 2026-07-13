Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21675368D4B
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934187; cv=none; b=aGsSE81Qro5YWdZ9B3CS9Hz5lZLgJ46/D/dZ8ORJDTSM8ChtD7KwN/FjhSx0ah8jFYj8zn6b3KMkB9gZ9ec7opedXHTToZERO5DxNkP+PFcee6FfYMg/4q0siZ8ldb9URctMZZcCj8XgTcat9JtvAWbRzipTcSNb8C409Hn09UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934187; c=relaxed/simple;
	bh=+IKt7HkKvvuZndazkU87cKD2wlXL3ZMBBm/eMI38q4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LlGC6BiGkbHve04eRXpbPZlgF4X+j76cHZsYqEPBvETv+80szOsvhaqjFnr3cMX43G7E6GQZ/eBoLAbnhC89NnE1d9UHG7/rW3LH+5pfDzctNPpm830U1bTdmMGDed1gVjewnLDsYdjwrhobEdRDih6++J+sLzTno3cR8GWx80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=afDUukYQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Thh7j4M7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="afDUukYQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Thh7j4M7"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6NvwQ568097
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 09:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=u7OzcwJPgZs
	QHVGY+2aqMLjEMoYse2TWQIvIkQHyER0=; b=afDUukYQ78MH83XCkauFs+vMTZ/
	xOyNWDf6WL/CM9LJdHEGic30lGUYZvRGJJ3Kyz2T1y0HCT22luB0e23N+z/EUIzf
	5khm/3SMHkGQsQh6bHyhITolyRnyFm7C5wpjQj1WtRuYZyHwr9+wC+alJ611tsG0
	8AtNzdrndDhk8XAcPDSte+5v6N95Rkf6HreGQNdT/W5+VQb5VQU06CIz2Z8+c6WY
	vPVgd01tsrDfzhhr3ZCXUeybPw+3CepMYtgJyNezCPSuObTlbCwOYjCepvjcsx1L
	QJxpnVywme8ybMu9ADH9VwNZet/eFzd4szu7a1EkvXJUMTHpC9cs2HiJPFw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe915cjh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 09:16:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-382befb9555so896671a91.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 02:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783934184; x=1784538984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u7OzcwJPgZsQHVGY+2aqMLjEMoYse2TWQIvIkQHyER0=;
        b=Thh7j4M78vejxkyH8T5Yml/dsm5WAUCL+cFT6Nui8nr1IKKJUjtNvyhbed3rGOj2z0
         ZijxFVne8/2ygOjcXnA/jqwhYKdA1x59oUr9pp1liSHj9xX79YZsqa/hX7ksXbyhKLPB
         zLNZgiegfuZU8YWZBDggsbxX2zQ2+fqZueeOswy0TLU7cyRu1DumbkQ7UQ+N4oObPQmO
         J57oGCugElKA4CD5yx1MnOo3I6nF/VuI7tKOfLFo15FGW0qsIA7/W7OUZn47erVJNcAJ
         1ej6tdYokRG7WdRHZDKhCNG2OZP5xyyR63VT/VojiP3zAjF3tL5nVDvvAnk1b8K+CF5B
         ixEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783934184; x=1784538984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u7OzcwJPgZsQHVGY+2aqMLjEMoYse2TWQIvIkQHyER0=;
        b=OSF9jKPSWjBUeFGiUqv+aLZbslQh5vRgbM8gUG8IUDyk1feOIf1eeFsSQPT4ie/uEN
         7+oEgHKJfRGr8ZTiwEgo4uOdPQOxvhx07RX/JcFvP/rWbyJB7ndXk1HnbguSWMaObnNX
         E7ESvCylpK7d5SiGQNunkUvzKcTX9Zp+q62ETFtLmskxvsETQPjwyzzNJYkcakwudP5X
         a5RpDrg2Kc0vQHJZ82mJPc5LoFuKXXM0gDmZ+rBsr++WL+m6r9R+4EcvlgdtX0LBgBW6
         vmD4UTp3dnf98RS7khRNB0vpW8+Z4oIXH9kiSKnaaVQH2kyRq1fc421IXg7ZaMv9+PP/
         G1jw==
X-Forwarded-Encrypted: i=1; AHgh+Rr8BR8diX9ePve4/eooK9pgONkvjL6cwzp2OZL4hSS3iQiTCX8kLkMxPHYq4GXo4y6Bkxj4CVSD52w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmwzgqQChesPFPHVB3oB0fvRrspFcs8EwQFgO5zT6Mt8Dc63yO
	eCryKcw2el2RbzXd1LQuRV5zUNGlfLcaxXUl9/frXzdgkfuf3Tgv0r54FbQXb4kOzM9bF/IRSNO
	Ea/4SY81xKBhzlw4sb1hQSnH8sYjzmsW/YJbZvELIUYQIcJoFtXdL4nZcWLBuepk=
X-Gm-Gg: AfdE7cm8OAZLkBupzpwTiAA79pM/MInujBxOLoUL9b/VirrLXizm3F4P9LhzhpyuG5x
	r2s594Py5qypQYhvL0OsiBXyh1AeFP5ljkPXvJGm5P8Ia3Mymie7pNLSLmy9GxHEMeWgbKMfNlm
	E3QQGt9DykwWA5MXIUElJN3ZQrg+RPnEmNao4mjcfBKfK9TbEIfU8Doo4Q9RGqTVyJ0sMqF4jm6
	nFU1Fh0a5rL5e7Rw0Qm+0Yf1DYp3VeR8Oxc0P3V4aUvs9r5fGvPNihPHf4gAkSsyRvTirSkDvpj
	4gLNxnefqSwPu47Rd1JYP3LVRffI8WYdPPpK5l4vi4ZeE4BtMb4eNI9sf/NSvzq7Dyzi0eX4pSK
	GWybiewkwVV6a47CeODBHPKALOWcfVXPyeFc+1bN5+fX6BLbXK//S8Z6M2i2ULQ==
X-Received: by 2002:a17:90b:2dc1:b0:37f:e7e7:ad1 with SMTP id 98e67ed59e1d1-38dc7c0eb95mr6154259a91.5.1783934184107;
        Mon, 13 Jul 2026 02:16:24 -0700 (PDT)
X-Received: by 2002:a17:90b:2dc1:b0:37f:e7e7:ad1 with SMTP id 98e67ed59e1d1-38dc7c0eb95mr6154211a91.5.1783934183550;
        Mon, 13 Jul 2026 02:16:23 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b9ca880fsm26496089eec.23.2026.07.13.02.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 02:16:23 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Wei Deng <wei.deng@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Chen-Yu Tsai <wenst@chromium.org>, mengshi.wu@oss.qualcomm.com,
        quic_chezhou@quicinc.com, cheng.jiang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: Re: [PATCH 3/3] power: sequencing: pcie-m2: Deassert W_DISABLE2# when no UART serdev is created
Date: Mon, 13 Jul 2026 14:46:16 +0530
Message-Id: <20260713091616.4092086-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <gatls7n4xes7mrnhgxwsjof7owpocdmjrvuxazedznwa3zeb22@q3mtufc5dzkv>
References: <gatls7n4xes7mrnhgxwsjof7owpocdmjrvuxazedznwa3zeb22@q3mtufc5dzkv>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TbymcxQh c=1 sm=1 tr=0 ts=6a54ace9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=M_wy9YA4QbPrr36y3cgA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA5NiBTYWx0ZWRfXxpjDLGBLAE5X
 7IwGvENKr//laMXlrYxAraHcbDHFy8Lol/VPJc7Kkj/yjnul0WKQWtIJKOesr32ZXYh0bn8Eg3m
 cu7xq7vVL2k0vKIf+RaUlVEo2euwco0=
X-Proofpoint-GUID: hF-mQOia3l6CY0ZnQX0xC6BAuLea-ZcF
X-Proofpoint-ORIG-GUID: hF-mQOia3l6CY0ZnQX0xC6BAuLea-ZcF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA5NiBTYWx0ZWRfX778pxCks+6/w
 NYwHsfEARMaw9rSFByHUL4QOEYHjcbvHDLDFjoQ7a840FGeajT6NNMmN4rgE/AMf5Db5TNq7Zc9
 5s/nRtarNtsDiReG0a5xK68WaKiuIEfCSAXEZ5aQgQffFFzUJRzgCi6T0Ud3w+E3cAVXF8tVOtB
 i91BqIEoPYE3eo5oE4kAkvbhKPrNFl3kuAgCRtA2yQlwBLiuC9TutT85ScLupUA240y5Om6CfjZ
 nPgktwk3RzIUh5f9Ux73cgC2lSKNJCaXCMYd3AswHMBjcJmZBAihucBznSZsSXOQcCf71kzNA0t
 2UWQf7LIWNSQrcE3uRkwiu6H6YATRNuxKeNrgsWRr03+bMJ05+x6iA2DdPAzM9L4QXX8aDgolA8
 uVDaOPnL7ZWlLIwqS8L7zCgfhvVRbEBpjS0V5UcIHDLVvNN4wDShsxYfp9WSa25vXVOueDoZKbD
 P1H67c2WO45yuhsxryA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130096

On Thu, 9 Jul 2026, Dmitry Baryshkov wrote:
> On Thu, Jul 09, 2026 at 12:59:42PM +0530, Wei Deng wrote:
> > The pwrseq_m2_pci_ids[] table lists PCIe BT devices that use UART as the
> > BT transport and need a UART serdev created by the driver. When a PCIe
> > device under the M.2 connector does not match any entry in this table,
> > no UART serdev is created.
> > 
> > However, the BT subsystem of such a device may still require W_DISABLE2#
> > to be deasserted to power up. Rather than adding every possible non-UART
> > BT device ID to the table, add an else branch that deasserts W_DISABLE2#
> > whenever a PCIe device is detected under the connector but does not match
> > a UART BT entry. This allows any BT interface on the card (USB or other)
> > to enumerate without requiring explicit knowledge of its device ID.
> > 
> > The primary use case is USB BT variants of combo chips that share the
> > same PCIe device ID as their UART counterpart (e.g. WCN7851 NCM865 USB,
> > sub 0x3378, vs NCM865A UART, sub 0x337c): no UART serdev is needed, but
> > W_DISABLE2# must be deasserted so the USB BT device can enumerate.
> 
> Instead of forcibly toggling it, would it be more sensible to tie pwrseq
> into the USB too? The onboard-usb-dev implements the same idea (of
> powering up the USB device), but it predates pwrseq.
> 
> > Reassert W_DISABLE2# symmetrically when the PCIe device is removed.
> > 
> > Validated on Hamoa EVK (IQ-X7181-EVK) with WCN7851 NCM865 USB card
> > (sub 0x3378): without this change GPIO116 (W_DISABLE2#) stays low and
> > no BT interface appears; with this change GPIO116 is driven high and the
> > USB BT device enumerates and comes up via btusb.
> > 
> > Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> > ---
> >  drivers/power/sequencing/pwrseq-pcie-m2.c | 33 +++++++++++++++++++++----------
> >  1 file changed, 23 insertions(+), 10 deletions(-)
> > 
> 
> -- 
> With best wishes
> Dmitry
> 

Hi Dmitry,

There is a patch series from Chen-Yu Tsai that appears to implement what
you suggested:

  [PATCH v4 00/14] arm64: mediatek: Add M.2 E-key slot on Chromebooks
  https://lore.kernel.org/all/20260709095726.704448-1-wenst@chromium.org/

We have been testing this on the Qualcomm Hamoa IoT EVK with both UART BT
and USB BT M.2 cards.  Is this the direction you had in mind?

Thanks,
Wei Deng

-- 
Best Regards,
Wei Deng
