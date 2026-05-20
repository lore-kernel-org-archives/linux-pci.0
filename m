Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8893334D901
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264361; cv=none; b=nUFIRx8kvoMaIo2Nnb/0LTp8saK8p4SIesZJk6RdH7kolWpwMnyymN93bJ9wWH8RLQXIkEfzk1PcgFOt871dZtacj79GO5yIQ3hNgA5rUR52LEbf1eKKMU872oOBuVEEkNU7y/fYCdq3gtDKnM6fmJBxSqe5SgXcSZlUdRQjr70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264361; c=relaxed/simple;
	bh=KUaCdDomY2qU9nG60VsZNCEO7wba/w9qv4eRI81YKo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRelFOX6cUEeKZ/aPLHQr2Az/kr3DOKZ41f9UAakz+r+aEQHfF/5/v7rw3snq/w+x0PzuxIIbUBQIbZuScYGBwVDr61bw9f1ohveoocbcsrIt7O5hWNZxZWoLmSWW/yVofR3SP36rXtR+ZJ9TvZH+R6dqRZm+Go8jHFfizgA9m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZaRSheFu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VuBL/fce; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZaRSheFu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VuBL/fce"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7AKDO1954028
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 08:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h4o4tguLJ2M8UFVCSQAOmrgjGYGYAaNNp+BkOJSYljs=; b=ZaRSheFuPELGrHrU
	5bq5fVMfyqResKiQ70JQ9GcmVcwVO++BNdtAGa8VE2RcuXKOS1fdXMzwTJtDbph5
	Kdz4noyWWRWd6d23UxPQMSbSlVPYhaCaEpU8/dR7MIrPBCAKu4u2eeLWD7A9h8Ru
	U3reVb2kI1+5mBFvP29oQxg4eDYm25BSrQS33OCcAsX2dxLWXMzwkxEAzAllr/T5
	SbMuaMtk4zoKuAm4QahqJUCu0TasoEKPmouhj+BzAYKQPlph23Nquuv+5EWqtMuO
	plY7E2DXbNgLQ53IfLC/cnaAcIDD30ZwYB/zcqQY/p+D8n8MDMmrXgdUON6gqfI7
	uk+kjg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3xuqkk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 08:05:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-367cb6de61aso8003496a91.1
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 01:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779264354; x=1779869154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4o4tguLJ2M8UFVCSQAOmrgjGYGYAaNNp+BkOJSYljs=;
        b=VuBL/fceh5Ece1PXQOSfa42Xn/BfhtInYmw1tzmg/mCFuIR9AvRBemthybBkBYGyuT
         l1aN5WXvh/d1k9HifM5Q5KHjfjV8E2xSd2hqkUutdob6AoDWrgxahqbhd3fwaS6pniEA
         fmZ4dcf02QzSLtPZi1F1u77S5mKvhzlK4KoUnNbCd6whLfmZTqRNECZYZNIXz3MRrAzT
         ZDMkZ8Q028IMCiGRuYTbyqGur6/QHEMBy+K6M6ZGywlRKv7PXdHfUnhowyhsklEHU6+f
         3mj/+9y3LZIDcROOWc7NWK1I3X0rEZOYiuuKLZTwRRh0brbizGc0stzt0spH53XN5NHD
         TzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264354; x=1779869154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4o4tguLJ2M8UFVCSQAOmrgjGYGYAaNNp+BkOJSYljs=;
        b=juPPLQYjkeg7YJ/YPP3BUciLoYny/2T09EWuwhZW6pFkWHgNDl/f9CNU6Oep1r+fN3
         WU64FqMdyRZLO5ipYMwUohOmYdIvXlTdmfOiHbp2Zdhmkj2Cb1jOzJdz51WWeMaTdtJt
         RppWO/dr2oAf1NzSG6Tv0QsVuI5yxkJrJwR1ikFSA1KjxF2TdBqefCxts0VKG66e0UXJ
         UEdmzglBoUzhCIXcuGpPtqOzSjtGVMcsMrjqRsd4Bs0mWRIjBZVyrqsC4F0gE24s6S6/
         DYCE8nO/M5dztK/jR4Sxul8DbIywQs+NPTjdGPxcKFCicCYdJvm9HPVJS+Q+eE1YX2E+
         uIlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+r0TAUITAtSuOiqp0a6dHr4QZl3j/AsZEmf0dv5Fd7ZtGQb8/zgELPw84qx5c3kckZsmwI0sR61zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1CeF927SZTcGzBBmmzqd3ThKPaMD1d4F7i+JlWrSrhSPtygII
	7NMP6AG8acY07lVLSHmPZ495FRzxjMuHLyNOghHElDzrbiWlsI8HB526ZGAYi3JzGFb1I0Z/aXs
	QJyeEixyWDYJxmU0Gr6JVptL+0roAlTKkclQzPMEpJOsCN86W7lYZDmJWyW7p6x0=
X-Gm-Gg: Acq92OE+swnvWrOEZta83bJyp92CZrZb9mguOB472yu613QGn7GGtY2YBnEg96p/+/J
	NpNWFwJ58gt9CAyqMC7VaF0/gotL2M0wkeuXMkJklzo4OxeHgAmFz1i7EFK0vEREQc70ESJxImw
	EwM6+BAxSO0CP1cMQxrPttwFSDoPpRknJV7i4y66gJDv6WzeYsNqZwyUmMNkkTs9hA9C2TTNDKE
	fFDbs4aBMCpflsjr4U6KpNBTZ3LuAKZC30smDunuIX2g/IQAUXT7q9DCwcTaTkuulUdY2MurTf7
	mwbBYTmWUtRJS8DVWjPmDz3iJcGBoYX7XLJSMldnDSyhGHmDwf0qAm3iTQR0lR/D83shA1qvXum
	oK5o8rCxozWQ/szJn409IRo7cgNZ49AUDrqmADGLJ+3fe37mZc+bbZlaYiWZqZFvX3mA=
X-Received: by 2002:a05:6a20:7d9f:b0:398:ac0d:9a0b with SMTP id adf61e73a8af0-3b22ecb031amr25955112637.50.1779264353643;
        Wed, 20 May 2026 01:05:53 -0700 (PDT)
X-Received: by 2002:a05:6a20:7d9f:b0:398:ac0d:9a0b with SMTP id adf61e73a8af0-3b22ecb031amr25955066637.50.1779264353199;
        Wed, 20 May 2026 01:05:53 -0700 (PDT)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb11683fsm18637582a12.26.2026.05.20.01.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 01:05:52 -0700 (PDT)
Message-ID: <11b91838-9b24-4a62-8760-fdeb3703afc4@oss.qualcomm.com>
Date: Wed, 20 May 2026 13:35:30 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/3] of: parsing of multi #{iommu,msi}-cells in maps
To: Rob Herring <robh@kernel.org>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal
 <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
References: <20260424-parse_iommu_cells-v14-0-fd02f11b6c38@oss.qualcomm.com>
 <20260506221915.GA3290640-robh@kernel.org>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260506221915.GA3290640-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WaY8rUhX c=1 sm=1 tr=0 ts=6a0d6b62 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=zmrd7r8un3QtD10oEDQA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: lRa8lG0tbHc1QImlx2lp8a3TCInao0V9
X-Proofpoint-ORIG-GUID: lRa8lG0tbHc1QImlx2lp8a3TCInao0V9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA3NiBTYWx0ZWRfX8YLktclbyXAv
 h13Lb8y0CjOh9GKtXt5st5bZ2kpCK6RWU6TTacjyWEUMoFWbv2ebWz+HG1yJ7hSTMt3iF7aPeXB
 25Kaipcodhb0GsJugQIzZwwgFPZXkxaIW0AhSlIR82MJbYkOax4LqQps/5qEgaJ7VTF3e1juoye
 JVc6X3knIMW1eyG26pSwI5U6eKhKbjImkgm5uxehW623betDbnuEG/KhhbtvgfWR8cgfrT4bMFR
 LiGJS3y0nO0qTmnhyX7TECneksXqlLsDtf+Y7LF32Rm01lcafQeFIbX0HfjpRYSbGt/AMkSrnoR
 NXcS2IcZbxz6X8PWT2n62/+8b4AD0k6pgIrj649qIzJs86Kv8P949YNu5fxtwysmIg9uv1gduXt
 cfFI+OVLqn9sKegwF42kR4IrVrjOWLml2AYcpwdNRmBGZSZX1x+fzkjx4JY1r3JgQh51mJnLS1w
 F/T7sOzHKyzpMDhANQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200076



On 5/7/2026 3:49 AM, Rob Herring wrote:
> On Fri, Apr 24, 2026 at 11:26:07AM +0530, Vijayanand Jitta wrote:
>> So far our parsing of {iommu,msi}-map properties has always blindly
>> assumed that the output specifiers will always have exactly 1 cell.
>> This typically does happen to be the case, but is not actually enforced
>> (and the PCI msi-map binding even explicitly states support for 0 or 1
>> cells) - as a result we've now ended up with dodgy DTs out in the field
>> which depend on this behaviour to map a 1-cell specifier for a 2-cell
>> provider, despite that being bogus per the bindings themselves.
>>
>> Since there is some potential use[1] in being able to map at least
>> single input IDs to multi-cell output specifiers (and properly support
>> 0-cell outputs as well), add support for properly parsing and using the
>> target nodes' #cells values, albeit with the unfortunate complication of
>> still having to work around expectations of the old behaviour too.
>> 							-- Robin.
>>
>> Unlike single #{}-cell, it is complex to establish a linear relation
>> between input 'id' and output specifier for multi-cell properties, thus
>> it is always expected that len never going to be > 1.
>>
>> These changes have been tested on QEMU for the arm64 architecture.
>>
>> Since, this would also need update in dt-schema, raised PR[2] for the
>> same.
> 
> Sashiko has some thoughts on the series:
> 
> https://sashiko.dev/#/patchset/20260424-parse_iommu_cells-v14-0-fd02f11b6c38%40oss.qualcomm.com
> 
> Rob

Thanks for the feedback, I have Posted v15 addressing comments from Sashiko.

v15: https://lore.kernel.org/all/20260520-parse_iommu_cells-v15-0-b5f99ad4e7e8@oss.qualcomm.com/

Thanks,
Vijay
