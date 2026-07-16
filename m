Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9F42E8D1
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212896; cv=pass; b=klBgY+DP7I9aJnjJVhE8ps8E4rzYdQk4EeaycMTC2zK6FjddqtGNQuuf9++/8mEEhqrZKnJx6QPHaswJhfMUZRn1s5XFYJvmrejgYEk0CEybkhNNnanraNGjovSVjWebIAyu4KGw59DfJWbxaijbCAo2xjSlU5/HPXiawCOgsuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212896; c=relaxed/simple;
	bh=hyj3UnvN1eL7blZIruI+pgZz/uFUOhtMU/v3/gNCvNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5y85SayMIubCO/cgMypsGxSeGwPTAyzLwGlpy0CF3U0me6coSiesYQmRrc94Bj+uB7wX8VscWdgGrS0YbqPinyAQBj4amQOwiJpMuE8BC67A/kKY8i9HCgAoSwwRQLhXxMlXkLlJrvT7p2+ZHcj22BBXbd29OQjTVsTdX3HQlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fq32eMEn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wmm9WxTd; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fq32eMEn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wmm9WxTd"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJdtE2946548
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 14:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uUqxKURSoOVb/5L3BwAiJscutjj+pBqwPiIBk2WAZMY=; b=fq32eMEnkSDXCyNI
	O+OEn+jRvMsMTtmNa8m8gqiLuPqA2oGtOQ7mvg4N+hT3NzUjClAuV6CScNuA0TdU
	9GlVijnYeCmS/lYORwfduWOa0mCSQ+XTxd/KZlJ8EhYxOkHk6phRqtYkMugLqSw9
	LPoSTjBDF7DYXdaOBt0fVBPki4cWKimQd3lNASYCEUJMmPcX1dmXxHTBL3kvRqRz
	DNlTd2tZzOkZbFCDvgIIP/2gbXc0oRYzq50cXSc1YrpWpOcmTFyfH1eZGNskfRxV
	8i8Jt7O1K68TUzD3qb/YC2zQSc+00matnHCWmrWfkio3K8+oRzkTlrx3cBJalygz
	NfxUlg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fen4wb11e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 14:41:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-930a098ea19so170277085a.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 07:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784212893; cv=none;
        d=google.com; s=arc-20260327;
        b=nviYBDOfUuvJpNVM0juX+PgMFZfgE1QxHmA4yxFlZX2gER7/eSZpCwrcRpUfr/5Tuh
         N8eXfwzykZnxYn67CFGp5DNCyk63epzRLEFO/aruH6y5HPedzh+EZThX1821O68LBYoD
         wcsmDrzCAFW8oCjLtb5spBqXYV5afUq+v8iGPlnk+HsYuBWd1+pRDEyFdVnnELOgVNNY
         B1VVMOc9lTa/5ZdeCJ0Itu0uWNXFkyn15v6T0pH+y17fWyUee7NHjpxIZ1kkbxSeUm/J
         yXZ7LG6/ae9+HWfJB4LPDFfrG/PW98cNBHDwFJznS5TQIGjTQX9ngAqTN/nl5kQ6GIoN
         h7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uUqxKURSoOVb/5L3BwAiJscutjj+pBqwPiIBk2WAZMY=;
        fh=jsMqLVtCZZrwE49BufBjsPDoSmcem4OJSt6wf/RxkuI=;
        b=mwf9hZMs5NVjkDhfkD/oWlHwUxGns/hGzX+EEqAFWhVxUTe/eX63VrhMy0ZlJnbF74
         6kzthtoZlqBH2YzIM+nNL8wKuu4RiZdWbo0qH2/Xyy44XheAOrEzpy+VqCkZm/nZX7XK
         0unzLbC7l98e5jLF+N6eC/F1/ivPouNk17H02nB3LP9cOqD4l3QlKKisdRSegopnc3nl
         IjixMhuc0VFtd+PWLdNwmeifPzgK/CnOOe2gIeGPRlOCs0mW+KSKrljMFtUaTLXaPwEr
         uzKTT7o7rGWOzX4f824dQ+s1z+rBSfG+jTCuqE6r3a/aRgIiMbckagdhM38UYC3DI4gK
         oTgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784212893; x=1784817693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uUqxKURSoOVb/5L3BwAiJscutjj+pBqwPiIBk2WAZMY=;
        b=Wmm9WxTd8EUWtvr9KorvXD8wLWoCKYO9rNJTzlbdqec0HlUIF/9ESodj86I4hapIaL
         LFepfgInSYfl+u4JLXVnt2Lf6K3y5TB4PbFdV5ES0Cq7eYmPk4VoCIXZ5nt4fkfvGpHf
         Wi+6HpC0hFDzz2BUTte3h8SatKbHfITuUNOF6pzvhEujIMLRvqJrtaxW2H3zuJx6wMUf
         hWe9IjyzbBEu3aNM6aaqDtX9foQvWOxXvbsVPYPL0w5n2xp0f2ISQijkWtN4V1ae5x9O
         O1W+HADEVks7SY3gjOioq6g+jpLbVyRAQtWYEHu230Hkj22/heWUYp+vcH7BnHDjFTF8
         i8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212893; x=1784817693;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uUqxKURSoOVb/5L3BwAiJscutjj+pBqwPiIBk2WAZMY=;
        b=BML8UtyRDWWYj9z9qCgmeUHXVIYi+XuX5DSq482zgBhPo1huXgXiKR8fjYEB7xKY14
         OUfpo7+Jvi2CXRPGDJS7KSeCQSM+DZXwynZfLcBWz5bLfgCT+ESSm4txeGiwDtz2g6dw
         ErOzqZyaSGuJi2cU9aI/6aCA9CCb1Ux+s+Z+MB7T1EwW3NZRIW/eGLBtM3du1ljjFzHg
         YRkgwP+2Y9FYPf9jqno/JSWxFQxNBU/DGwDL4Uw7JOfX720dV3zUasjjRNlkRtLUURXo
         0iRh+yyWAiR/79J0huD9b6yVwYbc+h84GuBpy4ovviT1w6tvGJGIs3t2ghp2SFfnIQN8
         KwpQ==
X-Forwarded-Encrypted: i=1; AHgh+RqG4IUv/UEQRxs7NBLllNfeHrMvHtOMVle1qFrYZEguB2TOM3U/jQHsEpoXY91hGU2uEqVLE6vYcnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8Q8RuHvGYEgSwR8Yqcf71CTPIouhA6q+w52rDqOzwul5rabD
	YnqRtXNEdyDOz2vR6XDh/yyFE/5DaC8YaIyK6XcWFuFunEn85uTT1CQKSNX6v0xdIzgK6vt9B53
	abCCCF4CjzkctqqgGxSeP3M8Obw0iu/F/ySpYMr9HPQ2V8RDVoCGgnwtyG8rmk31rG/iOltOvIC
	jPUXsaPR2bA40A9bIu72x7iR0R04wAukiue+4n6Q==
X-Gm-Gg: AfdE7ckM3Aj7C8HrqK4xG/Ho+V9Zw87Rt/oOHltMj21XJ3NHN8yKhszBqE2RPzVLPwC
	v2Bitg6tPjj+mIE1aCfF+sMcWnU41MH44cyPQV6Fx8vktMtgw7w+18W5+BDXiHj+pWCGonL37Lx
	ppbNJyAykGGkSmqZGh4nSWQ+fNSoTbXIikGdyLyodVKe16SuaEWL9fOxwhq/uQf4dNErGTOchoo
	G5KNX8je/QucDLVG7AHzCbb+OcRTOjkl2Aj/sDLLNfiqnV1PqLXLgU6tB1CsgI4Wpo3lkBpEu4h
X-Received: by 2002:a05:620a:254f:b0:92e:7733:e398 with SMTP id af79cd13be357-92ef2c61899mr2368571385a.41.1784212892873;
        Thu, 16 Jul 2026 07:41:32 -0700 (PDT)
X-Received: by 2002:a05:620a:254f:b0:92e:7733:e398 with SMTP id
 af79cd13be357-92ef2c61899mr2368564085a.41.1784212892247; Thu, 16 Jul 2026
 07:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
 <20260710-monza-wireless-v3-9-46253587af64@oss.qualcomm.com> <6txwszoqlx5msqhspafk2t66hpdf67tfvc6qejeave3gg4fuby@rosphqguupiz>
In-Reply-To: <6txwszoqlx5msqhspafk2t66hpdf67tfvc6qejeave3gg4fuby@rosphqguupiz>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 16:41:20 +0200
X-Gm-Features: AUfX_myENjJrfTQJZMSC_KpPtznIhruyFgPIX7MpMY0JW25MDOTnZMlXQyQrAw4
Message-ID: <CAFEp6-07-6wzV7c-8mLDCkfVhgwVQ59BdTGvaXovu5PUGBCDZg@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] dt-bindings: connector: pcie-m2-e: Add vendor
 LGA connector compatible
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=PsejqQM3 c=1 sm=1 tr=0 ts=6a58ed9d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Kcl6yQRxnNA2GZFW2kQA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: cz98-k8PGI-v6Cu7gFu0XWLYMFOwRSUy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE1MCBTYWx0ZWRfX+hGpfcUiXF/Y
 fl5S9Kv48CyIgrPF5MrBQsEIe1syqJjY6yllVP/HbtHIlYQH1H1Og5G4XTpR6nONS29hnDYNyD9
 RW5On/V5Sv+6hvFUjk95DLw/G4C7BxY=
X-Proofpoint-ORIG-GUID: cz98-k8PGI-v6Cu7gFu0XWLYMFOwRSUy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE1MCBTYWx0ZWRfX4gP25D42inLc
 K5MFPOKIEwfFF+Vu6u0a7D1yUFZBi+4RAE/T6a7PyqbHViO7l7AOf42XSDof8107ck59icpz2Xf
 l+/ShahIPE0akb56Yob9NvZ2H/fnGJibVW7us3XazMhjtCr0UwDdzZp1+i7bDtA8Lk/9tKMNMMT
 CQ3T2nFEoAwW3GCYqaET8oeDXKgxNf8Ba0Oxqz21iOf95rx+7iRIElVi2VlyGPks2szEQAKTd9K
 Fm3LaAK72J18duBaFqpM3uNerDLcwcHl7OGnNaPqXmnW3tFT/uhR4TlD0WwFptaeHA87kl2GlkH
 Itjyh9SUjQm+OY1CmsG5m+ozTq1KBGbAI+g/tgsAbedlPTKK10jBx5G6WAUvrAGSYlXfWW5slRf
 CVkEk41OSH1BpRMuXeBV7OYjRd7CbNbKDXBU46SqFwILjAQPBw8eXhuIwD1Skgd0a3hpfzKMPC+
 /1Zx6aiwX8f2GLJfF/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160150

On Thu, Jul 16, 2026 at 4:30=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Fri, Jul 10, 2026 at 11:57:35AM +0200, Loic Poulain wrote:
> > Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
> > Key E interface signals but are physically soldered as an LGA package
> > rather than plugged into a real M.2 Key E connector socket. Such design=
s
> > are not actual M.2 Key E connectors, so describe them with a dedicated
> > vendor-specific compatible while keeping "pcie-m2-e-connector" as a
> > fallback for the shared signal semantics.
> >
> > Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 module.
> >
>
> Could you please also add "qcom,pcie-m2-1620-lga-connector"? It is
> functionally compatible with the Key E connector. Otherwise, I have to wa=
it for
> this series to get merged and send one more patch to add this compatible =
:)

Sure.

>
> - Mani
>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/connector/pcie-m2-e-connector.yaml         | 7=
 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-conn=
ector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connecto=
r.yaml
> > index f7859aa9b63469cb43919c0b5719c18694c5364d..0282c6ee9272446064a99ec=
6314a5ceb1721e0c4 100644
> > --- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.y=
aml
> > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.y=
aml
> > @@ -17,7 +17,12 @@ description:
> >
> >  properties:
> >    compatible:
> > -    const: pcie-m2-e-connector
> > +    oneOf:
> > +      - const: pcie-m2-e-connector
> > +      - items:
> > +          - enum:
> > +              - qcom,pcie-m2-1418-lga-connector
> > +          - const: pcie-m2-e-connector
> >
> >    vpcie3v3-supply:
> >      description: A phandle to the regulator for 3.3v supply.
> >
> > --
> > 2.34.1
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
