Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B943F99DB
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332976; cv=none; b=dl1GimferrNcNrKRhyj9xvVmKgiOqBzBLZ5RyPfCR/zgpIK57J3E/wzFbqweRSf5q5c2Cn4NYmNxte7GDsPm9wmRxmauvQP/pN+JCTf5vx9zelfAG08YMkEELH/UWQW2QgMW6eT4yEDhjtPvlm0ARrfZpKOfCqn4mK/Dmd7AOa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332976; c=relaxed/simple;
	bh=vDJh9D+J/f126swwFBr0k9vo1Zcg9E6qqLIgFAnXEyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dr5WvRN0ZD6pGB48Yc4bdgMJu8STjGKri5JUM2McQ3czJAje22s3bnhCt086SY7on/ovFiCgvXoFI8vqyTwDh6kFEkVL2oXHGD2zmPjRjlU8VxeLiHsaP2IU66fVZvBpyNtJ3Zg+yVOC8K4Mx+fm/FPgwnoUao2QG8omBfZI6H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pudbPVFV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XsllUISW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pudbPVFV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XsllUISW"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C9kguf4132843
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 16:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z1pAuYDK8sre9nhu6GxcwknUeONHyMaKI9ugJiqJNXA=; b=pudbPVFV0/hXzm3n
	JNYF1RDINA8xCAOMBHUbxF5PHAqERkuY8xxN260r+gJl+cswCNtAUkHrnuQnjq9g
	rLWy+pqXcZctLV+VcBy1jcdzaRHlsod8TBMC9v715Kn58+Fk1QCTd48YdMy99dY1
	BtY7DET58QNbUF28ixDJ/zXtLCE9CvFrmy0x0sz8V5ZhitvwREyTapjbJ1UGidrs
	YHQf64blDjaL7d7nVUwg1SD0XWb4bsB0g4InLoc+NeDvpS4tz9g6qGrXZt3jNITk
	MawKJ7mCIiSPAPNjs/YWSP2CoO5ANKLsFjL2Rxrr+hpuniBaqttnyJblebhNuTeB
	wVt5Xg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh4w2taw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 16:29:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd85e08fddso1173263385a.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 09:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773332969; x=1773937769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z1pAuYDK8sre9nhu6GxcwknUeONHyMaKI9ugJiqJNXA=;
        b=XsllUISWoxrc+oDpkl3nOVYL46NVxCmKFXf4QfGCj0+9mTZCey0jxnhrSaYyozCV2h
         qmk14t5xCSqQTo9mnPTpeRdXavc8uPTzl6Po38QvlZh6gPv+CVUDnIUUKOA6mBydZ1go
         QSOjUX0iMThIdM1rQxlkKQzbpzYCYBWpIdUCnhoXG86s4ukWBM3z4Gdw1wqjKntYq0dO
         LYslgeyf1GWPiQ37FkuvXlE5ONAzmoRywRJhNHj0hQsw1XHDansc/IZd97F0cN008tvo
         KMqxWJVPGtRECgqRB2a393G02YzGtmnXz7X67lndsna6czP3bPyzNFKuo+TZ0VhcKY34
         3p/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773332969; x=1773937769;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1pAuYDK8sre9nhu6GxcwknUeONHyMaKI9ugJiqJNXA=;
        b=izc6BjzJduBmFnLV0dYr2tvMNREUHgY/aigaiZM8F+VgryrsSoA+eS20tp9boJEggB
         A78q8xYa6HoWUVMzLgTwksxNsJbGAxzLza2alxhMayzEK1GIWoI8AcfnoHLB36Gzghbz
         fUcYHDDmTbp2aIOlhZyASNdwlFYI6jrvlGUw5Df61G6cyKCdjLc3WXzYjVadmAjy1gjW
         pAdzSoyXo7rKvdPepkKS7dcc9ShB989RpsidnyVNRaQTE57YRsDIXGEl+xXBsU6kwxWG
         2fAv9wODWKN4PPZqj7TaFnzV+7+5DwmIGDVDcNuksJpqKCN6GEt7/j0fdsgKuszh/LQy
         k1wA==
X-Forwarded-Encrypted: i=1; AJvYcCUiPKMNNgr+Zz/zvRrcHbinX8BIl6JqC2LRqdhAEL6puPvTdB5Q3/xsZ9hXCh+Aaq0uD5AzZibBPnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQNGXUsMiBgBNsfou5ykf4UponMOeWc7xGmJYisACYfo6ypRhx
	AENAW9ddzeHn41Vihx/b6SPBtNO808y+o/vb+Z4Dh5PV5g43C9GdCX3bRR0nhjfCit5A4GMiJnz
	N/NZC4VnBD+3/mdAKzzLBJj9mcD2OV4qpYZZUjz+IfQpmFbi+et14zON38+ns4jY=
X-Gm-Gg: ATEYQzzvi3x52wa7Spn2s3Xib5I4gDeHmjg2tTrCa0vvPcopTEU9Sucddgcxx5z1Gk3
	CE4/caG6SZfQAEU0xUHSLu9uOm7rqSozqHMcSIgYW/KCVi6QA6AjhFGtwaI8gpgj6Aup0zlvnw4
	JSxDfSFsOovtGfXp9qFfOfa6k48H9pjxmboNftcn5aLVmX/pTASQEQqbpWEIWS9ypH6IFQC7iV/
	hdatWBGry8CZsGZb/pQTtub9WLrYBifNkuGbDKQbgcfPjiMD8qKrzeGd/6bIplWqeH0PExG7MD2
	dFgAutIDNBmvO3Gy2kI4HEbygs56qUtof/q5z8SXLXjgBf2xn6ib6i7BiAzuV5qIwtwB6lPOjVB
	vfm1sOgtVOSFd2Mk1lZGBe9uJkeTHpGRzEH5bq0rf3nTToSsh
X-Received: by 2002:a05:620a:2981:b0:8cd:98c1:762e with SMTP id af79cd13be357-8cdb5bb0b34mr40580885a.63.1773332969176;
        Thu, 12 Mar 2026 09:29:29 -0700 (PDT)
X-Received: by 2002:a05:620a:2981:b0:8cd:98c1:762e with SMTP id af79cd13be357-8cdb5bb0b34mr40575185a.63.1773332968636;
        Thu, 12 Mar 2026 09:29:28 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe23afc5sm10571864f8f.39.2026.03.12.09.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 09:29:27 -0700 (PDT)
Message-ID: <800fc82c-1b2f-4330-9a25-e1d067dc83ac@oss.qualcomm.com>
Date: Thu, 12 Mar 2026 17:29:25 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Switch to
 undeprecated reset-gpios
To: Sherry Sun <sherry.sun@nxp.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>
References: <20260311154955.145120-3-krzysztof.kozlowski@oss.qualcomm.com>
 <VI0PR04MB12114361EE728C74CEE500FED9244A@VI0PR04MB12114.eurprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTpLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQG9zcy5xdWFsY29tbS5jb20+wsGXBBMB
 CgBBFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmkknB4CGwMFCRaWdJoFCwkIBwICIgIGFQoJ
 CAsCBBYCAwECHgcCF4AACgkQG5NDfTtBYpuCRw/+J19mfHuaPt205FXRSpogs/WWdheqNZ2s
 i50LIK7OJmBQ8+17LTCOV8MYgFTDRdWdM5PF2OafmVd7CT/K4B3pPfacHATtOqQFHYeHrGPf
 2+4QxUyHIfx+Wp4GixnqpbXc76nTDv+rX8EbAB7e+9X35oKSJf/YhLFjGOD1Nl/s1WwHTJtQ
 a2XSXZ2T9HXa+nKMQfaiQI4WoFXjSt+tsAFXAuq1SLarpct4h52z4Zk//ET6Xs0zCWXm9HEz
 v4WR/Q7sycHeCGwm2p4thRak/B7yDPFOlZAQNdwBsnCkoFE1qLXI8ZgoWNd4TlcjG9UJSwru
 s1WTQVprOBYdxPkvUOlaXYjDo2QsSaMilJioyJkrniJnc7sdzcfkwfdWSnC+2DbHd4wxrRtW
 kajTc7OnJEiM78U3/GfvXgxCwYV297yClzkUIWqVpY2HYLBgkI89ntnN95ePyTnLSQ8WIZJk
 ug0/WZfTmCxX0SMxfCYt36QwlWsImHpArS6xjTvUwUNTUYN6XxYZuYBmJQF9eLERK2z3KUeY
 2Ku5ZTm5axvlraM0VhUn8yv7G5Pciv7oGXJxrA6k4P9CAvHYeJSTXYnrLr/Kabn+6rc0my/l
 RMq9GeEUL3LbIUadL78yAtpf7HpNavYkVureuFD8xK8HntEHySnf7s2L28+kDbnDi27WR5kn
 u/POwU0EVUNcNAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDy
 fv4dEKuCqeh0hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOG
 mLPRIBkXHqJYoHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6
 H79LIsiYqf92H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4ar
 gt4e+jum3NwtyupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8
 nO2N5OsFJOcd5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFF
 knCmLpowhct95ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz
 7fMkcaZU+ok/+HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgN
 yxBZepj41oVqFPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMi
 p+12jgw4mGjy5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYC
 GwwWIQSb0H4ODFH41ZZ3t1Qbk0N9O0FimwUCaBdQXwUJFpZbKgAKCRAbk0N9O0Fim07TD/92
 Vcmzn/jaEBcqyT48ODfDIQVvg2nIDW+qbHtJ8DOT0d/qVbBTU7oBuo0xuHo+MTBp0pSTWbTh
 LsSN1AuyP8wFKChC0JPcwOZZRS0dl3lFgg+c+rdZUHjsa247r+7fvm2zGG1/u+33lBJgnAIH
 5lSCjhP4VXiGq5ngCxGRuBq+0jNCKyAOC/vq2cS/dgdXwmf2aL8G7QVREX7mSl0x+CjWyrpF
 c1D/9NV/zIWBG1NR1fFb+oeOVhRGubYfiS62htUQjGLK7qbTmrd715kH9Noww1U5HH7WQzeP
 t/SvC0RhQXNjXKBB+lwwM+XulFigmMF1KybRm7MNoLBrGDa3yGpAkHMkJ7NM4iSMdSxYAr60
 RtThnhKc2kLIzd8GqyBh0nGPIL+1ZVMBDXw1Eu0/Du0rWt1zAKXQYVAfBLCTmkOnPU0fjR7q
 VT41xdJ6KqQMNGQeV+0o9X91X6VBeK6Na3zt5y4eWkve65DRlk1aoeBmhAteioLZlXkqu0pZ
 v+PKIVf+zFKuh0At/TN/618e/QVlZPbMeNSp3S3ieMP9Q6y4gw5CfgiDRJ2K9g99m6Rvlx1q
 wom6QbU06ltbvJE2K9oKd9nPp1NrBfBdEhX8oOwdCLJXEq83vdtOEqE42RxfYta4P3by0BHp
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <VI0PR04MB12114361EE728C74CEE500FED9244A@VI0PR04MB12114.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UEzbWN7Kx3TnkIPdIwXQpw6XJv4lpfn5
X-Authority-Analysis: v=2.4 cv=Cpays34D c=1 sm=1 tr=0 ts=69b2e9ea cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=fcfTcuGm4GDwl_1-7aMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: UEzbWN7Kx3TnkIPdIwXQpw6XJv4lpfn5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDEzMyBTYWx0ZWRfX3iqCmVoChBfL
 jJK/WMsUjTm8q/L5ubEsHFxvfgtkQfcSiaZGWKRDBwqW+nKF+n/SFD4AtNi0DtvW8Yhitrq1fDu
 3TYGOTar1U+4tCAOAgdPzAurP6cI2eTugFTkIghjNtOB0JugWF8D5Ir76zc78qS8Eg2x+0oe0Is
 clDIbQi34TPln0zhvklAuww+FNcLUv3mz5TWfqJxYCOLyp6ok+3VUKrKG+LUUu4Sd3MlLrZsi3Q
 BFF5g7CgclLAUuxxpCiHQUiC8wfH9DcouodePUd3dwoDtnyWR8ahMLAHbeHOi7pzy9bFnT0KJy/
 tOlA8huHCYgpIVWrqd5fKU4EWHeDHAR8gP5nFyuRHMx699KGNiciNh7ql0gjsfLTxiYBccCg22y
 2R94pTTS65EU305ZeR4PEFulr/u+Qv79Sw6RRju9kmlGl16FsS0jmLOWdg2O9RTFn2VOXjNlmnO
 /xotprGy2WmLk3cQA5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120133

On 12/03/2026 10:18, Sherry Sun wrote:
>> Subject: [PATCH 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Switch to undeprecated
>> reset-gpios
>>
>> GPIOs with "gpio" suffix were long time ago deprecated, thus "reset-gpios" should
>> be used.  Linux kernel supports both, referenced schema snps,dw-pcie-
>> common.yaml lists both as well and this schema uses
>> unevaluatedProperties:false, thus change has no impact except code readability
>> and removing deprecated patterns.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
>> b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
>> index 12a01f7a5744..b9ba938c6239 100644
>> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
>> @@ -58,11 +58,6 @@ properties:
>>        - const: msi
>>        - const: dma
>>
>> -  reset-gpio:
>> -    description: Should specify the GPIO for controlling the PCI bus device
>> -      reset signal. It's not polarity aware and defaults to active-low reset
>> -      sequence (L=reset state, H=operation state) (optional required).
>> -
> 
> Add Dmitry and Bartosz.
> 
> Hi Krzysztof,
> Seems this property is still handled in gpiolib-of.c, see commit b8b80348c57b
> ("gpiolib: of: add polarity quirk for Freescale PCIe controller").
> Maybe need to change the quirk gpio_propname here too.

Oh, I missed that completely. Thanks for mentioning it.

1. Having this property in drivers/gpio/gpiolib-of.c means we should
keep it in the schema as deprecated, because each ABI should be documented.

2. I can drop reset-gpio-active-high from DTS as well, because
reset-gpios have proper flag.

3. We don't need to update gpiolib-of.c, because standard flag from
reset-gpios will be used.

> 
> 
>>    reset-gpio-active-high:
>>      description: If present then the reset sequence using the GPIO
>>        specified in the "reset-gpio" property is reversed (H=reset state,
> 
>  Also change the "reset-gpio" to "reset-gpios" in this description.
> 

Also here - no need to update, because this will be used only for
reset-gpio.


Best regards,
Krzysztof
