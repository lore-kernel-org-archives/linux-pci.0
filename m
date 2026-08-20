Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9A847F2FA
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246334; cv=none; b=kxw9JLLm0UqzE+iAJoe9bqZw2d8tk2aIPd0eNlr+JvLghMbVS7Zk325rbuwvscXCb1Y9C73iQq13eZXyQ38ee0BbY6FRinbToi10CYRrYOEshOGxqpL6hwC5V9ooMDPXfe/HAWJQqZs3QP1772xObKvk3E85U3Y4t6ick6QT4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246334; c=relaxed/simple;
	bh=sDIQ1vLsYFppGokpUhtjUe6z+MBWd9JK7GkUzlazqsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vETcNCf6avvlPjLYumNFNrqwLdF+2qQA8t1H8GStBqi6CGDbTHmzBAHJ9wHI2ZZ/Fc0/dFzW/jVAgA/M1eJugbfBH+uWWXNpJnWEylYG6bCeOCxvc5pQc6glX1U1uQOa3oWYmF8ReWLTrcmS1tpJxuDhbLlIZqhUt72Cvks5J3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=eB6hJXBq; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="eB6hJXBq"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-936dfd009d1so104591085a.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 10:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787246331; x=1787851131; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRMpkuU4HK2cX9MBfuMzYQo0OypqY8QmS/84hefJFZU=;
        b=eB6hJXBqsckOHJuZyi9K64sStQ8nr5UQ91s+Rd0dim6LH9LpMuBETf6fofRz9WQsZB
         rUZMuDSMX7xHxysqLXdh6pYGlbu/jRPMw8YhKhv/6PPjpg8Huo/+sAyyBEsVPWmtazeh
         wEBOsc0oHurLJ4wnW7zexk3AnyDzlJk71AEuxp4DEVuJUqg8gNbh1NzH+gGuA9ggd+zs
         mufBuB4UHmB8BL+IQOLYYFj2+d/rz4P/X430QQ+vTWWGjhrHCbX/1OSGuqZAPWHD9RlY
         a8wuR2XRX6ybsXy1DvKaj815/anApGc5X2B25/JEnYDhr77sgA4OhxnX1iOD+TFMkfrh
         MBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787246331; x=1787851131;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IRMpkuU4HK2cX9MBfuMzYQo0OypqY8QmS/84hefJFZU=;
        b=NlFSW7hnroycDKbc4jr17Cr/G3VXVKN/WF4QAhyQBZeggi5VQCaDArbOMT/DWXSOOO
         cAg5Wi/judLTvKYURwhKTOrpEcmbtKQ/uxnC8m+LXzQtVajrgyAJeyK3+YvzHbl8M0B1
         UOKSgE0rx2JUmFlYwcJsSlkYdbymwRzJdPxuKrL62NuaUyHg+REvZf2wCSMOGBblYr86
         /l8Zwhw9kBWExy8lmGDR31Co3Um8h0mTjxpfHR5ohbFU2jlzPUug+16bnCymBLCJplpg
         dtjGyITiNkEzbmJEaCSqR4q+PTDfArVs7fbyeiBavNkCHUYM2LTXT/0UGsNK6EdJ4P3n
         Ch1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqLx+9ZHDVwE9o5VQzdcawc2VBJOKGgz59JsoGvF8oIDdPhGji45h1m8w2vEHf4+tp/aZfj3NJyliw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3FlvRqDjtq0RkNmfX3Y1aahpqQe7E7lrJBgk7OSORzU49sIwD
	7rROM+VSErjJlZ5kPaA+z5m8WpwYVY9C/SW5A0RXemIPHbmTffV1FY0gRXztTD0or9E=
X-Gm-Gg: AR+sD10J40YtIDA/nY70zWFWI4KoHhg1Alf2bdgv5J6dMvoQdbnEMwaKwbjf1ips+je
	NwHGt15b+G1FmDNqAqZhOgM/BzU70EcS1IdjecK2t3xP5vtDizC9In/u6Vsz1R6w7CE8WNdsPy+
	Hw46degLiII+4Lq7A6XcTrrbONUhIi5ncvJGluOhv4oga8f5lN8uboSIhtJ9+qgsxOAR9p9pHgD
	NSAmF8P5iln4I6CaYq/c3aAntDyqmwQTUbtgtcylRB9tt2hSMBVL0JkVrcR/6LzL1ymvs9q1Iid
	aYON3HckQQPMBO0MLo1LcpJXs19BExYEAdbUIk0dBJMerZGtdLh/p66i/zj++S2LBu1qxxJlRWY
	T1A3mbIfizuKGfbjypqsO85pE0yX7hjEsWhuavXh8xXQYTEmPLV8o8EIV4M/rWzlxE/Z4XVBcIs
	Qlp6GK5Caqn0RYmIEsz5dr/3exAwhXyvnpNrbtwf0Wze74XjM8btAPcOp3xhMq
X-Received: by 2002:a05:620a:4887:b0:930:bd6c:9c32 with SMTP id af79cd13be357-9372849f086mr799219985a.12.1787246330439;
        Thu, 20 Aug 2026 10:18:50 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937204a91b0sm418891185a.15.2026.08.20.10.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 10:18:49 -0700 (PDT)
Message-ID: <dc48b8cd-1bec-43d1-bc33-0a71bd2b6c4e@riscstar.com>
Date: Thu, 20 Aug 2026 12:18:49 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: misc: introduce pci1179,0220.yaml
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, bhelgaas@google.com, daniel@riscstar.com,
 mohdayaa@qti.qualcomm.com, lbiancon@qti.qualcomm.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260813222943.1655453-1-elder@riscstar.com>
 <20260813222943.1655453-2-elder@riscstar.com>
 <20260814-deft-unnatural-teal-1dbac3@quoll>
 <8c33e30a-e35e-47d4-a851-c82e18ed7472@riscstar.com>
 <55991af4-c613-4cde-a121-30f2ff9c8347@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <55991af4-c613-4cde-a121-30f2ff9c8347@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/26 1:18 AM, Krzysztof Kozlowski wrote:
> On 14/08/2026 18:55, Alex Elder wrote:
>> On 8/14/26 2:01 AM, Krzysztof Kozlowski wrote:
>>> On Thu, Aug 13, 2026 at 05:29:41PM -0500, Alex Elder wrote:
>>>> Define the binding for the Toshiba TC9564 PCI endpoint function device.
>>>> The third downstream PCIe switch port within this chip has an embedded
>>>> PCIe controller, and that implements two of these PCIe functions.
>>>>
>>>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>>>> Signed-off-by: Alex Elder <elder@riscstar.com>
>>>> ---
>>>>    .../bindings/misc/pci1179,0220.yaml           | 150 ++++++++++++++++++
>>>>    MAINTAINERS                                   |   6 +
>>>>    2 files changed, 156 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/misc/pci1179,0220.yaml
>>>>
>>>
>>> There are no properties in the binding except standard PCIe ones, so why
>>> do you need it in DT in the first place? We do not describe PCI devices
>>> in DT by default, so you are doing something unusual. Commit msg should
>>> explain that.
>>
>> Maybe because it's using pci-ep-bus?  I'm not sure I can answer your
>> question though.
> 
> What is pcie-ep bus? If a device is a PCI device (so not the host
> bridge), we do not need to define it in DT except a few cases and this
> does not look like one.

It's a weird case because PCI has its own enumeration method,
so there should no need to involve devicetree.

Nevertheless the pci-ep-bus model *is* a devicetree thing
related to PCI, describing devices accessible via PCI BARs.
   Documentation/devicetree/bindings/pci/pci-ep-bus.yaml

It is used for the LAN966x SoC, however that driver loads
the devicetree content dynamically using an overlay, and
its overlay source is found under drivers/misc:
   drivers/misc/lan966x_pci.c
   drivers/misc/lan966x_pci.dtso

This use of the LAN966x has no devicetree binding.

The Raspberry Pi RP1 also uses pci-ep-bus.  It, however
does have a binding:
   Documentation/devicetree/bindings/misc/pci1de4,1.yaml
>> An earlier version used auxiliary devices.  This time the PCI device
>> sort of stands by itself as provider of the endpoint buses that are
>> used by other devices within the SoC.  There is otherwise no single
>> driver (e.g., for an Ethernet interface) that is implemented as a
>> PCI driver to bind with the hardware.  The SoC drivers will all be
>> platform drivers.
> 
> All this is driver explanation, so does not really answer my questions.
> Whether something is using platform bus or auxiliary devices it
> absolutely does not matter for the DT. It cannot even matter for DT.

I understand what you're saying, and I do agree with you.

Still, this is a strange case where the devicetree language
is used to describe devices and properties that are not
discoverable, using this pci-ep-bus devicetree *technique*.

The core PCI functionality gets discovered in the usual PCI
way (enumeration).  But this allows additional hardware to
be described.


I think that if the devicetree language is used to describe
hardware, having a binding to explain what's valid for that
hardware description makes sense.


As I understand it, for the LAN966x, the original use of the
SoC used an internal processor to run Linux.  So platform
drivers for the devices within the SoC were created that
matched with compatible strings, etc.

Then in another mode, LAN966x is used as a PCI add-in card,
and the pci-ep-bus allowed all of those other drivers to be
used, unmodified.


So anyway, pci-ep-bus is an odd situation.

If the answer is "don't create a binding for this stuff,
even if it gets defined in the devicetree file" then
I'll accept that.

But my instinct is that it's good to use a binding to
describe what the DTS describing the hardware should look
like (despite it being accessed using what amounts to a
logical bus).

					-Alex

> 
> Best regards,
> Krzysztof

