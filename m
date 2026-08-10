Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6632B3B27E7;
	Mon, 10 Aug 2026 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357644; cv=none; b=mYs3oSE/2OL7nQ7lE1jwZclmtNOwBGV/ohokQJqA8uPzNnBYeiVsTSMjIFY3RmWd/2/Y8Hx5P8J8fsFqga5D1QO4x+k8c8LFkSGlwHJFewe6Rasg3EX0YFeUyQecGhNVsvAuFAPaLqTtuHZloP8xJa7llPa7cZy2xTyShkCnvRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357644; c=relaxed/simple;
	bh=eMo7RiFxf486lOJsy0lJdVppqNImmgiXhVLqpPYRKxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBiPO8ymMneHHqyNeK3Z1kfuyuKMX+zazmgh+8bQnzrVjpv3cCIPIx/9FobeWYV9gF+BF/Qn8N0ge/ddDgEmiLgQ9o0wG+oLnGPEvPkoxKPH8Chd5TDZ2V16siEvKD+H7QbhpSH1klv+oSGu/t/RpO6YqMVlH8TJNd4EQSAm5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7jzu2pt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7jzu2pt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CB61F000E9;
	Mon, 10 Aug 2026 10:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786357643;
	bh=dXt/1L/uHFM3OLFJe78YGdrRxxWdzR6Xr8tdcZbXvnc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K7jzu2ptlkM364QmUboSzRgav59W+7lFiSK5EyjU/sDCNrbPA7HHbaJnXOKyEw2d3
	 wLM70UY8XCrQcE5JlmoS2psn0NBAt4BeMQFM1UFJ6OY1ik0BzFszrNEcPM9/nOMc+Y
	 xb0AVjre8gwilijbDP3GTjVfbS+2Udes2dOXgqOvGILmtym40kRYEBBynMF8Z6Icx7
	 HWutXkJXB4CaNXG5rr8qlHaMqc8cv2y8+lm7WqeHiVwVPlYG7+7vknob1/bEdhy/ap
	 m1BNituEWxd1unN9rKnd4PrTFpMMoz4XdEHUobAPdjHeXuM3hS5EJ8Y9yCLCQ01wgY
	 /9QdkhOSg5ZZw==
Message-ID: <7ba2ec58-8717-4fea-8c79-c4923741aaac@kernel.org>
Date: Mon, 10 Aug 2026 12:27:11 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: bluetooth: qca: add QCC2072
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rahul Samana <rahul.samana@oss.qualcomm.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
 Rocky Liao <quic_rjliao@quicinc.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-1-2d100f30e202@oss.qualcomm.com>
 <20260731-first-righteous-bear-dd72ed@quoll>
 <712f8a14-d2a1-4a90-82f9-05cd694f2658@oss.qualcomm.com>
 <c1875dd6-fe3a-4a69-a6fd-b461c8fba6e4@kernel.org>
 <6d6465bb-47ac-464c-af4e-0ca72325705f@oss.qualcomm.com>
 <8a388310-d3cc-4d02-abb6-0eb98c24cfce@kernel.org>
 <4523441f-498a-4bbd-80f3-97a7a9206c00@oss.qualcomm.com>
 <6e0b9e79-ccd4-4689-9a6b-9b4fc556d5e4@kernel.org>
 <dduqm25cy2j3ab7gu65qjho76gifij3sgnvgsgqyvncjxa46x6@vg7egioz5vxx>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <dduqm25cy2j3ab7gu65qjho76gifij3sgnvgsgqyvncjxa46x6@vg7egioz5vxx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/2026 11:57, Dmitry Baryshkov wrote:
> On Sat, Aug 01, 2026 at 05:49:53PM +0200, Krzysztof Kozlowski wrote:
>> On 01/08/2026 17:31, Rahul Samana wrote:
>>>
>>>
>>> On 01-08-2026 20:18, Krzysztof Kozlowski wrote:
>>>> On 31/07/2026 17:51, Rahul Samana wrote:
>>>>>
>>>>>
>>>>> On 31-07-2026 20:34, Krzysztof Kozlowski wrote:
>>>>>> On 31/07/2026 16:45, Rahul Samana wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 31-07-2026 15:16, Krzysztof Kozlowski wrote:
>>>>>>>> On Mon, Jul 27, 2026 at 09:15:01PM +0530, Rahul Samana wrote:
>>>>>>>>> QCC2072 can be used on M.2 E-key cards where the card power resources are
>>>>>>>>> described by the pcie-m2-e-connector node. In that setup, the M.2 power
>>>>>>>>> sequencing provider creates the Bluetooth serdev child after matching the
>>>>>>>>> QCC2072 PCI function.
>>>>>>>>>
>>>>>>>>> Integrated non-M.2 designs need board-specific power resources. Document
>>>>>>>>> only the compatible for now and leave those properties to be added with
>>>>>>>>> matching driver support.
>>>>>>>>>
>>>>>>>>> Document the qcom,qcc2072-bt compatible used for QCC2072 Bluetooth
>>>>>>>>> controllers connected over UART.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
>>>>>>>>
>>>>>>>> NAK, exactly same comments as before.
>>>>>>>>
>>>>>>>> Nothing got improved, although what is weird - original SoB is gone, so
>>>>>>>> this is legally dubious work.
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>> Krzysztof
>>>>>>>>
>>>>>>>
>>>>>>> Hi Krzysztof,
>>>>>>>
>>>>>>> Thanks for the review.
>>>>>>>
>>>>>>> For the binding contents, I tried to capture the current scope in the binding
>>>>>>> description itself. This series supports QCC2072 only as an M.2 E-key card,
>>>>>>> where the card power resources are described by the pcie-m2-e-connector node
>>>>>>> and the M.2 pwrseq provider creates the Bluetooth serdev child.
>>>>>>>
>>>>>>> The binding also says:
>>>>>>>
>>>>>>>   Integrated non-M.2 designs require board-specific power resources. Those
>>>>>>>   properties, together with a static devicetree example, should be added when
>>>>>>>   integrated non-M.2 support is added.
>>>>>>
>>>>>> Bindings must be complete and your driver support is irrelevant here.
>>>>>>
>>>>>> If you claim this is a PCI device thus you do not need any resources,
>>>>>> then the binding is not needed either. PCI devices are enumerable. And
>>>>>> to prove it: look at your DTS. Do you see qcom,qcc2072-bt being used? No.
>>>>>>
>>>>>>>
>>>>>>> We do not currently have an integrated non-M.2 QCC2072 design, so I do not
>>>>>>> have board-specific regulator supplies to document for that topology.
>>>>>>>
>>>>>>> Could you please suggest how you would prefer this binding to be handled for
>>>>>>> the current M.2-only use case? 
>>>>>>
>>>>>> Drop the binding, you do not need it.
>>>>>>
>>>>>> Anyway the problem is that more comments were ignored.
>>>>>>
>>>>>
>>>>> Hi Krzysztof,
>>>>>
>>>>> Just to clarify the reason for adding this binding in v2: 
>>>>> v1 did not add a binding because this series only targets the M.2 use case.
>>>>>
>>>>> I added the minimal binding in v2 because checkpatch reported
>>>>> qcom,qcc2072-bt as an undocumented compatible, and I interpreted the request
>>>>> to fix the checkpatch warnings as requiring this compatible to be documented.
>>>>> I also had the earlier feedback in mind, where the indirect
>>>>> qcom,qcc2072-bt compatible was pushed back because it was undocumented:
>>>>>
>>>>> https://lore.kernel.org/all/20260703-eliza_evk-v1-3-7624440bd76d@oss.qualcomm.com/
>>>>>
>>>>> Based on your clarification here, I will drop the binding patch in v3 and
>>>>> keep qcom,qcc2072-bt only as the pwrseq-created child compatible for this
>>>>> M.2 case.
>>>>
>>>> My previous statement is also valid, please read entire threads.
>>>>
>>>> You cannot have undocumented qcom,qcc2072-bt.
>>>>
>>>> I ask you to drop both, because they are not needed. But feel free to
>>>> prove me wrong, see my first paragraph in the previous reply.
>>>>
>>>>
>>> The PCIe M.2 power sequencing driver, pwrseq-pcie-m2.c, uses
>>> pwrseq_m2_pci_ids to translate the enumerated PCI function into the
>>> Bluetooth compatible used for the generated serdev child.
>>>
>>> For example, WCN7850 maps PCI ID 17cb:1107 to qcom,wcn7850-bt, then hci_qca
>>> matches that compatible to select qca_soc_data_wcn7850.
>>>
>>> For QCC2072, pwrseq-pcie-m2.c matches PCI ID 17cb:1112 and creates the
>>> generated Bluetooth serdev child with compatible "qcom,qcc2072-bt". The
>>> hci_qca driver then matches "qcom,qcc2072-bt" and uses qca_soc_data_qcc2072
>>> as the controller-specific data.
>>
>> The purpose of Devicetree is not to describe Linux internal driver
>> matching. Do not use compatibles for that.
> 
> So, if instead of M.2 module the WiFi chip gets soldered to the main
> board, the qcom,qcc2072-bt wll be a legitimate compat string?

Yes, just like the rest of compatibles in the power sequencing driver
(and bindings).

> 
> Also, I understand your concerns about the DT bindings / usage, but
> speaking about the driver ;-)
> The BT is a serial driver attached to a serial bus. There only two
> options to bind a serial driver: OF and ACPI. But maybe we should add
> something like serial_device_id and let serials have internal IDs.
> It sounded strange in the beginning, but now I think it is a correct way
> to go.

Driver get away with that limitation, because we had DTS for the
existing entries. This is the first one without DTS.

Best regards,
Krzysztof
