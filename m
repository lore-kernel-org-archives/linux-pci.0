Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792643229;
	b=yf2iFq572xwY2OrZPX/5Tf9aPJT9CAWzGs4/iQQq1y6hC//Q/X4iKJi8d8WxnmCF9eoU
	 tKl2oDaY070jlUHDEEuigbfyxR1GsTkuGroXtcaHO839IN7PgTvw/d537fJcW9ShvZODG
	 xHdPKDxY4lM+IoJnFfBEjMggFD8dfEVTfDExjxzlmX3L2VNBxcMuTv5uJyxgdAf8Z7s0j
	 oDWCc4NhdukjeANIIOu8ilFG4UUPU+ogLuzgNebcTtDUa2f/IINDczVVWNuMmFZMVJVz2
	 qiZ0baZFjLbsDs1itDPGTJaiEeRgqKaMQGeS0pbPkZi7+P79MW+guod1RxnWAlTVBEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792643229;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kHd6t9MH/IhdCNLkpF2qZJyQtdXI16Ce5y1ruH8zFEk=;
	b=EPzDWVr7wMO41u+a50HIwGbW1Iy8xTNoeWVQnHP0kpXlFpk1PdEfsP3vImmEOzpZ1ps4
	 PaTObjnPTFeif0SPGuPifHJgw3w6dQWbdgFvqMNN+BlG1l3wB9WcKpKV34YmHdVlRq3Q0
	 VA6DW+LVUHcEqoYoWZqgRB2vu5SNyLXeQolZyGD47HPw0w5Fbg1/TkPMMNPRbKf2hSr0e
	 iVQkEmSR/ZazlrlRgLN48vG8R9LpKq9vlPs0MScHnZ+9t+GRYo+ttklK4JXbJ7yutdljC
	 VTGKrTkHMu27oM8INdOe5Nu2gOS1pYA5Yx7OnhxiJlhuqw5pKgtziBYT1IcgQu47Lig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NSeKbWeO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dYUDOUyz;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8378E606A320
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 04:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8378E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NSeKbWeO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dYUDOUyz
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M3j3u83715438
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 04:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kHd6t9MH/IhdCNLkpF2qZJyQtdXI16Ce5y1ruH8zFEk=; b=NSeKbWeOzMfGqFWG
	dw/KXAgKF8W5tod7RGtBKuGDtdq4rJuMBuGLTsJfXGp+68yK21yypMwoFBkT9NdC
	Y3eSuWGBP6RsZPfitiODG6bldAbdEC5SauygAMPQ7uNzpuS1TORcSGSz6DyM68/g
	Ze5Y8dgxJdtMmusbtE4aragvDVmRMSkoQpwVAAWhSj3lcHq6AwTq+6qdwhtxbrix
	1aCZmEyPZ9lWD4zq0k+Ti/71/qOnbfmFcvRXTdfTBdkXro5yW9ZgihiOPcVtCQV+
	Z5JrJAOxlj8QLBcyB2ECEQ049aBZhP3E8K/s3AHPf9s7VCFAJTmYwUmljbjSFFP8
	heMmFA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93d8n63-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 04:27:07 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso2349877eec.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 21:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792643227; x=1793248027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kHd6t9MH/IhdCNLkpF2qZJyQtdXI16Ce5y1ruH8zFEk=;
        b=dYUDOUyzPJR3vEomzOB0qY35X+kvz/fyX4ylCGFb8+4KSZoTME2gcvngjmUSPphsUb
         RtKAB9A8y8huHyBlFC7yDkFk8W69Sr2YS267fen97Y1F5Z32IxcmcOYORXF6XSQyx0Zm
         tvSHZk1T3dvMP5lsRUqZmKKNN2/L5Fo335hu1ykUshPW1qmb2xpalqUxOKb2U4wofcxA
         UtFMD23U7Pt71Z47IJd9/ylYUCpGMy3SmYra8skwH5Wr+yqk+nZk9djOtfxJWXM5FiLJ
         0I3TmzaZscmrrggTqMSnSHnyxxSkJuQUkXoRYOSFeyNTbpmcbNarlw+5MPNYCu/8GYX/
         slxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792643227; x=1793248027;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kHd6t9MH/IhdCNLkpF2qZJyQtdXI16Ce5y1ruH8zFEk=;
        b=tyIZc/6aScFfNDGk3mID0xVMKeaFHKWD8b57Vv/1boqDT5yl5vSHEKR9ICo3TXdjJb
         3Me21zEU+7zofHxLHH4Cyw+bPI7oez9Nlh/9ipyjHdWkx5gJt/Tykhx69hoyb0DramVg
         nI4wL7V4QWLbivu5kdat6GyBQ5WqxYqNQPCSempEn1Sv8K0UfU43VNvAN/J05TdSnGeO
         oVFS9MQnuDeQkGVbyPxNmSExEyvPKIyOfFoeF4TuGLIoadRnhb+mbb31awChVlmObJGq
         Q0Fs2US6H9XRXyESGgblJqIzJGBBVYC/wICgKLLQtwTnQMODOLyD1wEEkUKFYXcLFk5R
         j8Kg==
X-Forwarded-Encrypted: i=1; AKwUvBz6KEiltpHqA66ReqdWs1A31jo42/UhJwootVeVxNkUM5AN97BGTmB7ZQ8VwUjZ23wjBfI6cteRkCc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOWVW7fKg9hX987bLoapK4y51RjSkTFWxK7QEzGbiMGS8wx704
	Yl0DVP/hDuRnr1IZDxp1p0jP+hEprHZNeqlOOGMcP9pSehNZzrT/Qgn4KeCemJ8auHhZKIRp646
	a9jWv8ErFVXU8YIkrG2EnHgxxBFbpaeOJ0zNWHNu0jpiVQtRMvIMAPcXjsQBqEhvW8f/Pcbo=
X-Gm-Gg: AYBFou3ZELDZT6fwQHLXYGJYTq7AuBMIazMh8NzZyQ1C5urcFCwF3ayiM9Dduo0+UTz
	suAuks85g06B6g33esfcu+y9Ny3Jgr6U3NR4WUoKzbY4yT1EdndOSAuNrh9060zJO15BEADEF9Z
	2Hx+oFYKmeKSaV/V9IphXNwJzhwjVceYf1ZjtOU9+Cl5iMVHv4FPv3Kq+GkX3AGgZM/2biko6AO
	Fis1zN82Xye7fNGeEetyI6sEvukO/Nw9Z+3tKSZEQ09JLvwuJHSZLvNDSXz529nxNe2xxbF7Zti
	/bdxTfSgZUusETkg1ppiQP0tStloNydDWbcF3Ni/rgStxZgROwKdu3xwDx3USeZvUSa0TpDoeeK
	OXsjpmKwwS5c9J47YuXi3sIAlQ2YPcOyL
X-Received: by 2002:a05:7301:122:b0:368:e6b5:35ad with SMTP id 5a478bee46e88-368e6b53aa7mr1241625eec.12.1792643226594;
        Wed, 21 Oct 2026 21:27:06 -0700 (PDT)
X-Received: by 2002:a05:7301:122:b0:368:e6b5:35ad with SMTP id 5a478bee46e88-368e6b53aa7mr1241574eec.12.1792643225848;
        Wed, 21 Oct 2026 21:27:05 -0700 (PDT)
Received: from [10.218.42.145] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367411bd27dsm13118133eec.17.2026.10.21.21.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 21:27:05 -0700 (PDT)
Message-ID: <398a1d12-c28b-418c-bbcc-170d781223d6@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 09:56:59 +0530
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
Subject: Re: [PATCH 1/3] dt-bindings: connector: Add PCIe M.2 Mechanical Key B
 connector
To: Alexey Charkov <alchark@flipper.net>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
 <20261021-pcie6_fix-v1-1-ad37134c35a3@oss.qualcomm.com>
 <CAKTNdwG5XA_chr2ZM9qTnr2RaDMzOjdb85bRdCr4aJCr1EGy7Q@mail.gmail.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <CAKTNdwG5XA_chr2ZM9qTnr2RaDMzOjdb85bRdCr4aJCr1EGy7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAxNyBTYWx0ZWRfXzTrHvgZTH1/8
 zvGm9OEjJ9VtFgtHvoEKrqIpU3T2aiAreDWACymLAmR9MfEzsVpn8l1cLUTr/bTeMGezIVAePpD
 K+HhppgW1+HwWiQdhT16rMlQltg3VDU=
X-Proofpoint-ORIG-GUID: 1GvdISK-ULLyK1sgsZJ53UyggT3VOrqE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAxNyBTYWx0ZWRfXyHbvnFKKVXid
 7bBYKb3kh8ri93SrVUT1ZcXOyevDg8u4sVPKBwGCUZ2/3GXeiluZRntkSDBxmeeVSMib42AZVz/
 Gk3Z8bbc+BDteXRe0fsf0U9Eps+MYnWOV//FfD9VyPJifmazSpaKPnoV3GLsdy9qvT+QGjhzOqE
 CI6b0EVi+b9pxSsPFeBMSE3MtcjcK3qFLJ2BpyAGAhZziYVM+wkcC3G7ENIYN0f8wb6hppwttdv
 X636OsBcoM6lalf/OnS9dgKUnuBQ9DLl+2Ou4b6QNmSZCDm7lK5EW/Y67eHYlyyj8A+WAHDpJ8Q
 LdT6z7f0KK9KLGjIf7QYlgmGRsQLdO4zQMcyrJJ9J5JwEmJ1Sn55tLLM9e2OnQSKtIxf7Pp9J++
 lDYpCKxfy12cpKRyznkRE00iIjQpgmoNTdZp4clBdxjWq8+WXxNxgcoeccp0GYsOSO+Nw29+RWi
 n0KkJNmT3vEfgbZb/sg==
X-Proofpoint-GUID: 1GvdISK-ULLyK1sgsZJ53UyggT3VOrqE
X-Authority-Analysis: v=2.4 cv=TIPQ2Fla c=1 sm=1 tr=0 ts=6ad9909b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=FnTilxWQIxca3sEwcYwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220017



On 10/21/2026 9:14 PM, Alexey Charkov wrote:
> Hi Krishna,
Hi Alexey,

Thanks for the thorough review, this is helpful.
>
> On Wed, Oct 21, 2026 at 5:51 PM Krishna Chaitanya Chundru
> <krishna.chundru@oss.qualcomm.com> wrote:
>> Add the devicetree binding for PCIe M.2 Mechanical Key B connector
>> defined in the PCI Express M.2 Specification, r4.2, sec 3.2.19.1. This
>> connector is used to attach WWAN Adapters to the host machine over
>> interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB 2.0, selected by the
>> Adapter's configuration pins.
>>
>> The connector provides a primary power supply of 3.3V/VBAT, along with
>> optional GPIO signals for WWAN-specific power/radio control:
>> FULL_CARD_POWER_OFF#, RESET#, W_DISABLE1#/2#, WAKE_OQN_WWAN#, and DPR.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>  .../bindings/connector/pcie-m2-b-connector.yaml    | 146 +++++++++++++++++++++
>>  MAINTAINERS                                        |   1 +
>>  2 files changed, 147 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
>> new file mode 100644
>> index 000000000000..a7f4bcbc5119
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
>> @@ -0,0 +1,146 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/connector/pcie-m2-b-connector.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: PCIe M.2 Mechanical Key B Connector
>> +
>> +maintainers:
>> +  - Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> +
>> +description:
>> +  A PCIe M.2 B connector node represents a physical PCIe M.2 Mechanical Key B
>> +  connector. Mechanical Key B connectors are used to connect WWAN devices to
>> +  the host machine over interfaces like PCIe, USB3.1 Gen1, SSIC, or USB 2.0,
>> +  selected by the Adapter's configuration pins.
>> +
>> +properties:
>> +  compatible:
>> +    const: pcie-m2-b-connector
>> +
>> +  vpcie3v3-supply:
>> +    description: A phandle to the regulator for the 3.3v/VBAT supply.
>> +
>> +  full-card-power-off-gpios:
>> +    description: GPIO output to FULL_CARD_POWER_OFF# signal. This signal is
>> +      used by the host system to turn off the entire Adapter. Refer, PCI
>> +      Express M.2 Specification r4.0, sec 3.2.13.1 for more details.
>> +    maxItems: 1
>> +
>> +  reset-gpios:
>> +    description: GPIO output to RESET# signal. This signal is used by the
>> +      host system to place the WWAN Adapter into a power-on reset condition.
>> +      Refer, PCI Express M.2 Specification r4.0, sec 3.2.13.2 for more
>> +      details.
>> +    maxItems: 1
>> +
>> +  w-disable1-gpios:
>> +    description: GPIO output to W_DISABLE1# signal. This signal is used by
>> +      the host system to disable the WWAN radio on the Adapter. Refer, PCI
>> +      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
>> +    maxItems: 1
>> +
>> +  w-disable2-gpios:
>> +    description: GPIO output to W_DISABLE2# signal (default function of
>> +      GPIO_10). This signal is used by the host system to disable a second
>> +      radio on the Adapter. Refer, PCI Express M.2 Specification r4.0,
>> +      sec 3.1.12.3 for more details.
>> +    maxItems: 1
>> +
>> +  wowwan-gpios:
>> +    description: GPIO input to WAKE_ON_WWAN# (WoWWAN#) signal. The Adapter
>> +      asserts this signal to wake up the host system. Refer, PCI Express M.2
>> +      Specification r4.0, sec 3.2.13.3.6 for more details.
>> +    maxItems: 1
>> +
>> +  dpr-gpios:
>> +    description: GPIO output to the Dynamic Power Reduction (DPR) signal.
>> +      This signal is provided by a host system proximity sensor to the
>> +      Adapter to trigger a reduction in the radio transmit output power to
>> +      meet regulatory SAR requirements. Refer, PCI Express M.2 Specification
>> +      r4.0, sec 3.2.13.4 for more details.
>> +    maxItems: 1
> This seems to be missing the four CONFIG_* pins, which are quite
> crucial in these connectors, as they define which interfaces the
> module asks the host to provide on the respective pins. Without those
> module type detection is impossible.
Agreed, thanks for catching this. I will add a config-gpios property  (4 GPIO
inputs, one per CONFIG_0..3 pin) to v2. It's optional, not required - a board
that always has a known, fixed card type in a given socket (e.g. QCOM
glymur-crd's WWAN-only slot) can just describe that fixed wiring via the ports
property and skip CONFIG decode entirely; config-gpios is only needed when the
host wants to detect the card type/host-interface at runtime. Kept it as plain
sensed GPIOs with no decode semantics imposed by the schema - the property
description documents the full Table 3-18 state table inline (all 16 states)
so the binding is self-contained, but turning the sensed 4-bit pattern into
"this is a WWAN-PCIe Adapter in port config 0" is left to driver code,
consistent with how the rest of the connector's sensed straps (e.g.
viocfg-gpios on the E-connector) are already handled.
>> +  clocks:
>> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
>> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
>> +      more details.
>> +    maxItems: 1
>> +
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +    description: OF graph bindings modeling the interfaces exposed on the
>> +      connector. Since a single connector can have multiple interfaces, every
>> +      interface has an assigned OF graph port number as described below.
>> +
>> +    properties:
>> +      port@0:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description: PCIe interface for WWAN
>> +
>> +      port@1:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description: SSIC interface for WWAN
>> +
>> +      port@2:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description: USB 2.0 interface for WWAN
>> +
>> +      port@3:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description: USB3.1 Gen1 interface for WWAN
>> +
>> +    anyOf:
>> +      - required:
>> +          - port@0
>> +      - required:
>> +          - port@1
>> +      - required:
>> +          - port@3
> This misses SATA which shares pins with PCIe. PCIe second lane also
> conflicts with USB 3.1/SSIC, which isn't captured here. Should it be?
Before adding a SATA/SSD port here, I want to double check the scope: per
Table 2-1, every SSD-capable board using those CONFIG states is a B+M dual-key
card (Type 2230/2242/2260/2280/22110, "B+M" key column), not a pure Key-B-only
card. Pure Key-B-only form factors (2242, 3042, 3052, 3060) are WWAN-only per
that table, with no SSD row.

If that holds, is modeling SATA/PCIe-SSD states in pcie-m2-b-connector even in
scope, versus always describing a B+M socket via pcie-m2-m-connector (which
already covers PCIe/SATA SSDs) and reserving pcie-m2-b-connector strictly for
the WWAN-only Key-B form factors? Or do you know of a real case where a pure
Key-B socket legitimately decodes to an SSD CONFIG state that I'm missing?
Happy to add the SATA port either way, just want to scope it correctly before v2.
> Should the graph also envisage connections for the I2C bus (GNSS),
> audio (2 or 4 wire), re-muxing of W_DISABLE2# and WAKE_ON_WWAN# into
> HSIC functions in Port Config_3, GNSS interrupt line and the such?
> Should the connector node also define pinctrl configurations for each
> of the 15 interface configurations?
These are all real signals in the spec (GPIO_0-11's BTO-defined functions per
Table 3-15, plus the HSIC remux under Port Config_3), but I'd left them out
deliberately for now: every one of GPIO_0 through GPIO_9 is explicitly "VENDOR
DEFINED or GPIO_x" in the spec text, i.e. there's no fixed function to bind to
without a BTO agreement between card vendor and platform. The sibling
pcie-m2-e-connector binding takes the same approach and doesn't model its own
analogous BTO pins either.

I'd rather land CONFIG_0-3 decode plus the SATA/PCIe-SSD scoping question in
v2, and handle I2C/GNSS/audio/HSIC-remux/per-config pinctrl as follow-up
patches once there's a concrete board that needs one of them with a real
driver consumer - adding properties nothing reads yet felt like the wrong
order of operations. But let me know if you think v1 shouldn't go in at all
until that full state machine is captured in the binding.

- Krishna Chaitanya.
> Best regards,
> Alexey

