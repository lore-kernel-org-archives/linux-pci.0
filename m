Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C03A3D411A
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486274; cv=none; b=TVg6L42skRtW7F1VrMauCnWWiR3iDWhCkrtUubWd5dbkl2JGOMVysJQUEdTXF7ncBA9wy78vfFU9FEQOXO0uu5euBfz+6k0imin/fvPBB8zD9jyHZanDAhDWtB77j9HvEo5PFJxuC9uOlLuR/VCgxK2abtR6aXewlvhzbMMsM9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486274; c=relaxed/simple;
	bh=XQHWU4Sfz1Ec70VbB2iTXlINqT/lml/fJx8mYlhLP18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVGaW4NluS8zFCVntZyhrD8STumvdCVOh62WBP81uQSL6W86lIPlINFef8tPF3qMH/rUx2nxFvkfcJvV+WZhxpfP3dmRYdsA7DX0dCNAsoP0mqgM4YLJHQE75RpN1Uq4FgECdHwPxDeCFSLwz0SxQhR7wa5xPiH92Yk8K2ruOS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bQ0dltdB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=abmKQJi8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bQ0dltdB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="abmKQJi8"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V7vUk2393539
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 08:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vit+XptqPqCCnxhnywKX7IwS
	S7nXFK9HQm7gueLuEL4=; b=bQ0dltdBamKNK3T3QpavxRkpXeIn6V5eandPz93V
	/wqQPhDDFSoL2fyZRMy/3uZJwD0D0djNZwWjziXvfbRp6HMjZJDE/B5PanHvIJSB
	rhlCedDYXJ64AGRefUmijq2PG8VxwYEpx5up7v45axWVnkZkdtd7ux/WadtPBWjS
	7cQ/N2vhUeRYUczh17QvQh/gHbzzzosRYXtKFx0uXWWdWIGrROw33Q4TBqzTPTo4
	iB/0t/BWBRI2gMvGYXW2YheJA3n2qkSbv6I9yXaCaLLbA6nWI8A8HKi04ATS+rLM
	jxTOTVgs3AxlTRlGJZQWLnxFO+p1WwK9Pdb8mV4/ASdYCw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frq6dr76v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 08:24:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1d7886cdso12286531cf.1
        for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785486264; x=1786091064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vit+XptqPqCCnxhnywKX7IwSS7nXFK9HQm7gueLuEL4=;
        b=abmKQJi8vv6brmNSj7wIt9EKBm4vLsZMByvavqAee01BltWrZWIXCWZLb/xZOjXJjv
         oPBGnaKi29u6M2Eq6WPUcLvjtmKQdmwJIIyQVU9BpfBnBVpr23oohFwQptrGJ3u53JIL
         EOMiFA2t90o7ljLZCo0qPU96lrjCkmYpm1aokKG+FLOZhvtOSMt8YH2qKMcVLPz3UQcU
         nPiyMWEay2TSfdo0zqhIlv5SpFkEIun+MY3gg2DPBkUUYzXO7o9TfuoGz+iH5dvFOY4e
         tWqAc9Pdr9brfLsTG2ikdV25D+3zzFVQx+mejB/2bzmuTQN0K2+Yz/zpXp7OgeCWDiWr
         Da9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785486264; x=1786091064;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vit+XptqPqCCnxhnywKX7IwSS7nXFK9HQm7gueLuEL4=;
        b=aGNbgaMyR8+xk/ISSN9yDADnmIglrsmAlMXk5Ce3wnlGS63nRgBExeupPbyguWLP7+
         DnitrYduwJ1/uBQQ1vn+L/KMwOv4mZQGyMUhkmnx92yIta8/NX6xUnjMVyH+OemD6yh4
         3ItTyAQFFGd4UqtjUVZgslxtSOm9nhCfMIccLgwOZcoQ2tfJ9rMej0Eha/7rQqr6sLix
         bn5dKw7w8WYyQM57hVVODDF3kZy/o9/rvHBzjTbSUMu6ibJhWVEecIXzjBcJsqygvEnc
         lQHKakI+XpBIn+P1tTtSZRwn9YdDL5CvXWWNRG2Xv3MjSKo3HgHGojNnA15DILiO7/3w
         +sBg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0fsbIL7HWOIn8qkU28fg1iJfilYllf+tDVVcCF2qds5Q9Vt3/djRlf1E0LYt5iRVNJDHadc78lLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kc2nSRh0bcM3qTmlCPFUdXKAbCJRJQQCPFWh6ZoLT8zRs/NU
	qH1JByA5eXgi/VqL/4c5RYGEu1VczNB1B8kp60fJLy/j1Dlvsjo1se6f53TU9QBxP012IeWJM0V
	yPmjoPEw4LP1WZICtRt9P/16xe59FbmQqcaaPPGC0nLnbwbA4R00EjtcPYXpHBos=
X-Gm-Gg: AR+sD13jLxinU1A51od60dJIeniiJlmf9yyWUmZz+71amq3V491Sm5Td/r4V208Wjel
	b2T9/EE7VDO5na2RA+QoxkENdTA48wT8NDO1mP/C42yLr2RrEsEirJPsCDGi0ZrdEkiDtACxA7w
	tVA1u1/dU66O65NA8yc/w/zcJ8+ft95v4peg29sxLxkreBbMA3NymGDf8agZyudKdeWaoNyYFNg
	Jsu4OaOz7JAjpg1kb8cuiERW/cQ2y62UUQUF2LdjvkwTdz26sdRpHjtuEeyAdUkScpAlPkUxt+5
	KqpqY9D6rIhuwCV+d3Fs+sIfS/llG5vkOVA5tcF1aQvwDpht0DF4TTbzkWSm9oVmHwM55Z7H/PM
	rbXTyC/IUhD7gDuA=
X-Received: by 2002:ac8:59c2:0:b0:51c:a8e2:57a3 with SMTP id d75a77b69052e-52b4afc08d5mr12936801cf.28.1785486264486;
        Fri, 31 Jul 2026 01:24:24 -0700 (PDT)
X-Received: by 2002:ac8:59c2:0:b0:51c:a8e2:57a3 with SMTP id d75a77b69052e-52b4afc08d5mr12936381cf.28.1785486263923;
        Fri, 31 Jul 2026 01:24:23 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.163.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0d7csm1963043f8f.35.2026.07.31.01.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 01:24:22 -0700 (PDT)
Date: Fri, 31 Jul 2026 11:24:21 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v7 2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E
 key connector
Message-ID: <azz6axjfllmfdsxu46swm6yjxnhg6f6tpxhxjf7byryxw47vq7@wmmorb2kuerd>
References: <20260730-eliza_evk-v7-0-7ac7b66a3e6d@oss.qualcomm.com>
 <20260730-eliza_evk-v7-2-7ac7b66a3e6d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730-eliza_evk-v7-2-7ac7b66a3e6d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=CLIamxrD c=1 sm=1 tr=0 ts=6a6c5bb9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=6dw9+iwJWV8PcCi9M4lOBg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=adJbRHicXYsKkr84VsUA:9 a=CjuIK1q_8ugA:10
 a=zgiPjhLxNE0A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA1OSBTYWx0ZWRfX3BQFem61aDid
 XFm6SvOhm5y1+X92I+ftC3j7kSGqlI9ktaupgPEe5FJNJtT5pFuyLUnDe1KSJ9vKZj5BXp0uE6A
 qRZyEDloTfrGaMcsFciVhplfDodgul1cHDbnNBTGcldt8L6qzmXPZPBVx5U+pBu0Lz8wL/R4+Lw
 mlhdLYXawEiIUX29jLf4GMt5hX7EOhPw0YG0XOZHVEz7LvuPEgPbxvsas/FR0gf0P8I5XpY16FP
 Ws4SkUcDNaTCI9u4kG2UMFThJx1BErxtEXJm/i00c4YwdcVTY3+Rz5Xg2itXR9fqFRQ50vPStZJ
 UDO7drolU5nsr6zl9QPuaTb8CBmlXvbO/urCzIY4RmU01Ct+W6fyDvSEIOJkJQ8f9tNH6CFpcvl
 /drQf4ib5uCcwx4XZ4uy8lmzSqIoMEbXjfN4sS0x2P0qOzKBNm3XizBeUHjUwOh4Xmxdvc08vso
 7dz15i65CYxBNry+u3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA1OSBTYWx0ZWRfXw04f+Pp2WpCO
 TIF+mSNByb9K49jxgp9Fzk1FDku/kwej5s4aD56YIuKINksx0bseq4aFFnoRAYC1QLSeOhqoTey
 6DSDry55VBUNx/HDaeUJ+aA6yZ39qAk=
X-Proofpoint-ORIG-GUID: _pMf6H8Wj3-9WCwNXkhv66RWrvIQKgMc
X-Proofpoint-GUID: _pMf6H8Wj3-9WCwNXkhv66RWrvIQKgMc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310059

On 26-07-30 17:30:17, Krishna Chaitanya Chundru wrote:
> The Eliza EVK board features an M.2 E key connector connected to PCIe0.
> Enable the PCIe0 root port and its QMP PHY with the necessary RPMH
> regulator supplies. The M.2 slot's 3.3V supply rail is GPIO-controlled
> via a TCA9538 I/O expander on I2C4.
> 
> The M.2 E key slot hosts a WLAN card connected over PCIe and a Bluetooth
> device connected over UART. Model the connector using the
> pcie-m2-e-connector binding, wiring the PCIe root port and UART5 for
> the respective interfaces.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
