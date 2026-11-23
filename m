Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447940;
	b=AyxtpgBueuzVDrVlkk1d5bF8sQe9qaH9CkxreMLZLhoqTF60mDrQjIxVIWF5hlIQqe92
	 JEx6RV8wAOIroIQcvOOOPEchtcw8DugScm7EhhYFuC3FXsGi+SkckXa0SKwrlN+gxZmED
	 /1e8EAwq/2s20bUeUMROCp5RQURmtaksJiEzBVZbbdtO/ozZis3WVaeX/+fxFXUypmz3R
	 bYAT4jIGE/UxZHjYIqWdQwdQzfMukGF3JunMElSigz95LBoKPWf7Coq8PceVQukEjnDAy
	 bz2GLO0vsBzQMrt4k77qOHEdFwtVyXdDer44wY4y6QQdQ3kSra0m0T6wkO/ZVc3SlUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447940;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+cg+HLLf1GgThk3qa/fLNtMDnlxrXIqtYEA8DMiby0g=;
	b=10Hsa3SlbDhACACbgJ8ON5jhMS1fdUXoyt1RcFNu/rlE+lyc+NC4QBEYMq4SchSC6oGg
	 dcdreDcQMz+1RX0Em8flN6Ijm5rDpNig2O3POYptnS6mJ5wOQf13x+uKLQu/bDvkHM5Lu
	 Ji16IGul0kGJQmVeJlkHhmKjKtLlWrsnT/1RC4Z7pG7UYA47Vv5CHd72Dy9kqdHAXlPSD
	 Hy2KG4JWXUFR19uFlCzO7+sxFIKr0rYawrShvkyM+GT/pc96vIJFjLK8EOr/bWhlTbNrd
	 5rSHc7YBxizo2xFbXnnGJ6BY3d8W8zl9tQByLnEtqkn5G+EgW5OXv7Kn1OHrJgvQn+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XNi3fIG8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MTYpjMD2;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B5F606A336
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 15:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36B5F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XNi3fIG8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MTYpjMD2
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDL1Fd1937831
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 15:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+cg+HLLf1GgThk3qa/fLNtMDnlxrXIqtYEA8DMiby0g=; b=XNi3fIG8bLeWMU+f
	PwdUtzFy62pJN3m/uGsa6NfdR7ouMm5LiYtfaTNBKNdEfLs2s6R1cStk/RtofF4x
	SxsjBrl8EMJQUyf9IbdVp1Kkf3Ov/9iMVU+qYILRHQ80s/FTqKbeAsCdcCIifPYm
	qQguOivaL4NEWgFe/ZZDj9CPwEVNJVVlZIKbYGV5HOdLSWGOnNn4ayu09OWHKM5A
	pLK2Rue2VTs11R8os2eWmHiavQxvSD1MSHOLPNMkcUdndOq3w/AVWm/RhpR3RtwE
	1hpChhkUrek4n3LkgToNrUj3GFMofKy2/YGBck3DD8J/sT2qDTMkRM36+YjhmM+J
	t2o3Vg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4exx2a2e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 15:32:19 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3838b531addso313851eec.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 07:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795447939; x=1796052739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+cg+HLLf1GgThk3qa/fLNtMDnlxrXIqtYEA8DMiby0g=;
        b=MTYpjMD2QQBERPaZLcFvcdi3HK+YRFTwD9VXKk/QbPGtMqSoqvh9xHYlFJw9y+SYgD
         +eIr+FTPq9bnLRWRc6pV6F31+MBgbxhw/abckQ1JNU7oQPCaDfD/8McVVN55NXs7U+aX
         NZdNCZo0kobdV2WtjPMtE3HpBVwr9c3C0IbKXCIW4XVd8spmxk/f1Sh1egVhReB287Cj
         eXBQ8usEWhZ0Ic3avurBUPlt3g87pBe0pImO445Hp4gGCMlD+d7ifyH9sHxNSGx43SvK
         bsHxZkcoUURDDoG/Po/jZixHSThhYGzDc6MRKLBP3eTkFiCrnMXds0Uc83HM3ojtOHA6
         oR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447939; x=1796052739;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+cg+HLLf1GgThk3qa/fLNtMDnlxrXIqtYEA8DMiby0g=;
        b=w2zFLIOq0NMclfPPKSitZrcvPiBu1obSHTOkB/WIVdHN/Zl3ozFvCDXgsDkskelGKJ
         lza2BC8GMeldjBQJ+QdN/1wr4FCYsxRiFatTZYIGKBdDgyCm3th6PL5Suyjh9SoryqnQ
         9mMJZ+bv3Wta0qZ6xNFHSAPpka3RsyKOxvRoON0Q6GkipcchMQTw8PDPeR5SuFpVj+oD
         doNpR3sKRhQKSn//CvENgs9IyPM//VKRyvGD260ddXP/U/C501MxrIFtHwhxX8TsXZo6
         Wuo+zbWc43mhqC+oeTpiaTAGilQz9iaMk/+BDILJcmeDUaOAaoICnqepdJQse9yR81j6
         9HcA==
X-Gm-Message-State: APuU4Z84aYYKP67u5YGgJDcfk88KUJSeKD28fCORJWId4CDgjj1Vstn1
	CzFm20d5W+f3XuXqt+mlMImdtJXMjwmHtiuL1JODelMp/lrMRs7uyJ0X8PL5zyY+9rizn2sJI4T
	Uy1eG0UBo5suNxBMkQHIyEmmhWFXQFX233FbuJkbjd+ucmQrH3I3qnRpqxIBd9YY=
X-Gm-Gg: AZFdTZcQiDM3zTVuuwtjJC/zNF0L2DkFtawXWYWcJ4YNkYDH9RZYOt48P7G30xKRBXs
	W2TAMEq3igtKtHK6qDWiV7NTLs/LyXwgox6Y8DsmeKKOVBRiHY4g4t75kIKC40XcoxxunVGYsgA
	7+LvRipbhpd+UmfHl/tb3WTW/RRQXWs9+8K/NDBO9dik4lc+Qq3TvNbpafX3KiTjbX5Z3dU0oM9
	AeScF+2pKKIuFZ8imSQmmUcXYjL+xraobfe40gRVBU7joOG1YMXZj1CO61AjdQCrbcg0iNVU6s8
	DuS7Z+Co3EfDT8YTTUMMZh3Ao+Hud6PCvX8nmPYO64KPNLg7n1lIHmTqYpLO/dkH4QuWkLWIWxp
	u5SJcdrL2Utb82QUZ2GqwbzImNCxhPMlWkC+n1MSPaVCvADTfnxZ+niklLK61uDGwfux90+M=
X-Received: by 2002:a05:7300:6025:b0:384:cea9:a109 with SMTP id 5a478bee46e88-3856925debfmr19458787eec.0.1795447938639;
        Mon, 23 Nov 2026 07:32:18 -0800 (PST)
X-Received: by 2002:a05:7300:6025:b0:384:cea9:a109 with SMTP id 5a478bee46e88-3856925debfmr19458731eec.0.1795447938084;
        Mon, 23 Nov 2026 07:32:18 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370cbb80sm5516406a12.9.2026.11.23.07.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 07:32:17 -0800 (PST)
Message-ID: <b777e26d-98a1-4cef-96f6-cdab7918a1cc@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 16:32:13 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] wifi: ath12k: Add support for MHI bandwidth
 scaling
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com
References: <20261119-bwscale-v6-0-9a9a715fcb46@oss.qualcomm.com>
 <20261119-bwscale-v6-6-9a9a715fcb46@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261119-bwscale-v6-6-9a9a715fcb46@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FKKOVOos c=1 sm=1 tr=0 ts=6b045c83 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EZJCw1MXRrN0MplZF-sA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: kinBRQptyoPw-NwI4Eak3OcQsAGtIHdF
X-Proofpoint-GUID: kinBRQptyoPw-NwI4Eak3OcQsAGtIHdF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2MSBTYWx0ZWRfX1A3RQk/W3LB/
 5d4VEXby7MizmMZc3QZ3xI4wvW1ic5zSmP300ZxXJ6EIbu3xX9OB2nhmN6xZA048CAYl8Kqyjae
 MoNm1E3UuswvmiGnCRBl07qoxDlC/EA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2MSBTYWx0ZWRfX3coomBDH9g0J
 X5jPk8h1XiT9I2wqCJRvMpbcGtLfwKajfVZbsVZuDEIqxnCRVRYE/zSbbJqw1jByfOoosePfFNo
 RIalNjiGwQ35W3b53u/LUb2XUNlH0d0QSiopRptCZGDAh+3RjioYmEhNIJJTZo44m6m8hYXZeu9
 TdpdvQsNhahITUKYuWOTzjKja9gx6wrd+LoqOr8NZrGEts3nyyEcWY/rkTRA0To3GWP2XQmQISK
 5Cu8nCp1KD+7e+6JLa9cSwn0dF/lbVqEFpTUYJyDu03fo/QZJ7TjDE8W8gNyKtHa0jJBpvZhWYR
 QxYht+Iy5SXuvWsL4O4iVTseHJVOip954JoQHnWtLc6ocus9+tUGTetW7Z7sAD3DxJvSPmNtMKo
 xbj2J5K5GrQdtUxrKVg5e9H5ZFDhLmNlV4g7kAikdNEY8P7dpPum9wwDaVMEoj/P0y5Z13dNoo6
 K329b9rmoZzfuCjPSLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230061

On 11/19/26 1:56 PM, Krishna Chaitanya Chundru wrote:
> Add support for MHI bandwidth scaling, which reduces power consumption
> if WLAN operates with lower bandwidth. This is only enabled for WCN7850.

Curiosity, not necessarily a blocker - do other ath12k chips also support
it?

Konrad
