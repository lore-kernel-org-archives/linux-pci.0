Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B277E408612
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502927; cv=none; b=FbzF8FsYOdzCKBLtIEwH+zXymFO+i+k9g07CHFQQeByHwHafSQqZPojuQ1VCl/rIrZ8jbo48YRNOshcMJ2FuE36hWla0EMY7R7tUlaNWY2KDIarHXtS8meKOMKgkUUhdg/NAeff6D0OAf2cQWXS/V3H5X4bxDGxTmHI+eHuqyAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502927; c=relaxed/simple;
	bh=LyINBnJSAFoIpPgfttj3fvePgZKwAAcbkaqj4GVumIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+Mb761Iu61c1QcDPW5oWdhG77vG2m7oE6VTKeAwSm5XugxwryaEGR8epW7UHguqaoEga35U72YPJbFSlyrxoeJFLqH27aGeMpcgbK89Sd7w13Acx58jeGM4as9bsZRhnKBoscaZhdsizqPBdAAShTtjexbNzSiu9ApvQpGNlfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0IGkATb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjxsSBV+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0IGkATb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjxsSBV+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783502923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4UahMxvFLpEJ8SWR8y6P/YLPifETC5c2Y4bUtJdnQPo=;
	b=Q0IGkATbpT6pmju/lcbIbr9urdNuCqUdWcEpnJQRGwOQZGm0JDZ89E7rzTh8NyY7qyskF9
	OugfDO5xwZTHfY6XGkw3ck+1Nu7cfjbwwXN/UgX0RrgDHczhL+aw+4WSengu8cTnAduK2o
	i9u7SMkqxZ5O2jm9i68nC5gRNVg7GMY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-sX6dlfNuPPSXdUqpiQfQEg-1; Wed, 08 Jul 2026 05:28:42 -0400
X-MC-Unique: sX6dlfNuPPSXdUqpiQfQEg-1
X-Mimecast-MFC-AGG-ID: sX6dlfNuPPSXdUqpiQfQEg_1783502921
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-473de38dcfaso398670f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 02:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783502921; x=1784107721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4UahMxvFLpEJ8SWR8y6P/YLPifETC5c2Y4bUtJdnQPo=;
        b=fjxsSBV+DciXVsuFzOYXlBkSq29kOiU3+OxB6uBGv2dTRkQSQXURyIKsKNDDidDK9P
         QC5kH4Yvk18vgUXraDwOPT6yPnC69sNxTg2H09KgaqX5keN9wU1Fmt9flbRsdUpdrZOO
         LOj+YkE/8qjOdupmSeuGSDy/DyzBCmrNCf75YJCMBCx+lUDggIf0ZfdEsr0OJW09ika3
         58Lx3amkzOf4D2d9IFDy7f/1ZEVxmLxCcw2XoziGfCWhQSvAls+AZfVDekYrWD7u8/b8
         QwXioU872d2uKD31OnD2aLy12iYsjaPCgLjJQoEre07lc7zaimcTdzGezV+5BzELXRKv
         msWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783502921; x=1784107721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UahMxvFLpEJ8SWR8y6P/YLPifETC5c2Y4bUtJdnQPo=;
        b=RmGZUlKlJBWHh0A/O/UQPLXjBtrkK7tjOSduxafa84OFsG0sfjBoD0yY6oEYN3j6zl
         Eg15wYpxGEAt5BXNfGCXmS4LoJVcY8Wxn2hOjCyb+l8zHwt29d7gJvN9xrOTxfQXlO9b
         nxPJ75fDVDMymEluMQPPtcGFJubwNCcIhw9XIueXM+zrvovoRj0Ch4Mk5tYAFNbJVKiY
         yAcHPZSYQYaYlOhqJd7EaHyJVZEctJW+hxo9Lh4Hadht4GxILI2sBWok/E3+LCPUONNt
         ME+42xvktH2utVpgm3+Om5S0S5h/oc6M0S4Pf2dLwrWn//1leyIFJk1f495RmBSeI1+v
         GTHA==
X-Gm-Message-State: AOJu0Yxp9zNgOjG4oZ/bN6REMvnm7W7PRSJxbX6lSyru/pESLafkP+/q
	yKk7uxmFeGUKOAa737YnrddBXZXgq/akZA2SGua5VWHfldHi8QIoMBRbY5PdSw3kl98inQr1Z/L
	WiYC8brvNQUXkOaIJK/soAXoGlhtE77NzzAyHXL7kvjp6E0V6cryki4CXZvoayA==
X-Gm-Gg: AfdE7ckeizA3TZelHOYuuCPXH6c2/SHACiZQyZ7PMhl9P/Qv7KYg736SMZZrDiSD/E7
	mH0vabbpY+unr5YpyD+aNh9cId1iFLYIs0l101npLBSi7XXYYTFNk+k0mGidYIhpb+U7d1K1CXc
	Oa49PFgDzIw6CNRJJSn+fDpPokarDWW5f1H32PsNYt24io2IJ6OOWPk3uVuTKxM0H1qZXgKVNYa
	B7vadl8RXVeZNQAAsgIfDy+YOzY8OfiYIi1hZVB3vw0DGCQTMpH7vp/KNxD5o/5UmVGytQrpyDg
	DDCCiG5zacIrW1KU7ek6+kP8iKn0/5iJnsHaWwYXSPFPqYPlJwjX+4NFtbIgIcEfE3Zh5PyYk0R
	YopM+Wn8zMtvLRt8Tadu1nHa0ZgZN6G+ncAITsT80uhfuNz763N3ixjN/
X-Received: by 2002:a05:600c:5307:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-493e6866163mr17171585e9.24.1783502921116;
        Wed, 08 Jul 2026 02:28:41 -0700 (PDT)
X-Received: by 2002:a05:600c:5307:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-493e6866163mr17171395e9.24.1783502920636;
        Wed, 08 Jul 2026 02:28:40 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:263:8800:8714:9136:d3b4:25b3? ([2a01:cb1c:263:8800:8714:9136:d3b4:25b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a6d752sm28658575e9.2.2026.07.08.02.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 02:28:39 -0700 (PDT)
Message-ID: <04c3d618-c38e-46bd-8618-ed95657b6a60@redhat.com>
Date: Wed, 8 Jul 2026 11:28:38 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/23] PCI: Add pbus_mem_size_optional() to handle
 optional sizes
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 LKML <linux-kernel@vger.kernel.org>, Myron Stowe <myron.stowe@redhat.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
 <20251219174036.16738-14-ilpo.jarvinen@linux.intel.com>
 <f23946f2-06ac-4607-8f2c-3ffbc52b627a@redhat.com>
 <fbdc88d3-b6b4-8098-58c5-1fdb2f7b19d6@linux.intel.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <fbdc88d3-b6b4-8098-58c5-1fdb2f7b19d6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ilpo,

On 7/7/26 6:12 PM, Ilpo Järvinen wrote:
> On Tue, 7 Jul 2026, Eric Auger wrote:
> 
>> Hi Ilpo,
>>
>> On 12/19/25 6:40 PM, Ilpo Järvinen wrote:
>>> The resource loop in pbus_size_mem() handles optional resources that
>>> are either fully optional (SRIOV and disabled Expansion ROMs) or bridge
>>> windows that may be optional only for a part. The logic is little
>>> inconsistent when it comes to a bridge window that has only optional
>>> children resources as it would be more natural to treat it similar to
>>> any fully optional resource. As resource size should be zero in that
>>> case, it shouldn't cause any bugs but it still seems useful to address
>>> the inconsistency.
>>>
>>> Place the optional size related code of pbus_size_mem() into
>>> pbus_mem_size_optional() and add check into pci_resource_is_optional()
>>> for entirely optional bridge windows. Reorder the logic inside
>>> pbus_mem_size_optional() such that fully optional resources are handled
>>> the same irrespective to whether the resource is a bridge window or
>>> not.
>>
>> This patch seems to introduce a regression when trying to hotplug a
>> virtio-net-pci device behind a XIO3130 downstream port in the following
>> hierarchy.
>>
>> this happens with a v7.2-rc2 guest kernel, on an arm64 guest with qemu vmm.
>>
>>
>>
>> 00:01.0 Host bridge: Red Hat, Inc. QEMU PCIe Expander bridge
>> 	Subsystem: Red Hat, Inc. Device 1100
>>
>> |_ 0a:00.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
>>    Subsystem: Red Hat, Inc. Device 0000
>>    Kernel driver in use: pcieport
>>
>>    |_ 0b:00.0 PCI bridge: Texas Instruments XIO3130 PCI Express Switch
>>
>> 	(Upstream) (rev 02)
>> 	Kernel driver in use: pcieport
>>
>> 	|_ 0c:02.0 PCI bridge: Texas Instruments XIO3130 PCI Express
>> 		Switch (Downstream) (rev 01)
>> 		Kernel driver in use: pcieport
> 
> Hi Eric,
> 
> Thanks for the report.
> 
> I cannot get much done with the log snippets. The first line with 
> difference is a symptom of something that originates from outside of the 
> snippet.
> 
> Could you please take a log with dyndbg="file drivers/pci/*.c +p" on the 
> kernel command line and also include a /proc/iomem dump. Like 
> you did now, preferrably take those from both working and failing case so 
> I can easily diff them.
> 
> --
>  i.
> 
> 
>> This produces the following trace
>>
>>
>> [   28.557947] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card present
>> [   28.557949] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
>> [   29.605376] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x020000 PCIe
>> Endpoint
>> [   29.605724] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000fff]
>> [   29.605765] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003fff 64bit
>> pref]
>> [   29.605816] pci 0000:0d:00.0: enabling Extended Tags
>> [   29.606994] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
>> [   29.606998] pcieport 0000:0c:02.0: bridge window [mem size
>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
>> [   29.607003] pcieport 0000:0c:02.0: bridge window [mem size
>> 0x00200000]: can't assign; no space
>> [   29.607005] pcieport 0000:0c:02.0: bridge window [mem size
>> 0x00200000]: failed to assign
>> [   29.607007] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>> 64bit pref]: can't assign; no space
>> [   29.607008] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>> 64bit pref]: failed to assign
>> [   29.607010] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>> can't assign; no space
>> [   29.607012] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>> failed to assign
>> [   29.607014] pcieport 0000:0c:02.0: bridge window [mem size
>> 0x00100000]: can't assign; no space
>> [   29.607016] pcieport 0000:0c:02.0: bridge window [mem size
>> 0x00100000]: failed to assign
>> [   29.607018] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>> 64bit pref]: can't assign; no space
>> [   29.607019] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>> 64bit pref]: failed to assign
>> [   29.607021] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>> can't assign; no space
>> [   29.607022] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>> failed to assign
>> [   29.607025] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>> can't assign; no space
>> [   29.607026] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>> failed to assign
>> [   29.607027] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
>> assign; no space
>> [   29.607028] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
>> assign
>> [   29.607029] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>> can't assign; no space
>> [   29.607030] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>> failed to assign
>> [   29.607031] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
>> assign; no space
>> [   29.607032] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
>> assign
>> [   29.607033] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
>> [   29.611260] PCI: No. 2 try to assign unassigned res
>> [   29.611269] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
>> [   29.611272] pcieport 0000:0c:02.0: bridge window [mem size
>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
>> [   29.611276] pcieport 0000:0c:02.0: bridge window [mem size
>> 0x00200000]: can't assign; no space
>> [   29.611277] pcieport 0000:0c:02.0: bridge window [mem size
>> 0x00200000]: failed to assign
>> [   29.611278] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>> 64bit pref]: can't assign; no space
>> [   29.611279] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>> 64bit pref]: failed to assign
>> [   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>> can't assign; no space
>> [   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>> failed to assign
>> [   29.611281] pcieport 0000:0c:02.0: bridge window [mem size
>> 0x00100000]: can't assign; no space
>> [   29.611282] pcieport 0000:0c:02.0: bridge window [mem size
>> 0x00100000]: failed to assign
>> [   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>> 64bit pref]: can't assign; no space
>> [   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>> 64bit pref]: failed to assign
>> [   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>> can't assign; no space
>> [   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>> failed to assign
>> [   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>> can't assign; no space
>> [   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>> failed to assign
>> [   29.611287] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
>> assign; no space
>> [   29.611288] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
>> assign
>> [   29.611288] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>> can't assign; no space
>> [   29.611289] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>> failed to assign
>> [   29.611289] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
>> assign; no space
>> [   29.611290] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
>> assign
>> [   29.611291] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
>> [   29.616141] ACPI: \_SB_.L0A2: Enabled at IRQ 37
>> [   29.616378] virtio-pci 0000:0d:00.0: virtio_pci: leaving for legacy
>> driver
>>
>> Previous to this commit hotplug was successful:
>>
>> vm-rhel10 login: [   38.385692] pcieport 0000:0c:02.0: pciehp:
>> Slot(0-1): Button press: will power on in 5 sec
>> [   38.385798] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card present
>> [   38.385799] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
>> [   39.553709] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x020000 PCIe
>> Endpoint
>> [   39.554018] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000fff]
>> [   39.554042] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003fff 64bit
>> pref]
>> [   39.554099] pci 0000:0d:00.0: enabling Extended Tags
>> [   39.555202] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
>> [   39.555206] pcieport 0000:0c:02.0: bridge window [mem size
>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
>> [   39.555212] pcieport 0000:0c:02.0: bridge window [mem size
>> 0x00200000]: can't assign; no space
>> [   39.555213] pcieport 0000:0c:02.0: bridge window [mem size
>> 0x00200000]: failed to assign
>> [   39.555215] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>> 64bit pref]: can't assign; no space
>> [   39.555216] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>> 64bit pref]: failed to assign
>> [   39.555218] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>> can't assign; no space
>> [   39.555219] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>> failed to assign
>> [   39.555222] pcieport 0000:0c:02.0: bridge window [mem
>> 0x10a00000-0x10afffff]: assigned
>> [   39.555224] pcieport 0000:0c:02.0: bridge window [mem
>> 0x10b00000-0x10bfffff 64bit pref]: assigned
>> [   39.555225] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>> can't assign; no space
>> [   39.555227] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>> failed to assign
>> [   39.555228] pcieport 0000:0c:02.0: bridge window [mem
>> 0x10a00000-0x10afffff]: failed to expand by 0x100000
>> [   39.555230] pcieport 0000:0c:02.0: bridge window [mem
>> 0x10a00000-0x10afffff]: failed to add optional 100000
>> [   39.555232] pcieport 0000:0c:02.0: bridge window [mem
>> 0x10b00000-0x10bfffff 64bit pref]: failed to expand by 0x100000
>> [   39.555234] pcieport 0000:0c:02.0: bridge window [mem
>> 0x10b00000-0x10bfffff 64bit pref]: failed to add optional 100000
>> [   39.555236] pci 0000:0d:00.0: BAR 4 [mem 0x10b00000-0x10b03fff 64bit
>> pref]: assigned
>> [   39.555290] pci 0000:0d:00.0: BAR 1 [mem 0x10a00000-0x10a00fff]: assigned
>> [   39.555305] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
>> [   39.556804] pcieport 0000:0c:02.0:   bridge window [mem
>> 0x10a00000-0x10afffff]
>> [   39.557730] pcieport 0000:0c:02.0:   bridge window [mem
>> 0x10b00000-0x10bfffff 64bit pref]
>> [   39.559629] PCI: No. 2 try to assign unassigned res
>> [   39.559636] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>> can't assign; no space
>> [   39.559638] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>> failed to assign
>> [   39.559640] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>> can't assign; no space
>> [   39.559642] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>> failed to assign
>> [   39.559644] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
>> [   39.561078] pcieport 0000:0c:02.0:   bridge window [mem
>> 0x10a00000-0x10afffff]
>> [   39.562011] pcieport 0000:0c:02.0:   bridge window [mem
>> 0x10b00000-0x10bfffff 64bit pref]
>> [   39.564500] ACPI: \_SB_.L0A2: Enabled at IRQ 37
>> [   39.564541] virtio-pci 0000:0d:00.0: enabling device (0000 -> 0002)
>> [   39.572231] virtio_net virtio2 enp13s0: renamed from eth0
>>
>> Any clue?
>>
>> Thank you in advance
>>
>> Eric
>>
>>
>>
>>
>>
>>
>>
>>>
>>> Additional motivation for this are the upcoming changes that add
>>> complexity to the optional sizing logic due to Resizable BAR awareness.
>>> The extra logic would exceed any reasonable indentation level if the
>>> optional sizing code is kept within the loop body.
>>>
>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>> ---
>>>  drivers/pci/setup-bus.c | 77 +++++++++++++++++++++++++++++------------
>>>  1 file changed, 54 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>>> index 3d1d3cefcdba..3fcc7641c374 100644
>>> --- a/drivers/pci/setup-bus.c
>>> +++ b/drivers/pci/setup-bus.c
>>> @@ -125,15 +125,6 @@ static resource_size_t get_res_add_size(struct list_head *head,
>>>  	return dev_res ? dev_res->add_size : 0;
>>>  }
>>>  
>>> -static resource_size_t get_res_add_align(struct list_head *head,
>>> -					 struct resource *res)
>>> -{
>>> -	struct pci_dev_resource *dev_res;
>>> -
>>> -	dev_res = res_to_dev_res(head, res);
>>> -	return dev_res ? dev_res->min_align : 0;
>>> -}
>>> -
>>>  static void restore_dev_resource(struct pci_dev_resource *dev_res)
>>>  {
>>>  	struct resource *res = dev_res->res;
>>> @@ -386,6 +377,8 @@ bool pci_resource_is_optional(const struct pci_dev *dev, int resno)
>>>  		return true;
>>>  	if (resno == PCI_ROM_RESOURCE && !(res->flags & IORESOURCE_ROM_ENABLE))
>>>  		return true;
>>> +	if (pci_resource_is_bridge_win(resno) && !resource_size(res))
adding

&& !dev->is_hotplug_bridge makes the hotplug successful.


My understanding is that otherwise the hotplug bridge window is
considered as optional and no memoy window is allocated to assign chid
device's BARS

Please let me know if that makes sense. In the positive I can send a patch.

Thanks

Eric

>>> +		return true;
>>>  
>>>  	return false;
>>>  }
>>> @@ -1258,6 +1251,54 @@ static resource_size_t calculate_head_align(resource_size_t *aligns,
>>>  	return head_align;
>>>  }
>>>  
>>> +/*
>>> + * pbus_size_mem_optional - Account optional resources in bridge window
>>> + *
>>> + * Account an optional resource or the optional part of the resource in bridge
>>> + * window size.
>>> + *
>>> + * Return: %true if the resource is entirely optional.
>>> + */
>>> +static bool pbus_size_mem_optional(struct pci_dev *dev, int resno,
>>> +				   resource_size_t align,
>>> +				   struct list_head *realloc_head,
>>> +				   resource_size_t *add_align,
>>> +				   resource_size_t *children_add_size)
>>> +{
>>> +	struct resource *res = pci_resource_n(dev, resno);
>>> +	bool optional = pci_resource_is_optional(dev, resno);
>>> +	resource_size_t r_size = resource_size(res);
>>> +	struct pci_dev_resource *dev_res;
>>> +
>>> +	if (!realloc_head)
>>> +		return false;
>>> +
>>> +	if (!optional) {
>>> +		/*
>>> +		 * Only bridges have optional sizes in realloc_head at this
>>> +		 * point. As res_to_dev_res() walks the entire realloc_head
>>> +		 * list, skip calling it when known unnecessary.
>>> +		 */
>>> +		if (!pci_resource_is_bridge_win(resno))
>>> +			return false;
>>> +
>>> +		dev_res = res_to_dev_res(realloc_head, res);
>>> +		if (dev_res) {
>>> +			*children_add_size += dev_res->add_size;
>>> +			*add_align = max(*add_align, dev_res->min_align);
>>> +		}
>>> +
>>> +		return false;
>>> +	}
>>> +
>>> +	/* Put SRIOV requested res to the optional list */
>>> +	add_to_list(realloc_head, dev, res, 0, align);
>>> +	*children_add_size += r_size;
>>> +	*add_align = max(align, *add_align);
>>> +
>>> +	return true;
>>> +}
>>> +
>>>  /**
>>>   * pbus_size_mem() - Size the memory window of a given bus
>>>   *
>>> @@ -1284,7 +1325,6 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
>>>  	resource_size_t aligns[28] = {}; /* Alignments from 1MB to 128TB */
>>>  	int order, max_order;
>>>  	resource_size_t children_add_size = 0;
>>> -	resource_size_t children_add_align = 0;
>>>  	resource_size_t add_align = 0;
>>>  
>>>  	if (!b_res)
>>> @@ -1311,7 +1351,6 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
>>>  			if (b_res != pbus_select_window(bus, r))
>>>  				continue;
>>>  
>>> -			r_size = resource_size(r);
>>>  			align = pci_resource_alignment(dev, r);
>>>  			/*
>>>  			 * aligns[0] is for 1MB (since bridge memory
>>> @@ -1327,25 +1366,17 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
>>>  				continue;
>>>  			}
>>>  
>>> -			/* Put SRIOV requested res to the optional list */
>>> -			if (realloc_head && pci_resource_is_optional(dev, i)) {
>>> -				add_align = max(align, add_align);
>>> -				add_to_list(realloc_head, dev, r, 0, 0 /* Don't care */);
>>> -				children_add_size += r_size;
>>> +			if (pbus_size_mem_optional(dev, i, align,
>>> +						   realloc_head, &add_align,
>>> +						   &children_add_size))
>>>  				continue;
>>> -			}
>>>  
>>> +			r_size = resource_size(r);
>>>  			size += max(r_size, align);
>>>  
>>>  			aligns[order] += align;
>>>  			if (order > max_order)
>>>  				max_order = order;
>>> -
>>> -			if (realloc_head) {
>>> -				children_add_size += get_res_add_size(realloc_head, r);
>>> -				children_add_align = get_res_add_align(realloc_head, r);
>>> -				add_align = max(add_align, children_add_align);
>>> -			}
>>>  		}
>>>  	}
>>>  
>>
>>
> 

