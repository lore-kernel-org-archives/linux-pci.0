Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5DC42A7BC
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505359; cv=none; b=lhQlxDgj9OybPHmoKMlM8JhdRzQYQm4gxi+MbPQaEC4xkstE4DXr9amPGfjAmtALxN4CJXMb3fV0N4c7bamt2hfhnZLvjNJL72YFUHWlo/5RLJpW9X+lMhmIiO7oB+dmhBKi52luh9MVvE1GQjuL0X6ptDTqlFeuavv3FV+ZnsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505359; c=relaxed/simple;
	bh=/ZtYnblEv5u9xlI130waUKIQSQ7Ho1KTod+WjiROOSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jwDWCHYpM0DO3k6GTiI5EnvyV0eG4rWFBIOr+jANKjYN3/z3HM3OP60F4Xohr83bDMbD6KX1a5WWGx68wMfnuW04XMzLWmMA1kOqPgobuDZGx4xeLk3spXjYCaZwcAXKDumAnxI+N85pD+G9q5t9tXkBmXLW0xvOX8TmyaA0IJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kokLOxeQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QPRBbE6V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kokLOxeQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QPRBbE6V"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBmAXd3905280
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 13:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=I7QdW2PBreeH2I/q/W9dkz
	OrQKYFPLU3+DU1c9bD4Hw=; b=kokLOxeQr8liutJQR+sVROVyP9mN89ywBdMOpB
	urCHbNngljt5xMxE9DKGuBRhjFMW6PPNDeNaUjczbJ3JO1l2LKvIBu/hG8a7yGfX
	ZCozgLofknV/JfjRFdgZDAcffJ/al08D+o7PPnY/ZKe302nBXaCHM3VVhuwWkP78
	t0OIp6RsA2hBUQrKsugIlBARcPkLjlGF3jCwGNfICqt12H20LwybIDew6XxAAyiu
	jkz+nAC6c0MPCVlUFjIsxQZz5piYWTJS/fstrMvoh9Ko7EFSLCEQllrVA9MVrfao
	2ZpT9r2dTw4CqC2Qob8JOZspicyZV85hN4WhUYwPFGN1PfDQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru5dgfqf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 13:42:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1e6f602cso15758791cf.3
        for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 06:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785505350; x=1786110150; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I7QdW2PBreeH2I/q/W9dkzOrQKYFPLU3+DU1c9bD4Hw=;
        b=QPRBbE6VfV+ldvg7Z9/j4L2wOKuG5voFCybXCH1XitT3R7dzpTsEZ4s1abP1cLpjtA
         ZDFxOQA7UJTEJ6+fC52NSpwPcU8GJCS375k/sH3JeG0FwwIP/XKqOEUC/R6i56Pk0cl2
         /QzJ+6LWWIvbjEg4nLrHTQ6kntktu288RY7e/kbCH5uiBLmoo9HeUeq5JMTDPLdNmdZ1
         LQrBWkDhD+5cw2jN0miDGeCI4GgFbXUB1S+vgvdRmJl7vY9vmj8u7I7e5ehexyMVKRRo
         k+M/3MTBa3HGGXMNN/I/ZuT51c6iH979uxcHNxjawfPgk6gp82k2JUB5ZtHUqiDJKRH9
         j3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785505350; x=1786110150;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=I7QdW2PBreeH2I/q/W9dkzOrQKYFPLU3+DU1c9bD4Hw=;
        b=dRbjPVg7V135iKVjFNEFjz10acR/Hv+1Ody2aPsa25BhoJiBfzyQ2AS5aoBCIOfJQD
         7G8s66R/jYh5vXBcUbRRNzW66SaUfoC+dlX7LBmRWwiyhOCUKk+C66mUIHOWHyFuyFhP
         IalKRmow8/Osh641/zNuG3ffTiQY+nOL2VMcg54IbK/qhUXFE3kk6SZ2fxd2BaU9klbI
         hp0iX7rZFEkypt0x4sP4Pzz7eEod6tzrOtpOGAo6kJsvnpmr0FmeSvV9aSgTSLvkW/Ih
         WwFSOLRfdkOxbt2isctXiI7TUCutz5MCHzh9XNVskhkDNZNbBeLZNEeb9G1D4xQ9j4Nb
         qxhA==
X-Forwarded-Encrypted: i=1; AHgh+Rq6lbEjkRQV3fQ64gDll0hz5XMu+6Q6I/ChBE6u50trZt1NRArwjWVMA+mDhsA2LwmoiGMapEUZVHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQCEgyF/C3fjfIr8BkMSKTrByA1g2wxheiPQ4fNAlQVfLQGC/0
	soZyD/2LN1JJitCd6PqArO78BZJ+bm71hIaqgXDZ0eypGtPMoHphTRZChvAZ7lfl/erviSUAaGi
	6i8vFp8gIvFMnlsSPC6yg2oM6nJNTvpfANJV2WW+w6ddgcPwKqW5ZB3iHYXhXb6A=
X-Gm-Gg: AR+sD1356IDpU42fErwhrnynWJteli941Nvx1NlfxGj+2J3zDme+bXABgRL4C9I5wzH
	1pSqix+0a/Xn7rDxjjvIPK0MDhG2zc+UMmImbUOjqMso0rf3KephsT7qzojxKWVR9pVmeK3AGp7
	qHySxP0D4k15dY2RZlLXRPNJl5W4G4oLg8VviCdvNbqCSh+HCxnFErODCeMpoRxQcI817OBzLm4
	oz1CscqpksbEzgBP8rWsYnC6i5naKQOuChO98m+D/+YtL2WsKp8gMAPo3lwjnUOD0/KW5L2pd/d
	1dGWhuMY5iuBzQAdNivGm/FvT3USt8NfX+7UX6EZXU9QhOacguRgp5W+cIM1qbBX7yQXQ4hvuTr
	PbtYOkQJjtRsVHHPgZYQc2Vdy7W8oCA==
X-Received: by 2002:a05:622a:4c8c:b0:51c:257c:8166 with SMTP id d75a77b69052e-52b567915d7mr2007131cf.33.1785505349382;
        Fri, 31 Jul 2026 06:42:29 -0700 (PDT)
X-Received: by 2002:a05:622a:4c8c:b0:51c:257c:8166 with SMTP id d75a77b69052e-52b567915d7mr2005921cf.33.1785505348617;
        Fri, 31 Jul 2026 06:42:28 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:40fa:e8e6:4785:ce70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c5b4d4sm170638366b.3.2026.07.31.06.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 06:42:27 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 15:42:18 +0200
Subject: [PATCH v3] power: sequencing: rename pwrseq_power_on/off() to
 pwrseq_enable/disable()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-pwrseq-vote-rename-v3-1-44e60b8be053@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADmmbGoC/33NQQ6CMBAF0KuQri1pp9CCK+9hXNQyShOh0GLVE
 O5uYeWCuJnkT/68mUlAbzGQYzYTj9EG6/oUxCEjptX9HaltUibAQDIFig4vH3Ck0U1IPfa6Q3p
 VpgHOBEhZkXQ4eLzZ94aeLym3NkzOf7Yfka/bv1zklFOdGrVG1EaWJxdCPj71w7iuy9MgqxrhR
 xJ8V4IkFRUTpaoLiYztSMuyfAGchA57BQEAAA==
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
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11797;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=/ZtYnblEv5u9xlI130waUKIQSQ7Ho1KTod+WjiROOSo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqbKY9BLAKPCKKdAtGKsF/O1XETtWdpusNUE+kz
 k3xKaVeETeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCamymPQAKCRAFnS7L/zaE
 w77CEACsyXT5/yMxHu3ndloSlpevSE+Xmz6RAu8QU74Y5sEYJSkVdMTfKAB07P6C3AXxrhXz1SO
 hAfDA26nBMR4HY8+Dbts3letQqVtiYaE1WYS6fzOj/lGy2E5FpT0TFLRlTrKAyQgCZBea7IOg6u
 b/xjl2grrnzOE73eKwZF2PDXi3kn2nLgCmykKxnLNpi9iNzp4TUL2BSz4T/cpsC0Bz/pUtYrXT1
 PTjFx7uZnUX83pxElnPGBDy8eX/1z3JhwkiTG99mcyqL44w6iFJh94A4Zu2436xDPG1NCZMtU5t
 mEa5hNLnnEGLv4whY+CTxMCv0pHuNVjT5ko1hdokSkv8EHPg1zvdBmRPFh8lK436UVN4d3RW73L
 1j352tkrJr98H+76xbO2Fpq0Pf+bjmU3Wki/pi0dWtw2mxASSxPPVNfZ0yLB0OIvwAglTGgTPYu
 UuPeuOHRJlrQg08cTreWJY2gdifIGumeRPprkwbDsHpWz8kFLbN/7hyazrw6ja+HZjLUeWq/Fdd
 g0A+he10ZFP9oO1Ep79ujgyAd2eP0PSHgrtQ2DCRZYdx0BR8D16rDGOT2bUfP8QHXua+856Gd50
 CVvv3GZ3gtF2vrFIqbmTf0nxqzf9F/Wl6Cue/AyixiYdka/DBV4hI3D4XaoTS9jO0jCFkVbvxxr
 6GFlCm9Og5+HPFg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: Y64aszEK3Ic6czCjORmcCMF6rHvxITAK
X-Proofpoint-GUID: Y64aszEK3Ic6czCjORmcCMF6rHvxITAK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEwNCBTYWx0ZWRfX6mcAxqAIJFzy
 sNaC42GoeaAWgaH35K+TaymeAm1rk3AKCvilyKDiksFWNUwAat2J/4Vl3rZaewyffc7P+54nTeB
 xfKiLJbLWDzwPiWD2bKbtUwo4OM5yGAIPRK0WlUY8ds312eKvtRvkgfy5c723+6hg/qBGXiB5tp
 gzQLc4Yy6MBB1/jd8tC1XxwdBMEe3tFtlj11CexKlaEXX9XXKUxuSPfGgQzrmcG8BVFLKZ02g9S
 XzGG2NabCJCH62EAscr255G7Zoen0t4nx87XotPBrgdle9Yhgu3orO45DpPYfvm9T0egydjYB0p
 lOB3cjfPlZqNEa9G8ESUvAc67aOBP0plgA5ZMB6HD3e0inARVkJEfUboSDOreAFdnqBogopALGI
 ATnohupk88vGGGlLNBLZvrgJFLwmVWsb5JGWLI8sNKjZh3SdFe6VknA5XI828aiVQDp9ZjIfbDm
 QIcwFgGAaQA83aSS19w==
X-Authority-Analysis: v=2.4 cv=SKZykuvH c=1 sm=1 tr=0 ts=6a6ca64c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8
 a=RTdnRIbMq3CNlSfCOOQA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEwNCBTYWx0ZWRfX31+AVXwbMKA5
 m6vjNx29fPTGxrQLXE/KmBPcuVs7pI1q8gd0hleIppiWNJSsgV89hTGpdSRmA9jmgi92FUobZL7
 DniQVqf0zx852uGe0qqu08Pf8Q/7oXE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310104

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
purpose. pwrseq_vote_on/off() also have been rejected as unusual in
the tree.

Change the name of the two functions to pwrseq_enable/disable() which
better reflects their purpose and semantics and also mirrors other
enable-counted resources like regulators and clocks. No functional change
intended.

If at any point users need to know *when* the exact power event happens,
we can provide that information in the form of a notifier.

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
I've floated the idea to rename the two pwrseq functions from "power
on/off" to "vote on/off". I've sent a patch but the overwhelming
consensus seem to be that enable/disable naming is preferred.

I'm doing it in a single commit that should go through the pwrseq tree
with Acks from subsystem maintainers.

[1] https://lore.kernel.org/all/CAMRc=Mefxn81d0VUwmQgwFtffkL1=Er_1VQZCbC1Sa-Qph4t1w@mail.gmail.com/
---
Changes in v3:
- Fix type: pwrseq_disble -> pwrseq_disable
- Link to v2: https://patch.msgid.link/20260731-pwrseq-vote-rename-v2-1-480357946e00@oss.qualcomm.com

Changes in v2:
- Change the naming convention to enable/disable
- Link to v1: https://patch.msgid.link/20260727-pwrseq-vote-rename-v1-1-a2029aeeac65@oss.qualcomm.com
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
index ad18b2326b689a41471216f3889480b11768ca82..e1056d1418451b0feda6567bab9eec1cbff682fb 100644
--- a/Documentation/driver-api/pwrseq.rst
+++ b/Documentation/driver-api/pwrseq.rst
@@ -50,9 +50,9 @@ Consumer interface
 The consumer API is aimed to be as simple as possible. The driver interested in
 getting a descriptor from the power sequencer should call pwrseq_get() and
 specify the name of the target it wants to reach in the sequence after calling
-pwrseq_power_up(). The descriptor can be released by calling pwrseq_put() and
+pwrseq_enable(). The descriptor can be released by calling pwrseq_put() and
 the consumer can request the powering down of its target with
-pwrseq_power_off(). Note that there is no guarantee that pwrseq_power_off()
+pwrseq_disable(). Note that there is no guarantee that pwrseq_disable()
 will have any effect as there may be multiple users of the underlying resources
 who may keep them active.
 
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 345f602e9ce233a0934a73a85d1e7c17c4f3210d..faa964735adb17a05f2a8fac16f553b37b96020b 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2259,7 +2259,7 @@ static void qca_power_off(struct hci_uart *hu)
 	}
 
 	if (power && power->pwrseq) {
-		pwrseq_power_off(power->pwrseq);
+		pwrseq_disable(power->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
 		return;
         }
@@ -2319,7 +2319,7 @@ static int qca_regulator_enable(struct qca_serdev *qcadev)
 	int ret;
 
 	if (power->pwrseq)
-		return pwrseq_power_on(power->pwrseq);
+		return pwrseq_enable(power->pwrseq);
 
 	/* Already enabled */
 	if (power->vregs_on)
diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index a71d5b35601e7b996428312028a4c0542a5b1350..eb4b6ecdf4f4d09d96d17d0d53ec5cb876b21b50 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -352,12 +352,12 @@ static int pvr_power_init_pwrseq(struct pvr_device *pvr_dev)
 
 static int pvr_power_on_sequence_pwrseq(struct pvr_device *pvr_dev)
 {
-	return pwrseq_power_on(pvr_dev->pwrseq);
+	return pwrseq_enable(pvr_dev->pwrseq);
 }
 
 static int pvr_power_off_sequence_pwrseq(struct pvr_device *pvr_dev)
 {
-	return pwrseq_power_off(pvr_dev->pwrseq);
+	return pwrseq_disable(pvr_dev->pwrseq);
 }
 
 const struct pvr_power_sequence_ops pvr_power_sequence_ops_pwrseq = {
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 3106502275781d32d17a45a661362206144df6b3..f28fed89cc28b45d72a9814be38d19e2cdf96943 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1025,7 +1025,7 @@ static int ath10k_hw_power_on(struct ath10k *ar)
 
 	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power on\n");
 
-	ret = pwrseq_power_on(ar_snoc->pwrseq);
+	ret = pwrseq_enable(ar_snoc->pwrseq);
 	if (ret)
 		return ret;
 
@@ -1042,7 +1042,7 @@ static int ath10k_hw_power_on(struct ath10k *ar)
 vreg_off:
 	regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
 pwrseq_off:
-	pwrseq_power_off(ar_snoc->pwrseq);
+	pwrseq_disable(ar_snoc->pwrseq);
 
 	return ret;
 }
@@ -1060,7 +1060,7 @@ static int ath10k_hw_power_off(struct ath10k *ar)
 	ret_vreg = regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
 
 	if (ar_snoc->pwrseq)
-		ret_seq = pwrseq_power_off(ar_snoc->pwrseq);
+		ret_seq = pwrseq_disable(ar_snoc->pwrseq);
 
 	return ret_vreg ? : ret_seq;
 }
diff --git a/drivers/pci/pwrctrl/generic.c b/drivers/pci/pwrctrl/generic.c
index a7e599d841e6289db161b19a93ba5a61d9e0ab1c..d56171e0ee244691c3bdb0a72b81c65556a8081f 100644
--- a/drivers/pci/pwrctrl/generic.c
+++ b/drivers/pci/pwrctrl/generic.c
@@ -29,7 +29,7 @@ static int slot_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
 	int ret;
 
 	if (slot->pwrseq) {
-		pwrseq_power_on(slot->pwrseq);
+		pwrseq_enable(slot->pwrseq);
 		return 0;
 	}
 
@@ -48,7 +48,7 @@ static int slot_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
 						struct slot_pwrctrl, pwrctrl);
 
 	if (slot->pwrseq) {
-		pwrseq_power_off(slot->pwrseq);
+		pwrseq_disable(slot->pwrseq);
 		return 0;
 	}
 
diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
index a308bf4b5fc01d23b75db4cd396201c3ba3fe695..c5ced87944b6ca3dc642692311ff504a650acec7 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
@@ -56,7 +56,7 @@ static int pwrseq_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
 	struct pwrseq_pwrctrl *pwrseq = container_of(pwrctrl,
 					   struct pwrseq_pwrctrl, pwrctrl);
 
-	return pwrseq_power_on(pwrseq->pwrseq);
+	return pwrseq_enable(pwrseq->pwrseq);
 }
 
 static int pwrseq_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
@@ -64,7 +64,7 @@ static int pwrseq_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
 	struct pwrseq_pwrctrl *pwrseq = container_of(pwrctrl,
 					   struct pwrseq_pwrctrl, pwrctrl);
 
-	return pwrseq_power_off(pwrseq->pwrseq);
+	return pwrseq_disable(pwrseq->pwrseq);
 }
 
 static int pwrseq_pwrctrl_probe(struct platform_device *pdev)
diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 02f42da915985339d3de507fc36dd158b0035a99..721e888b658d1f254513e126bb72f2d0487a8383 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -708,7 +708,7 @@ void pwrseq_put(struct pwrseq_desc *desc)
 	pwrseq = desc->pwrseq;
 
 	if (desc->powered_on)
-		pwrseq_power_off(desc);
+		pwrseq_disable(desc);
 
 	kfree(desc);
 	module_put(pwrseq->owner);
@@ -874,7 +874,7 @@ static int pwrseq_unit_disable(struct pwrseq_device *pwrseq,
 }
 
 /**
- * pwrseq_power_on() - Issue a power-on request on behalf of the consumer
+ * pwrseq_enable() - Issue a power-on request on behalf of the consumer
  *                     device.
  * @desc: Descriptor referencing the power sequencer.
  *
@@ -887,7 +887,7 @@ static int pwrseq_unit_disable(struct pwrseq_device *pwrseq,
  * Returns:
  * 0 on success, negative error number on failure.
  */
-int pwrseq_power_on(struct pwrseq_desc *desc)
+int pwrseq_enable(struct pwrseq_desc *desc)
 {
 	struct pwrseq_device *pwrseq;
 	struct pwrseq_target *target;
@@ -925,14 +925,14 @@ int pwrseq_power_on(struct pwrseq_desc *desc)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(pwrseq_power_on);
+EXPORT_SYMBOL_GPL(pwrseq_enable);
 
 /**
- * pwrseq_power_off() - Issue a power-off request on behalf of the consumer
+ * pwrseq_disable() - Issue a power-off request on behalf of the consumer
  *                      device.
  * @desc: Descriptor referencing the power sequencer.
  *
- * This undoes the effects of pwrseq_power_on(). It issues a power-off request
+ * This undoes the effects of pwrseq_enable(). It issues a power-off request
  * on behalf of the consumer and when the last remaining user does so, the
  * power-down sequence will be started. If one is in progress, the function
  * will block until it's complete and then return.
@@ -940,7 +940,7 @@ EXPORT_SYMBOL_GPL(pwrseq_power_on);
  * Returns:
  * 0 on success, negative error number on failure.
  */
-int pwrseq_power_off(struct pwrseq_desc *desc)
+int pwrseq_disable(struct pwrseq_desc *desc)
 {
 	struct pwrseq_device *pwrseq;
 	struct pwrseq_unit *unit;
@@ -966,7 +966,7 @@ int pwrseq_power_off(struct pwrseq_desc *desc)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(pwrseq_power_off);
+EXPORT_SYMBOL_GPL(pwrseq_disable);
 
 /**
  * pwrseq_to_device() - Get the pwrseq device pointer from a descriptor.
diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
index 3c907c9e1885dc2958043a9a733fbe20bdf95f6e..16fad5f3e3ab563110598f733e4a6c10a7b13f2d 100644
--- a/include/linux/pwrseq/consumer.h
+++ b/include/linux/pwrseq/consumer.h
@@ -20,8 +20,8 @@ void pwrseq_put(struct pwrseq_desc *desc);
 struct pwrseq_desc * __must_check
 devm_pwrseq_get(struct device *dev, const char *target);
 
-int pwrseq_power_on(struct pwrseq_desc *desc);
-int pwrseq_power_off(struct pwrseq_desc *desc);
+int pwrseq_enable(struct pwrseq_desc *desc);
+int pwrseq_disable(struct pwrseq_desc *desc);
 
 struct device *pwrseq_to_device(struct pwrseq_desc *desc);
 
@@ -43,12 +43,12 @@ devm_pwrseq_get(struct device *dev, const char *target)
 	return ERR_PTR(-ENOSYS);
 }
 
-static inline int pwrseq_power_on(struct pwrseq_desc *desc)
+static inline int pwrseq_enable(struct pwrseq_desc *desc)
 {
 	return -ENOSYS;
 }
 
-static inline int pwrseq_power_off(struct pwrseq_desc *desc)
+static inline int pwrseq_disable(struct pwrseq_desc *desc)
 {
 	return -ENOSYS;
 }

---
base-commit: 95d6a9ccef99117115e41e9adb271243bd5e985b
change-id: 20260727-pwrseq-vote-rename-b7cd21032668

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

