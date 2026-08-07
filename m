Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CDF3DAAC3
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786095616; cv=none; b=V5z13MYJpTO1+7+oCPRO/CbEv1ZXJ18Ksi1dYBWuQQ7QrOJhPEAIOxCIuhoY3Xn1KZ10mFP1XsG+zzE0aJgjxP7Yb89u4TmPMvPa1NcHx759MWFVq3tRYnpZc1/jPOnP3QSsD/Zus/xryMuEaPjvtfLvLEKjeJWHWQt19UnpC90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786095616; c=relaxed/simple;
	bh=jHjE0fv6zFeXLSeP0ciuZ6zHV8wXDQFqjkZLZqhT2R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdvrDQ7WZyPNRGSY2h5wNMBKzdqUg0vlG3KFudzc3XLaIAhYx0slQdfDKahdZKoqsj02sG1RL3kzV6jEh2okMWq1EkXfWnSXV6z6rIyHsfZ0CQrfCdG8BXW2DMCtxqrRNxY84f57ZtsJjGxS06k/hMz8sToQa8LnpJrLoS0ZDrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a0kWnM21; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OcqR9Wro; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a0kWnM21";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OcqR9Wro"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6779EVdG1064997
	for <linux-pci@vger.kernel.org>; Fri, 7 Aug 2026 09:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QUy93ZzZ1r7ECGsel26PzCavsKQDhoSI+BvI0PuXz8Q=; b=a0kWnM21jkfBu19M
	AVT7GVsBzX9TjGg/PD8VotnCtOy3qyc33SaUnryeZtPSq16Q6Jw0LAwnQ6QU/bi0
	CC61zRikVcdnQFHSdlNbYYLiFGYwvvwBb65BpdvET9+nv5IQW5iDiMAhr4//cdro
	eEqbarsdlqchY8RSGOvV5KCJLGKicmGvo7caajTK29vs5Wch6HZsdfMjGoccu9fi
	Pp/cV86qfmkIJoMhrG5WO3XakjSxEDQVVoM3FtJq3jwKQXWUHWHy96mqm+Z7Y71k
	p8UtJpbuv++qub4sxKR8gdmYpNY4q5mQ6s01J626aIRrvof4oqlW9wgNs41/Aiox
	toZzqQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwcjb030h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 07 Aug 2026 09:40:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c21c01cf3so51930191cf.2
        for <linux-pci@vger.kernel.org>; Fri, 07 Aug 2026 02:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786095612; x=1786700412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QUy93ZzZ1r7ECGsel26PzCavsKQDhoSI+BvI0PuXz8Q=;
        b=OcqR9WromtxlhIm3LR88W/vRoU250S3WGFtVC3ssx46+e1vQIGWthRxo+RKGO9HMKo
         qhA21tsd7Sxi21BWfyBw69zwcmkXJBDPj3d0Z8WgM0i+AMiY9CzknyDxfjvb97s7tyOD
         NHa4ko3cE9J/v52cW5OrNYBSu6R1QLvoeYXCdQi8sPy3KITvo3kDqahOQrirRSyJCzAO
         id9zDbPFyUYjuj4UXzu6Mvqv9HL87/ytNOxHRBVeNiD2QsLpHQqfAi1+KwsZwZNDCXS5
         WFlB3JaY3wyP54Ny+bdhpuL7r3ew/trnbH81+gAMA9YjA1USieMJA/HoGHCUa21NClxN
         Jtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786095612; x=1786700412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QUy93ZzZ1r7ECGsel26PzCavsKQDhoSI+BvI0PuXz8Q=;
        b=neV+Db4hxDyeAURq4WhEe1z3FX/ufghivvSXxmp+k8SebSgbN2iSc3JPOHobzYplX7
         2GV6YuWoqH2enB9zrA3D1cWQ2FJnjrF0I8E9IPRTVdNn+L2D3KBNgqil4UbMH8j47dsw
         f+6IpkV2su743y1ybE8YDUU5RdSrXE6UzbX34u2TGqV/1bCPAI4Nd6t4k/90wwH26KX3
         fs1t85l5xmU4yXuU3w03yD15mOaXIOxvfI11LnFFmSuWbkxNuVhGGB9AIU40Pu7+oINq
         xJJjdQ2rfmhSKLgT5CtIR5m7ECONCPDzErlFZUKwuUP2M2+FFkiILYU096cWi6k7l+Gr
         jQ5w==
X-Forwarded-Encrypted: i=1; AHgh+RpfNHdUhDPJYJkJDDuw73M0nJo1mC9bkKsK/ACBEUhdTgLKnGdYb7GTKAVfIXBuL56tewk05nHLgq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/EHWLoFcnb+hsEYAdO/3lx7ypnLSJsKlXoAcZP2cMYWiwHX1J
	XYxC/zG3/HXjMnxAwesnGJgGa3qbPTDlNQI7Y9R6nbI6NXsFf0h8gyjfbiGT3NMLDhip3LK9NeN
	pXv824jFFS14DdCO/b39U+CkzhWIU4XgYpEJTvBm9M8zUUZz8LPCQrQVjxZHaOr0=
X-Gm-Gg: AR+sD11nRRtxrDJfG+niXof0W0VXhcyKbsRdayCwBu9lqkEnN08KDJIepYiVE5m8QKJ
	t/8OKwkYs7Sa+6IP9xdCwe1tvLr+woljNhXrzq8rlzTgveRgKDch110T0yj/tjDmws6LgoMOycD
	rW8f58c/wAu5xOsZO33dAzU/qL1TkTBJepiH4xIR4IGBSkEHTlh56wY4paAq+sfuNm/bqzozYCC
	dGtl5xFKYjmQ2TcRJWQ0Rst6qX1iGpC1BEMrRLeYSbW2+QSeP2SLeDQoEQc4Yl20xQ9b5wQ/yDe
	nLUx77pzKBD5K9KxURJ5770BVLtm15Pdo1FZ8OREcKbvfwitLMOtE/jv+Rm3seb/paFiR4yoj5i
	nsfkL1+psEt5EjPhgY0YijygTd5yrV/X/PnVBGnttLyWSe91mP2U1QvWguu9krB0XsjFOmyghSI
	X+cjlkfcTUNYBNsQ==
X-Received: by 2002:a05:622a:c83:b0:51c:22c5:daf5 with SMTP id d75a77b69052e-52d0b281f3cmr88517051cf.38.1786095612359;
        Fri, 07 Aug 2026 02:40:12 -0700 (PDT)
X-Received: by 2002:a05:622a:c83:b0:51c:22c5:daf5 with SMTP id d75a77b69052e-52d0b281f3cmr88516781cf.38.1786095611923;
        Fri, 07 Aug 2026 02:40:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39fdda9ebbdsm2217531fa.17.2026.08.07.02.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:40:10 -0700 (PDT)
Date: Fri, 7 Aug 2026 12:40:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Rahul Samana <rahul.samana@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Subject: Re: [PATCH v2 1/6] dt-bindings: bluetooth: qca: add QCC2072
Message-ID: <2iymaoj6ryayvsyfnrkwf6ldq57lkitoyqrazytxh7wxnpeoeo@vg6q35cua2oy>
References: <c1875dd6-fe3a-4a69-a6fd-b461c8fba6e4@kernel.org>
 <6d6465bb-47ac-464c-af4e-0ca72325705f@oss.qualcomm.com>
 <8a388310-d3cc-4d02-abb6-0eb98c24cfce@kernel.org>
 <4523441f-498a-4bbd-80f3-97a7a9206c00@oss.qualcomm.com>
 <6e0b9e79-ccd4-4689-9a6b-9b4fc556d5e4@kernel.org>
 <gfhlyvoefcsvtjuxfo75qeham272cc5g2r3npjenzs5esjifiy@ro7dtkpxwizk>
 <8ab6c26f-b648-447c-9fdd-f1424beb44f4@kernel.org>
 <sewfntbhqtj2apfdi4ouan27artvj4lyxqizvinsvzltbofqu2@riuoo3fmczff>
 <768142f0-2638-41f3-a34f-dc80bb99eb7f@kernel.org>
 <5tkajres2vjkt436teaujcqyc3mjqr65rsfvwhjbmlk3fc3gpt@j6ozyfattae3>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5tkajres2vjkt436teaujcqyc3mjqr65rsfvwhjbmlk3fc3gpt@j6ozyfattae3>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3MiBTYWx0ZWRfX+Pp+U79tm3lH
 ximXkLlhwUSfSjokf+Z4MEugMuNDm/WULXmwAoJGWovdcNNT/onri11NsMkpfyA5b+BejXFycXt
 gxJAkiSV3RSlM6UI15F8jyi7hWjkJi/12IFz2IXxhOzPbRlyGSHH3x1zt9kY4luuL08qC5NaX3B
 4e6DRrF4G5XqAuZIjiUpwIoV36piYiDEvR1GPFmzqGlPxby+zXU0GqrikTvM9vpxz/OzXq1qdH7
 Ik7pzx9BkHUCEcTrudIg50wntXjUVcFUlz5xXcHLLq8WOlKQgBlA15N8ExtxAoeyLBeUnj0aUQp
 d8F6yLCzUbxu4ccdqnNe29ymGYuacFGqCosfhmBMG4qTRvBZHfjCh2bbOMnbu9WwoNEKC+CMke6
 9uERlDnJJtD4iYq9CqdVvxZhIcOqO/f0VoYyK6JQtqO4ejH+p3hNfRecp9jY2Y4KdjcBJvM577V
 sYKbPMEUJRtfwrgDSnA==
X-Authority-Analysis: v=2.4 cv=QsBuG1yd c=1 sm=1 tr=0 ts=6a75a7fd cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=OJEdAEo-X711VEBAeTEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3MiBTYWx0ZWRfXwsyarq5HF57K
 DSHJmuvhVLLbRjFZx1DUlSy4fohybgAXvQKPzzNbnV1YcdlKmvCNRcsZdEu+aMlBO3dzYwfTR13
 +oxXj1ys6y5ZjkHzHo3XpXPawQntyVo=
X-Proofpoint-ORIG-GUID: hvNU9fGbSNJ0WP29P8O-UmugYOBUkFxR
X-Proofpoint-GUID: hvNU9fGbSNJ0WP29P8O-UmugYOBUkFxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070072

On Wed, Aug 05, 2026 at 04:52:15PM +0200, Manivannan Sadhasivam wrote:
> On Wed, Aug 05, 2026 at 04:36:31PM +0200, Krzysztof Kozlowski wrote:
> > On 05/08/2026 16:12, Manivannan Sadhasivam wrote:
> > > On Wed, Aug 05, 2026 at 02:33:51PM +0200, Krzysztof Kozlowski wrote:
> > >> DT is not representation of internal device driver instantiation mechanism.
> > >>
> > > 
> > > Here, the driver is just creating compatible for a real device. What difference
> > > does it make if the BT node was defined statically in the DT vs created
> > > dynamically? Both nodes do represent a real BT device, not driver's own
> > > representation. And by the time the node was created, the device is physically
> > > attached to the system.
> > 
> > What stops this power sequencing drivers, after more driver patches, the
> > best if being part of some bigger series, to add properties like
> > "linux,name-of-driver-to-bind" or whatever other SW properties?
> > 
> > This is what happened in that linked thread:
> > https://lore.kernel.org/all/20260326-pci-m2-e-v7-8-43324a7866e6@oss.qualcomm.com/
> > The driver code is adding children under other nodes (references by
> > graph) and it is nowhere documented. Maybe bindings of these other nodes
> > allow it, maybe not. How do you even validate that?
> > 
> 
> So the concern is validating the properties that get added dynamically and I get
> that. How about inserting an overlay for the BT node instead of creating the
> node on the fly? Like, drivers/misc/lan966x_pci.dtso
> 
> This way, the overlay would be validated against a binding and the driver would
> just be inserting it.
> 
> > So answering your question - yes, there is a difference because:
> > 1. DTS we validate but whatever you add to driver code we do not and we
> > cannot,
> > 2. DTS represents hardware but whatever you do in your driver code
> > represents who knows what (maybe hardware, maybe not, can represent
> > anything)
> > 
> > And if you claim "I add hardware in the driver!", I respond - maybe
> > true, maybe not, but look at this crap:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=687bfbba5a1cb15cee51519c210141ed1c4b0ec7
> > 
> > Since we DISALLOWED venus-decoder and venus-encoder DT nodes, what did
> > Bryan do? Squeezed via driver code fake disallowed nodes and even gave
> > them compatibles not looking like compatibles, so any regex won't work.
> > 
> > This power sequencing work here has the same problem of sneaking ABI,
> > which I pointed out here:
> > https://lore.kernel.org/all/9cc5af16-d95e-4f10-8b4a-5e29c136079c@kernel.org/
> > 
> > Look at above patch - nothing documents that ABI. The same as Bryan's
> > fake venus-decoder and encore (not only fake but actually rejected). And
> > to avoid ABI-check tools (or incoming tools), this power sequencing code
> > does not even call a "compatible" a "compatible". No, it calls it
> > "driver_data" nicely avoiding detection.
> > 
> > This is terrible practice and I feel like allowing this patch is silent
> > acknowledgment or agreement of such practice.
> > 
> > It's about basic ABI principles - if you have DT ABI, it must be both
> > clear in the drivers code and in DT bindings, instead of obfuscated
> > calling a compatible driver data. If you don't, then this is not DT ABI
> > and you are not allowed to use OF code to instantiate drivers. Use SW
> > nodes or KHO-style whatever else is there.
> > 
> 
> I did propose using SW nodes initially, but then it got changed to

If I remember previous discussions, SW nodes can be used to provide
additional information about the existing devices. They should not be
used for matching.

> OF_DYNAMIC with review from Andy. But honestly, Andy only mentioned 'DT
> Overlay' [1], and I was the one decided to use OF_DYNAMIC.
> 
> - Mani
> 
> [1] https://lore.kernel.org/all/aWSwgRiEkT9unYw9@smile.fi.intel.com
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
With best wishes
Dmitry
