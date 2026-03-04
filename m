Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286E339891C
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616884; cv=none; b=SPBTf/UnVsAhuM4HWWp7fuG4h6+F8sVzyynEMgh3LEreamL55Ovj+mBw84AX8DLzh1GYSA/+sDkOUEAu4JstViPvqoL15ukI1ampkFtGYht2e9RCwgJQF0u9htIgPcXvtuwi/e/B1Pspu7Xi5O2s/KTYMpVvJ59LI8zSOWXoOW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616884; c=relaxed/simple;
	bh=XWtG4w+RB2jIlE8XCXYlCTclLv1DMkaQyVrjOrWsDSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfcnIfQpu63KYq8W8VTAH0JVp0mCAOCe02/5irmUVFJehdsQJCwhZNEHcRm0IuWlOhr7ydZvAwG0IXkgoqTJnGaC5eVlnCb6IjjCfMNJcm1mlZJPF9c7QfODVmM9qQ1LXCjnVwYfKjTM/tJP2Kmu28tG8pwiSDKaDBg44spqwnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eKEnwxk0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aarkVNpC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eKEnwxk0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aarkVNpC"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SOfm152512
	for <linux-pci@vger.kernel.org>; Wed, 4 Mar 2026 09:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eL/MxpDDt/5/2ALudUSxO1nN1iy4vdaNTzKBdYqEsSk=; b=eKEnwxk08ZSuuIb5
	kLnhOzDXKxPW3zLqbJ5i4X54fIBV8ekw6WA+QDZnIeum2m6HgZKdTzX4cPzMLchr
	5neNVC9YrL0B3EGsnHNgfXT05VeYt225ETdM/AVXVP7//SkXB+1NzN8TeDk5RuFC
	27wO/Anxs1VGEBZa4acXnCLLVSO0dORMonWjSO3FqxuXk8a43Wx2H73d1BKdA4cE
	cxQQpibSkWaWAkJiWBDKtr7fW54WyW1SeY84/O6qB+m+jZ3tI0VcQa8JbqlDPGP8
	LB1IrM9dcfY+1udtjPx+AYfb3o7TgoA/Gyl6T/sV5VyaqTfN5LbziEYbwNJlrEhZ
	gV/dBg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp3tvk2ut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 09:34:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3594620fe97so32489411a91.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 01:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772616882; x=1773221682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eL/MxpDDt/5/2ALudUSxO1nN1iy4vdaNTzKBdYqEsSk=;
        b=aarkVNpC7wmODEKE9NZ7FhWY6VkMI3EC2Oj2f2ApWw7rcwQAr9z47F+lX2Zu/h/1Xk
         KrB9SzdwsjNUyLZuW+X9r4oLsTYFo1fIXorkjtcLnRd2KfYEM9RLucn6Bd17mldHOwWr
         47dCAwN5uh7h1T7rm7Y2hhIoxG8+jxa9NgrkxPeezRHEcjeC2J0Vo7bBg7gQXRPjZrm+
         Il9XjVgGrBn5kD/03pujANKp0JKXdCmpAXUsbkpkOjeW6tq6KKJ3jn+z3Va/nvyHFS1m
         Y9N/65G7CiJLzDhJ4ym9oB9TicoIBe2kDwYgS99+9qBjPvTUDtQzVyOpn0wHPDHbqNG4
         ixPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772616882; x=1773221682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eL/MxpDDt/5/2ALudUSxO1nN1iy4vdaNTzKBdYqEsSk=;
        b=E/ixqBybO1fZuA5+vY4cO3zMbfVHypdSIM+2gCQsGmBuE+il6FKoczihJA45bvGa3u
         bOFfpZwNbEHdj44VKd7Cmn0JiFZGP4yU65r7NLzYP7rNBndvcGW/Vh0uuvfBRwoQDa2K
         WPfDy2sADWMxkgJgFW0TNG5fbBNlc7WuUACp/b+zp68G7A+iIsd2JsKGjnAmnpmWfIn8
         +NoG9V1qod0G0USd3Z66nPMtt58NQcopcodxoybmPWeP03le2KPKUKj/9oMx8DUMNTof
         eJp5KId2guQvntL/7cjrF0lYiKlVrN34nEhe8Zn+87UIg7xrusHEAk/pChbZ/apc1m01
         k5ig==
X-Forwarded-Encrypted: i=1; AJvYcCVhRlJUy3uj8id2oNkjgxFkuatY/Fm7JMocIOQGDRdH70EGiIL10ZHJrujWjd9vYqgyayQsbcYMaJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI3thPV0XJW9hB4RUn2qeJ9JFdoU81qzNr0BX+YRAcDG8mN5IZ
	QMiuNQ7o/QOCG9GEqDzZYe+qLfWFpkDp9SJwkET6wLXj0gxIDEh4S2LEVPskIbGQynMtDaVFxFA
	ondjRDZCPe3I8H4QxWfNXOjF29Mm/InOJ3RSSkgx+IqQDZ1isRHvxOSVGgFbsbB0=
X-Gm-Gg: ATEYQzwAbjWuu0+KtCysN1sajSpkyl8cchR117Yp50auAd5uXp2JLqcydSKIyAxpxyr
	05yKu5HWpGXbIP4WMapQIt4cvrDSjuqPU1YzUBJT74LfMeBih73tMGquSjexjPh9Isdwz9ZRvmW
	5nQJxWYHKE63FHLR+hni7Tc+TtRQ57XS7l8JZccEOTPTYGtzM4RgHFGzKZOXtKb8I3s2TuxU8Tn
	2/BASk6WyGYc9l9opNa2CcSEafxVe0wLCp5px9S0ol6vLkAXdZw+75IXbytkfV5EmFmqyxc2ZbG
	f+pisZKByH2ccumpGqpkOqPXj894VTfqN9OHd5LC0ZJqZxY5vQiZhwUMPPa08nR0xC0KGqwgECy
	EY+7Jj96JfX+7C9PgEvsu6DdtMCjivVYvZd4G1hWTnp/02bdELP1BCqoL
X-Received: by 2002:a17:90b:5784:b0:359:8cad:bcdc with SMTP id 98e67ed59e1d1-359a69d6372mr1471645a91.10.1772616881622;
        Wed, 04 Mar 2026 01:34:41 -0800 (PST)
X-Received: by 2002:a17:90b:5784:b0:359:8cad:bcdc with SMTP id 98e67ed59e1d1-359a69d6372mr1471607a91.10.1772616881094;
        Wed, 04 Mar 2026 01:34:41 -0800 (PST)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359a8d65b31sm500720a91.0.2026.03.04.01.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 01:34:40 -0800 (PST)
Message-ID: <ebeb6f4b-4195-4e9f-b211-a8e11a875b7a@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 15:04:30 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] of: factor arguments passed to of_map_id() into a
 struct
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal
 <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260301-parse_iommu_cells-v9-0-4d1bceecc5e1@oss.qualcomm.com>
 <20260301-parse_iommu_cells-v9-2-4d1bceecc5e1@oss.qualcomm.com>
 <bo5kb53hrzvl6e5mctvnpqluobdgbpq4x3m5ca7mwtfnl53npw@7axqsph2vyqd>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <bo5kb53hrzvl6e5mctvnpqluobdgbpq4x3m5ca7mwtfnl53npw@7axqsph2vyqd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA3MiBTYWx0ZWRfX7uUdDcwqcBQX
 LJ3JeRhh0A17dV4aYQAW6fNyA3KKYbhRTE/KsMWFQmEbSes1xrpo6H2qAm/EgrgINWKyGZM0aZq
 7CNKqfy44dn6dahfkjbLb47c45qiyecazxH1dKloFIf/S+BEm9lVzKQ3TcOIoyzEZu3xqTOfbe7
 VbUF46fcgf+YWlmTMFjjnM/oFmd+b0+iArLQdp4HTJwuv4v4f2UPzdbkQsr12fA7ORdhpUzdooG
 vvvqthSyfmrxJKzyBj/OeG9LDtTdAgnnnC5TW35XntvVJkgGzYzh20bJDPp2BVwuXM8Dw3+Xe6Q
 utuS/w/7lhZdtqpPVFQKL5ymwPbWUgoRIB/OflpEa8ssobjNXgRPY+51af0TBHziPO/Mc/dyh13
 Sy/MIduf9V8wcWXQy3eG0uSBz9Rz2WnsmxkB+a2mqrNmNtP8e7xQkxWjLbMQS+YKAKAGeHeY2J4
 KE+svOOnd0hDBmvadWw==
X-Authority-Analysis: v=2.4 cv=VYv6/Vp9 c=1 sm=1 tr=0 ts=69a7fcb2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=kVzFkbBwBCoyR44kgfkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: jMxipYtbHriUvCcBe28L2dQkF1VD4bx3
X-Proofpoint-ORIG-GUID: jMxipYtbHriUvCcBe28L2dQkF1VD4bx3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040072



On 3/1/2026 4:29 PM, Dmitry Baryshkov wrote:
> On Sun, Mar 01, 2026 at 02:04:20PM +0530, Vijayanand Jitta wrote:
>> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>
>> Change of_map_id() to take a pointer to struct of_phandle_args
>> instead of passing target device node and translated IDs separately.
>> Update all callers accordingly.
>>
>> Subsequent patch will make use of the args_count field in
>> struct of_phandle_args.
>>
>> Suggested-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>> ---
>>  drivers/iommu/of_iommu.c              |  2 +-
>>  drivers/of/base.c                     | 37 +++++++++++++++++------------------
>>  drivers/pci/controller/dwc/pci-imx6.c |  8 +++++++-
>>  drivers/pci/controller/pcie-apple.c   |  4 +++-
>>  drivers/xen/grant-dma-ops.c           |  2 +-
>>  include/linux/of.h                    | 21 +++++++++++++-------
>>  6 files changed, 44 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
>> index a0937b7b3c4d..e1d4b37d200d 100644
>> --- a/drivers/pci/controller/pcie-apple.c
>> +++ b/drivers/pci/controller/pcie-apple.c
>> @@ -755,6 +755,7 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
>>  {
>>  	u32 sid, rid = pci_dev_id(pdev);
>>  	struct apple_pcie_port *port;
>> +	struct of_phandle_args iommu_spec = { .args_count = 1 };
> 
> Hmm, I didn't notice this. Parsing functions are expected to ignore
> of_phandle_args before the parsing. So passing .args_count = 1 is
> strange.
> 

You're right, This is not required. I'll remove these initializations in next 
series.

Thanks,
Vijay

>>  	int idx, err;
>>  
>>  	port = apple_pcie_get_port(pdev);
> 

