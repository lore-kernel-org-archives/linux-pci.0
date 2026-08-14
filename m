Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69394486E5A
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726528; cv=none; b=Ku4ec3QhpnlgDOxLfX4NAXBI+P/lmrbhup8DZl4Jhud6UDr+I3AFs2qH6Lx8wetGvoYc8UVAZM5TjgQiooGCpXIkkSOrD+Yp2cpm1CUbA54CDDMjggO1gVHWi81p2fQ61ERO59ZMlyaYJ/2fk9ogZ/VAKvxz8QmWfknH1ChRtss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726528; c=relaxed/simple;
	bh=WqmD5hXYOAK6kBvhlyX9kY4EFHWaHHEjeY00+AR2Vzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Op4WyIZG7AnS9tRCNY1VocLYKnwhtGNGvZxBPhH2DfwxvQwyR4tY4Um4syyRY31bR4l7h8AEanGlILNJalemCSfsYt8LaNUCsKgfXhmRBGup3T5AP5ShZIiyrDpiLROxLwnD6OH09hj2RxSt6+2RRFy6ZoWkz86KvKQ+cAkz/1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Q3kJfHfE; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Q3kJfHfE"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51a868b6962so13333271cf.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786726526; x=1787331326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MBdDNyiCPGHvqfQIw5TnuF+7Orj5dVBLCug+K5ZvgvU=;
        b=Q3kJfHfEJlIWB0LDUDyD+PHkvC5HpNL+bUBXYvoAEGUF9TuDCgno5MFbIXWwmtggbg
         mbopcxjH3wNpzOzHVLKx6+Y2WNY7WNn9AgzPB1PM7ChF9s156zoEh+ejU6ifz/bEnztS
         jsEk6hlg5HiAIgVYE+EcAMef8csKoJ1My3ro4Z2yFvkG9oK38vkgSFwBdl1JGV6qiykW
         oQq9rFW6XN41kBEiEK83xKmouDYEtI1pbhSWbnEl26SapwoYS6rl7VwexiSSzVU7sWuU
         0+ycPJme4DfeuChclO5WWvoiL4XNk/KS3wsrrQS5zmHqzmQ/GXKptFMrf8A6L9AAsFhC
         kWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786726526; x=1787331326;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MBdDNyiCPGHvqfQIw5TnuF+7Orj5dVBLCug+K5ZvgvU=;
        b=VXmio6YKrkT34qvKjrb9IaX5ozV+cVqU8Uk7CgYqDZPGGImPYcV75kTRSjWL5lqEAW
         GpctmiQJ6GghIUGTMu0A5flQAu5eG88BEX5gA3NBKkjXQI1Cndk19mF23HyrPLDMlicr
         adq6U+5ENphM1qQXqp3CIWVOmHPpQfmC7Fsb0C0hVUW/922D0uHFaKnD6kZHp7907e6S
         cZRb8xMCGT2VS4xwrU1ecf8rgWjY/xbH3GnmzXA4iYkohK900RbmrqFmmgqCeH5OLl+N
         Hv3rvrk9+9IAqs2zWo6HolX7dMCVOMrfDKslIz86UVJsveQ44ZLv6Mlk0Bwhw7fkDSLC
         4PPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpTE2Lea4jZMAd3UlOH+iXIjp9W7wVLlq2w6QRryo14ufQ2rinPPbGum6QHrV9HPvoYeZs1Zl3U1rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwWf8dISpSgFKTViMKDr6vB/6ng6orOhFvUSU9f1V+vo3nTlPq
	OsODBw4poyPF+udJkZ12y5fFH1ycFaL0WGzR+dW+u86u+kM/zaKhxY/kdGeX2h7zXZ4=
X-Gm-Gg: AR+sD12nJpa37PE5cX1k+U/ZS146/fqMj2Y/kdqqm+KJYPWrXwbllItlkwk4yOMIuMT
	zWx4yxJAagCoFWjy+ac8CoNPLaW3IqC/2yKG2u8UnukbSREV8TU4cIPp0ayNtqQBInTPOUU/xNH
	ErSHb/HRYZO14D1Cxa8daVdzgk6hjXKrQzhG/A+CaKVNPthl7uBENcvGP+pf46OU6eUp1fqFl54
	AlVKDu6JCqzYbij+9OBkq+im6SRyKa9CKZDUnEf0PKZm/eFv0rzL083rtJIKrB2A/Z7bwjeJJw6
	Ev8aECANIFT6Em6lsM5Ef5zI8veNplbKELuQLOhTizRkia1dVR81DiSZCFihyQnMEKGw19QeRa6
	UcVUXh60+T/r9ZnTe7yb6x03YVf5i4mrcMqPvpLMHVmTHEoKrw2+aWn9ZksMx0j8Rtqz2jcHdNv
	cO4eth1rJLZX4FgXNxkkunYb55U1Nf9ILMCjK+QuRwzN0qaBdN9JE5bW4e7n6T8nF3W9TIqJU=
X-Received: by 2002:a05:622a:409:b0:52d:844c:b176 with SMTP id d75a77b69052e-52d853c9846mr76430861cf.11.1786726525996;
        Fri, 14 Aug 2026 09:55:25 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d84071799sm24476161cf.20.2026.08.14.09.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 09:55:25 -0700 (PDT)
Message-ID: <8c33e30a-e35e-47d4-a851-c82e18ed7472@riscstar.com>
Date: Fri, 14 Aug 2026 11:55:23 -0500
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
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260814-deft-unnatural-teal-1dbac3@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/26 2:01 AM, Krzysztof Kozlowski wrote:
> On Thu, Aug 13, 2026 at 05:29:41PM -0500, Alex Elder wrote:
>> Define the binding for the Toshiba TC9564 PCI endpoint function device.
>> The third downstream PCIe switch port within this chip has an embedded
>> PCIe controller, and that implements two of these PCIe functions.
>>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   .../bindings/misc/pci1179,0220.yaml           | 150 ++++++++++++++++++
>>   MAINTAINERS                                   |   6 +
>>   2 files changed, 156 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/misc/pci1179,0220.yaml
>>
> 
> There are no properties in the binding except standard PCIe ones, so why
> do you need it in DT in the first place? We do not describe PCI devices
> in DT by default, so you are doing something unusual. Commit msg should
> explain that.

Maybe because it's using pci-ep-bus?  I'm not sure I can answer your
question though.

An earlier version used auxiliary devices.  This time the PCI device
sort of stands by itself as provider of the endpoint buses that are
used by other devices within the SoC.  There is otherwise no single
driver (e.g., for an Ethernet interface) that is implemented as a
PCI driver to bind with the hardware.  The SoC drivers will all be
platform drivers.

If you don't think this is needed, I'll gladly accept that.

But the PCI endpoint bus is a devicetree construct, and it seemed
to me that using it needed to be documented somehow.

I'd appreciate guidance on how to think about it so I can document
it properly (or not).

Thanks.

					-Alex


> Best regards,
> Krzysztof
> 

