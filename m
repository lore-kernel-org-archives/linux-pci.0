Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FF3369D6E
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934756; cv=none; b=tDBvdGF3uAB017fhBphfCINz1XtyLIqchj+b/mrUMNhdyTQuYe1xInIUmMb3zGEvkOSQD1nllao+Nfg6I0CPRx6U23Bm60hrMT9EbnSPrnSZe4uULpk9MWNxNUJV74dB2eK89IKpXL5Dt+7bubLNBEXfelbsaRXKQytgqqKyYmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934756; c=relaxed/simple;
	bh=IGwU/XzHL5SyWQ9S/hw4TQ6IbW+i1/eFqewpz5BZux4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LctlgIzpleSSg5b2sIPJBKAAjTuWnM5bJ9g1oT8nyti47cjnNFoQi9MJ+Q0UenFjX68q02jeE6Res2cbb0aDbRiYdNaliDT5ObOj113Lh/GXtnlsPUptIpe6LOgO+Hf48hWtJCK7rMA2L42lZLwsRnDH7/vIL+9oSWiYGcbVSDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D4r0JED/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=URT92oqC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D4r0JED/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="URT92oqC"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D77RSW810576
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 09:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NbBmG6kgKD2
	CVzzcP60K4ZcdLZpgmeYKoleCsoDM+Ww=; b=D4r0JED/rr9wtjtCMM66Ly6auYz
	sm6/XhNXWNLB9C3tM/7oD3opkoU+aZjiiGdGe4jdRlPWE56PPsryex3GWydx9IT/
	vNTFlNrL4NCzV4NMMYqXzN6hW+n111kLX5uapuMMoUDJzoul5q1ScU6ZLrDRUxty
	qtsTfnpd5Qq2uRpH/cXbrlSf6D4JQtTLO5YFFDCynhZthA/oOMHat75UzB6h5qjO
	NlnLc+bgy6Mz/ojFMaP8awhQAID9mdBZ2VUdZbiiOF5iLaeVthLzgMJG8G6RSh1t
	eaWpXjiIio7M7VgVfc8DHJzgu9gsEQM8tcqC/FlMvstX/44QZcpBvVNpd+Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcubsrgts-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 09:25:54 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c9e5aba3d80so281235a12.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 02:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783934753; x=1784539553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NbBmG6kgKD2CVzzcP60K4ZcdLZpgmeYKoleCsoDM+Ww=;
        b=URT92oqCOtzZMG0Hd/Ptt6yIQdjqB/xV0UepMtdQumP/0lBLbTdOpqDUd3M/XMQvhH
         k0pGKGkzFJiEypCBqy2fGJNIwinwG2Qtgv4iC2B+PGJ4kbFklfxOivsKmainrC3fpE66
         /W7UA6L8nDGZUTNCb1/iMP3Ot5NBkBPFmqzfGPBUW9oDaWjDRCqdk7zPEIvOLCsgCO6Y
         HbzkbBXzZhmwOB3rkp7UJGYR1y+m86YTBZV8liJexQM7flAty72IwTR+0k6BUbzS3cAl
         tj+5GW7xPl00mnVHMOC+Mv4JHLdGpR15CojcRTq2cUhWjM/+LvzQuas8bG8KOpDB5YQJ
         vFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783934753; x=1784539553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NbBmG6kgKD2CVzzcP60K4ZcdLZpgmeYKoleCsoDM+Ww=;
        b=HX1MNYlzq71Y6LexEMXcnH1A37v2Cx38sXuzJQp37Ce2vt/At5e3hpsVOZblynkKMn
         cpFJJL+wt305jM7kVBYnVjBypoLKb/XFSW7AEDcX5Yq9Wl3OGCW57z6f9KajL9zY9Bwr
         we6YMEI45IJ08MKx7Qoguhtt6lWqjpuMUxVxbqw2s3dqjnHxsa28yv1Yn3bKsFi/eo1M
         AzNhrKqYPU/K+LZNzpch158Rl21u2xnZK0CMLLz+pfG3aL81ndjadXVQla3M/m33V5ki
         j2HzJyJcpPxWk1zJcjz34KJyFZUNhM89aJG9sRFWbGg+8cwJsDSZbaWrGi+MNgOrWNyE
         i5ew==
X-Forwarded-Encrypted: i=1; AHgh+Rpqej2CV7mjQ890UJjB10hYp01/GGjCdlwqcO1/Nib9/DyTU4jAVV43Fi+/2sXwgO1PRI4dYSDTnG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVt3NOHBdoEiyS9BLfM3MLW8k70qf7exsLJzRGLFwCn1H1JYlk
	tZdLOYGTrFXQNgnMPFJ4LOjAnGwBBEgfeS0jEhJ9WAKedRYbPQmurOMiwYE4iLlONW6e3ZcWbqD
	ekCkjFp5T05YKJ2jKBcYPWmVxAZwXybEKJKzOChOG/eH7qlyW5uD4mE8bFGBfmuE=
X-Gm-Gg: AfdE7cmw7oHhyw6G6dgfM4F7MsWFjw6Ay9jmuq7VmKqk5QaWdeItwMgqVOrAOtQ4R5V
	eMejvU2GUANwIDAX63+DkMDCwfs0oLWOnSjCFzJfa/XlX0xmQG10NzosBz4bk5MrGFvYxyqRq7e
	aJuz13Z3l+LoY7ECsm1NC3u94v2mbiNe8wD1hAggOuqv/xvqCQm+UGPn6EwfTfBZFHcMQ11niDX
	wlo54KKolLWGdGdrYJfDunt4Bj/0Go9eHNdE0TjOu6Onwuosfp3EgikKIJybjE02mc4XOX1RYiV
	yqoE7Q505pAL8677+mOPz+bHUes81dgTypCid5PTTJMX1XHFSiyandcl7VWElwKAQ6eJiiqiAJQ
	oCU+yyaeMt3R/Cp/3WtTlP+/uQOOvKjExMCqDWZewsmoPwD2q4uvPZBdHEAViIA==
X-Received: by 2002:a17:90a:7307:b0:38e:bfe:81e6 with SMTP id 98e67ed59e1d1-38e0bfe9036mr506232a91.1.1783934753190;
        Mon, 13 Jul 2026 02:25:53 -0700 (PDT)
X-Received: by 2002:a17:90a:7307:b0:38e:bfe:81e6 with SMTP id 98e67ed59e1d1-38e0bfe9036mr506220a91.1.1783934752667;
        Mon, 13 Jul 2026 02:25:52 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm67901497eec.18.2026.07.13.02.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 02:25:52 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, mengshi.wu@oss.qualcomm.com,
        quic_chezhou@quicinc.com, cheng.jiang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: Re: [PATCH 1/3] arm64: dts: qcom: hamoa-iot-evk: Describe the PCIe M.2 Key E connector
Date: Mon, 13 Jul 2026 14:55:47 +0530
Message-Id: <20260713092547.4100116-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <63643fc3-3a3b-4aef-96b4-de42498cf47b@oss.qualcomm.com>
References: <63643fc3-3a3b-4aef-96b4-de42498cf47b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Oq9/DS/t c=1 sm=1 tr=0 ts=6a54af22 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=VjGlub7PaFdePbqR2KAA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: TPV0VSrhuIhZrhWiazamLPHOtrs1Fu_M
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA5NyBTYWx0ZWRfX0s2sa91Fm2iV
 ZZgrqIVhZq764xil4MsjbdpRLwO8LQHCfFneGOYDMr8UHt/95TPFeFgFLVU9DdvpAVdP4zBtfBy
 RK0+0kmxEQbUhItRmRneTgKZms0a9UA=
X-Proofpoint-GUID: TPV0VSrhuIhZrhWiazamLPHOtrs1Fu_M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA5NyBTYWx0ZWRfX9evsKwhhrPvC
 iD3DFLoNXjDotGieZiiVmvj80ga3+JvJuYpkqZTRqSAuBhmvKj/hUYN0nwGtnWir52lbS6aPqug
 VShp5yNhvUEwpUorere3i3eV7RdJmVuiU3va81jqqd4WH2wKM0MiwaiAB5UB4nEd5ZLbgqbmP+y
 Olv1w4G4+ihyYoYjAyAPNDnXERdIGABCvvPEQAZCEbqaAcaMZxq7xaVTZ6wgjDOLBM2g3xrJAmX
 xlF3gJHddXpirRbDcpua55fNa5lBdfD8bbFCR5nDhH/NJa4FdE4FoyfqBxYqdBGr65GLzPNfXpb
 Vy7AHQL9oCffBk3z2EFMerqHKmTeLbW6y7T9zrfBs+s6vCPvGzlDLCnoJUcTMO1wRbqDT4uWfmv
 6+l0IoOb39cpILpd6eD00TiGISnEuObDOR4L4OcbIAd6LiJpsXQclVMXzRNbzIC0mF1oB++hnPi
 IPncVMBJwe4Ogy8QfXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130097

On Fri, 10 Jul 2026, Konrad Dybcio wrote:
> On 7/9/26 9:29 AM, Wei Deng wrote:
> > The hamoa IoT EVK has the PCIe M.2 Mechanical Key E connector to
> > connect wireless connectivity cards over PCIe and UART interfaces.
> > Hence, describe the connector node, link it with the PCIe 4 Root Port
> > node and replace the static BT serdev under UART14 and the
> > chip-specific wifi@0 child node with graph port/endpoints, allowing
> > the pwrseq-pcie-m2 driver to power the card and dynamically create
> > the BT serdev device.
> > 
> > The M.2 Key E connector is powered by vreg_wcn_3p3. WLAN enable is
> > controlled via W_DISABLE1# (GPIO117) and BT enable via W_DISABLE2#
> > (GPIO116), both described as active-low GPIOs on the connector node.
> > 
> > Remove the chip-specific wcn7850-pmu node as the M.2 connector
> > approach replaces the WCN7850-specific power sequencing with a
> > chip-agnostic one managed by the pwrseq-pcie-m2 driver.
> > 
> > Also add 'compatible = "pciclass,0604"' to pcie4_port0 in hamoa.dtsi
> > to allow the PCI subsystem to associate the DT node with the
> > PCI-to-PCI bridge device.
> > 
> > Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> > @@ -1025,19 +1004,10 @@ &pcie4_port0 {
> >  	reset-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
> >  	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
> >  
> > -	wifi@0 {
> > -		compatible = "pci17cb,1107";
> > -		reg = <0x10000 0x0 0x0 0x0 0x0>;
> > -
> > -		vddaon-supply = <&vreg_pmu_aon_0p59>;
> > -		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
> > -		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
> > -		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
> > -		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
> > -		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
> > -		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
> > -		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
> > -		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
> > +	port {
> > +		pcie4port0_ep: endpoint {
> 
> "pcie4_port0_ep", please
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad
> 

Thanks for the review!

Will fix in v2.

-- 
Best Regards,
Wei Deng
