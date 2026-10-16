Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DAC38A73C
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158111; cv=none; b=gWMkjGnKgdLkMA4UFDjuYLSHkF/j30rV5hRI2CLitUR4/u8hl6amNWIlLwWDT+XZaeBT+bukpAhPLPZDCOiJnVKmOtPEX+9C/cEYurrxgesQef6WIE5loIQiQcAPoldJMlYSxqYkzSiLAFFuhAJgsxg2mRH7d1LCIhc/i0iTMEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158111; c=relaxed/simple;
	bh=/zR8X6sWq9nDJwlulrdRxs4JEZClf9bzUIbyy6aGuMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfn+ADbEPuP75IOi5fd8l7tmKi4mTh4BBaDnghFMcucZdJIsVOw3MfXpFdEq0dxPvb+5CgVA5ooE+wuTQclWgE7aVauWX9P8uUNSrHCBV+Pjkng19Zu++sHZmDO9TxebgkB7ZcOWdFXZfZHLa24bt4Sa9JQ29shY9qZG1ho4pOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QMJa48YV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PdyI3gcf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QMJa48YV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PdyI3gcf"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAAGh61793687
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 13:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LLW0dwvOxGWpHegS5C7HG/kvWUkdwyRzWYnnzVJQotc=; b=QMJa48YVEcz4cPgI
	11UqulUYYo5Bi3mi2qAw5JB7asvNfzBrmcf/eIk3pghjWlWzYkbs/Eb6YvYzzk0w
	Y5Q4BtnMFqIuk9yAKmpDkdAOsFy7Jyz5a2B9Psn5NW3pxGZCakFrggMinsHiJDvi
	vTz4P7YDQD0ytBudc+F3c/J1cXkGYcTsg/mBqb+dzqnT0s/gegmPo7XFp5wqlcIb
	ytMOG2ijjrzMlcbJtR2leQABtlUJhvTQg7zqTxPBbDBp0fWcVXF9l7fozm/NQSZ7
	M6g5701lLv3R5NmOxvPalCrmppV8O99WEK6vxmsKrzMr6EU5yl3qfOcUAaRYqwmL
	8zBxWg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3seuxp0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 13:41:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93e92aad34aso1177598885a.0
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 06:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792158108; x=1792762908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LLW0dwvOxGWpHegS5C7HG/kvWUkdwyRzWYnnzVJQotc=;
        b=PdyI3gcffOZxlXP50kTuI/UWjJS4ES4Tp+2hFfaofhWhwN0NkTPcUCxWqGeSp4A7Vr
         CPiMq6oOe7FiQKQgd/6Kj8OevDakOW0ySdsvGwFhQcncaBp70txxHmwp57A/ViS7uGQV
         qwvDryrOO9gAeoN5Oo1o0CyX/EuNS7UyOtrNBvSF8QL1VheiU040jJ1Qkrjrc72OinII
         uvZYeY5XKcTpdLwfrl6X2/hDiKGrx/t+iue1IIuJS3i24DNNKH/D0Qrx4Ql0zrl/yivH
         HfAWC6zuGdvTHqxBoVN2XoGCgbMkPfSne8cgolwwDva3Do5ztmZSzQ0R7BBcVx4CG+h/
         AiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792158108; x=1792762908;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LLW0dwvOxGWpHegS5C7HG/kvWUkdwyRzWYnnzVJQotc=;
        b=cyieGN5RG9Qeei/xHeItx9ectYdh3JkgnCzty4Am0XZxSLfTjUSHHZkrHE7JGCmQ3L
         YhuqJ2Llz5vb/iNK22OOSJ6gf/Vxy9/sFY0LdkZVIdR09Z72vKlPnM0Pd2iEiClwFRHn
         qwbc6pPMzH9BhbNN6D+O0hr8a/nwGDUdjU2GBJdm/aDBqJDF9TyH4HEQlww5NUB8enRY
         eLub2Juk/qrtDmRZ3FpvDwz7JV/87fHhjeCHj0gQwXI3Ldwlzmp0aO+WlATMaWVokWUn
         TfHBapJne2Qor7cgcIEOT9sCSLISdhBAfdMQJbzeFVMMAiXEXO4Y+iJfzGfXHHzosKF8
         rtHA==
X-Forwarded-Encrypted: i=1; AKwUvByeu8f3vv0eKzxE5HlYd65i3UvqasqsSAwGiP+akTmQ/BSiWkyaM1Rap3wLVjJ+qLnd5GsmTOH4Msg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ23PjIxitr1NGlGadr1dg8SmO5l0MYZXQTs9/sJ2p8MWNW6li/
	VBmaubWDCbxx6cMmK8yyE/UCLVL0dUGMRWNA+xMVz518VbeDoI2AW0rowzc2yss0f2BNQX4/wyl
	lpqeO54rkhPNcZUEj3/10mVIe9cyEiuMFMZUx6SSrNRPi+9dG+y4bzKPu+uKQuDA=
X-Gm-Gg: AYBFou1NHQ2rQGEg30tPXPigcH9WRvdBYJVXJ292JXJw8mxXjSnPaY2R7JqsSvDwVo+
	nXhNwca46c4BorSjuxkpg+TBTRSGCYO+t62RHhhcoACrgnm9rk65kz1ZhLYZExTChVERX7O1et/
	JeKF5aS3yqOxZ9t/EIRhE9TamTjT6USvSQGt03l0nsH6H6eR8BqKnRcptlHx5tp6+isnXmj+jX+
	V/Ma/Sy9zTroJtlItA+BojZcs/ben/7rt6hju+1ciM1d42rrQam+NwRdgUH9FZ192/B+X8RJr1F
	mLmZIl7dgRBckhWWne42PcMis8RwsAhzw3nBYyVZyOciYv+cjnwWPzxvdWNTgt1jELBB8oQV705
	BNDveD0kL0xXCOQzH9/GP3fmxe7I=
X-Received: by 2002:a05:620a:29d5:b0:93e:920c:bf9a with SMTP id af79cd13be357-93ebd1e011bmr3417416885a.13.1792158108260;
        Fri, 16 Oct 2026 06:41:48 -0700 (PDT)
X-Received: by 2002:a05:620a:29d5:b0:93e:920c:bf9a with SMTP id af79cd13be357-93ebd1e011bmr3417410885a.13.1792158107616;
        Fri, 16 Oct 2026 06:41:47 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8d1esm5486672f8f.39.2026.10.16.06.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:41:46 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Wei Deng <wei.deng@oss.qualcomm.com>, Val Packett <val@packett.cool>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: Add Foxconn WCN7850 subsystem PCI ID
Date: Fri, 16 Oct 2026 15:41:44 +0200
Message-ID: <179215810170.58960.8245836334838240026.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016051745.577777-1-val@packett.cool>
References: <20261016051745.577777-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: n-id4s-vGO0XQPTrt1f3SJr6YWdW4fgk
X-Proofpoint-GUID: n-id4s-vGO0XQPTrt1f3SJr6YWdW4fgk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NCBTYWx0ZWRfX6o9Nje3GBJzG
 Nys4e91re03lsdXP2paCBY8Xza1zlluOa4uSK6U6hs7yCBirocFa+VWYPc9lwxrI6hnClXjOdcE
 c5MFCBoISTw0N7+WVqibbst1GUYUUj0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NCBTYWx0ZWRfXwpisldaN95ok
 G1dBN1THGfNRsV5xWCdMSjzxGwWpg2DxWZEm8ZMg/PkvUycEbf9Pbd7ZKxZGW3Vqz+KniQ94SCT
 DOns92itpns4/mlrwVa50Sqikq5d1EjiEIaPupAvdqHnzGtklRD3gp+HUj1F9OUeWq0+UJ5og8A
 tm+PoI4GHoD/nMZfT6SsObn2751lqNE6nlLCzVjtwGJ6CCF7pfKzKQqGrK2ffx7NV+kt5Gzdhnb
 e69dXOl+P5ZCYLJTRerAJKADeKhXmo9ZEfdkbFrwYFB2ckpf1Ar80pHP1c+HfOu4bKjgYH3IXMc
 smDxEUMUDkGnvcEL9ncavBvVTeRhVaeIx2nIqxe//kewStN130KfSzod/3jVzj4Rt+z87B9pXtU
 Xqnniybe5Gcm5uwzGMQ8ohfwmLdU7HeWBobAgneR/Ocm++IZPq5FCQgrCI3B72bnA2Sn/s4P5bF
 ECKcLl+0UtgWLpgV7rA==
X-Authority-Analysis: v=2.4 cv=Se1i5fRu c=1 sm=1 tr=0 ts=6ad2299d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Ac9oEOQn9GJuJuDrb4UA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160054


On Fri, 16 Oct 2026 02:13:35 -0300, Val Packett wrote:
> Add a new device match for the PCI subdev id found on the Dell
> Latitude 7455 laptop.
> 
> 

Applied, thanks!

[1/1] power: sequencing: pcie-m2: Add Foxconn WCN7850 subsystem PCI ID
      https://git.kernel.org/brgl/c/eadea156f11b2c9a780b60c1699c2da145c9d1f2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
