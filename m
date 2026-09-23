Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE78F517BA1
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165983; cv=none; b=NNQKKmlZ+jlJkHcSfVEVhF/lPKaJcL/rpzZUclXwohLMBKLDKeZGNrCLSPjS7BIvyNMQaK3mP+65Vud+B98fE19G5o0ZrSgh1drxExNJsOCR09pvU/hFZPJ25uXazbRQoDHhme7aDLhX/NQqo/n6Nb5S3THKcMPl8eQ4t1FmUtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165983; c=relaxed/simple;
	bh=FRdZr1Qf2ewNAG90/1w19BygcGtrxeTxuYozL/kI2NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CP6naOJd2ySFBF2iD0WpgfuPhAy5r084RFocyi4hn1fAylAZaE9QiYr+fsbO+Q0NP3ox5WHzZXdgNih+cABx/l2DfFKZQ12XJM3/4k2DTwXoqfPkHXsVj+0S/1FZhxXX0s7uvt6bEZfmeq/gxUCa2Gz4hwdQ/EtY4q3RV/YkNcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kSFRmsHs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R0oBM9n3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kSFRmsHs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R0oBM9n3"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbfk72638328
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 12:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GnMmorU5z7ubvp2RV2au0vwumoI2G82ZHEvqLawCVIM=; b=kSFRmsHs+oW+GSUU
	LEz6kZCbnLmpB6rmdxPPBwFZ8nEOw6U3TrYlxIcfTNQg5rpTCFb0P4h3jowlyhRA
	HkpRBwcDwfH0kDYeBBhUwa8GRa/Z+H+mmVWHOHw4mlbl1kjQSo10i3kN5LrrPcdm
	knEs9W5dcHZjmPCaoFnVPTQKtchQqGhmyNFg1xf7jYj4cfgyizDvxcQGUmf00e06
	1sjSaUZgzZvoo7wcoRn5JT20n818K2hSJOWlNULI1wz2xV+So11VZTZyIK/lml3g
	8HR0IsaDkrXUpzcJUFH/m6yy5ETHH+tyjj+bTYuEnUGPDq9+6/y3ursRtUiGw6j4
	ysbULQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv9bqhgd8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 12:19:40 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-97f18b9d6feso28937241.3
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 05:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790165980; x=1790770780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GnMmorU5z7ubvp2RV2au0vwumoI2G82ZHEvqLawCVIM=;
        b=R0oBM9n3EsHbNbGF+9YMcC/vXlvEigwOm9e2vI7nSKjQ22Qb7wK1t6oPKhgEo+TqQb
         drf/5EBOBKpD8MEqg0T2Mzca+0yJxfmV0mLP7oQkmfHnFA/HF7oXrw4KcWs6j+gqHUtb
         4s6kGhCN/uY20hKOKV4iepYAqN+2fZDCdV8hlKliTs3CYmF212jjt7zrPjh6TYMNK0FF
         aRWqd1prUe1apnA0M2L1smnqhYJW/omid6ttEpgGv6IzurlcGmhjtvjWtcfav1+vlDh7
         j1TJsG3WoCNC6Dl0bvfxDMlj5rOtvc1ZXRYq4H5TV+wMPKx0OUONksYdrw4fzZ+9SYoD
         2JXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790165980; x=1790770780;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GnMmorU5z7ubvp2RV2au0vwumoI2G82ZHEvqLawCVIM=;
        b=B61LlCEQL0XAeaKc7uS7QVLnLZeMK22W74/QyzAbGhOk8vI08aJ1GWqMX3ARcWknqC
         onMgS1mcYqs28RZv7/5ZpFmwmQdKAy+HZcrELwG19YSh1lStgId9+yFbWFRauhvGTOuk
         HoFhc5nYKXkyiHmR93jAan0UVXsg+c7IS2tesGkOlaiGqhq0F1raA/FE8rsupcVhYl0A
         0fqq6mkio9+5aAq4SDdy2Mb+Z4ldEXw9VLHD0mxL8HjZ73zZnFPvpDD0woZolrkxXzJV
         acYe/H+PS7pCAHLRvIpaHx6+X6/FptBpwaQ1fbbIw+5qR7mS4ScSQ7jZuUUQUVuLjY1v
         EoEw==
X-Forwarded-Encrypted: i=1; AKwUvBzly9J2iOhOjXG05CiRivb9ecUZH7C7Us/jQVTULDqZS8zMHC2KJ/J9G9+L/9AxKwR1o1oI/sqaiCU=@vger.kernel.org
X-Gm-Message-State: AFuF++mnX3JM89Y0pSuQetiG3ZmLWCtfDyt32J8Rw0FcglqdGaur6Z/P
	YA8DzDIoHgVspn1H7P028bOvAjiy9B+591jO/syWm8AlOv5J0tbzp5HjhbpNzouLzwtFYFc1s9q
	8BCzOcXLALI8jDfjkW9G2ghHvmwRjZRzIkdN6If44pKJtYHYBfiWFZ6rVp9wdjmA=
X-Gm-Gg: AYBFou02BOpZXXmbHElzKSQqEyy/tXyiP+oVFi9Wue6zJR9bnwmFCwt3oM6Y9RNLZo7
	D7zxNCeR7xJeYNeDzQ6nhhV6+ZzYkH/Fc8uEmN08/GzJq2JfQRPfp9FPWl2KEwljpPamErEr0g8
	PtJ/Qdh5QIN75T0ryasdXYP9EfXFF/XTK/M5a5toT0CFtCryC5B6C9QAS4P6p6tcyk2f3SzbVAM
	dAmMxHVC78eLKCf1ws8XuRXWI4+gMDJYiAVYu50DuRVtXWaGzd6q4iMwDA/FgWtI8aYZEMd9Yie
	YFIvyO6yUmnY1bihWitd868VG8K1xOP3iQhRQWsHMNs4lzYSdKXBwUxp45c9v4j9jxD6fARRv81
	8wlqIGoE8CBhetQrR5A0+uA==
X-Received: by 2002:a05:6102:5e93:b0:7a7:ad9f:539c with SMTP id ada2fe7eead31-7ac1ca9015dmr1987619137.2.1790165979987;
        Wed, 23 Sep 2026 05:19:39 -0700 (PDT)
X-Received: by 2002:a05:6102:5e93:b0:7a7:ad9f:539c with SMTP id ada2fe7eead31-7ac1ca9015dmr1987594137.2.1790165979587;
        Wed, 23 Sep 2026 05:19:39 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ab0aae727sm92143166b.0.2026.09.23.05.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 05:19:38 -0700 (PDT)
Message-ID: <07ad0b0e-f666-44f7-b5a2-bf9ad016b297@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 14:19:35 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] phy: qcom: qmp-pcie: Add endpoint PHY configuration
 for QCS8300
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20260921-monaco_ep-v1-0-63c5282fb0db@oss.qualcomm.com>
 <20260921-monaco_ep-v1-3-63c5282fb0db@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260921-monaco_ep-v1-3-63c5282fb0db@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sMpPO3tbDUXItj6qRjByScP1PvgDhnwg
X-Proofpoint-ORIG-GUID: sMpPO3tbDUXItj6qRjByScP1PvgDhnwg
X-Authority-Analysis: v=2.4 cv=WZuZ+EhX c=1 sm=1 tr=0 ts=6ab3c3dd cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Z49P6srHwRQ8gCsPR7EA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0OSBTYWx0ZWRfX3Ryf5arlv8ib
 XLQHrFbFUBVcFCAMJyHBV3bOlmmEUWPL08NIp+bDUKR0Vq4XyNA4lGoU+8qYwt9zbpOTE1vPzKz
 ASaR8E309GteMhjlEpgj33Kmescmjcc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0OSBTYWx0ZWRfX3s5GI4Ir38Ue
 R/qPNQ9+YZQmWAxUoyjCSFvr7JlxCD7mETyNducft8y3+qzrgSFG9ehPhvldEqs6nXVzaxJ754T
 MOiXrUEWnrDGlgjMQXocmC/wlQDtp4vlfyvZW3BlXZMxLa0R2XzOXa2yIYKsF0Y7RRDHSRg8DJA
 miWxhvMkUV4gHvd4jtr28WbwmYsK840v7C2EI6SR4E4twEel7lpvLc3m+PIoQ55oLYjW4o0Rr3Z
 8zqmah3mtzyr2XE+U3yv4T+ldXwjNT/toaPE+klohQQdkY750od8zHX6RU5AC+0JGIUy7ju/Q46
 h8xKkza9rhEZlv+Ph8GwBmatVmsH9sfRDzogpCGOSmu1HFToq8q4GjHHwmWBKbOCDy5h5O5Sc3k
 ecslE4YwNihHUOFJf8INiAaG5U/c1gN44lebTaUkj/gz5gScGHEavsgorO9dm4dL3SwaM+4TgWM
 TxMsmVvGGtLC3G9DTEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230049

On 9/21/26 12:58 PM, Krishna Chaitanya Chundru wrote:
> Monaco supports PCIe Endpoint mode on both PCIe controllers. Reuse
> the existing SA8775P Endpoint PHY programming for the 16 GT/s x2 PHY and
> add a new 16 GT/s x4 Endpoint PHY configuration with the required RX
> tuning parameters.
> 
> This allows both Monaco PCIe controllers to operate reliably in
> Endpoint mode.

Does that also apply to lemans?

Konrad
