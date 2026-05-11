Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA7339844
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497344; cv=none; b=WBXrGXKMdurjudvWZXmoieP21F2MVEf8zNjpYRyOt4G1iEouDahD3SG29luV0bsRCJWP1C56FKRyo082GUb+sA0r9BB+IRXHH8b/pfoeBxQM0aigf1XXmPI+Q+GDtVeInGhBVZ76tTKlEgt38UKgGMFjuAq8V722cNTtQKqh0+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497344; c=relaxed/simple;
	bh=tTNXMZH6Ae+7u/TjfyIMvdzqq0hdS/+lhtAgJD0DOPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRHsNzYWNbf0lZzMeaOUA1sxBqgdpYQpZnPC53ELc5rh06i6MbaSaj9JcWUM3G5MFLNalAcUslkEAJLPYplObJly0+DSWDUMXANLPOa1IVkzOBxlYmt7w+aDYPD9cbQM1Anc+VPSiP6mNjeqPLwXkyjP8KHdcGBGjyI6LC6YNDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AvffCpGg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ecIivv33; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AvffCpGg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ecIivv33"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B98iog017313
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 11:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=yMmxsHM6Uj0ezvVVKE35kNxfWzaw7YGLP+g
	ykgxHWXQ=; b=AvffCpGgIyC4GPNB+NsO/7GqsYPjpKtpaDnvWyzJsXXHU2V8MVj
	u6NJiopbN8d3rn3Pb6mZpErVt4hulbzaPob2+Ymgc8YGqXgJEqcLkbee1Q0N5nVB
	sC30wU8p5ypVBbJYDhfJgcsR1x5VBgpcBiQzHdSHJdVymSXEUcaxfWKiAs69oHD1
	uX9NcKp5YleHe2O1D4Z+SelyRvlYkQomvH7elqgnbYR/f9QysOUF0yLK/1qpU0B8
	OyO+dgirOSmkA2rJEyWMZlKcUs84puxBy/zHCWYSBjiLNWTxnjGAJA1zEFiyOsgm
	ZqBquMHFEUKk4AWBf7zjTG1ugAxSibri8aQ==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e37xfsdf1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 11:02:21 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6961bdde2a1so8207420eaf.2
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 04:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778497341; x=1779102141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yMmxsHM6Uj0ezvVVKE35kNxfWzaw7YGLP+gykgxHWXQ=;
        b=ecIivv33XunAofNSIxlBPAvQfTP4eukYK7c0Ai99cmduzWuqtU4tSqMqoJ7De6lae3
         2lzHVHgwLDgvcbFLtGfbXnBuaoB5GojP0OU3nzIM5uWu/cPrcrsdBqyQCCjTAoKnPLxw
         1HXWxKJIjKgfdHswfTYrS5lXzFZt6EZEXxAsjdm3jucjp2rvbvIzytsXwQlz11Ron39A
         8DT6+UO0m3wkAljBNSJtGvpaHnbqbV5qo4WZ+TTSDRHBJW4s/HpoFj0rYWsl8KMfQQZm
         RhIp1KK7Zi3adUhqxBRQgaAq1aiQlz0/Ie+Il4aPP4zFZ0IAtBs+cvgS5O/CjfWzF7BD
         WxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778497341; x=1779102141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMmxsHM6Uj0ezvVVKE35kNxfWzaw7YGLP+gykgxHWXQ=;
        b=A77YWxFcb/oDTxsvJdlVU4eUIa2cDpOckqxDH2VqOXBo0ivJvP/06d9fcGCgMb8BZu
         2FJSq6ddrl9sTHzoqkq2p0vtx/YVlias55mcMz/wfC4vLPvjnK++rtRupGEX7nOFf9NV
         +B4+nvlyBe4N8w91w6OJFTXPHehqa13I0OzP2vecCggMYOyvo4969TzXEHGW4KfxFbej
         5FkQ8X3FuDbmrOVxTLDCjeVCcfJk4dnv3wN5Tu6zMjRxmd7h6U2qTfHRs4zClX7g33Gp
         OwrrP1JAmH+fY1ub4QD6omGjfKzavE5vohyFUA6fcqZ82yon2d9y9HHqXKdookUmqCEW
         pYQg==
X-Forwarded-Encrypted: i=1; AFNElJ+zD41OMU7RtmJ53oXww4TzpPEzLC4cFt10hwOVAkPJog9/z9xbVI7i+fW4cG5g9WJpeiDKBHKKFvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2XppC2LycZ5LuQBFiKF7fLZGRX7kXpnnHgLF51HcBcicAZpul
	GzhzY66lhFHNqBMSygkdfQpSft4Dt8p+CoKABYz0ERjA/QFuM0endybBHSU7f4AvKfjsy+B3s6V
	QcXCPbNWWzTs6EE/7gTZu0FLOTq3bYy5UEzW2HzLlxb4FwC6DhDR7N1dFEXmQZPcebAyj/LE=
X-Gm-Gg: Acq92OGQny2srxqTswkdCtckpIXtRpKQNEdi+NSyxz9JgplyYw1QOPNYZSYCA4aaEIo
	Motz7dJsLld7gpnp9OGyAnovSIagR1spXii6LNgerCqi6wd6uSeNlm5UoNEkKK/Q5ohljTGbHZQ
	Mzg/CA5iPuB8YmmEDLl5OTR/OCJ8SjHSuNevcfBBjYh4q5XA/LA91fAbGtiBc0s4UzrOhrSe06A
	wpGGJZPD71dW5+CMTlDKdN3JFl3wNpm30CBbdeePr31xTZL2euSCs0ULH9xbCB1kPLP+9+cUrjU
	2f/StJP1mzVvE9rsMc2CmPCAvcBIm5q70b5KRRdxQSinVF3gMFG8I38BNmdmmB8ua0f8jwCG7df
	eR+YDh7XIOS/QGoRCBN+aZkw691pFdJFMPlF5zbE7zr4iT+Vwp3hnV+lMb4KA
X-Received: by 2002:a05:6820:160b:b0:694:9a8a:2ce with SMTP id 006d021491bc7-69998c8fed0mr12284335eaf.8.1778497340848;
        Mon, 11 May 2026 04:02:20 -0700 (PDT)
X-Received: by 2002:a05:6820:160b:b0:694:9a8a:2ce with SMTP id 006d021491bc7-69998c8fed0mr12284298eaf.8.1778497340436;
        Mon, 11 May 2026 04:02:20 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:63bd:c2f9:cedb:aa32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d895781sm109967955e9.0.2026.05.11.04.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 04:02:19 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_vbadigan@quicinc.com, sherry.sun@nxp.com,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org
Subject: [GIT PULL] Immutable branch between the GPIO and PCI trees for v7.2-rc1
Date: Mon, 11 May 2026 13:02:09 +0200
Message-ID: <20260511110210.46711-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TqXWQjXh c=1 sm=1 tr=0 ts=6a01b73d cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=OnGjS8KU5By8L4kgiv0A:9
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-GUID: 6JfM1aCe_eRcIQibeQD-NT3NFj7DXAfs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEyMiBTYWx0ZWRfX1R/7LvBzYYKh
 nJhr/yfLGUYHh7wo85yK8o2aba12IcYrB94YuRT8TjhfrdWbW3tkFG3k62J7P6lNqZw7Vit8A3d
 2pjTUm7OUIIQ5cvcpQEHSgik9u2/Emfvya5RQZJMyfS7/7hxZkqQ+QuEt1CCXeDLXXxPHlWcDud
 ZGUdLBvmX/8x4Y1Q4m2uHfnguoDeuC713AkrquWtzZMSIBBpjnqxd+PMkA63u2Wu+SswA8Gp8hL
 nJ96lE7O8WG1I8vBr83bHyIysLN8eESOOtKc6/CO5F11xjjoOwvKSgi6ocotTnisyr3tbpk6bFq
 oVpzvTr/yK5HlRCI3EUvIc8vCgadaZn8b+W1v3h88NaWSLRaLIb+kM98QKrxvlJZqmjUICZxRLw
 YE1pN/fTIozVVKN5A31GGisrTSgazc3QLOgvyYcLiNSx8EA9bkGLmOXzscXDQoa/o46M0HutsEl
 JKMQO7YqO4D4E99z9ww==
X-Proofpoint-ORIG-GUID: 6JfM1aCe_eRcIQibeQD-NT3NFj7DXAfs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110122

From: 

Bjorn,

Please pull the following changeset adding a new helper to the GPIO
consumer API.

Thanks,
Bartosz

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/ib-gpio-add-fwnode-gpiod-get-for-v7.2

for you to fetch changes up to 8a46bd2638f1ad6d1ed73dc3ab10919e67274738:

  gpio: Add fwnode_gpiod_get() helper (2026-05-11 12:57:48 +0200)

----------------------------------------------------------------
Immutable branch between the GPIO and PCI trees for v7.2

- add fwnode_gpiod_get() helper to GPIOLIB

----------------------------------------------------------------
Krishna Chaitanya Chundru (1):
      gpio: Add fwnode_gpiod_get() helper

 include/linux/gpio/consumer.h | 9 +++++++++
 1 file changed, 9 insertions(+)
