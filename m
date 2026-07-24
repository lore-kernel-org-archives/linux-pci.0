Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC642BC48
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896611; cv=none; b=F+ew/epLDF6M0sk5Jp9AycEzn9l+8PAWt+RMEBOIkrJlHzAmkrWT6CM339S6/Xb0/Vvpf1ngh2BYwyvlbhH9jqcB/Rm0aQ4MNeQomFac1zoyltDDPkXnl54jkjeBOn1Os46QfU0Dpw53DlXH9/lyw1Xi8sfUFe8k/KSMBoVAreA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896611; c=relaxed/simple;
	bh=On+U5sZtQGZNC7xrtx/ie3LGSZMOmGdCwE+QOb/ojPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4oQbzz8eSyuDvvxmdxNY0CetYh5KsMyHncfIhDfOqZBGA5QS5kGhL3nELnWVq2drab2agm2JzLh9+fq+Yj+zraXC6nZesfoLuF6b2Y3nHqXyySO2QaKobvDAVYVvOGl7B0cpse7kfkitkftuMGG30RQiB4jqW8smgLxgBf8n1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gXFf62Ri; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RaBb9PF/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gXFf62Ri";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RaBb9PF/"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADrw52616192
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 12:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4ef+wpAo9/ud8vszxpOpil4lSBTQBiQbjcVY9DMcRtk=; b=gXFf62RihZMqBFZY
	k4N/Dwyqh9EkAXu2BiRRyysuQ95dvtSl8Vssl+btmtCc0X28nmUc/9lnxZVFxx/r
	vOL2R2+xTakZjyHij+Dx1Jo1K3qWE8TkBZhjdTfwCHGR5K4naZa8lx1UcvL5kcKB
	j5GLbe5nRSDw/E6lZqh5TxzeoLQfy/mucQvS3qxIkDulfXM01l1pVD8YNEE/g2Ez
	X6VgsBepnXFmcvw38Mqn+IhVfsv7Ryn2mCHkc3To2G6LYuCUcBntfqBvGve4ma2S
	y2nCZrz4VWM3FzbMViXq3oHoDbI1RB/YLPlQ8KCbJAuhbCpyJ0+JQCTgSG/uzCRr
	gmXy3Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0pw9s2x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 12:36:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52827090cc5so7017041cf.0
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 05:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784896608; x=1785501408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4ef+wpAo9/ud8vszxpOpil4lSBTQBiQbjcVY9DMcRtk=;
        b=RaBb9PF/CrWsa+nYNvYffzmRdVkY1BunTJh0SR0K0eQj4QZX4XCtbDSF2lx/avai9s
         gYx2/g5HPM0UjyMVE1OXeQRHrLCDqSSbWRX/HGj+rqNOAQmQtGkC81kXQ8EoBHXQ8dMj
         xnPIL00hcgndNeCTdG1qBVSRpJwMzO8eNRa1En5Fz5ahC3TQ/mqcVBthzvxKrjPBGJyQ
         lNDK2xWzQZ3lexObmObLz42XRa3emp7xmLboFjGV7ivYbHyi3hnP+I/Gu2yU0psaAS2I
         +3TmKaaJL125ZB9w8buOOpIZC63d3vSKtb4JS4drjlacg8D+F/EYgouLjr3pk/LrxM5A
         P40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784896608; x=1785501408;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ef+wpAo9/ud8vszxpOpil4lSBTQBiQbjcVY9DMcRtk=;
        b=dE33v8fVrRGR02+yCz49QDSHS5cC48O0U+U+joak9/XSDUqByI/XyuH0lcwq3+iO70
         WN/SU/ekh757koxEEmcG4gQpS1EbLkWgx/EFE7oBm9qXEptRz14SK3+ifej8G8o5PX92
         pMZ5YdXL1bxX39nJ76hsZjnWawWwyLm2gwsmI+Snc9y9vGVeUWyZAcf9TpXNSrSObEeU
         9g36KDKIE4+UBJYzhHM5bUZ/IrZJP6koanLR2LJh80zE/Q7BBeZop9pb3D/xFACAr+bH
         boE5T5KrbjD3J4Kgo+N2xeWwtwdAAFinDuOMF57tu+KQ6mAQO4zExld2RYBWRD48MQpS
         0eog==
X-Forwarded-Encrypted: i=1; AHgh+Rp0CC550AZL7w9u7QyuqUUyl9B3kZ2PHgtSaGmrWy3Aoq/U1sBm07gZI+KsH9zamv8geFinmJt07Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD8tGcHnB3zQCXJkWorIYOCPYsnkIcm3OYur1QhIppemflff0f
	WgEqiG0gz7FmF1vXOYbCmuDNDgmaE7Q3KuC7jEAepulp9+zH1d1mI6lCREBbJ9bfbmqAMs0auNE
	30iT9JhX9/jY58Q6oJKJj9s4HBCkj9jAPqnhATe6QRYwgRk8Dl1m6HNXhDf/E+zY=
X-Gm-Gg: AR+sD133Ee8wJz25ck9FkVyBAFqIubP8f57T4g0mDC/uwjP6ZIQNR+y4jhXHhRnov3E
	QDxHS5TeiwHg1pee5pyRBoA61wpnVmqM9VUJE4pY4/3cXca94eoExkHQC3FqmPyP3bSUbwbpHLY
	E6mkJIharZa0To9oIgsIiQcXoDClgHXpCue/oLgJ8jqX0OMaovZUlYqtuQ/R3UsjmzVR2hv0qQb
	2H4JS9i4bP1BN+l0jVa9kCiZYsQ2IG7TrlSgVCdZuvQ6xzuiwbKs8ZE1wN5Ex3npNrDvC+M05tL
	JgD/d2D4nioFDhUO2LDCHKEXNgAxAm+AQ/wnFAg8r2SA0i1hskjB3Fagzq8T/7U0KWUOsHlf/93
	PiMLTOjfF+g9nh5dg2xWQiY9yi3E=
X-Received: by 2002:ac8:7d16:0:b0:51c:b91a:33f9 with SMTP id d75a77b69052e-5295d2d9bc2mr4467561cf.13.1784896608222;
        Fri, 24 Jul 2026 05:36:48 -0700 (PDT)
X-Received: by 2002:ac8:7d16:0:b0:51c:b91a:33f9 with SMTP id d75a77b69052e-5295d2d9bc2mr4467221cf.13.1784896607776;
        Fri, 24 Jul 2026 05:36:47 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:4034:92c:3896:182c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bffc501sm38898115e9.4.2026.07.24.05.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 05:36:46 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v3] power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART BT variants by subdevice ID
Date: Fri, 24 Jul 2026 14:36:44 +0200
Message-ID: <178489660241.15691.2530971556020227133.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260724-hamoa-m2-sub-id-v2-v3-1-af97de70bbbe@oss.qualcomm.com>
References: <20260724-hamoa-m2-sub-id-v2-v3-1-af97de70bbbe@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDExNCBTYWx0ZWRfXw9k0EH45dl8d
 +bLUVGzHdU2wnBbIedorQbfs4gafS1OhGwnp6tjZPxDTJOytHLdVGiIhE3Nzi99e2NiDtwCD3E0
 bWQ3aStogcD+WOOSqxXLjj4PFqz/oKKTqtEw+ZqNdIPMeFfHwB6zPqR66Qg3SrnLmlFXcX4khXy
 wIWMUxuPM1FR/YADcLmnNhZaK617kQ958L6U/HqVwKvz695q53EGAe/LNZaBp/ThL4Fwjl0sd2w
 LEWBKsRU8Xcf9+6ohGQlqvj1YQuIiHLGjjk4L4TqCKjRNLAbWczheTLP+CEmcnnZsVRqxal+fnn
 YeXUcQuD3PApZayDLfFGjKlVEAUIOmrGNX1M6jJU5g+NIzElXm0TN5+nEKJ74uPRI472yoW4TSb
 j2pJDwrpn8TqBTX484Yk/hoFgcHjvARI0wSPcB1QSU5jLgEgA9+fFjekNEaVbEVX62UxfMCYV7J
 QrTr8fTJaZwg9eYdSow==
X-Authority-Analysis: v=2.4 cv=RJeD2Yi+ c=1 sm=1 tr=0 ts=6a635c60 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=sM1ioMSF0laoeU0cyGQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: shQ3-Mv39Ms8c3fSt403AKznITWtAGkL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDExNCBTYWx0ZWRfX6iVl7FkL7GAg
 50yeXmFZtEYdFXFztzf4/MFaACZmLvQU77hnTUe5Io+02IO7P/ZFdv3ysrziMLOs/wHe+lhiAi4
 jCkkA9+4jiWTfDbQnOGKCrg9xhyYmlE=
X-Proofpoint-GUID: shQ3-Mv39Ms8c3fSt403AKznITWtAGkL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240114


On Fri, 24 Jul 2026 13:51:56 +0530, Wei Deng wrote:
> The WCN6855 and WCN7851 combo chips are available in M.2 card variants
> that differ by their BT interface: some expose BT over UART while others
> expose BT over USB. Both variants use the same PCIe device ID for the
> WiFi interface, distinguished only by their sub-system device ID.
> 
> The bare PCI_DEVICE() entries match all sub-system IDs, so both UART and
> USB variants hit the same table entry and trigger UART serdev creation.
> For USB variants this is wrong — there is no UART BT interface on such
> a card, and the serdev probe will fail.
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART BT variants by subdevice ID
      https://git.kernel.org/brgl/c/a39ac4651e3b9d2ca78b6d3dc2a81a6bd25fa616

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
