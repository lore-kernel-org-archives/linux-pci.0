Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6A6522F0C
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091429; cv=none; b=jLtInbAh+p2b1i/hlmFSXLJmoXBVRSN92ZsTSf3Oj/1V2dOb2g79DKXRR2UxvHbwO0OadwcnLSvWYGkRHvYEyteEhP5IlbUjSmhyaxyRKJLL4g7c/8KfcpnyrDIquDeIr4UZGBrDQs5IOF56WFiTfIRsCD+/AjYqarVU9FzKO6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091429; c=relaxed/simple;
	bh=hE3f8QdWqnVhUuJM36XTgD2Q348p5LglREhubn7I+ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrSmy7vLCoXz4LnQL6Fg7rC9FemNzDUcDboCi3uQJ2LQQ+bkS3eBzvaMfqt20/8FO0kiTFCObAbSy3pI0DfsOOw9Fl63bgU1LHKD+1wxmBNgHedrZyZ/KRO1etpMqg1UUXs4Cfuo+RzscwvzHOfGZr9Ks+r6ZQLqKEn/FFX2Ffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VV6K+DVN; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VV6K+DVN"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ab4178ee33so3316308a91.3
        for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 12:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792091427; x=1792696227;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fpovG3xe/GFBxw/GZpFun0w46KPpZR7RwgjQ0+f5SJE=;
        b=ru+Rjhgsg187T3kx1lsSja3/KIg1i4tCQM+vECKUSr7A8acX4+86wSAZn6SFA0SsIQ
         HTjNMMyty2moxLQvE2qS0cCNWMq9x1TLcoUQo1klSF8sChD8aFch4OjwVQ9TyI5A79lM
         poGxwUgGmDv+ZtfvYok+ie+NbJDq25o91Kd35RjhmuPXG2gf1bLk2FrlU0t976FscpLn
         /U6Zno6VRuCkZDKox6Lg0x2o7j3iWqqBoDDkZOCPGCARaOKYotKIssfw9SclOS1MwbUB
         yUYSFHccu9mfKDTZnmwqUyBZbefJvFedHvSHVYkYuLbsFc345S43tYad2qewNEwVzw2Q
         C3sQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxZIDPv8qWx0mBszA1imXQv6D3qx58ixLkkThPJVgjGvvAZU8GHmU1VC2DRrgglpc/aCRt4F+Ucwk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKLEv96TKMwYsX/L5VHFN/SuV3lrqbIJH++tuoryvEhBObuHR7
	E6FfvgEBoHO3pqrygqrJLmXJdGKTBttw/Z6Vk2O0aAurPtawJNHptbIf6WkHChz1quA23nlacrT
	JRnduECPqW2c7TB9bRlsbmvvgJRQfvjZSmGPVwKF9mobNK5aDBGe/yidsVMp3ljQJd/J5bR0GY1
	lxg3MIxJAeaHPmxrio7MZRnZnEJ1MqaQ6BwQ3BoQUnZ8g3JQZygQ/qXUpfh/WRopZsvAMN5bOtv
	JyhsMgne2upWNpRZwiY
X-Gm-Gg: AYBFou0ICPaDVPFjWG3qW8vOpygu5Oufp/0SSMAFxawMzktAUdig0ziefOvhIpgfmgs
	CHc6byTzxjPkO3sk0a9cM222toCPmH1OZdbRBw9aziuPDdDg/+BE51w5nKku5reK4bPF8LSKuZg
	8/1HE/eJ43PhtjWviXsoeDyK3pNdOnjoQDfZ/n76Z9eXi38vDCVt5W/LKll5lRtY8Q8r0VsP++O
	xNnaOZxS7cbZDrB2npunvczZrM7U9INEZ92nfs1LxaQ8D+Is8XUVHyE6/IpE6sOfOTwiBOdYuHT
	ESl5hFuuGiGd5kik2jptFUBAxPzCAmPI9RH6LMBxZpjosPltp2pfc2ziD6LxIkL3UF5ylk2TZNz
	y4yj4A+MiQBsmeH07DsBtpdMnKq9B4mLJ3xw/zyfk7STDDMwlPrkAYXa+x/9Rr76hMva/cCy249
	9obNWQ5ydBpjBl2K4c6m7s2DRnSVMaMeX+YRIN0XV59VM=
X-Received: by 2002:a17:90b:3c0d:b0:3ab:b39f:41da with SMTP id 98e67ed59e1d1-3abb39f450amr13105013a91.11.1792091427239;
        Thu, 15 Oct 2026 12:10:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac944741d8sm2140582a91.1.2026.10.15.12.10.26
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2026 12:10:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cbacbb996so900066185a.2
        for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792091426; x=1792696226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fpovG3xe/GFBxw/GZpFun0w46KPpZR7RwgjQ0+f5SJE=;
        b=VV6K+DVN5vaRfTlBAHAqkf37WriJyaIgIDifIHp5nZMsvzTOhB5i3Tcu768etqPYX7
         fdBhBIFS3JlNk7MWbRRmT1mrn+QqbPIhUcE8YHsMfeOxDjLcxdPR66QU1PNFZlPZAfWj
         wDWBNffboufNooiacKahpBD3FutI8sAtdsXNc=
X-Forwarded-Encrypted: i=1; AKwUvBzdXiIOWU3JERJJ1w6R/KIK7cwB1VWf+ZzW4g4ri2TDKtSlmn4gCat90e3+FQHFMfw5DKvmF6F8GEU=@vger.kernel.org
X-Received: by 2002:a05:620a:19a5:b0:93e:acdd:acd9 with SMTP id af79cd13be357-93ebd0cb796mr3250024785a.7.1792091426076;
        Thu, 15 Oct 2026 12:10:26 -0700 (PDT)
X-Received: by 2002:a05:620a:19a5:b0:93e:acdd:acd9 with SMTP id af79cd13be357-93ebd0cb796mr3250018785a.7.1792091425443;
        Thu, 15 Oct 2026 12:10:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcb8b4c51sm3232936d6.5.2026.10.15.12.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 12:10:24 -0700 (PDT)
Message-ID: <f7cf09c5-dba1-4501-b93e-ce4ad555edeb@broadcom.com>
Date: Thu, 15 Oct 2026 12:10:22 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] PCI: iproc-bcma: Use EROM instead of devicetree
To: Semih Baskan <strst.gs@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Rosen Penev <rosenp@gmail.com>,
 Rani Hod <rani.hod@gmail.com>, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20261013220421.1588051-1-bhelgaas@google.com>
 <0dcfb2db-5536-465a-bee1-afe160535748@broadcom.com>
 <CAAsRjR=_Q7aT6+NGAszYx=FkFMYWtp0HVe1KJwLwHEVhR0ghSw@mail.gmail.com>
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
In-Reply-To: <CAAsRjR=_Q7aT6+NGAszYx=FkFMYWtp0HVe1KJwLwHEVhR0ghSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/15/26 11:51, Semih Baskan wrote:
>> Humm, this is not materially different for me before/after applying tihs
>> patch and unfortunately but here is what I am getting with these two
>> patches applied on top of Linus' master at
>> 0fcb05b72344f40806cbe810de8872f1698bf053:
> [...]
>> Unhandled fault: external abort on non-linefetch (0x1008) at 0xc896df40
> [...]
>> r3 : c896df40  r2 : 0000ffff  r1 : 00000f40  r0 : c1ce1a00
> [...]
>>    pci_host_probe from iproc_pcie_setup+0x8a0/0xd94
>>    iproc_pcie_setup from iproc_pltfm_pcie_probe+0x10c/0x1d4
> 
> The series only changes the pcie-iproc-bcma path, and this kernel probes
> the controller with pcie-iproc-platform, so the patches do not run here.

Yes, clearly not enough coffee, thank you Semih.

> 
> I think the abort is the read of APB_ERR_EN at offset 0xf40 (r1). I
> measured the same on an RT-N18U (core revision 0x01) in September: the
> platform-only kernel does not come up, and with this one line it boots
> and enumerates the BCM4360 [1]:
> 
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1388,7 +1388,7 @@
>           break;
>       case IPROC_PCIE_PAXB:
>           regs = iproc_pcie_reg_paxb;
> -        pcie->has_apb_err_disable = true;
> +        pcie->has_apb_err_disable = false;
>           if (pcie->need_ob_cfg) {
>               pcie->ob_map = paxb_ob_map;
>               pcie->ob.nr_windows = ARRAY_SIZE(paxb_ob_map);

Yes that works for me, and I was able to establish the last working 
baseline was v7.0 which did not include 
76701239797698b620f2b7ec713fe08ef50ee664 ("ARM: dts: BCM5301X: Describe 
PCIe controllers fully"), whereas v7.1 and onwards crashes unless your 
patch is applied.

Also, the good thing is that my local test bed has been resurrected and 
will be more regularly testing now.

> 
> [1] https://lore.kernel.org/all/CAAsRjRnV-RTddO6h2XCUz2N5pB0pS8i_-_2XRcD=WOTA7AAFZQ@mail.gmail.com/
> 
> Best regards,
> Semih


-- 
Florian
