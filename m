Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E61A411A10
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274696; cv=none; b=DUWdwEHTzoqg17bnh1RPs1YvE1QrN5kUF0mKnYEG6ST6wCAj3tkoY32cPyB3CrZqkByo55qTHV7uyufuUAchNwJrMigR6SXEeVAIpu4GpfhhXaCrp/Xb0Cp7SbJjw6wex3uWGKO72qSgIEHMywUD5ZPG4npDZbpmMxez3TEm/b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274696; c=relaxed/simple;
	bh=xksdRuihJ6RQTqUvVSFVXcRtvXMnSxoSEw/clmOQOt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijksHQPJSm5K5rXDTtjtfcrRfI7XR2hM64/hR0zIUFu8RhkSetMcC7W7rf/O4ocPREwFvME9jDftd6egnuj4s3s4yfZzYQbiZN6DbBlx6ArvaSEENrhsCp03mA3ml7K6dq+Q/wLWfvZmmAmUiiaKnHxGjaGk09kKB5lkdPo71yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=VyDC4Wv1; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="VyDC4Wv1"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c0006ea8eso48793171cf.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788274693; x=1788879493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KCwYat8AACN3jrzTsU7VQdP9QBM1LUdIVo5Kd7wh13Y=;
        b=VyDC4Wv1EUCDYNddG/RWCy+vUU0cVHnUEapNQGjogg64q60bySJhzHazdP3mxvyv5T
         VTIiLb/R+gIki/mIfR3SpGU6gDSd4uVIR75EZhhk/ZLFZZ1cv5eW0HKg0gQvXPERt604
         52uZqKte+feGj60AGWNxP9hPmeeH/QpNfVC1akHPYKok9CtU5N6vrxF4bA9f5rFWgJlv
         R0hTNAw6wNGsEDNdJvjLeA6jCbH9u747RNGRl7rFF5PYbelS3ptuGRL8loe3XNzuj2Tq
         QMvw4OS9FCmoAxwfXnxqawqWDLd9yPeEtbSQcPw6jdlBtir5IU34UNI6qXn6gu15c4VW
         BbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788274693; x=1788879493;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KCwYat8AACN3jrzTsU7VQdP9QBM1LUdIVo5Kd7wh13Y=;
        b=K6zUJd58cKbN3vyVUyyUlK+uAqBJEbSfMAF82Ez6kTBkt0zcU+EXwgtFk2AHO7BZSO
         DhSFGS4x0I5IJPNbJnYdWFEjOu9kdBBh/XoBT2bY5usDQ/t13DkXcJ6KJLtzrcQIehFW
         BsfR2wf4wNh7SHTiuAdWP0aAlZUq+Wdtyl1zOBWYUr9SjPfaGWXNr9ZPjYq904WJnzWY
         CD2ZRZEih92LN8CUVwQsC+Lw46uaFlnoPiE2+JzBW/w8ewg+1GbcdiQLE83bVIKxl4Xy
         Zy4E8Lg1Wp40zYygfoe9RMRyqgpa95g5HB0f6k69WFWycahhPfYRK+/XSSYYlpqzjAqJ
         FUyw==
X-Forwarded-Encrypted: i=1; AHgh+RphYt43pNiWPbtP+kORUP4d7ulKg0AhxicPk0opxtX4kIlSS6UA9VCnjvcURff8x97luZPcCTYY288=@vger.kernel.org
X-Gm-Message-State: AFuF++ljwHqTLitH2rTgxq+SXoBHsoelySEzRSzLEo8uJRTbNj5S+EOr
	BnoJ8M9KlcgNkK3Mb0TOzMC2v5dfAGLvlrcHyDIK/Lg0VJN7bZ8nL4IxzL7UTYWkXLc=
X-Gm-Gg: AR+sD12dJE4hHfB6ncX2ECF7IB3VAmwvcowU0zVarkaz9zFAHturYMwXTs1ymlb8TTa
	DhZAO13Yk0YRL6UYtTTu57EUIv67ZsEBrpVczZMvwjyJrkMXWqK0z8RqoJc1bZOlK2ub3zwoDNC
	pM6IrmZgpr9HykG2D6sHI7cfAGjHLoOWihan6y73BgAvCeNbGBy4xTg6TMrRY4tjbwNn/mQ8cqN
	IGD+yHJ9tLxp/cwPAAVg2T14v9NPWbNTkeQYW26aZbmJVRyPu5ugP9QgjAU8N4VFKO9XaRClsdh
	uapGxd23Y1qPLjsO2N2hVdlzinp1CsE6yTUbUmAV7jo61Fy8OvWxkeLXXY7uN6Tji4HHqaPsMmD
	MV6pBaEM0NejS3mHzM4slGUBFpUHVF+xDo0on27cvstF4BZ4l55EPK1Hpdx9Gb2/TqnV8pJOJz9
	JkhpGFktK6e4otg/zOYmnn/WVlx/UxNWhCBLWTRCDj9KcftsEpvDnD4s27nduc
X-Received: by 2002:a05:622a:c8c:b0:52f:a319:da85 with SMTP id d75a77b69052e-52fb96af1b0mr447135601cf.39.1788274692940;
        Tue, 01 Sep 2026 07:58:12 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ff6f363fasm81508941cf.16.2026.09.01.07.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 07:58:12 -0700 (PDT)
Message-ID: <6a5bec41-71ef-4d9c-a34f-77d166b15ca6@riscstar.com>
Date: Tue, 1 Sep 2026 09:58:10 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] of: address: kill of_node_is_pcie()
To: Herve Codina <herve.codina@bootlin.com>
Cc: bhelgaas@google.com, robh@kernel.org, saravanak@kernel.org,
 daniel@riscstar.com, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260901011338.1323243-1-elder@riscstar.com>
 <20260901011338.1323243-5-elder@riscstar.com>
 <20260901084546.424c6ef2@bootlin.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260901084546.424c6ef2@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/1/26 1:45 AM, Herve Codina wrote:
> Hi Alex,
> 
> On Mon, 31 Aug 2026 20:13:37 -0500
> Alex Elder <elder@riscstar.com> wrote:
> 
>> The of_bus->match function for the "PCI" bus type is fairly liberal
>> in what it accepts as a PCI bus devicetree node.  If a node has no
>> device_type property, it even allows a node named "pcie@" to be
>> accepted as represnting a devicetree bus, though it issues a warning
>> in that case.
>>
>> A recent PCI commit introduced of_pci_verify_node().  When a PCI
>> device is added, if it has a devicetree node, that function checks
>> its device_type property.  For PCI bridge devices, if there is no
>> device_type property (value "pci"), a warning is issued.
>>
>> That warning duplicates the warning made by of_node_is_pcie(), and
>> there's no point in that.  Avoid the second (OF) warning by just
>> checking the node name directly in of_bus_pci_match().
>>
>> That leaves of_node_is_pcie() unused, so get rid of it.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v3: - Added (new) in this version of the series
>>
>>   drivers/of/address.c | 12 +-----------
>>   1 file changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/drivers/of/address.c b/drivers/of/address.c
>> index 499d37ceae210..ee2eb44884d85 100644
>> --- a/drivers/of/address.c
>> +++ b/drivers/of/address.c
>> @@ -134,16 +134,6 @@ static unsigned int of_bus_pci_get_flags(const __be32 *addr)
>>    * PCI bus specific translator
>>    */
>>   
>> -static bool of_node_is_pcie(const struct device_node *np)
>> -{
>> -	bool is_pcie = of_node_name_eq(np, "pcie");
>> -
>> -	if (is_pcie)
>> -		pr_warn_once("%pOF: Missing device_type\n", np);
>> -
>> -	return is_pcie;
>> -}
>> -
>>   static int of_bus_pci_match(struct device_node *np)
>>   {
>>   	/*
>> @@ -156,7 +146,7 @@ static int of_bus_pci_match(struct device_node *np)
>>   	 */
>>   	return of_node_is_type(np, "pci") || of_node_is_type(np, "pciex") ||
>>   		of_node_is_type(np, "vci") || of_node_is_type(np, "ht") ||
>> -		of_node_is_pcie(np);
>> +		of_node_name_eq(np, "pcie");
>>   }
>>   
>>   static void of_bus_pci_count_cells(struct device_node *np,
> 
> The warning here was printed based on the node name whereas of_node_is_pcie()
> prints the message based on the 'device_type' property of a pci_dev node.

You're right.  Both warnings were getting reported for me, but for
different reasons.

I would be happy to just drop this patch and live with two warnings
in some cases (we should rarely see either one of them anyway, right?).

Is that OK with you?  Does anyone feel this patch should be kept?

Thank you.

					-Alex

> For PCI to PCI bridges, no problem the warning is indeed duplicated but what
> happens for the PCI host controller?
> 
> PCI host controller drivers calls pci_host_probe() and are seen by the PCI core
> as a struct pci_host_bridge.
> 
> of_node_is_pcie() is called for children of the PCI host controller (i.e. PCI
> devices scanned on the PCI bus handled by the host controller) but not for the
> PCI host controller itself.
> 
> The OF node of the host controller must have the 'device_type' property set
> to "pci".
> 
> I am not so sure that this warning was duplicated when we consider the PCI
> host controller node.
> 
> Can you double check on your side?
> 
> Best regards,
> Hervé

