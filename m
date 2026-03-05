Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B64A351C3D
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772746730; cv=none; b=a5g/dt+K/WrO8ALUE33hicYLO52nGBMR0L9x1QMXwyBSFcE3ZNSM6UHTSQUXimy0jACfF418YoNk79uUOPVLc870FPguh2seiK6OvP4xPycnZJHR7O5UMt1s7ge/KDhElaGeroIKtpL+JbJZvi8LyxmQ/pAIVSYgj2pyzHz+Ffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772746730; c=relaxed/simple;
	bh=Uwmt26+2XzaE5le2RqtkwNQ+bnkFBIhKzYPOs/QX1lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0QJrs4nTeFskLL49ktechm1vYst1dsJvM3eZzhs4m0GxqXHVqzQKklk+IDQiD7MIFbZSkpu+VjRcPbxiYzYCcSlR3Vw6T0fLsUE4WsHe6uo9WYzrrhsebJZcRmjnxND7CFvKwgOdCsVlD2x6liAc15KsorZBm3UBkEHL1Unw/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RraeqGoI; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RraeqGoI"
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-824af5e5c81so8404133b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 13:38:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772746729; x=1773351529;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E86KQkPdedmkSR5QIoII9sxxjP2I/DVToqV/yYFJhQY=;
        b=xOKWQFZzqdkL+EjN5V4/NlogZSXRzUYAV7iuDtldUtxFYPott5HUnSW4zTDDOTwvh7
         rMMCIoUvh0ExputBk6L14/oxc3nIXaTZkwQehjb7Afg0FFrkAawEt71pSwnGDOOXLXcJ
         K7NXB6OSl2W2QcjF4SJbI9m7/q0aE7mWwIEBLlUvRHDkdABYhBIdBTS1LZCezBRq/Pi/
         Me/J7anz7SCTeVPcsZgs6AefvYDU21RDLCUUhb/Onr1X2vq1m+nqlgWMhP0id0iAo3Ab
         DOIO/d8LPiGFh7jB1IQf2puhHpQJQD5dnqhy7nvAcdqreNsotTemE15+3bZ5zHRN/oUG
         ov+A==
X-Gm-Message-State: AOJu0Yx/etgFPL82KpX+tvisGZ7yNUIb/uEqAaUsdF547cBt2hzY0ksM
	N1YAJuJTk21Gfyk/qraKyI8p9tuyufBehK6NCAgSFdYOcY17Lj5F+Hmpd6FIugc9Ls+FYkdwCow
	UvzyGX+gHkn7X3h8KjwQW2eNJq4xhkatZybejqPQpWasi/yMxXZ1VCZpiMkA2ML+FbMBv893EeK
	oCEXE8npNNVz7KYGe23jGfhmdie1bgRfGeGpI/daqvUMRJ8PfOj16xO/AT6YmaWJfzDX3+jRJfT
	2ooLRx5PGkzMfIAXtYN
X-Gm-Gg: ATEYQzxKKQHgbllswd21akKHx6vZjvXrLonGfKL+ukR840R30KAOycuJ3HargEnE1/L
	BuhMnqUMDMf86cyIP9U8zKIy9EctYGgeDBtimrjnrEz3DsZFTwDP1/KJ7XItMy462Fnq/oZN3mZ
	aggkyXRj7xJV0ppGJ5wBaxas/UMcv36ZTo+TgQb5dAmn+9WG+sYX8qaZba7VzRcRSNu25zrY+hl
	ibHLvrdBwNrqaVyORb+Hr07nvVEoXUBxPDrzaqMPR+wNWjyn0hOcGSemNMmOFcCFZ7UKhy4qqMs
	jKoaAqvyRuboXx0jAbrcxM1NEFIuLfId0S6qqKy0NiMvLX78ZByTH8o/1XkxIg2bCpvi6qZygzc
	g56lrMKvIceA0w8DgMH/cFCUozPe7AGZiwtWzf4gU+3dXd31OdiksGBq19Q9mDg46WffvSfqTxT
	E6OMHf317vwzEzSBFuiIPLVmHFx6UeeGQ7m9Yd246XwJ1Jz4Iq7yXf3RKEnClYgQ==
X-Received: by 2002:a05:6a00:2499:b0:823:877:5519 with SMTP id d2e1a72fcca58-82972ca362emr5048199b3a.43.1772746728703;
        Thu, 05 Mar 2026 13:38:48 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8298b51ec2fsm272425b3a.9.2026.03.05.13.38.48
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 13:38:48 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89a116bf0f8so195360046d6.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 13:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772746726; x=1773351526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E86KQkPdedmkSR5QIoII9sxxjP2I/DVToqV/yYFJhQY=;
        b=RraeqGoIUkIhSvmE3b6FJwiTB8KN+M6CPtR5NtxlZ9ticdRXTLHy139WFqH9Y3bR7r
         8SLigzYX7TyOb0y3KfM+DtqWnuNKcpyBuEZ8HLx/pGfFOQZ64Tx8yogRo9RAz8bGjXuX
         MVT2AXtB0kJ3a/3vlLqfefKJWasqajLbW7wIo=
X-Received: by 2002:a05:6214:27c8:b0:89a:7e2:b8a6 with SMTP id 6a1803df08f44-89a19ce5073mr110796046d6.32.1772746726605;
        Thu, 05 Mar 2026 13:38:46 -0800 (PST)
X-Received: by 2002:a05:6214:27c8:b0:89a:7e2:b8a6 with SMTP id 6a1803df08f44-89a19ce5073mr110795506d6.32.1772746725976;
        Thu, 05 Mar 2026 13:38:45 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899ef69b089sm121419276d6.46.2026.03.05.13.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 13:38:45 -0800 (PST)
Message-ID: <143704d7-2126-4191-bb86-7d6784e3c848@broadcom.com>
Date: Thu, 5 Mar 2026 13:38:43 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND 1/1] PCI: pcie_bus_config can be set at build
 time
To: Jim Quinlan <james.quinlan@broadcom.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 Bjorn Helgaas <bhelgaas@google.com>, open list
 <linux-kernel@vger.kernel.org>, Hans Zhang <18255117159@163.com>,
 Niklas Cassel <cassel@kernel.org>
References: <CA+-6iNzJM=C+Byb+wnmPYdJcYoTT7N-XwE3o2OpJzmcJrtOc8A@mail.gmail.com>
 <20260303000337.GA4038046@bhelgaas>
 <CA+-6iNzd0RJO0L021qz8CKrSviSst6QehY-QtJxz_-EVY0Hj0Q@mail.gmail.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <CA+-6iNzd0RJO0L021qz8CKrSviSst6QehY-QtJxz_-EVY0Hj0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 3/5/26 13:36, Jim Quinlan wrote:
> On Mon, Mar 2, 2026 at 7:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> On Tue, Feb 24, 2026 at 04:10:17PM -0500, Jim Quinlan wrote:
>>> On Fri, Feb 20, 2026 at 5:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>> On Mon, Sep 28, 2020 at 03:46:51PM -0400, Jim Quinlan wrote:
>>>>> The Kconfig is modified so that the pcie_bus_config setting can be done at
>>>>> build time in the same manner as the CONFIG_PCIEASPM_XXXX choice.  The
>>>>> pci_bus_config setting may still be overridden by the bootline param.
>>>>>
>>>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>>>
>>>> We merged this as b0e85c3c8554 ("PCI: Add Kconfig options for MPS/MRRS
>>>> strategy"), which appeared in v5.10.
>>>>
>>>> In retrospect, I think this might have been a mistake because it
>>>> forces a build-time configuration for something that may not be known
>>>> at build time and can be set via command-line parameter.
>>> ...
>>
>>>> But I can't find any discussion about it.  Did you have a use case
>>>> where command line parameters weren't usable?
>>>
>>> Yes.  We have a Cable Modem (CM) customer who can update their Linux
>>> version but cannot update their boot loader or its default bootline.
>>> FWIW, they only want the option to set pcie_bus_config to
>>> PCIE_BUS_SAFE via the .config.
>>> ...
>>
>>> It's a CM product which uses a particular Wifi chip.  Recognizing this
>>> scenario would have the RC trying to grab the EP's vendor-id (and
>>> possibly more info), and that seems awkward at best.
>>
>> This is actually kind of weird.  I don't know why a particular device
>> would have any special MPS or MRRS requirements.
>>
>> Do you have any more details about this?  Does the WiFi chip actually
>> not *work* with other MPS settings?  Or is this a performance thing
>> where other settings don't give acceptable performance?
> 
> Hi Bjorn,
> I looked up the original request mail thread on this -- it appears
> that the device defaulted to an MPS value of 128, and that value is
> what it was assigned. Unfortunately, this device has an occasional  HW
> bug when MPS=128.  Rather than fix the HW bug, they wanted a SW change
> in Linux,  and somehow that request morphed into a request for
> PCIE_BUS_XXX config settings.  So the reason for the original
> submission is weak and we should have done something different, but
> here we are.

Late to the party and probably could have suggested back then, but this 
seems like a prime candidate for using a PCI quirk fixup?
-- 
Florian
