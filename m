Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5828D3ED11C
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091357; cv=none; b=ViEHYOVtgR+tZ/j8nrL2MQqQ/NckH8tBfy/mSsxABb8K5DNLN7GItKdfhHnHxgyKV/q4m1MNbmNkhdly6YJq0NFg8TJlbaOnPSCZZqzRutOjC+VnMtimZtPv7ETD8uVRYZ8bHFhXZTUpwG6bMqouwIUagHRZ4j3NrmL6P+QKFyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091357; c=relaxed/simple;
	bh=UQQouORRLqUgjE8irwF3HtFW3vJ24g5VLcuvlsmn6v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fB9kMbdNHAzf0GaCpCS3PnbPao46oej3KkXI9l7UxctmLTY5fHeatJnERxsvmWDhOcyqLK2JrK71s66/HKk4upDLwQMSLuKTAPc9ccQ85EmrLi78lRRnhZUHQAjc3a73q2KZUF3iMz/p7L5LQUT2LjRUG0PeVYdprtPovsCzGl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IdF8OuJl; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IdF8OuJl"
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-42fe552aedeso2066044fac.0
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2026 11:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091355; x=1778696155;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tc35fNzFyPuxuc/CBMONA9M+RTBFlJ+zPVDNxFCN7Y4=;
        b=tODZ3/jM1nNloSw0yaF0mUJzwRPUjGLc36zNtnHHXPU6BJ9Q+/ItMJxXsn3LV6og/k
         mCT9DYULamosc914ngbaqg9OlGECwNn+gWUL/V+cdnE/6C2R7UGd4SooFgBS5rSQWNWP
         JgvqhsBnQITk1ixPOmasToM90Pzhu11KrmvIHY2hENaZMrGxs7bXDGigoYI2o7ZQuN7L
         8V+M4WpA8MGWq7x3XjeY4XOnGZNRk7cL7kThwSMPxC9S9RBllKt/M6gbQv8abJGiNOTe
         b8wWCTr4+8HwQT84qPcqn5Y16Vg+EK8GXukHwYkeHCBhEBH37h3Ra5dnu7fEbsKhswt3
         AjsQ==
X-Gm-Message-State: AOJu0YxFX/gGsAM27aPySvpcaPLiH5xherYnG9N+gPA2f0o1R0l3sKpo
	BkH53KbdzVPBC6JlV/J+1cU0KFY2hKnLevrmgQqjOnLg+6RAbKNFAtFouwqPUv39teEuEjOduyM
	hpvoikit+JBKG/uKShTs22ytt8uI798SZSsY5tP84F21lhAdeeMlvBwAHupnxAq8X47fkbYUTsw
	pizUsBzpyPUFf/FTez5b8R8NrlEwe1jq/a5YrWtltURR56WK3gOnzKgpewKDKgV0PhkH0kiThFy
	39kyGwIG0lHEAAkLqgC
X-Gm-Gg: AeBDietAMagClyn3Zg6+UCXmgW2uiBBztDuiiekbgV5DX7TnKWvHFyo1+dYAwLcepJD
	GVICeen/5hHK4eSfN5BWSsibSLfZVFVfNiZfqjGJR+8qvbSlbS7ks0gFjTfO+hSavbZrzuLoVrE
	9ruWbl/oZnbWRpno3AqJdn0mg2Wnp5Z0Q/EX86svA9oWagVpxXpEIEE/vfc/5TkraofJ6z1kj9j
	8FqEo8zit3eQYRDkL5v3Qa9y2i09n8BZzojDJb/7GbNSnW2hORvAIGhpJ8ctDrp5nqCmFQkY6BB
	MApzYvsRUGNBFlr9S3EHAGSRRyXk4w7YeJ4YDP5N06aUxWjOoSzSrIp8Vyq0smjw8oadLDY1BCj
	dkrq8AtTP8IyC+J5bMc+lCmjg/au4uX3SXUatgGrQhVrD02EDwJ47reA0Iob7M9nj8DnI8sK+W6
	/hCBoJztAnhYo3cqECciJghZn7OBjqytAQLsgphUprH5Ph1YiF0JCFrDbKvqoEeahe2iV06f97
X-Received: by 2002:a05:6870:2188:b0:417:3260:8586 with SMTP id 586e51a60fabf-434f66c1cddmr2698159fac.34.1778091355197;
        Wed, 06 May 2026 11:15:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-43454523a17sm1436754fac.0.2026.05.06.11.15.54
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2026 11:15:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2f485961555so5346927eec.1
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2026 11:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778091354; x=1778696154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tc35fNzFyPuxuc/CBMONA9M+RTBFlJ+zPVDNxFCN7Y4=;
        b=IdF8OuJl7k3ZGgZyqh5w7T1nMRvy6J1O/wkZG4sMevblpa7Cgc+z+v/643mIPvTSUS
         GROXbu6vnCqTV0kmfQJz6xj3wV+pvoly+UYY/RWVLD0zbHQeHWvTA6K1+ZpKRZeJj3Py
         Blj3kOt3Ee9vldI8KWncB9CKyEX2I6U8udeDU=
X-Received: by 2002:a05:7301:3d1a:b0:2dd:6937:79b8 with SMTP id 5a478bee46e88-2f548159736mr2514686eec.5.1778091353744;
        Wed, 06 May 2026 11:15:53 -0700 (PDT)
X-Received: by 2002:a05:7301:3d1a:b0:2dd:6937:79b8 with SMTP id 5a478bee46e88-2f548159736mr2514665eec.5.1778091353038;
        Wed, 06 May 2026 11:15:53 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f57038b0a1sm4262270eec.28.2026.05.06.11.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 11:15:52 -0700 (PDT)
Message-ID: <83ceeae6-20e8-40a5-bc0b-6231d2118b6e@broadcom.com>
Date: Wed, 6 May 2026 11:15:50 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: brcmstb: Assign pcie->gen from
 of_pci_get_max_link_speed()
To: Manivannan Sadhasivam <mani@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-pci@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>,
 Phil Elwell <phil@raspberrypi.com>, Jim Quinlan <jim2101024@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Hans Zhang <18255117159@163.com>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <mid:20260501202438.376033-1-florian.fainelli@broadcom.com>
 <20260506164537.103196-1-florian.fainelli@broadcom.com>
 <t3u7r2ee6gdkjceula2ctvgditgxibwxcpaejc7ekbgdjog3br@c6n6ztzsbhpu>
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
In-Reply-To: <t3u7r2ee6gdkjceula2ctvgditgxibwxcpaejc7ekbgdjog3br@c6n6ztzsbhpu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 5/6/26 10:08, Manivannan Sadhasivam wrote:
> On Wed, May 06, 2026 at 09:45:37AM -0700, Florian Fainelli wrote:
>> After commit 03f920936977 ("PCI: controller: Validate max-link-speed"),
>> pcie->gen stopped being assigned and as a result the established PCIe
>> link would stop supporting Gen3 speeds on 2712 since pcie->gen is used
>> to populate LnkCntl2 and LnkCap in brcm_pcie_set_gen().
>>
>> Whether the 'max-link-speed' property is not specified, or it exceeds
>> Gen3, resort to the HW defaults.
>>
>> Link: https://github.com/raspberrypi/linux/issues/7343
>> Reported-by: Dom Cobley <popcornmix@gmail.com>
>> Reported-by: Phil Elwell <phil@raspberrypi.com>
>> Fixes: 03f920936977 ("PCI: controller: Validate max-link-speed")
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> Since this is a 7.1 material:
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks!

> 
>> Change-Id: Ic5431469dd7a6c8b391f84f27119dad876256880
> 
> This Change-Id is irrelevant to upstream.

Should I resubmit or can it be stripped while applying?
-- 
Florian

