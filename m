Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC6E442FD1
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753801; cv=none; b=Ax+gO1ulwrP9jOrfVLwm7l2uYPadd97YC0Gnlv/7HKXZktOwRQ6U1lFNwtYUpkDZA1bDdfRR2s5jRGNVxUvUkHNKlQWuwlS8ArwDFYBEWr975RVry4EzrAvpmy48rXp8XrcArMmHk7JBcbt7wcKiRiCyLqIPaFvWTvcxgXfidVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753801; c=relaxed/simple;
	bh=afPlTpVBOVxRusNWGxKuDYVFIlS9SkvZcarrTJS78lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbg3qFf0w4e+2kxvwToFSHfWSg2DJzjv8gpYHNFuuY49o0fZBmm+x1lNEXMwX3MO2zkm7CndsaYOfIHgREwMYJVrnv/hYUWFiJPV5GVi4lg+JD6UaQ6n6jUDy4c5l1theN7pbwDPvT5jX439HJ/px86k2t+dsBmMdNL/Ykd69LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=pVHEJOwK; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="pVHEJOwK"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-5329fc7e0bcso11717401cf.1
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 10:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789753795; x=1790358595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QBXBlps+fzGob8XyzdrqGGeZGJ/AtzGPAtCevAfGf40=;
        b=pVHEJOwKKdHLMeJuk4L8dL8tZ6DcYhRBL5eQdj3UfUKw4ms5RN1YlVphH0RTWYxbo8
         0dD9ZMsseW2hM7CXiM9mld2iUGabg7YU8cIfsrr4qUpT8GSld5V15b4+9z7Si4oDz+X6
         HkDti8jIAE8b6wkPrMuliLmC5JTEdLBJBHdhpBvhp7TieAuzxtMfAM/WOJNfuDYrNmSm
         TioyH2QXDpMo7UAJLntVwrqL8UVSPj2z2KcgN3RvBtVXB1kjfv6Aurfz08wOOCkj2snB
         zHU7ekFl8DBJB2+vSOD4clFjWjaRrqCKInFU+Nv29l3co1e5ZP0SXwBl71kfo1BTtyEp
         DfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789753795; x=1790358595;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QBXBlps+fzGob8XyzdrqGGeZGJ/AtzGPAtCevAfGf40=;
        b=MRyADIJdAv8IQuZ504OAJow4wzexfiQqSvv83yBiGi3Vpn1dAU3ZXf3Dof7KFR/gzC
         tvOUSCWoyTtRWhiFFligMTj3A3M2uBQ9idOP/b4S1q3IudKAuBXpBF4jLLqH4IAglSoG
         UEMU/QobKCnYc4mmDTevcyv4wYAaFXzHT7YPz/OqyiZ/yF7/ycBaypSTHkIjE+1JeHnn
         ewtZfhY7UlCqxZmjQA31Gw/mjWRGI53PPWq8BwbVMwYy5bH3OD4Gw15249yVZZHSfetC
         ZEKzDcptmf3ldlFMWwlZTNtILj5hH0H+KKbweHM/eu7wtE4qm+cv5JKfKsamzNPRR8Gd
         UeWw==
X-Forwarded-Encrypted: i=1; AKwUvByIVoPHM2ManJK7ESNxc/Gz5iifOdj7HXPzKqIN6Y32FnI5I9/S15RrQQEmHPeV53Hb9Onz/MnTfBE=@vger.kernel.org
X-Gm-Message-State: AFuF++mT7lCwZRUaFDj5Rjxs3fuIISNZPs3x9+vjIIXj9VGJ0V28apk1
	EenSCecZdsyqDcQsTYAxi7AjmuJjm0Is0qE2V1o1Jl7DRwxS/JZymcw/PZ+MBsDmFmM=
X-Gm-Gg: AYBFou3GtJIUMTn7UfwtJcwqdtKiE8rb8Rm6DqSNqWvHp7faiiQ9eZ8y1plTaYinyYD
	J7Hud4rxv/5bcUfgPk3sV7VyCnG0MtIfgCF04wJ22mGgLA302dg9M0X8H+EqrDqwzae8dN1W+DN
	XNDtpi0XkOLHQUnP9nr+HsQsyDqQEJKPUj82VlSYTY9nda0J/FTk4rL7nk1BCmAFno5kGYEqcoK
	KdKLPRS8ZF9OABr44+QzYL/HlCjTuxvAe29hHm4Zgsp2R8Jxgr6uKpNMX8lJlRn5UoYW7esJcGq
	EJQvUdW3Q3tXN6aOH8x0HW562eigpoz5d5SrH7bcFRqnz+9l3iWGYe2fPt+FafsEBLiQH2SxT2c
	+ecxcElYsNjLSn4cMJdngPSzVBfJcrtJSgkK/uPOs8VUk+9J29DTNlw3wKxbV8Ay5pBldIVzyfW
	zG53FWHW2AG4sA4X3uA8iymKMmW4cWZRVNXgsvCzqwV9bc63jBYp2J6fuSFRPBwdTeS6fKWTM=
X-Received: by 2002:ac8:5d8f:0:b0:530:ff84:e426 with SMTP id d75a77b69052e-5329e47ff4bmr57576891cf.47.1789753795392;
        Fri, 18 Sep 2026 10:49:55 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532ae5ef242sm2551661cf.5.2026.09.18.10.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 10:49:55 -0700 (PDT)
Message-ID: <e9bd7954-1cec-4ffb-a5b2-2389469b0c05@riscstar.com>
Date: Fri, 18 Sep 2026 12:49:53 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] misc: tc9564: introduce base PCI driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, bhelgaas@google.com, andersson@kernel.org,
 konradybcio@kernel.org, abelvesa@kernel.org, daniel@riscstar.com,
 mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrea della Porta <andrea.porta@suse.com>,
 Herve Codina <herve.codina@bootlin.com>, Lizhi Hou <lizhi.hou@amd.com>
References: <20260918173003.GA1166280@bhelgaas>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260918173003.GA1166280@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/26 12:30 PM, Bjorn Helgaas wrote:
> [+cc Andrea, Herve, Lizhi for of_pci_make_dev_node() quirks]
> 
> On Fri, Sep 18, 2026 at 10:26:57AM -0500, Alex Elder wrote:
>> The Toshiba TC9564 is small and highly-specialized SoC that implements
>> a PCIe switch as well as an Ethernet AVB/TSN bridge.  In addition to
>> these, the SoC implements other functions, including a reset and clock
>> controller, an address translation unit, and a few other devices.  PCIe
>> BARs provide access to registers that manage these IP blocks, and the
>> SoC is modeled using a PCI endpoint bus in devicetree.  This allows the
>> IP blocks to be bound to platform drivers that do MMIO via the PCI BARs.
>>
>> Create a new PCI driver under drivers/misc that binds with the embedded
>> PCI endpoint functions within the TC9564 SoC.  Because these functions
>> will use devicetree pci-ep-bus to provide access to other IP blocks
>> within the TC9564 chip, the main purpose of this driver is to do basic
>> PCI initialization, then call of_platform_default_populate() to scan for
>> the any endpoint bus children, and probe all devices defined therein.
>>
>> Because we're using pci-ep-bus, we need to use the PCI quirks mechanism
>> to have of_pci_make_dev_node() be called for each endpoint device in
>> pci_bus_add_device() (via pci_fixup_device(pci_fixup_final, dev)).
>>
>> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# quirks.c
> 
> Not an issue for this patch, but I'm not sure the quirk mechanism is
> the best mechanism for doing this.  It's not working around a device
> defect like most quirks do.

I pretty much agree with you.  I think I mentioned this before
(though it might have been in a private conversation) that it
is an intentional act to call of_pci_make_dev_node() for an
endpoint (and not just a bridge).  And that's different from
a hardware quirk.  You only need to do it if there's a pci-ep-bus
sub-node on the endpoint.  (I'd have to verify this on the other
users of this approach to be 100% sure though.)

> I wonder if pci_bus_add_device() should unconditionally call a wrapper
> that calls of_pci_make_dev_node() for bridges and any device that
> appears in an allow-list.  I guess it sort of amounts to the same
> thing in the end, but it might be a little more explicit and not
> subject to CONFIG_PCI_QUIRKS.

Yes, I think it would be better to separate this case from PCI
quirks, which are really intended for anomalous hardware behavior.

I'd like to get these things merged, but would be willing to work
on this sort of thing (and/or on separating this driver type, as
Arnd suggested elsewhere).

Thanks a lot Bjorn.

					-Alex

>> +++ b/drivers/pci/quirks.c
>> @@ -6391,6 +6391,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, of_pci_make_dev_node);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TOSHIBA, 0x0220, of_pci_make_dev_node);
>>   
>>   /*
>>    * Devices known to require a longer delay before first config space access
>> -- 
>> 2.53.0
>>

