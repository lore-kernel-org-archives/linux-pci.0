Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A492E3603FB
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787350030; cv=none; b=GnKREfe4Y8aunx/aJhYeVVjhNEjE2MIzvwop15KUrsMbv5JIq4SHkR9iMl6g1YXLVxnaj6eH1natdAeI3vRnsJlVnzlcbgS19tQLOkqiEYG2NWybx5fNC9oGs1/bZVudM0t4Z1GowBXJ0p12td/Kpw6r2hKePba40uPHOJ4XzaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787350030; c=relaxed/simple;
	bh=6Sy/3+LWsfOwjXFoi32GTDWNL3NWio8b9bVSRLWO4dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofXP6We+NkQ6CLh7GjlTJEzBz9I/6qo7mDqO/ornnC8bcBbbXI0IneGZjb5xS8bP3MmzqwahGDSOGntAtKS4DW22xCcNMK94mIasLk66DcViuIDYe2uV7PwVA68XvxWkQeWH1Cxidnpfz+hqtA1vY8PmjWbILJf8jHOJzvysPDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=0ARCY7i7; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="0ARCY7i7"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52de178a66aso10388201cf.3
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787350026; x=1787954826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vz7FCoU2PHVKybedY5PjDxRaiiuKTcrRzROnVCWiU28=;
        b=0ARCY7i7/Tv8MMIqe9zRPEraAz/vVoE2Tn7WPdQGotk/GOfPGBiDeRW5fBDSegu3Hk
         EFTc3l0yDUn8jtr25OHPHoI9RDXyKUa8oNVlnpixbnmMhldmYgv1vTCdmr7KJaY5mLqG
         THPopmtXqXmz6wxCVBJvet1OVT3NQ31KCW1X9hdQOQmoZK+91dQmsGDsMmHtpAi3CwPN
         kjOZmKpsdYTUVyI7/YTd9VZJPDO8DbhuEoiatxBepxDSLS9LBm0DsZL9tZeskfj1QLJ0
         8yvuOnQg1kHZC+bGHBYUGKkqhG6IOfilTrM4/eTJDOlcRDnnw2u4rU+9Mc8yavC+PpiK
         4f7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787350026; x=1787954826;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vz7FCoU2PHVKybedY5PjDxRaiiuKTcrRzROnVCWiU28=;
        b=S6AhG37+hyEZP4u9vrUcakegtJ8Q7JsJVRn8sUib+wEeGr0BlnsdMo6Ou/lqYRap3W
         9SvHfBRKU4GIxRFIY7hJGMzrNw+uMtcCPmrH+M49JzuTdFST1fsc23Us2ZV09jTtZi78
         zZyIhJNlqqSXIiTu0FE2T6UvHqyshKYCTfhJrUAYEH2ND1TaDD2auu9Z3mlcipxZrOQB
         goWqm7H4WQtqF+A2rzdJJa/Fq0VMOYo1Cs+f6TJ3ZgCjPOU5muPYFHDTIj8krJmnSGEv
         TpaJcv4SnJ2tOcDSF90FFQc0nM/ynhzrYSlL0lZ1/W1CMhWR3l+81uwNzWzaNXdOcVdT
         BNpA==
X-Forwarded-Encrypted: i=1; AHgh+Rpi8xzPd0heWdXFgGGu4PToIozAqkZaj3jYUezCKy766mGUxyufToTCArg5VRu4VPw4sj4pciwunoo=@vger.kernel.org
X-Gm-Message-State: AFuF++luqrTA/dyfJDWITZLW36uJVke6oiXLsH1MmE+NDW5L4Fq6US2H
	sR19C5iByDlblu5BUDdahoIQLKTyIDlZt5amBrQqnQp/C1QCgUAxxVDK2I7EkHKKZqM=
X-Gm-Gg: AR+sD10StsdCKusyqdDOa5310iNz4b9buWE1DruQlOkghpfbYurAzHO5jyVwCgjx9OX
	vuwL0nT6xQQxrDkL9sjDr0qdCo2qGY/Zo84BWhvjzHTghQ4vN2aPXY85ugngqqBthOz1O5kN4bJ
	yMHcmNFTxW3/FYhEfA+kYNLszc0Y3pRU8MNvYWjydPGH9Ab0JVbCIUJFXKcZykWqZTvR8M/yRtr
	rMB5XdlrnEfxPOkyyRYJVdVj4Kb1Ukel6tGH5US3SeokWonxzQGqfLiKaaEnpcUwoLi5qSLUlxE
	UGRPhjB3QvfvIR+U62YKLo53OhkVNZIT7s9bIudyDYOOD9BSBzcOQKzV8Nx6VqeFyxr1vJAR8Rr
	8sJB5S9FIfxGOUCvyp/HSeeaz/lKFdIVfsUjUVzalA+nHUdBZJ81PchSeLjTCSPxEQH4r/nlJQF
	yr+a8xHhUf8I4DGIC5L6UbgNt1mKAGQONkqxRwXLEPwFiy0wQZTObUWn9xA3R7
X-Received: by 2002:a05:622a:15c1:b0:51c:15bb:b4f2 with SMTP id d75a77b69052e-52df5a01354mr89780901cf.27.1787350026378;
        Fri, 21 Aug 2026 15:07:06 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e09aca33esm3721411cf.21.2026.08.21.15.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 15:07:05 -0700 (PDT)
Message-ID: <d188963a-e5d1-478a-a0bc-9ee69e34517f@riscstar.com>
Date: Fri, 21 Aug 2026 17:07:04 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: misc: introduce pci1179,0220.yaml
To: Rob Herring <robh@kernel.org>
Cc: bhelgaas@google.com, conor+dt@kernel.org, linux-pci@vger.kernel.org,
 mohdayaa@qti.qualcomm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 daniel@riscstar.com, krzk+dt@kernel.org, arnd@arndb.de,
 lbiancon@qti.qualcomm.com
References: <20260813222943.1655453-1-elder@riscstar.com>
 <20260813222943.1655453-2-elder@riscstar.com>
 <178682676059.2183315.4478974489132403040.robh@kernel.org>
 <e98e8996-1ae8-47be-8854-55a004530c85@riscstar.com>
 <20260821191011.GA4061718-robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260821191011.GA4061718-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/26 2:10 PM, Rob Herring wrote:
> On Thu, Aug 20, 2026 at 12:18:45PM -0500, Alex Elder wrote:
>> On 8/15/26 3:46 PM, Rob Herring (Arm) wrote:
>>>
>>> On Thu, 13 Aug 2026 17:29:41 -0500, Alex Elder wrote:
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
>>> My bot found errors running 'make dt_binding_check' on your patch:
>>
>> I don't see these errors, so I'm probably running an old version
>> of something?  I'll try to sort it out.  Sorry about that.
> 
> Are you setting DT_SCHEMA_FILES? If so, read the rest of the msg that
> was cut. :)

Yes I do set (export) DT_SCHEMA_FILES to the file I want to check.

yamllint --version
yamllint 1.38.0

pip3 install dtschema --upgrade
...reports a long list of "Requirement already satisfied" messages

I suspect I'm running local versions and something is out of date.

> You can also now do 'make misc/pci1179,0220.yaml' which checks your
> example against all schemas rather than against only your schema.

That's good to know.

I'll spend some more time trying to reproduce the errors soon.

Thanks for following up.

					-Alex>
> Rob

