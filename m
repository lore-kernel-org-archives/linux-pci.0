Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E8641D64E
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433535; cv=none; b=a4Gmce7Kzv9R81TpdbeNolCRa++BuvNUmVv3D2t0NfSbHuD30k/Pongd8mPIt4fy5CGMdOUTLworfLH7eh8YKz81RFpxMNBiwkaNcisV3uFdEq34TQRELzapkWvDuVQOVnumflWiHMza71S6PrcdFK4tfwgIVJUq0wfQVitffDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433535; c=relaxed/simple;
	bh=/qJDC6cugKVjmjaFiZdIAgE0dBgEMsPvwp+P8zVZKFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDUR2sQTlqZGLZLiRx1BwL6PeE9DwhDWhOqAt+Aj849CLP9ZF7bcUVNc3KI0gGPwHF5539Iww+u8oZe2jVWYLrvTI7KjSuf6TMixrOJ1TsQu8KKlQP7q7/RTIke165V4rP5/PiPg7KJUtdJH1pwg0xgPRXrlysFvmfRs3Z7MnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VxaK/D9d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UKxrOknE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VxaK/D9d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UKxrOknE"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AH79I1328098
	for <linux-pci@vger.kernel.org>; Thu, 3 Sep 2026 11:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QHJgfTmB9a74tsOwrBzPpi9Z
	i24vB+4V/J7Jo+ncd8Y=; b=VxaK/D9d9ZLeFG4GKdKBa6I16OaErg5xO9KDaE+3
	XajvEu45mVJHmY0vHWUyec6/Xhg1O/jEUAmgHrJayuZBQUhocwNRpKuSBY0wJf5r
	cTYLMm0gC0TlWzdrGfk7oHqMA2aLWJwk4vVt16VcIAoAHWyxaK6cLkD2sswkVFSX
	aJ7ksiwGrd/FBcjgTyspUadfbViy/bCIMmSgL12azaioy71H/7zd8Ra47wwaAy4o
	54Z9PTGxc/PrekOdo6/1zPrRnWVyTkfH2foGispkM6hy2xohDt2XbhwF1CN8Pw2N
	YJOoDmBcXZSa6/1RGPhmnoYRoj7c+nMBq3Sh7tCxJrqPdA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrnmpg1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 11:05:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934956beec8so420088985a.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 04:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788433532; x=1789038332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QHJgfTmB9a74tsOwrBzPpi9Zi24vB+4V/J7Jo+ncd8Y=;
        b=UKxrOknEnPwATiFyBNDOgsXK6HnitjWkKEkIpsdATxmn3fM64eOlIBGuADmQtdLVkx
         2ZLWWPs7UQ1yh1dbr3+DHQVUUdrDLVN4nekprViTKG1cBH+ixAcnJOF+69U7lxz4Dwaw
         yx3tl0gUgtENBaWU3KcCckmPsq0AatiuZCh3a6ppydQDjk+1rKB9fqdys7uOR4dyQM2e
         Fc9gd+ogMSJt9jUlqzWCfSWRVmWomNcai7lMDXR9RbxvZV037ZfXeAx1OpJ1BUKXndFg
         YoCy1EHmhRQ+tNzDQ15wBhfX2bHa3J4x0GaNsnZ+gvI+JGtK0QJkQDqIuud0TBy4ky12
         WuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788433532; x=1789038332;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QHJgfTmB9a74tsOwrBzPpi9Zi24vB+4V/J7Jo+ncd8Y=;
        b=s/FyvI4yEFCiHwg0cXsHSzIszdzCdwwl92CaIwODb0hI2zpb29L3vFI4nA4Tbora3A
         eNxnaO7G8Q383GeWQhUWTlHpkYqwlL9bCs0CgAK0BTXz1hzl5GOUnP4mf/JiBOAkC1zU
         gYWOJyZter+svcyzgMMplmWSQ6QAveUNzNfU9DOP+NKkpZNAAIvQe7BD4hkbIJCa9VZM
         r/1b2R+I3/dD2+AMRwLnfsa+YHJugbxrJ7BNmFbC8lyOEJdUMNujwNVwpl8VLJphhFKA
         ruZn662ifJc+Nz7f14/O1FD2r/tUAbYgwE1cafFiPramPLykmwZ8DFf9DtquhgfOkiBw
         wIFg==
X-Forwarded-Encrypted: i=1; AKwUvByQqaukRBdpS1835qvXfu/jpWom9WnXVDd7EasmXJrq2OyMZiE/tJWfAf5csf9fUF11669emiASWXg=@vger.kernel.org
X-Gm-Message-State: AFuF++m8laSjRAlgAywpcvmMKM6B9FFwCFnaEpQKDQt3PgLOg4lj+Mxg
	msCtrJtY92HBwG/PDf+KduEVoqCfqFoyLgnT1gOvXDNmGT5VGLaMfYoZtM+c7bu3zNyMMd4E4SO
	ThxtXVnRNH3GqmvlYoU84mjlwdtgLjgHiCsgBUyiTvrq/FPJSauC3xZvub1zvNgY=
X-Gm-Gg: AYBFou0Ej19UcwT68Hb+zxSGpR7hRKbbT0hdAK94IQ2nX4D5Jg2hclBh4oI2IdgDGlv
	wQab0v6H7exTH7M/GotMTcZh7Sf0ikrjEJOMIEIpZxsm7mZdVXYu78hQg31IN9ETMqbsHn689A0
	jJ5iY7Bc/D4x6m8cMaz133MYYSN9DaT0cc4NvkBFZTGc1KHtJcSYgZV+hASv26+9Da7bt64i+tq
	sVHHFVno+GaY0Pcb9PDYkvksQ8K0uGo5M3Ybq151BauweKy8Y75Sg6+f4E1F3mu0ottUKiaZf2I
	p1Rc88VqzN7feVqo2qCQHhPWhS/k7phkWNVr5tswINWA9x0unnEKL8bPVOCcJz3+fk8tQTAUPkA
	XxJYI3YgB7mqfjA==
X-Received: by 2002:a05:620a:404e:b0:932:ddff:123d with SMTP id af79cd13be357-93960f796d6mr1350755285a.29.1788433532142;
        Thu, 03 Sep 2026 04:05:32 -0700 (PDT)
X-Received: by 2002:a05:620a:404e:b0:932:ddff:123d with SMTP id af79cd13be357-93960f796d6mr1350745985a.29.1788433531584;
        Thu, 03 Sep 2026 04:05:31 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5dec54sm74620175e9.12.2026.09.03.04.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:05:30 -0700 (PDT)
Date: Thu, 3 Sep 2026 14:05:28 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Michael Walle <mwalle@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: qcs6490-rb3gen2: enable TC9563
 embedded GPIO controller
Message-ID: <33t3reowiellyer7bc6ipp3n5jhchf5ozbj5imkctp7mcibkq4@w3jbhjet4w6z>
References: <20260901-pci-tc9563-aux-v1-0-dd9b80738e70@oss.qualcomm.com>
 <20260901-pci-tc9563-aux-v1-5-dd9b80738e70@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-pci-tc9563-aux-v1-5-dd9b80738e70@oss.qualcomm.com>
X-Proofpoint-GUID: D6M3jnp8oZh59Hor8raBw-Qly_UNg5kA
X-Proofpoint-ORIG-GUID: D6M3jnp8oZh59Hor8raBw-Qly_UNg5kA
X-Authority-Analysis: v=2.4 cv=YKuvDxGx c=1 sm=1 tr=0 ts=6a99547d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=q7XEBjOi5DRkXzmV0jSBjQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=fFHDuP4XVuiI0RsLl8oA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5NiBTYWx0ZWRfX2ZdvlTx0AI4E
 Zg+Brw9aZii4+gM/PITaqjIC+JmpG9ms5XxByRDkJ36EpJtEqM6sRIZCf0PRBnM/mN+qEZ36BFB
 wliu9qC1xyyF/6jvzIJYtsBuU30MvVEqEjXCK4+fsABAQi223OU8pSNkY5zkNB5WamcXMBMd+ZR
 gmHokmtraLDNZ0z8J4l4SvpZgVZTbeMvQOJuKFfQdoJinZ8aH5K5Q5/B1fFUDcAlkGyyR/Sq091
 r+H/AaCFqR9mSTVZ4qYAh5oUVyHcdebCGLx4AYbJr6rMfpWUDPC8IDicr/gn7FuvNvPunST+m9l
 rRttytQMZMZtd1WD86cIhUU12owbzcqXYdZpWLiEmG51fYWZwqAHMn6z4hVqko8WlDLmFRqkuhr
 gy1fXRAdMQBlLdB0PVbvAnFrV1H3KrDcHhlKnr7CpzaSaZC8n34w7Bo6oKmGALy7odC5QvsBK8I
 pWHDGvPj4MhhnYvto4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5NiBTYWx0ZWRfX9L0qyiRYb6eq
 IRcBfZYpBwqEkV2Efvj7npST0KtJD3ibk11lNo8wGOoEVD4iO2Gg0gOrx0KHTRzbXRLBYVEvy32
 8ulIubNNvXiNFzYgZau6kXEpnfQskWw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030096

On 26-09-01 12:27:57, Lorenzo Bianconi wrote:
> The Toshiba TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
> lines.
> The controller is registered as an auxiliary device by the TC9563 power
> controller and accessed through the same i2c device.
> Describe the controller as a "gpio" child node of the switch and use it
> to control the PERST# reset lines of the two external downstream ports
> (pcie@1,0 and pcie@2,0), as expected by the TC9563 power controller after
> switching to the GPIO descriptor API for per-port resets.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
