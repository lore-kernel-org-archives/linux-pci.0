Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801CE3AE187;
	Mon, 10 Aug 2026 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357730; cv=none; b=nFEFu+a5rTXbmcA2d6WQF9x02+VePOgbo3fJrcYg43P0LzAV0L2LlyIojZfFnUnM6oX3D6XAjMmBgrBGom7xqUBg2D4+1nvOoILtGXkeC7HMgwQbw4k1wU9jINE4f5M8tt9LIXE2mkLwudxmG/dOlZbOXW5Zx+gTSKzvp7iYwgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357730; c=relaxed/simple;
	bh=maqLFykox4FH0KHiP8TnBxvurfPRTkEhw7HCpnqJSOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLuh3vMFE4UmdV9Yhb8CcmnNBp3qZiPgN94YYUPLU8pPoTkUXueH0JkXev32xumqep+MTPCCe4uw1PI//BK2YhK2ywy5SjmHmdZ5qtxAxQAsn1jjNVPI57O2HiMaFiXHMqoS6Dg8nG+4LSVxk559FeIrNuOpmuJIKsZUdJgm4yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNWlz5is; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNWlz5is"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC5B1F000E9;
	Mon, 10 Aug 2026 10:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786357728;
	bh=HgXIrs2B3DfHBP5nxGyXdoxDZ3P+3le6QMIeyZwLRVM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VNWlz5isL+Wt0l8KtVvJpm0kw1mzGgAyZajrwxKfI7Pf0qgoMF33QcDhFAN4nJV/Y
	 j06/8hXpGIkUiM0CDqI43+YLSqK+2eoPaFcKytISFTkM4NP5AjhFlXTGFDbPUjGB5W
	 3Afd1IU2O40xsmCrVHb9a+BmmOs3C+NCdRD7Yi9nKiG4ingJxgmyr+hmV3S1xlrqbS
	 qBm/0Gqe1+z7Yoa3upftAHXC9SF3aJm39IlHcbHI6eX6YVkmyN6GmxKPsrzVEM+8HW
	 suSFs+u4pASKoE3AXWQ181pZ9RPwZfLLfuRYl3LMHdU6rHR28RFzAM7lmvDz+oA3r4
	 HjNeuwD0NfZhQ==
Message-ID: <5330838e-d3f0-454a-b856-bd8fc3e941aa@kernel.org>
Date: Mon, 10 Aug 2026 12:28:36 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: bluetooth: qca: add QCC2072
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Rahul Samana <rahul.samana@oss.qualcomm.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
 Rocky Liao <quic_rjliao@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <c1875dd6-fe3a-4a69-a6fd-b461c8fba6e4@kernel.org>
 <6d6465bb-47ac-464c-af4e-0ca72325705f@oss.qualcomm.com>
 <8a388310-d3cc-4d02-abb6-0eb98c24cfce@kernel.org>
 <4523441f-498a-4bbd-80f3-97a7a9206c00@oss.qualcomm.com>
 <6e0b9e79-ccd4-4689-9a6b-9b4fc556d5e4@kernel.org>
 <gfhlyvoefcsvtjuxfo75qeham272cc5g2r3npjenzs5esjifiy@ro7dtkpxwizk>
 <8ab6c26f-b648-447c-9fdd-f1424beb44f4@kernel.org>
 <sewfntbhqtj2apfdi4ouan27artvj4lyxqizvinsvzltbofqu2@riuoo3fmczff>
 <768142f0-2638-41f3-a34f-dc80bb99eb7f@kernel.org>
 <5tkajres2vjkt436teaujcqyc3mjqr65rsfvwhjbmlk3fc3gpt@j6ozyfattae3>
 <2iymaoj6ryayvsyfnrkwf6ldq57lkitoyqrazytxh7wxnpeoeo@vg6q35cua2oy>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <2iymaoj6ryayvsyfnrkwf6ldq57lkitoyqrazytxh7wxnpeoeo@vg6q35cua2oy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/2026 11:40, Dmitry Baryshkov wrote:
> On Wed, Aug 05, 2026 at 04:52:15PM +0200, Manivannan Sadhasivam wrote:
>> On Wed, Aug 05, 2026 at 04:36:31PM +0200, Krzysztof Kozlowski wrote:
>>> On 05/08/2026 16:12, Manivannan Sadhasivam wrote:
>>>> On Wed, Aug 05, 2026 at 02:33:51PM +0200, Krzysztof Kozlowski wrote:
>>>>> DT is not representation of internal device driver instantiation mechanism.
>>>>>
>>>>
>>>> Here, the driver is just creating compatible for a real device. What difference
>>>> does it make if the BT node was defined statically in the DT vs created
>>>> dynamically? Both nodes do represent a real BT device, not driver's own
>>>> representation. And by the time the node was created, the device is physically
>>>> attached to the system.
>>>
>>> What stops this power sequencing drivers, after more driver patches, the
>>> best if being part of some bigger series, to add properties like
>>> "linux,name-of-driver-to-bind" or whatever other SW properties?
>>>
>>> This is what happened in that linked thread:
>>> https://lore.kernel.org/all/20260326-pci-m2-e-v7-8-43324a7866e6@oss.qualcomm.com/
>>> The driver code is adding children under other nodes (references by
>>> graph) and it is nowhere documented. Maybe bindings of these other nodes
>>> allow it, maybe not. How do you even validate that?
>>>
>>
>> So the concern is validating the properties that get added dynamically and I get
>> that. How about inserting an overlay for the BT node instead of creating the
>> node on the fly? Like, drivers/misc/lan966x_pci.dtso
>>
>> This way, the overlay would be validated against a binding and the driver would
>> just be inserting it.
>>
>>> So answering your question - yes, there is a difference because:
>>> 1. DTS we validate but whatever you add to driver code we do not and we
>>> cannot,
>>> 2. DTS represents hardware but whatever you do in your driver code
>>> represents who knows what (maybe hardware, maybe not, can represent
>>> anything)
>>>
>>> And if you claim "I add hardware in the driver!", I respond - maybe
>>> true, maybe not, but look at this crap:
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=687bfbba5a1cb15cee51519c210141ed1c4b0ec7
>>>
>>> Since we DISALLOWED venus-decoder and venus-encoder DT nodes, what did
>>> Bryan do? Squeezed via driver code fake disallowed nodes and even gave
>>> them compatibles not looking like compatibles, so any regex won't work.
>>>
>>> This power sequencing work here has the same problem of sneaking ABI,
>>> which I pointed out here:
>>> https://lore.kernel.org/all/9cc5af16-d95e-4f10-8b4a-5e29c136079c@kernel.org/
>>>
>>> Look at above patch - nothing documents that ABI. The same as Bryan's
>>> fake venus-decoder and encore (not only fake but actually rejected). And
>>> to avoid ABI-check tools (or incoming tools), this power sequencing code
>>> does not even call a "compatible" a "compatible". No, it calls it
>>> "driver_data" nicely avoiding detection.
>>>
>>> This is terrible practice and I feel like allowing this patch is silent
>>> acknowledgment or agreement of such practice.
>>>
>>> It's about basic ABI principles - if you have DT ABI, it must be both
>>> clear in the drivers code and in DT bindings, instead of obfuscated
>>> calling a compatible driver data. If you don't, then this is not DT ABI
>>> and you are not allowed to use OF code to instantiate drivers. Use SW
>>> nodes or KHO-style whatever else is there.
>>>
>>
>> I did propose using SW nodes initially, but then it got changed to
> 
> If I remember previous discussions, SW nodes can be used to provide
> additional information about the existing devices. They should not be
> used for matching.

Yeah, matching is via standard driver name for example like MFD is doing
for platform bus.

This is not that different than MFD.

Best regards,
Krzysztof
