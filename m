Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF42F86334;
	Sat,  1 Aug 2026 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785595736; cv=none; b=Uh/HpEz+NfkH1ajMf4vyrmw2xckAVdRKwB6qMR6nuHN3vhcfRGqKwbMvD07BFCmlkOKZk6LPgQdwGvPHk9hE3f775UmTW0fnod8R3Q0jwvJAw8OMkMdZXqHV7G18i/z1CSfo99+Zw/PzWgtORs4NxeLY4RmLxpA5A8YmuIXnQug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785595736; c=relaxed/simple;
	bh=ZwlbDAuf/yjKiLJtbRSi5oTev3wFIRh+OMpl7qVgAi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R34r00CcuTw1VRI40vxele26dQ32fHmH3tZAIES2CfOfVshz0Eanhwk1bUK/xQKr4i9HNTMUu7RIMmJq2rA/enTIqzEqQcHhFa1zu/rKzmTWvxVx2GwU7d/Avub4/nJ5UGB1EB/54KL534VilV6stW8pvi2J+YPBk8R7FF1ScR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlSiAoRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlSiAoRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87831F00AC4;
	Sat,  1 Aug 2026 14:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785595734;
	bh=OTxS74XF3qRcmKVPA+PzGrqCAGF/IDrig2LGi50+26M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QlSiAoRG/s2S1kjtyjJaLQ4NJHM5zwvkEW6D95gZ3mhuFr655vsD8lUYsTt2h7i08
	 tAoZHd5Wz7vA9zevbOuxwshtlKCra3/wlXquOm5fIj+o5BphRHafAdAjmwoLWnzVOQ
	 393yOuyaImTYkaxDjO2Yga29jmtFN7QHdSnZ7uuTd1tyiU24FgGGEEm4xnqYwOvFzq
	 gr8r+hrNofzcVYR6MoD1R7hv3szoxzxNmh2WSYP0CD/tvWk/6btUWjaMFy05TLukzw
	 JBQ9GmR7iodjagzx4FAd7Oy5ULhEsf9WgirQhGSHEK4sbDRmAr7UjtcItpWJUzQ2bq
	 +PKthGmLxg7Ow==
Message-ID: <8a388310-d3cc-4d02-abb6-0eb98c24cfce@kernel.org>
Date: Sat, 1 Aug 2026 16:48:45 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: bluetooth: qca: add QCC2072
To: Rahul Samana <rahul.samana@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <6d6465bb-47ac-464c-af4e-0ca72325705f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/07/2026 17:51, Rahul Samana wrote:
> 
> 
> On 31-07-2026 20:34, Krzysztof Kozlowski wrote:
>> On 31/07/2026 16:45, Rahul Samana wrote:
>>>
>>>
>>> On 31-07-2026 15:16, Krzysztof Kozlowski wrote:
>>>> On Mon, Jul 27, 2026 at 09:15:01PM +0530, Rahul Samana wrote:
>>>>> QCC2072 can be used on M.2 E-key cards where the card power resources are
>>>>> described by the pcie-m2-e-connector node. In that setup, the M.2 power
>>>>> sequencing provider creates the Bluetooth serdev child after matching the
>>>>> QCC2072 PCI function.
>>>>>
>>>>> Integrated non-M.2 designs need board-specific power resources. Document
>>>>> only the compatible for now and leave those properties to be added with
>>>>> matching driver support.
>>>>>
>>>>> Document the qcom,qcc2072-bt compatible used for QCC2072 Bluetooth
>>>>> controllers connected over UART.
>>>>>
>>>>> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
>>>>
>>>> NAK, exactly same comments as before.
>>>>
>>>> Nothing got improved, although what is weird - original SoB is gone, so
>>>> this is legally dubious work.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> Hi Krzysztof,
>>>
>>> Thanks for the review.
>>>
>>> For the binding contents, I tried to capture the current scope in the binding
>>> description itself. This series supports QCC2072 only as an M.2 E-key card,
>>> where the card power resources are described by the pcie-m2-e-connector node
>>> and the M.2 pwrseq provider creates the Bluetooth serdev child.
>>>
>>> The binding also says:
>>>
>>>   Integrated non-M.2 designs require board-specific power resources. Those
>>>   properties, together with a static devicetree example, should be added when
>>>   integrated non-M.2 support is added.
>>
>> Bindings must be complete and your driver support is irrelevant here.
>>
>> If you claim this is a PCI device thus you do not need any resources,
>> then the binding is not needed either. PCI devices are enumerable. And
>> to prove it: look at your DTS. Do you see qcom,qcc2072-bt being used? No.
>>
>>>
>>> We do not currently have an integrated non-M.2 QCC2072 design, so I do not
>>> have board-specific regulator supplies to document for that topology.
>>>
>>> Could you please suggest how you would prefer this binding to be handled for
>>> the current M.2-only use case? 
>>
>> Drop the binding, you do not need it.
>>
>> Anyway the problem is that more comments were ignored.
>>
> 
> Hi Krzysztof,
> 
> Just to clarify the reason for adding this binding in v2: 
> v1 did not add a binding because this series only targets the M.2 use case.
> 
> I added the minimal binding in v2 because checkpatch reported
> qcom,qcc2072-bt as an undocumented compatible, and I interpreted the request
> to fix the checkpatch warnings as requiring this compatible to be documented.
> I also had the earlier feedback in mind, where the indirect
> qcom,qcc2072-bt compatible was pushed back because it was undocumented:
> 
> https://lore.kernel.org/all/20260703-eliza_evk-v1-3-7624440bd76d@oss.qualcomm.com/
> 
> Based on your clarification here, I will drop the binding patch in v3 and
> keep qcom,qcc2072-bt only as the pwrseq-created child compatible for this
> M.2 case.

My previous statement is also valid, please read entire threads.

You cannot have undocumented qcom,qcc2072-bt.

I ask you to drop both, because they are not needed. But feel free to
prove me wrong, see my first paragraph in the previous reply.


> 
>> And why this is sent so many times?
>>
>> https://lore.kernel.org/all/20260218114955.3970974-2-vivek.sahu@oss.qualcomm.com/
>>
>> https://lore.kernel.org/all/20260529175342.3363935-1-yepuri.siddu@oss.qualcomm.com/
>>
>> and now by you.
>>
>> How many times this will be sent in separate patchsets and asking for
>> separate review ignoring previous review?
>>
> 
> Regarding the repeated submissions, the reason for carrying this forward from
> the earlier QCC2072 work is documented in the cover letter. This series was
> intended to continue that work for the RB3 Gen 2 Industrial M.2 use case, not
> to ignore the earlier reviews. 

If you continue the work, you do not ignore previous comments, so I do
not see how this is any sort of continuation. Looks like duplicating
work without looking at previous discussions at all.

Best regards,
Krzysztof
