Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1665D3EFFB3
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146278; cv=none; b=kBpYNysersqW4T5IJ6RI1uNKz/U6MUlXmPs48g1lwEYXI0A9wPwZ+JG3UfluLCKnhTU6FEJflDyW5cRiY8387hmxwpnrt3tedqDUS79mtxz5idAJFyCjzwg4E45XHShhdnoZDCzIqqogfczvxWOP0yBsvprc8sNdOU8K0qzoQxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146278; c=relaxed/simple;
	bh=G7OuZnFzXRxi+fDAYiRyDUKp+x0C6VA6eN1JvMlufl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z/GV7Izmi/mVx+/cddoJ4RZyURCyVEyRP+tOssMmhbrZYZcZenCxwiA0y0BbC/2fkGkBlddH9a2A4+D/c0FN0OdB/TYvctq0W23//UGHD6OcfDXINRVq2ynM8iObMnlx0ZlRj7ZTiDbcjVaDwCU6dPXvTRJYY8OSzObGS4hM1mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I5+4aNDG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SLQPlQ+3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I5+4aNDG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SLQPlQ+3"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9bOit3545660
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 09:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cTfkRuh1qMz6daNEBghoLo
	xTzu0WE8KxCU7LeuEabmM=; b=I5+4aNDG3QRbCXqL80MbnJjywj9Jrnz1zXpdSc
	hyfxnrWHR1+9c2Rxgw5uEjAd9NRO05v9bEC9r7Z17VXOZVMtMYF/UTH4ojUomfV5
	bJ4qnItwyxJRV4esxyRIcgT8FCB9cMVQ9jLmDES0h5esalX8Bn78TiQpWfcTaUV9
	4qFU80/l3uB9t13YBGGhjD/O58PEHe5JC0rCL1TXfkaVMijFd23eC5ZIl9QvrWsj
	pML/9uZya91IPI/TP9WVZNe+jakXNHXpJq02aV0iuGzUv4/84qVW5BvT/K0xY/Mw
	q8Wt2mqJxKrryqWC73ZeaKckmIIqi8GgjdeUs1pCnTkIy4NA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4mrr4j4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 09:57:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1b4d961dso25486961cf.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 02:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785146274; x=1785751074; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cTfkRuh1qMz6daNEBghoLoxTzu0WE8KxCU7LeuEabmM=;
        b=SLQPlQ+3zwpQS5a6eIrLxfC2pJ7AFOd7yiYJRjKzz9GLvIBaqjLdrKej136AyD39Ag
         cRn+drgHpl0J60pBKGYIZMvaD/VcDKcg35GymRl3aNmiA1lKF+OfJ3iO391vd5sqZUV8
         mrY5YUCXww1okohwukGpS1z74wcXtVAnbdRZMJjE8jm/Ulo5+JIueU1DO9gH4MbDiP3F
         wWWQiUbWQh+o/oh59iexLGY615+SPWPMDaUdSm3RwzOZv/ByfkXQJZqYYAR9rN0mh4IQ
         EyEL2Ow9QpvuKDhimXaLx5Tjk3t9JcaR+WPaa3y7mDtoTXO8FoxSMSiwMfcniUlo4Xwo
         G+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785146274; x=1785751074;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cTfkRuh1qMz6daNEBghoLoxTzu0WE8KxCU7LeuEabmM=;
        b=BMMu5NEKZpmISLMeB2Sx96god48IQsH7r6bCCIzmyrfJd7PH45IVnIuuxN4CqGB+Ac
         8CE0ZbNrUauo9MW5I1NKPo4yhpbBACIdRG452bG/xpSRrCbQgY2KTuEX6YKsxcaDVWrp
         OY8sbm2zdnmtiBpg8c5GK8WjRaiKyhmqCYUdBpNXFJUDpH5WQ57DiqddWiOphWGrhJuI
         XxE0SjM1786vFyG+f27gjB6xF6Ee/vHCwqme+LtZEIRRJJSThDqPKMojWfbtgiqyHpB6
         QFwohJTp8mCeU35o1kVATI2oEl/oYuep4fYW6T9B5LCFWUMDyIkylxIDD5+mFe20xAmX
         jq4w==
X-Forwarded-Encrypted: i=1; AHgh+RpmH/4c/SQ8tjSwmGNH71QxfwUT82xO+eN6/8A4IHQTsiPTFaPGkGbu+IIC3F+o5y7w6r4hrXkAB+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqZwu8XpLHF/rrWRlXQb+c/M1Y4XVzTjA0ag+rlPmW+gKismMn
	4fpaqECLVdy2Q5pqr09oL43aeot5PU94/2mW3/74A6DhPcKro8rhfdBmgHaynNjYmoBa0IGRtK5
	LcwfGql4O6zXgDE2jkBC17V37bd0nbz+d+4rqTMPNHTLIsRgwfNC6lDLPXEpSgdM=
X-Gm-Gg: AR+sD12rMKf2MI4aQryJzciyDnkE/eHNTmBHAj8ssrG7VQHqw3K7y5kmkh8T31l9iyz
	w9mASnCiow64+lBoqOOt3F+oljNfKUt4ZxukJu9S3SXeIeVlYyR91Jh5wlnyZ+3zh/4VaJV0+rs
	6VKDsqk6flTYMuNtFkOYHm1bQ2fVASKRKrVAZpHA3aEa3PQm9i7tWtUqBANe0NETnFt8ZznOr9S
	HHtVea6AJcy3EWS9ThlEcJTdjk385nNNhZDOsWJfbJeiqDwQXFWG/MgfNIQeXS9W4yb+g3cTwqx
	OHzs4eKaezZlCFkwmgxoyCNysCywgkPYYIbCnnAeh5F9Yrqy4TfZfB8Knlehjc7BO21SySrJcns
	6bYi9TKHWixaQOi8kqoaImXG+dbnG
X-Received: by 2002:ac8:6f11:0:b0:528:ce0:e9f8 with SMTP id d75a77b69052e-5295d270a04mr106677641cf.3.1785146273864;
        Mon, 27 Jul 2026 02:57:53 -0700 (PDT)
X-Received: by 2002:ac8:6f11:0:b0:528:ce0:e9f8 with SMTP id d75a77b69052e-5295d270a04mr106677341cf.3.1785146273405;
        Mon, 27 Jul 2026 02:57:53 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:1449:2d40:6dd2:20d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32f19c4csm611477266b.63.2026.07.27.02.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:57:52 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 11:57:38 +0200
Subject: [PATCH RFC] power: sequencing: rename pwrseq_power_on/off() to
 pwrseq_vote_on/off()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-pwrseq-vote-rename-v1-1-a2029aeeac65@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJErZ2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNz3YLyouLUQt2y/JJU3aLUvMTcVN0k8+QUI0MDYyMzMwsloMaCotS
 0zAqwodFKQW7OSrG1tQCp4jesaQAAAA==
X-Change-ID: 20260727-pwrseq-vote-rename-b7cd21032668
To: Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alessio Belle <alessio.belle@imgtec.com>,
        Luigi Santivetti <luigi.santivetti@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jeff Johnson <jjohnson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Chen-Yu Tsai <wens@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, imagination@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pci@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11233;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=G7OuZnFzXRxi+fDAYiRyDUKp+x0C6VA6eN1JvMlufl4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqZyua6+kj7mv/zzmBMIis+gdWuocontWnq+eD+
 vv740HUnhyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCamcrmgAKCRAFnS7L/zaE
 w9XLD/9fSN/wxCKeUPmwVIqjM6yzfNVAPIBYsenBC17Ef51V+D542ya4dKvWfOck0ahoGK8h1ES
 fCsIdb6yUiLOXdXE1N7WtKH/bmHWrKnmXrgpH3j8J9YwApddS/jwfnAr7KSwTchMurvib/KFXyi
 P970euD779qbQdjTUm//egbj70HYVr12XoKea/M6suEWXE2hbdsed+qgibBXGSuCYkSMRKBcGHp
 xri0RBKzDEDXkyIU2Yax1X+KsDClbCCOP+uvsrUsFDmvL+iG5VDV81txFmfJyU9Ywb7yXJMabgn
 9InJCDQjwFOf8N9p3g/gMRm+9KQxRAE4rgDYNjQck4b3ktI0dDbumeOi+y57YdDp/F+0KgErSoi
 /SEq/slk2oqnBZmzIZcFUAFRHG1tb1SU2aMFLnGl21eN+DQSDhnVGR/wh/i29p24hgZ7Ph+d3El
 Ty31M0gixh7rEQEZd7g15mOvTdvKan0cojXEvOjGCORFuVzEgu8Y0dJ/okF0nUifFkROr+oPoi7
 kGMN7iRtpUrzssjjW8+cD31Nj2fGuaa4o4Mu4t3h6qMp964o+6MOtZd5QKRmEUj6ymhsaD9v57E
 9VHzB97Yy25qtF/aV4dnpAJM9GU4gy/ZARWp189Jad+AaYMrA746ewg1ONLdSFrLwQFyL6r49+h
 s2Mplu1/U1vA/Lg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NyBTYWx0ZWRfX465kL93c5uj2
 TaZq8lpCa8aiFk+bdQJA+Kqs/mgXTkMGTwuQSJ7juTIMWqCSXI69HC/7ezkZ1iJXxVogLHQkM86
 pTX+PpS4mJlFrLGOZZDuInSsyFkDBGU=
X-Authority-Analysis: v=2.4 cv=UYBhjqSN c=1 sm=1 tr=0 ts=6a672ba2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=BH6fHGR_65QtqvMn8p4A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: KipgSbi4Zr9pcEBbnqLRQJC7vbsP3Kot
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NyBTYWx0ZWRfX+wpvHMeEnBKk
 OH/5nq17Y91DuWNgNaC0lW5ObOD1kYiBY/hZcw9QqSTF5j92/mGdKDcMZeBOnnvvz0q+hHJ01Dl
 Qyt9ur7376DT8vQtP3UifD6SIIOa+Y+kEUZGYZi0+o0VB3VInwIFaFJiG0QWx8rs6tVhu1nYbR5
 6OvQGfwtf8NHVgYhAxKIt8E9nFe7csDkzPauONaTavo8qi28CTnaNf51mqKt0OhaiGZi4F7/I4S
 IO5sX5WlB/zCYIOjJpcEZDXhgJoYk9SXYYQhap1i3gF0CZowV4M76re95CEMc8qosAxHNNDm0/Z
 amkYU4hktYKhhPRk1i5KsjuOauMSQoGFaW3vq1JGrGC+U+taOIDQls7QQsKdPLCDz9tKDvNeP0w
 eUplRLaeTomyL/XGGvoADzaIoBLGXZyFprLF/cK1n+n3UXS4I+Tdp7CGTmkusiiYvGPHEsbVUjT
 Ao1B9ypvoqVrtr7vNbg==
X-Proofpoint-ORIG-GUID: KipgSbi4Zr9pcEBbnqLRQJC7vbsP3Kot
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270097

The way power sequencing works means that a call to pwrseq_power_on()
does not necessarily result in the pwrseq target being powered-on at
that time: it may have already been powered on before. Similarly: a call
to pwrseq_power_off() does not have to result in an actual powering off
of resources: there may still be other users that requested a power-on
before.

We will also introduce the concept of "non-controllable" pwrseq targets
soon which further increases the disconnect between the naming
convention and the actual semantics.

What consumers of pwrseq descriptors actually do is: they *vote* for a
powering on of a given target or retract that vote. These operations
could be called get/put in line with runtime PM but this could become
confusing since we already provide pwrseq_get/put() for a different
purpose.

Change the name of the two functions to pwrseq_vote_on/off() which
better reflects their purpose and semantics. No functional change
intended.

If at any point users need to know *when* the exact power event happens,
we can provide that information in the form of a notifier.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
I've floated the idea to rename the two pwrseq functions from "power
on/off" to "vote on/off". Here's a concrete proposal.

I'm sending it as an RFC but if there's agreement, I can queue it as is.

I'm doing it in a single commit that should go through the pwrseq tree
with Acks from subsystem maintainers.

[1] https://lore.kernel.org/all/CAMRc=Mefxn81d0VUwmQgwFtffkL1=Er_1VQZCbC1Sa-Qph4t1w@mail.gmail.com/
---
 Documentation/driver-api/pwrseq.rst      |  4 ++--
 drivers/bluetooth/hci_qca.c              |  4 ++--
 drivers/gpu/drm/imagination/pvr_power.c  |  4 ++--
 drivers/net/wireless/ath/ath10k/snoc.c   |  6 +++---
 drivers/pci/pwrctrl/generic.c            |  4 ++--
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c |  4 ++--
 drivers/power/sequencing/core.c          | 16 ++++++++--------
 include/linux/pwrseq/consumer.h          |  8 ++++----
 8 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/driver-api/pwrseq.rst b/Documentation/driver-api/pwrseq.rst
index ad18b2326b689a41471216f3889480b11768ca82..faba5a8e3337e878c6dac0cc91d23b3577cab6fd 100644
--- a/Documentation/driver-api/pwrseq.rst
+++ b/Documentation/driver-api/pwrseq.rst
@@ -50,9 +50,9 @@ Consumer interface
 The consumer API is aimed to be as simple as possible. The driver interested in
 getting a descriptor from the power sequencer should call pwrseq_get() and
 specify the name of the target it wants to reach in the sequence after calling
-pwrseq_power_up(). The descriptor can be released by calling pwrseq_put() and
+pwrseq_vote_on(). The descriptor can be released by calling pwrseq_put() and
 the consumer can request the powering down of its target with
-pwrseq_power_off(). Note that there is no guarantee that pwrseq_power_off()
+pwrseq_vote_off(). Note that there is no guarantee that pwrseq_vote_off()
 will have any effect as there may be multiple users of the underlying resources
 who may keep them active.
 
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e6d107f67759f54eee2647d92bb8bfd4e68c9358..5aaabc9fb1b66eb6b24da25f77158690a2f03c84 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2259,7 +2259,7 @@ static void qca_power_off(struct hci_uart *hu)
 	}
 
 	if (power && power->pwrseq) {
-		pwrseq_power_off(power->pwrseq);
+		pwrseq_vote_off(power->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
 		return;
         }
@@ -2319,7 +2319,7 @@ static int qca_regulator_enable(struct qca_serdev *qcadev)
 	int ret;
 
 	if (power->pwrseq)
-		return pwrseq_power_on(power->pwrseq);
+		return pwrseq_vote_on(power->pwrseq);
 
 	/* Already enabled */
 	if (power->vregs_on)
diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index a71d5b35601e7b996428312028a4c0542a5b1350..c6dfa2685ee64086c53281d06563e6169109c00f 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -352,12 +352,12 @@ static int pvr_power_init_pwrseq(struct pvr_device *pvr_dev)
 
 static int pvr_power_on_sequence_pwrseq(struct pvr_device *pvr_dev)
 {
-	return pwrseq_power_on(pvr_dev->pwrseq);
+	return pwrseq_vote_on(pvr_dev->pwrseq);
 }
 
 static int pvr_power_off_sequence_pwrseq(struct pvr_device *pvr_dev)
 {
-	return pwrseq_power_off(pvr_dev->pwrseq);
+	return pwrseq_vote_off(pvr_dev->pwrseq);
 }
 
 const struct pvr_power_sequence_ops pvr_power_sequence_ops_pwrseq = {
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 3106502275781d32d17a45a661362206144df6b3..f87e56576e29124902dccd1a21600fd3407b2922 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1025,7 +1025,7 @@ static int ath10k_hw_power_on(struct ath10k *ar)
 
 	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power on\n");
 
-	ret = pwrseq_power_on(ar_snoc->pwrseq);
+	ret = pwrseq_vote_on(ar_snoc->pwrseq);
 	if (ret)
 		return ret;
 
@@ -1042,7 +1042,7 @@ static int ath10k_hw_power_on(struct ath10k *ar)
 vreg_off:
 	regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
 pwrseq_off:
-	pwrseq_power_off(ar_snoc->pwrseq);
+	pwrseq_vote_off(ar_snoc->pwrseq);
 
 	return ret;
 }
@@ -1060,7 +1060,7 @@ static int ath10k_hw_power_off(struct ath10k *ar)
 	ret_vreg = regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
 
 	if (ar_snoc->pwrseq)
-		ret_seq = pwrseq_power_off(ar_snoc->pwrseq);
+		ret_seq = pwrseq_vote_off(ar_snoc->pwrseq);
 
 	return ret_vreg ? : ret_seq;
 }
diff --git a/drivers/pci/pwrctrl/generic.c b/drivers/pci/pwrctrl/generic.c
index a7e599d841e6289db161b19a93ba5a61d9e0ab1c..8872f6501352d7273a9b4f20589c2f74d6accc65 100644
--- a/drivers/pci/pwrctrl/generic.c
+++ b/drivers/pci/pwrctrl/generic.c
@@ -29,7 +29,7 @@ static int slot_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
 	int ret;
 
 	if (slot->pwrseq) {
-		pwrseq_power_on(slot->pwrseq);
+		pwrseq_vote_on(slot->pwrseq);
 		return 0;
 	}
 
@@ -48,7 +48,7 @@ static int slot_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
 						struct slot_pwrctrl, pwrctrl);
 
 	if (slot->pwrseq) {
-		pwrseq_power_off(slot->pwrseq);
+		pwrseq_vote_off(slot->pwrseq);
 		return 0;
 	}
 
diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
index a308bf4b5fc01d23b75db4cd396201c3ba3fe695..86822f0f645eb757455f575000f81122bce82e60 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
@@ -56,7 +56,7 @@ static int pwrseq_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
 	struct pwrseq_pwrctrl *pwrseq = container_of(pwrctrl,
 					   struct pwrseq_pwrctrl, pwrctrl);
 
-	return pwrseq_power_on(pwrseq->pwrseq);
+	return pwrseq_vote_on(pwrseq->pwrseq);
 }
 
 static int pwrseq_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
@@ -64,7 +64,7 @@ static int pwrseq_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
 	struct pwrseq_pwrctrl *pwrseq = container_of(pwrctrl,
 					   struct pwrseq_pwrctrl, pwrctrl);
 
-	return pwrseq_power_off(pwrseq->pwrseq);
+	return pwrseq_vote_off(pwrseq->pwrseq);
 }
 
 static int pwrseq_pwrctrl_probe(struct platform_device *pdev)
diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 02f42da915985339d3de507fc36dd158b0035a99..c630b14f6f2c478f05e4b2893b386aab0cddaaf5 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -708,7 +708,7 @@ void pwrseq_put(struct pwrseq_desc *desc)
 	pwrseq = desc->pwrseq;
 
 	if (desc->powered_on)
-		pwrseq_power_off(desc);
+		pwrseq_vote_off(desc);
 
 	kfree(desc);
 	module_put(pwrseq->owner);
@@ -874,7 +874,7 @@ static int pwrseq_unit_disable(struct pwrseq_device *pwrseq,
 }
 
 /**
- * pwrseq_power_on() - Issue a power-on request on behalf of the consumer
+ * pwrseq_vote_on() - Issue a power-on request on behalf of the consumer
  *                     device.
  * @desc: Descriptor referencing the power sequencer.
  *
@@ -887,7 +887,7 @@ static int pwrseq_unit_disable(struct pwrseq_device *pwrseq,
  * Returns:
  * 0 on success, negative error number on failure.
  */
-int pwrseq_power_on(struct pwrseq_desc *desc)
+int pwrseq_vote_on(struct pwrseq_desc *desc)
 {
 	struct pwrseq_device *pwrseq;
 	struct pwrseq_target *target;
@@ -925,14 +925,14 @@ int pwrseq_power_on(struct pwrseq_desc *desc)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(pwrseq_power_on);
+EXPORT_SYMBOL_GPL(pwrseq_vote_on);
 
 /**
- * pwrseq_power_off() - Issue a power-off request on behalf of the consumer
+ * pwrseq_vote_off() - Issue a power-off request on behalf of the consumer
  *                      device.
  * @desc: Descriptor referencing the power sequencer.
  *
- * This undoes the effects of pwrseq_power_on(). It issues a power-off request
+ * This undoes the effects of pwrseq_vote_on(). It issues a power-off request
  * on behalf of the consumer and when the last remaining user does so, the
  * power-down sequence will be started. If one is in progress, the function
  * will block until it's complete and then return.
@@ -940,7 +940,7 @@ EXPORT_SYMBOL_GPL(pwrseq_power_on);
  * Returns:
  * 0 on success, negative error number on failure.
  */
-int pwrseq_power_off(struct pwrseq_desc *desc)
+int pwrseq_vote_off(struct pwrseq_desc *desc)
 {
 	struct pwrseq_device *pwrseq;
 	struct pwrseq_unit *unit;
@@ -966,7 +966,7 @@ int pwrseq_power_off(struct pwrseq_desc *desc)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(pwrseq_power_off);
+EXPORT_SYMBOL_GPL(pwrseq_vote_off);
 
 /**
  * pwrseq_to_device() - Get the pwrseq device pointer from a descriptor.
diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
index 3c907c9e1885dc2958043a9a733fbe20bdf95f6e..e4d2cb321354f0cb7e1d1d72e6b5a96b94129da3 100644
--- a/include/linux/pwrseq/consumer.h
+++ b/include/linux/pwrseq/consumer.h
@@ -20,8 +20,8 @@ void pwrseq_put(struct pwrseq_desc *desc);
 struct pwrseq_desc * __must_check
 devm_pwrseq_get(struct device *dev, const char *target);
 
-int pwrseq_power_on(struct pwrseq_desc *desc);
-int pwrseq_power_off(struct pwrseq_desc *desc);
+int pwrseq_vote_on(struct pwrseq_desc *desc);
+int pwrseq_vote_off(struct pwrseq_desc *desc);
 
 struct device *pwrseq_to_device(struct pwrseq_desc *desc);
 
@@ -43,12 +43,12 @@ devm_pwrseq_get(struct device *dev, const char *target)
 	return ERR_PTR(-ENOSYS);
 }
 
-static inline int pwrseq_power_on(struct pwrseq_desc *desc)
+static inline int pwrseq_vote_on(struct pwrseq_desc *desc)
 {
 	return -ENOSYS;
 }
 
-static inline int pwrseq_power_off(struct pwrseq_desc *desc)
+static inline int pwrseq_vote_off(struct pwrseq_desc *desc)
 {
 	return -ENOSYS;
 }

---
base-commit: c5e32e86ca02b003f86e095d379b38148999293d
change-id: 20260727-pwrseq-vote-rename-b7cd21032668

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

