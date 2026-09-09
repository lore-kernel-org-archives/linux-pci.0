Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE8F37756C
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974605; cv=none; b=EgA9R3/aWX/iQAF4anyq5d1FE0Q3rrLXxwkvQLjsRvvvBzOOY3le6hmf9lRLLAO2PYVO08ByBH0MSu8URvkigX5ffRozWQFjtDbPGsP2ZDOg3ACYKudK3NgfmRwempZQyOsaaJHBtfsZcX8cww0WHFQrRpH5Bs+sHXuUpgKh/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974605; c=relaxed/simple;
	bh=Ma/L5v3/MIxJsem7izls5YWzD6Lvnm0x0/IZS472r/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sc+ScJh5UH39lJxmcPYoVdBxxpLV5PsiL8M85B61jpNrVlRF5MnVnjweaFOahqDeEjrfg5dw2zqcuiyAoHZ+8NHcQMqCT7DyszViXxGBtLM9zzqmEdqHUf1+AVWElMyx/xdMqXSwgeNwLx1B0qqqHoYgl6odUySdVJgE72K5e4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=ZXjya9uc; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="ZXjya9uc"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso8558525e9.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 10:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788974600; x=1789579400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wiZKD6CltG7hf1k/8sp0Tt8gHPp1c75neCIdHUU3hrk=;
        b=ZXjya9ucptK6Uknx41A3wNMle/kzi0pyzSSA8sPDDc1idGRFs9pPg7xEwsGSdDjAV0
         iCTMeQK585+NA/B2LQDzPL5+eEfMKQnSLMvCPY1aABfDVERICQPikVZVF1wCkaWKDSQk
         y0V2azjdFv8XgFH1YmcuT5d0Gb8IG6do3tJTe0a705Fm82f7mXr06wfepx0K+xs49Xm/
         XuweYqX2Df7dEP+RM1M0AvejvURl3Uw/i4N+S/t3hzE8QTtYOyaf/v/ygZ7UbRD2qnyI
         0U435Z3aoZZeok8QBN6TBdSIzGUGKi0lvZkxFojZNwNBCnKvuQppkgA+Pe+/ZdZ6g7vY
         ZSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788974600; x=1789579400;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wiZKD6CltG7hf1k/8sp0Tt8gHPp1c75neCIdHUU3hrk=;
        b=D3JQK5OEvBi1LHB0YY22bsyQSYWsRUxYI7kEdhmX5JHHB8xdfd26wwqNTYHZP1/Ixm
         rv3qGLHmFY2Mk2kDCSFhTMP2qky9dHmOqYbQGNEVu1wdhTOb5WByVs/HSwJ0AICRBTdc
         kSX7FHw7Ad8pTyoBEP6r5MWqvRTMnBjHAqsbKkG+wl4I+Nuleb6stwfMKjTf9KGoAWuB
         JJn7o1pGF7qKC1NHiCP8Tkabwhvpi8osskMaM4Wfv/1H5eRK0hgS1yLjkY/fBNhTpZCm
         JNyEKdvFdf5RiydEi1UT3ndyzKrib/cA/Ei/MM+NHjWrwMFz6JZIP/OQ4BpjQZBNQuut
         r20g==
X-Forwarded-Encrypted: i=1; AKwUvBw2n3tWXWIkOsZayem+8zNplSMVz/VvQ90UwMiwVnHJqja0cPIepvHMKbWv5j2gcITmCrfAEG/kuLg=@vger.kernel.org
X-Gm-Message-State: AFuF++kde6qtT+dcDULyKA4MxwAyWW82M7OzYrJ8pZLZ+kz2Umbg/KXy
	vkp6PTnewsAotQaIWVX22i1cjcs7UkRHKo+WcgIdWjMjkRKjh3cXuMwCJKV1JcpWDuM=
X-Gm-Gg: AYBFou0b0xcxrEH1lauVBeofYPAu70ODpOo9qnZFDud1soQSz8QVbIv1d+ynhFqbhab
	FQqneRGUU0l7jg3LYpLtjmoFnRs78fSGOgbTZ6VFa4Dsyj3xJnaJj2bbtvPCHbHskUpQljP5FHR
	1lWYHXerlKwiRQyyhhFjUFJV+iCQLmdvGBBafoANRmXVzvNr+jpEGOmAOCoT5+wT+wkvByk8O+o
	o9r8el1cApnBU79vyq4HwcbDeqOx/CSQFhpkuJq2Sh1WQQTs/La9Od/YgtzznvaTS0W6yWBimyv
	julKo+/2OuKPHqp9tK+UsuvnsGjKMXeOyvl5rjlbys4eSKbLE1Ced6sZnRESFucPN1ujiK6M1lw
	59jb/sOIXvQZgM1uqg6g9vvBabRne94+sldczWDdjLntBJz0TVBC9xM6rdVKaty0Tke9tcsBD3a
	F60CpdgDXM2gCD9uvDfZ4WIHuFROrpsHJE9zUV5snHs7nNOCfGHKHxsHsZVPCqNGyxcZnQzJs=
X-Received: by 2002:a05:600d:8647:10b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49d26d863famr3428865e9.1.1788974600288;
        Wed, 09 Sep 2026 10:23:20 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26bf332esm5336325e9.8.2026.09.09.10.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 10:23:19 -0700 (PDT)
Message-ID: <c2d7637a-a99b-435a-b625-0f9d8e94111a@riscstar.com>
Date: Wed, 9 Sep 2026 12:23:15 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] PCI: of: introduce of_pci_verify_node()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, robh@kernel.org, saravanak@kernel.org,
 herve.codina@bootlin.com, daniel@riscstar.com, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260909163727.GA230382@bhelgaas>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260909163727.GA230382@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/9/26 11:37 AM, Bjorn Helgaas wrote:
> On Tue, Sep 08, 2026 at 04:34:58PM -0500, Alex Elder wrote:
>> Commit 407d1a51921e9 ("PCI: Create device tree node for bridge") linked
>> the PCI enumeration process together with devicetree, creating a devicetree
>> node for discovered PCI bridges.  Its successor commit ae9813db1dc5a ("PCI:
>> Add quirks to generate device tree node for Xilinx Alveo U50") shows how
>> to use a PCI final fixup quirk to also create a devicetree node for a
>> non-bridge PCI device.  These changes allowed devicetree overlays to
>> describe components downstream of a PCI device, by providing a place to
>> attach the overlay.
>>
>> Note that the dynamic devicetree node is only created if the device didn't
>> already have an assigned node.
>>
>> Later, commit aa7b4bbcb3a1d ("arm64: dts: qcom: qcs6490-rb3gen2: Add
>> TC9563 PCIe switch node") *pre-defined* devicetree nodes to represent the
>> PCI device nodes that would (also) be discovered via the PCI enumeration
>> process.  The devicetree node in this case is created with the content
>> from the DTS file.  So when a (host) bridge is done being initialized
>> during PCI enumeration, no node is dynamically created (the commits
>> mentioned above do not apply).
>>
>> Ideally, any pre-defined PCI devicetree node would contain exactly the
>> same information as whatever the dynamic creation process would produce
>> (though it could include more).
>>
>> However that is not the case for the pre-defined Qualcomm RB3gen2 nodes.
>> And in particular, the endpoint (function) nodes include this property:
>>
>>      device_type = "pci";
>>
>> This is simply wrong; that property is meant only for bridge nodes.
>>
>> Rob Herring requested that a runtime check to be added to spot this
>> specific error, only for non-bridge PCI devices.  Herve Codina further
>> suggested we ensure that bridge PCI devices *do* define the device_type
>> property, with value "pci".  We also accept "pciex" as the value of the
>> device_type property for bridges.
> 
> IIUC this patch basically adds a warning for ill-formed DTs but
> doesn't otherwise change any behavior.  Obviously a developer could
> fix the DT, but what would a user do in response to the warning?

You are correct.  It really is meant for developers, not users,
and no user should ever see these warnings.

> Is there something that doesn't work when this warning is emitted, and
> fixing the DT would make it work?  If so, is there any hint that could
> be included in the warning?  E.g., "DT device_type is missing; can't
> support X"?

I discovered this the hard way...  I'm implementing a PCI endpoint
bus, and didn't realize that endpoints should not have the device_type
property (= "pci") specified.  These endpoints *did* specify that
property, and as a result, address mapping for the pci-ep-bus didn't
work.

To be honest I don't know the consequences of this property being
missing for a PCI bridge device.  I do know the problem I encountered
if it's specified with value "pci" for an endpoint node.  I have no
objection to making the message more informative, but it might not
really cover all the things that won't work as a result.

The DTS files have been fixed:
   https://lore.kernel.org/lkml/20260902214321.1721477-1-elder@riscstar.com/
(And as a result, a few verbs above should be made past tense.)

I created this patch simply in response to Rob's suggestion, and
updated it based on Herve's.


I could update the description to look more like what you got
Gemini to produce.  That talks about some context that I did
not provide, but it also lacks some of the other context (like
when/why PCI devices even have devicetree nodes, and how I
discovered it).

> The commit log doesn't actually say directly what the patch does.  I
> asked gemini to work on it, and it produced this, which is
> straightforward but omits a lot of detail you might want:
> 
>    PCI: of: Verify "device_type" property for PCI device nodes
> 
>    According to the Open Firmware PCI Bus Supplement and Devicetree
>    Specification, the `device_type` property is reserved strictly for
>    PCI bridge nodes (with value "pci" or "pciex"). Non-bridge PCI
>    endpoint nodes must not include a `device_type` property.
> 
>    Pre-defined Device Tree nodes representing PCI devices sometimes
>    violate this requirement—such as endpoint nodes incorrectly
>    specifying `device_type = "pci"`, or bridge nodes omitting
>    `device_type` altogether.
> 
>    Introduce of_pci_verify_node() to sanity-check pre-defined Device
>    Tree nodes assigned to PCI devices as they are registered in
>    pci_bus_add_device():
> 
>      - Warn if a PCI bridge node lacks a "pci" or "pciex" `device_type`
>        property.
> 
>      - Warn if a non-bridge PCI endpoint node contains a `device_type`
>        property.
> 
> I'd like to get Rob's Reviewed-by since I'm not really a DT expert.

I agree, I think we need that since it was his suggestion.

I don't mind spinning version 6 to update the description
and possible the warning message.  I'll leave that up to you
(or Rob) to request that before it gets accepted.

Thanks.

					-Alex
> 
>> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/pci/bus.c |  1 +
>>   drivers/pci/of.c  | 32 ++++++++++++++++++++++++++++++++
>>   drivers/pci/pci.h |  3 +++
>>   3 files changed, 36 insertions(+)
>>
>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>> index 655ed53436d3e..679afbc6d3109 100644
>> --- a/drivers/pci/bus.c
>> +++ b/drivers/pci/bus.c
>> @@ -351,6 +351,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>>   	 * are not assigned yet for some devices.
>>   	 */
>>   	pcibios_bus_add_device(dev);
>> +	of_pci_verify_node(dev);
>>   	pci_fixup_device(pci_fixup_final, dev);
>>   	if (pci_is_bridge(dev))
>>   		of_pci_make_dev_node(dev);
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index a51dff91b196d..5a040ed836744 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -1085,3 +1085,35 @@ int of_pci_get_equalization_presets(struct device *dev,
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
>> +
>> +/**
>> + * of_pci_verify_node - Sanity check some PCI device node properties
>> + * @pdev: The PCI device whose device node is checked
>> + *
>> + * PCI enumeration authoritatively discovers what we need to know about
>> + * a PCI device.  A devicetree-based platform will represent a PCI root
>> + * bridge with a node, but otherwise devicetree doesn't typically include
>> + * many PCI nodes.  Where such nodes do exist, experience has shown that
>> + * the "device_type" property is sometimes wrong, so warn about that.
>> + */
>> +void of_pci_verify_node(struct pci_dev *pdev)
>> +{
>> +	struct device_node *np = pci_device_to_OF_node(pdev);
>> +	bool device_is_bridge;
>> +	bool device_type_pci;
>> +
>> +	/* Nothing to check if there's no pre-existing devicetree node */
>> +	if (!np)
>> +		return;
>> +
>> +	device_is_bridge = pci_is_bridge(pdev);
>> +	device_type_pci = of_node_is_type(np, "pci") ||
>> +			  of_node_is_type(np, "pciex");
>> +
>> +	/* Bridges should have device type "pci"; endpoints should not */
>> +	if (device_is_bridge == device_type_pci)
>> +		return;
>> +
>> +	dev_err(&pdev->dev, "PCI %s have \"pci\" device_type property\n",
>> +		device_is_bridge ? "bridge should" : "endpoint should not");
>> +}
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index ba3c3fddddc23..2e33d3bd4b0ba 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -1253,6 +1253,7 @@ bool of_pci_supply_present(struct device_node *np);
>>   int of_pci_get_equalization_presets(struct device *dev,
>>   				    struct pci_eq_presets *presets,
>>   				    int num_lanes);
>> +void of_pci_verify_node(struct pci_dev *pdev);
>>   #else
>>   static inline int
>>   of_get_pci_domain_nr(struct device_node *node)
>> @@ -1308,6 +1309,8 @@ static inline int of_pci_get_equalization_presets(struct device *dev,
>>   
>>   	return 0;
>>   }
>> +
>> +static inline void of_pci_verify_node(struct pci_dev *pdev) { }
>>   #endif /* CONFIG_OF */
>>   
>>   struct of_changeset;
>> -- 
>> 2.53.0
>>

