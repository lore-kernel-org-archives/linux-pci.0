Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302551;
	b=Ao+HQQaT/X/Ts6FDHfXh/YwH1pujbmgTk3MOYOITVEtKzZtl6IeOsxEiK+Zxa5PMqb1g
	 veWehPbzOGHLX3CQP44SWkQXi0K+iMW83UQBQYcfFAtujXEJnjKN7H54/4CJNpPw8eD39
	 a1CmIoJR5E1/EaoI75oj04BHN1bURbp/F+k+YFPWaIL3L2NnuswAEqrSgri0N2phZawCh
	 bnMcuJ/6eLZsNthW5IKdUzz1yQmTvKj0w51MsxvtlAjj99Zkfjc9HvVJxIAk2cajV/u7c
	 bhtuKkJOVtmKl1WTCJ97KPdy/lMLLh86uBufI2LXR4qGFT5c9N8bNLPQIB14zFzTxPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302551;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dyJLGnAN0Zs8RZGOGLmLqiW3HvWV8l2pKhgf9B011Ec=;
	b=qYbrziOWXrkE2BEa1fP7eYDoFqL/q9qNgOKyp4zsxq5L7K6lgwW6LEVlHIbt0AOLJvAf
	 wbcIAvs1/jTVt0RCljNU5J7/uRvxbF+92bhVBOHfWR9idXoZCfUBXmpcx/y/xM+HTLv88
	 dwXE8tHLNRhY0mQ3SMmnUOr8ErVP8dj6d+Wg+Vk3rXoh+b7sC0ZbmT6kfbh866TC56eWH
	 V79aMSDZGgXZzx5ptq5L1DDRw9U4Z1SnbUMe0jIgTxOeIFmmzl5iL3VVxhLqzgiL23akN
	 aLIQUT9rBR3zMxRnhLwCBEkKpnZ9HZbKNY/0nLYFg8X5K45jvXMU6VKu9PQFFwPXmFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="TEH/lf6z";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Icz1UF0o;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129AA606EEC6
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 09:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 129AA606EEC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TEH/lf6z;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Icz1UF0o
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA8ZKbv3850028
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 09:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dyJLGnAN0Zs8RZGOGLmLqiW3HvWV8l2pKhgf9B011Ec=; b=TEH/lf6ziK/UgIYd
	uc0AeWExH4ap+dhJha48zpFanrmUVquEziATbcTJvfSUXNvCTmGNORHwNU6BQEZR
	gq7Mw0UyQgIVlK3VIKAR9mCt5g7ay5aeJydPgyieZ3o2KzvXKDYbU/cwGfXtw2lc
	tODvs+qdhJ7XxoXfKAgBJcZCwZrlv8phRtO1/n5lSbvRDL06sUKUIPYKcavx1J9E
	mL41DhnIjwpXgrSTvkdHj3r1vWeXIW1jLgbY8s/cfE3H7dou+yb+k2rHLpwFEQ3q
	f263ZN8J3UJ4OZK3MSqsyYa5TOcLlFnYqwAwzumqX1v1r7GAcTp/LTdLflbndjsP
	YfAHiQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyvwg5vx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 09:22:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934963b2bc0so375293985a.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 01:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794302549; x=1794907349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dyJLGnAN0Zs8RZGOGLmLqiW3HvWV8l2pKhgf9B011Ec=;
        b=Icz1UF0oRH3yKlXDYLA4Jjllfgq8a4kz+nRwPkVVcQVE+rnFYEFPDPOkBXaOkoWd1m
         GfdtjYbVJjGlzytbPG793LOVIdw9HLoHAXQBeExxR9hJWMuGc8fnO7b9wbJO8HNtxqMN
         XQ3S6RsqWq+TeWwly8paPEzfPn8GcSniBUmbxTQFvnqI+P4SmqNebUonfE33CmThTSCT
         mUk9E4gYbhmkRRRhGB8uLtGZuG/wjWObJD9/JptvYC9Wy2fV4Nkjy/4DFEwDzEUz3E7B
         AGJZNPh2rsTnWwpGQ2ULqvF5cvwxJraMeQ5OWBGkaF9U/vVZP9lDwIdmjlFvGkA3sgIi
         mj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794302549; x=1794907349;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dyJLGnAN0Zs8RZGOGLmLqiW3HvWV8l2pKhgf9B011Ec=;
        b=0CZeyaKAgjZKVAq3412QSh5wYy0Kqp1OjfC/2C7urKg0Cv3c6Y3+/js+A1anv5lN+/
         HK326Ly/v8E+dKqaND5RxX+t6AMaGNYAc1vvZPIXnvqwSxmErk/8ItDndCzUEuPU/jor
         WhIiDoiRqQVMogU5zN0TzTGFQwWfWlXcsbPODGhBJRmV7K7jX69yPwY90wjYE3GEIAsm
         s6S9NP1gBLZwskhqQ0EwQmv5itdAzZhi/y/qNKQNwSUd858noo99P2KowW4lVleKNCOS
         Ww9/+wPK+MxwyyjislE0wJZLRPwQcmTy5BvGT4FzwICpvKr55877xZrthH5NuO3bnG97
         4GSA==
X-Forwarded-Encrypted: i=1; AL+hErEVu1uHcQC76lp9/f7tH26UeuTYFPUaLENbBWlT2ht6EnfeTmcoNDfKJbTdkuz7o+w02MVniTCx/Ts=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VLvNOiJYWjf4U6C0BLfIhNRA8ULgLsFGxTS+vdpx7Iznbf6PK
	WCjevdd6PIHc5LrM//SSpqjveEWNjVDwxCApeKRaC6wvxhK+TA/9D5zhQGUnt6GGkQN+hdJM0OR
	Fi6m7WDr7Lq9MTnR8rNS+prTZio2Bxb7Rs9Y5DpfC59UK930sXYK3uHjQ9ffyBMQ=
X-Gm-Gg: AYBFou1Ft4k9vNWaXhb7KE0AJ1ZH27ilxSaC+RIXRHs7snO38CmFDanKj4nGiFIe5LX
	Lo0QaW1ZzGipyfO1TZZDbT9O9DdisowHiYwpTZ8nMza0WsEDQ0Tyli4feLgVI6mjH3SCeW01Ex2
	+GsU67WhBHkRfpQxgxiUVVQ8sTtMoNCvNubET1nMYnzUROSeH4q/Os4cPsas4O9gKCre9Fdmnrg
	4nQb1bGE/MPZOVfBuKhewGODYaFaZcowzQOX6p4X74y3AjXzyzq460JuMbYOBGQR54FroI4Q9EW
	VGLSvaJWanjhXWSS0XGIgarFTqYt/YCX8KB14NoN+P4cHnFG9crdQH7jfVArydOZl3/2CDJosUL
	GRZwQrqNDb2ig1LUAPfmhO7tL6x3m0VXU0nUnIDLky4uSubcWNni1d30nmwgVet80DrZif47Fod
	nLTkf8Yi4DzVu+hGLbeCdMoFVVmzcCFAsk6gnpOGidcLSKJrAylPtJSTXG1n+4ew==
X-Received: by 2002:a05:620a:4514:b0:947:1d0a:c89c with SMTP id af79cd13be357-9479f326c22mr318964385a.56.1794302549330;
        Tue, 10 Nov 2026 01:22:29 -0800 (PST)
X-Received: by 2002:a05:620a:4514:b0:947:1d0a:c89c with SMTP id af79cd13be357-9479f326c22mr318962485a.56.1794302548873;
        Tue, 10 Nov 2026 01:22:28 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01ff3428sm60703515e9.15.2026.11.10.01.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:22:27 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] power: sequencing: fix use-after-free in pwrseq-pcie-m2
Date: Tue, 10 Nov 2026 10:22:25 +0100
Message-ID: <179430254421.7208.10083406967609133170.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-pwrseq-pcie-m2-uaf-v2-0-3e1dd415af9a@oss.qualcomm.com>
References: <20261105-pwrseq-pcie-m2-uaf-v2-0-3e1dd415af9a@oss.qualcomm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: l_sDIBXQcUvo2blulpzJ0aYeV2FSDlAI
X-Proofpoint-ORIG-GUID: l_sDIBXQcUvo2blulpzJ0aYeV2FSDlAI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzNyBTYWx0ZWRfXyUWZebjqRM+v
 Mo+ZzdYrOC92cyGKKUlosdpX2auk5x00Ifxt5QFhxymsK1h2RLEh5MjQCIIGMVv6MWBi6AIOKrL
 hO095E3uzKyss1uTt7IBNM9ywx/DLnA=
X-Authority-Analysis: v=2.4 cv=NNpAaE6g c=1 sm=1 tr=0 ts=6af2e256 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=mVFbF14yMUIBM6kXvQ4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzNyBTYWx0ZWRfX6mr4jC7IRILD
 xvFSrHriQFARB+MksvsHcewLO5C+rDELSLQAXQsTp1ZIIlhCvbIVup+ehpM5Rm2Xh3oqPe4BrQR
 6j4LrUmHvyl8a/xwP1YhThoZ+YEeh82cFBmRaPpIXwCjU5cD1yPHm/J8pi6gYoNYcfqFVocv5di
 +Tm9g54WT9w4cp07ivqCDhuse8WTx7LvOb+oPmbgHhFV2F0bam6xQjz2eyb5oF8OZNICMS3P/IB
 8xtZGGoXGgt6XWr0eQof/bRr8fX0XeJXISzrqtBlMhJtjIfhhsfed4q/VRKHfzTdBFZ8WJJJCBp
 6OkIUpcacqpOo6mSTp/WfuFr+u0m6h+8PVNSz1zWodV+8EtM6ncJ0gR43MVOUhQ9laXo5IqSjuF
 QWuiufGR9JqSgG+XXYuk8Gtbe4Ia78r2nSTagTZpHm1Uyl3gVD2Te8uInlbBpZikLN6FvQ7df14
 5TOW5UWRDuOVxbjnXAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100037


On Thu, 05 Nov 2026 09:28:34 +0100, Bartosz Golaszewski wrote:
> This fixes a use-after-free bug reported by sashiko and then cleans up
> the error path in probe() by switching to using devm_mutex_init() and
> dropping the remaining goto labels.
> 
> 

Applied, thanks!

[1/2] power: sequencing: pcie-m2: fix use-after-free in pwrseq_pcie_m2_vregs_enable()
      https://git.kernel.org/brgl/c/cd5f26ed96604b18e4235052525abe6b4ba505d6
[2/2] power: sequencing: pcie-m2: use devm_mutex_init()
      https://git.kernel.org/brgl/c/e551848a3a80aa2e2aab5bcd8f022c594b14eac9

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
