Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975DA49B444
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983346; cv=none; b=nxMMztOafP2Yd1Jv1SJSHz4yJ1sY6wB5VLaRqi/ZvHO8RBUGQU4UOMutFB5GtHDt/iEAEP/+Kt0r1DD82yfmAE/vlMD8rVyOIkHiKEmHFs4H+XE/kIT2/AmD3yDBQ/R4bJGH/wCvJ/Cu9jMp1TxMeuTf24YqwXHG0BtpZ9QFPe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983346; c=relaxed/simple;
	bh=ViUeWJk96PNqJrIhaEIWN5xsXuhaArFaHhFVC6OOLhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vEMHYNwdRUTW4tqFHE6isvqOH8FWt98CFDeB4A6bYaS4hDJ9kbfCBus+XwI0bRQbxP8gYovn66mwaSErCRquXfAUs1MSX9HlaSH3RgiCc9Xa6R2UuRrNeNRTYVO0R8mLxGtg6Bcd0JyYQo76xM2trPI/6qJtI3z1QLAYywIDTpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KFvsOztY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a7lsuEWN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KFvsOztY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a7lsuEWN"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L79s4P1096065
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 09:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mJTrOvpF8hQYLxtXvCLsRNpc5rO6U96I10x
	yU4upylA=; b=KFvsOztYpIvT7BiVlSUrkjRCgWpqbz7bevnuNrjNQe16G2UiTgH
	PZo7psoXfBCpj9WB7kWN+OgdDB7C1DeBKSUyMz5EdFCftCas1aY8ZJ3OkduKiiEo
	HnZ6nYO6PPfhc4aUa1HfFMLR+BWmQ6kYDh3YTw2dYQeGg0j0u7fab/0Sg8HxQ3aa
	WymnoUzuIjScFHkCUlrwBawf56lPMwT9VsHyxZrTHUYAkdCsXNb2udEszd3bdS6e
	FeuQkF2qZq9+DJoGGPPi+FTSorhIxHo6DbYjKO3Q77744xcxKcWOYUi6kGqLMai9
	ek7RbkSKjsdQVqA9anN5Ksicq+QM8sVsGkQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtysw0mms-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 09:35:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a3f673221so455353485a.0
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789983343; x=1790588143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mJTrOvpF8hQYLxtXvCLsRNpc5rO6U96I10xyU4upylA=;
        b=a7lsuEWNLlqeiim+gwnOQy5YGR1YMWLGacklyczwPXV7xJ1GYX8wUitc9BEOjEkHs2
         0C2gCnMlNJkhjSG2BZYXxpmUAXKF3unGz/wmrNbJQd0pWLiNflYxXgsyEsE/2ftRzMjy
         rf+ltCrP4DtQ43BL518FPjybeO7i7Bjzf8CyPtDygKPeDYqn4Giz+ytYUYYJ1+DtYwMI
         ovcnS85Yq5I2L0UreDkTPN/Rgwmd8mEro8SSWab6EiTLHAOXJ1zHsEi5p8mSpUe0Hl7D
         c3iP/pmZSxTzHuwiAH6HA9RvsQq00QftACuFcdScyKoiLK9PLB/fpRxk/xNNp61ubNqQ
         5UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789983343; x=1790588143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mJTrOvpF8hQYLxtXvCLsRNpc5rO6U96I10xyU4upylA=;
        b=glHl6FQtiSuD5/D5Wna55vu6lLUCOoB4C0cdvckyn62INUTEXK2MuHEkTMK+O1aqtZ
         Vwe03LBrzsydj/ybwAXtrJolg8WjIzkPPJqUUp42PNeCQkh/DqbsiFjxd9rX5Me3sBbo
         bKBRXjZXm45oOs/Bv7TCosJeAXL79oa7s5yWpxgnalYe5V5VqRRDBuIoF5+QCI8BTiKd
         KlPbQ1VMmURmRqI5nM0ol0j3gFbNw18/MBAzNYJXyN411I+Sd3DqmYfbPN75ggvO/FsA
         tvuLUOIVHui4IE05MBudXnAmXvZheLMHH25O1r6BTfmnfe/0M2NhBbQ9west/jNM4ha1
         xPCQ==
X-Gm-Message-State: AFuF++mrGmWaVgORslar5wpcWSfBbwLlr0MCLRiq4gCYlCpkoszfltCx
	76EIlXkm8s2MmzetwQ5VhGgcao9P86BAhk0L/nRjKNjybJAsqsnCq8HH3XqlUYKJLKeR3PON0nK
	S/C5AfPNLCVPOebgtDoD0pT4kBMDF+dcFtKOf2bPNFbV6ExAfEtpMG5rtGt1KIBU=
X-Gm-Gg: AYBFou1+aNetNwIfQpr6jjaEHiG9T64nDO8SMS8k+CiYiLqZqxT5uv2MNTSo4Wktk/C
	hx+hpTJm/BxM80+mbzE3IOEQG4tKa5/jKRdOYm/Wpe3rCZeSRBQoCI78RmZFJWTzh85rtzeEuE9
	c8aeRbFGPYelSYe9dai9Vs7P6/jw1NxsGHrypPWw/Gc73xh1cRTZfkfbhE4H3qvj4re0vymzL5u
	AXwxjRlnRFfQ5ysbD8VUAzYHJsVVl7kvyr5OC3dGWKzwzW7y9q2zbDLq4t2xJj8u2//UEy2sFJn
	i3+rGCKxUEJfvfvy+mLWFSnXQLeKKqZcKssEydWFb0ILJ0eGZsohHg1CUKZpC4D6e8zA/GJ6vZm
	RRs3I6iN/gLZM5nQIP8hOHQxJHA==
X-Received: by 2002:a05:620a:1a14:b0:93b:d7a1:ba10 with SMTP id af79cd13be357-93bf576ab1amr994781185a.59.1789983342842;
        Mon, 21 Sep 2026 02:35:42 -0700 (PDT)
X-Received: by 2002:a05:620a:1a14:b0:93b:d7a1:ba10 with SMTP id af79cd13be357-93bf576ab1amr994778685a.59.1789983342499;
        Mon, 21 Sep 2026 02:35:42 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:d04:d483:faad:1e4e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872456301dsm21897253f8f.18.2026.09.21.02.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 02:35:41 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        KrzysztofKozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [GIT PULL] power sequencing dependencies for v7.4-rc1
Date: Mon, 21 Sep 2026 11:35:29 +0200
Message-ID: <20260921093529.45596-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzNiBTYWx0ZWRfX+TEvYDMNwUiZ
 QVl9lTTaoYU76SPLHg4XaV5p8+9lsR7vPG7LY0wEpIt1m8jeNjuCbrRYoc0gWDluOuDkBXlPNMB
 onIzy7OCWejtV5GY31fEzF4b4jpqDYBu7kXpMC4lELx3U8Ds39Vs0ilTZaKCHjvuwzjoRdl/Ltl
 aW5XCZtVDiccbatXOTPZ01yGlfcbqUxRY4rCv4rVX2wasXDWkMEzsYao35VjW8GpbJE3RkFPsLe
 3LUk1DQDvApGGF5izgQ5Ur1iqDqH/KK3G8xAe6+Tcj8/Ep5muere0oTm58ojWYrdd8tkNuaApj4
 +jcE8/XGvDJFxcHizatAYRll0XGeJsRgKlF1fdqmtWT7ELskJT1CJgu1az++qpMwuOOMYnIEfWY
 kdpXv/S7ol3B0vsG24ULTV6fYeW3m3L5iSPLjFAImmbsUiWcXZ4tYfyGf4DLZYvHtcWGHH9pgr6
 ustLdC8EklN77lx68FA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzNiBTYWx0ZWRfX96v8wY0c+qXL
 9kFcGS3DOJm/eCC0cjvzTUsiR5P0SNQbUVCGxtNR35RAJscj5ASM3NRTRAeMCxI7rcc8IouGDSr
 14k/F17whXBkqD/1yyzkxf31/sg4GFU=
X-Proofpoint-ORIG-GUID: yYJ6PMSS2C5O5KzvykuKdC2K3W6ZeZnN
X-Proofpoint-GUID: yYJ6PMSS2C5O5KzvykuKdC2K3W6ZeZnN
X-Authority-Analysis: v=2.4 cv=W7etxhWk c=1 sm=1 tr=0 ts=6ab0fa6f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=Dtz6quo8gWpENlhL4bYA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210136

Hi!

Please pull the following set of power sequencing updates into the Bluetooth
tree to satisfy the dependencies for supporting BT on Monza.

Thanks,
Bartosz

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-is-controllable-for-v7.4

for you to fetch changes up to 295eeaf2c6543f746c1c7d9871f6d2f71a7ed4cc:

  power: sequencing: qcom-wcn: Report power controllability (2026-09-21 11:28:12 +0200)

----------------------------------------------------------------
power: sequencing: provide and use pwrseq_is_controllable()

Add a new core power sequencing consumer functions:
pwrseq_is_controllable(). This allows users to check whether the
sequencer's target is actually host-controllable.

----------------------------------------------------------------
Loic Poulain (3):
      power: sequencing: Add pwrseq_is_controllable() API
      power: sequencing: pcie-m2: Report power controllability
      power: sequencing: qcom-wcn: Report power controllability

 drivers/power/sequencing/core.c            | 49 ++++++++++++++++++++++++++++++
 drivers/power/sequencing/pwrseq-pcie-m2.c  | 26 ++++++++++++++++
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 30 ++++++++++++++++++
 include/linux/pwrseq/consumer.h            |  7 +++++
 include/linux/pwrseq/provider.h            |  8 +++++
 5 files changed, 120 insertions(+)
