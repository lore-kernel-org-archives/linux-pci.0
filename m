Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AD1318EE1
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 05:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783402841; cv=none; b=mHGnSVLAzwnORVTRLUbUCZ19s9+zrgwkTLCNwkVihZXPJ83x1bLvhr0ZcC0qBL52/uwIUasoGXzXyib0z6oDhIUZsbK2/bbUYOd7lpeaSsI06EON8tFeOmHzjVr/rqZHccVe48qxgGyRCuq41eNxzl9fR6mHxveZ+Bz85lTd5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783402841; c=relaxed/simple;
	bh=2tGlw8u9Rbdvgrkw3LNp7XhIeWAt+H/gpCH0Q53MUZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RubrvpgHgM00OFDqYaxIrA7C15j8nVhvPPC+Wxi0PhPl7bbmDWC03sP6o0HndisW4u+Y3R4GkPY2HztO716lPjz1lkhGsd+3u1xiB0FHEgdm0tbE6JAq0c1dN4TapWwvuyAqHXOLpwG9KfoDfIuFUpQ4Lb/SJmw+vQazExCxvJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OkLGvGfi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZRhsItac; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OkLGvGfi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZRhsItac"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66749J7w2670685
	for <linux-pci@vger.kernel.org>; Tue, 7 Jul 2026 05:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	09/2e/voBc+DyuWudh1rLfEp3vVKAMHxiosmb9KxU7w=; b=OkLGvGfiGBUgG5vL
	WKCnDi1XODznle+cnWEVbG5R7qSGM70OtRurYEvAwiJCD+RIvG1WtYODlMwQQEnN
	qQ9hYtbJbj99NQaP10wJwkzqD+sOU/HNQZsb534UJxG9HK3+xVjY4yaaVRfmtdje
	ORIEEDJqZ2bNn9dA+Al1WYyRO4lZrzcYWK0XLHOY3HDyv7QjrtLLuMyu/VrQDZAR
	tT5F6hR+cRv/0GI1pN5UtwBbE57w4cEanivdkyM6yHtVKTlFVDWGhenE2pSB4b0A
	EE/YOdy5InErfZRZPm0EPoj3RVOuyJ3XYn0+M8PA27JOqWFRufFFet23H6RWz9tB
	a+1Heg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgve49-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 05:40:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-381e93bfcacso8345061a91.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 22:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783402839; x=1784007639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=09/2e/voBc+DyuWudh1rLfEp3vVKAMHxiosmb9KxU7w=;
        b=ZRhsItacYmsR3wO9UJE2QqiLZzB9BRiBuG+vQVlk697EOjJIIGIJSsvYpKzFNCGKZo
         Fg3IL5QQv7/Y14qhMT913BWD0JLpW9p37aymGSK4qpP49m+F/Atj9QMeVqYCZptQ9b8x
         B35fv68Qq6LTnomfCXqXQKPMlfbFT7GFJ8UTiwoezFIKtC47cKrEcrHnwFvEHMNoha2N
         a+KJVulwz9fRb+CL8JFk8u36ZgXOfFu6ZGDUpQV3NzNZMz/gHtG9CcEPlu2H0VfhcBNf
         DI1xdTEffKgpRI/H3Fegjeo0XKq5Xgr9uyXFC9K19KOV381pAtkx+5A1VNHYCrpHEKwA
         AGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783402839; x=1784007639;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=09/2e/voBc+DyuWudh1rLfEp3vVKAMHxiosmb9KxU7w=;
        b=JeoPp/idL3fk8FS7PkYnMB2kWjpIGqi0vfRYOKb0zaGFkQxK9A1Eo07fjmo32+NM5/
         6m+xXTyF69jHf53pN0eQ7lq38uSsx2pRWjdv/BU1dcUpljWuyrmOByvTd+rrzmiXq+/c
         BWDnqTs4/0uuVeR9maax6OkUZFcFLEmPhaNqX9vSrZUUKLO6Job39+sWXQ0JtVUFsyVK
         vMkPq+TGi7SyCwYy9PCRDLsfQcCLWblFkQAntQFRmUdliner/NV8IsDf4Pmrmy8NioJR
         Jif2UNgeY7RDTaorVfR0GxgssDMiMrOoN2tAJK5/qkKcoX7p9KCsAWIEAtALd9smpFHx
         lTGA==
X-Forwarded-Encrypted: i=1; AHgh+RqeJjQLKRCxBHaYyum6KfU1zALV/zzqElzDqcqDUaNTSKT4ehY5y6mCxfJGkz32azoy43ECuQ0TCUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0bBLaRwrHPD85alhN77pfvWfYfX7FQMjbm8wgeVPLdqiPCQvU
	WVebBwVZ2DgOCKPA2vC2vxFfnVnsmBohmY+QEuS+ETWu5598AZ8XaRcaq7U2Tpz7r1ORCetpFlV
	AGmP6n5gi9aodvgaDgbChVZ4nDX1QXIiMmh+RBwOz6rgde/NeWLmyF+k+3ZmVrck=
X-Gm-Gg: AfdE7clpUsVRs0fw0jOeugc30mYqruV6Ded2JCiL1B/ci+GWurKA+uceEONuSHLzXbu
	3sM86oCyW5Hw2fLBDSvMshc9J7tNwZoLO2oG1o6wcgkkuhrviCH9Vg3VoESuz9vAp2MVawWwBzD
	wp8IqMCrnmzbhsi4PEoP2y8GfpYVox+RnAih+YmpjKszKiTNGVf0M/6JhP5dE73O3kOucQUo9u8
	dnWeWmdy9d7JXg7XM4RM1vEcRkOymK1pVwPr41MJ7V8L93IEtnn4sExfp1ypilyHBH6bmTqM/ca
	RM6ul+4qu3+y4jC49VmGKzSHUiXIdK0lLeNw/h69UNP4FFSijY2TgyBrAiQM9SgN8NWYI3JLJeI
	4pbRSWY5nBHpSByC7AYXjpbpoNlUO859if036QhGwh4cpDj281MK/6Gg/Cowk+lNxmWN6JBxiaV
	lTTCBo
X-Received: by 2002:a17:90b:1cc8:b0:387:e0db:3fb1 with SMTP id 98e67ed59e1d1-387e0db45bfmr1432279a91.42.1783402839113;
        Mon, 06 Jul 2026 22:40:39 -0700 (PDT)
X-Received: by 2002:a17:90b:1cc8:b0:387:e0db:3fb1 with SMTP id 98e67ed59e1d1-387e0db45bfmr1432259a91.42.1783402838621;
        Mon, 06 Jul 2026 22:40:38 -0700 (PDT)
Received: from ?IPV6:2405:201:c409:b03f:6d0b:bb83:7a67:4093? ([2405:201:c409:b03f:6d0b:bb83:7a67:4093])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d3c6bbdesm432182a91.16.2026.07.06.22.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 22:40:38 -0700 (PDT)
Message-ID: <8477653e-cd5a-4e8c-bed3-fc1a1e21088c@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:10:31 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] arm64: dts: qcom: shikra: Add PCIe PHY and controller
 nodes
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio
 <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260630192944.GA224708@bhelgaas>
Content-Language: en-US
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
In-Reply-To: <20260630192944.GA224708@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iXuhfaVTH9yT2016jU9S5UMDHGFZErBm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1MSBTYWx0ZWRfX5JnVY9wQUvIH
 CmfUmWC0ys35g8yaei82boEigAIOW5xiSXYbQi4WQgmQPgv+ibMTB8qMEm4At+U0iQnuRY06YUK
 KTMKufYFbuR2ncJhgJDLlK/rMAZxEyBi74oINB5MHPCiQrsbkXS2eJbR9n2gRpj1D8LIXQb1sj7
 TS/8KeoudUmmVJXmQ0Dnj6uiovgjyOSTt2VRLPGQ5tegkCODFpS8Nb6pAvf1hvzVdlE1ptyFpqm
 XP+pRAnRisSRnEo738Ltzl6atW5HM276qUQZ2zKtchr5n04pc+eXjM8OIdu48CIVKB9uib6Rr4q
 bFljaNujrdws1Cq2jSgNyLRC7GdJUdmwH2Ti5VKLagC38/qOPRwsffXLTwGPUfR6ZryYtoQr7Ld
 J4cB4mg6vA2na/xr4Rm2LsnMKxNnyv3l8mOM8Y13cBtBt+z9pwgvaV6H3eHVbjGaCA0v/3K/TTD
 BqdsGsDe5bab2+mTeWQ==
X-Proofpoint-ORIG-GUID: iXuhfaVTH9yT2016jU9S5UMDHGFZErBm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1MSBTYWx0ZWRfX+ojh2iQuAi03
 6Yfvl9lEHimlufdF2DiGAC+yy0ZsD2331tF0wR8EU0vf/6fLhQn8neC95iQvAD8Q8+tamOHU4bq
 4yaJUTnJnBrah1a0naFv8xk2oB4Gbk8=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4c9157 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=JUOmGHd9cyzBAK8M_EkA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070051


On 7/1/2026 12:59 AM, Bjorn Helgaas wrote:
> On Wed, Jul 01, 2026 at 12:32:49AM +0530, Sushrut Shree Trivedi wrote:
>> Shikra supports single PCIe instance with  5GT/s x1 lane.
> s/  / /
> s/lane/link/

ACK'd

Sushrut

