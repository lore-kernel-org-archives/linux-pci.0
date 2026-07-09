Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F216F282F1E
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607407; cv=none; b=uG17h3p2ioAbjoAktS5gQIcuCANtQDHp11eZslBfm1NSmY8s+pmYA1EzOp1F/c9O0yR+7KcL1ctc5rUdVR0aKRxftwoqdWeSCq5t87m/AQkpksBQO3t17MdSk2K0K2pbUyxpSqYxlzejKcUk5HgTUtnKJHdeSazhoWgPmsZjbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607407; c=relaxed/simple;
	bh=VFXmi7Xhn+81HgGLSWp6s3gOsCAc/31RKPPkWsC4rfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gr59oEEit+ilNdOAIH9vZ0iZJUsaBkRzE86AQDIBeGj+oJ4iGnr99x8AqIw7GDMZT7JqoYBqs5jYkvZKAIcsxrGb0LgJLKSYBju/3XzYSy72xfK3eF4IFBYvCcxqa4hxVejMEektYWoOrJJpwCFmRCeGKswx6VgwGtcN1MPXs60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VrVNXAO1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mJiwJmTN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrVNXAO1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mJiwJmTN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783607405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaIJb1k52t9eH19j2wpKnLd7aJcFxAKoXfTdy4hf8L0=;
	b=VrVNXAO1kOH/2oUmEcgnN7/3BWpXb/YRgRU5K9f/1rtI1iZ4NdeOH8QZ87+hizrPIXkvnb
	EsxsvQjahLj057xxsj6zJnc/5Q+dS/xLXQ6EXI53IuVj9rwzP82khwCtOcSBbbWvm3c8Sg
	Hz1uHQ4tBdjhCheixZvcFle3IOj14EA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-Wqd211YKPw-dFo1YiF1oDg-1; Thu, 09 Jul 2026 10:30:03 -0400
X-MC-Unique: Wqd211YKPw-dFo1YiF1oDg-1
X-Mimecast-MFC-AGG-ID: Wqd211YKPw-dFo1YiF1oDg_1783607402
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4784d0fb9cfso1500369f8f.2
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 07:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783607402; x=1784212202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vaIJb1k52t9eH19j2wpKnLd7aJcFxAKoXfTdy4hf8L0=;
        b=mJiwJmTN3Xsr+5cO9DHejKeaA11cmaPPWa1/F5S7APfCBpzAKyPzGBXW4DQB/NN4Y9
         wA8f7FDZ2ht62OAfKF6rdv5wVbls6WDz1ZspPe0Lj3x3eoI6foZ3YnkhgDwDbsPTafAs
         jVhqG8xu8luam9xOwbedEXNbcTIiA6iOihIHYuDWQ2VMhRCBVDsbuIxFu+ty4+4Ls51w
         xb5xSLtTUCeyZa8LTbtQPU9QdI39GmiuArkWusuuyE/iHcodk8tRljJ7evtFM5GUQgUs
         DCgcXAXRDDg3T3pnnAl7vGca6g4jO216QtR9IqfQ7uoGxUARM3AvZMO4sdqqf3qGZZQZ
         JAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783607402; x=1784212202;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vaIJb1k52t9eH19j2wpKnLd7aJcFxAKoXfTdy4hf8L0=;
        b=PzC1WfEMtwZGlblfCb3RIBbPDJZRcuWCEdaL2Hz7TxWqJFDg7nnkR9XltEZVBuX0A3
         O1l2UiD0/6F76KMTxtNZMH83cO/zT/2KRY72m2dgEMaSDuAcoFHn6S/eU1mWDQYXwIIf
         upu6zCdwdT++aDkwBk/YJIek30XI4RvAKagufwWl57qrIfXUsolOdYFTD09pKVlz2PPJ
         Ncf61Rt/wk5aNePLJXBtPw80ea9Rs2QmU5JTgzjtaPjfP8lUhhOcukA6K0t3LmmGAWMi
         eXjd6dCM2nqH/jntR1ZZ38ZftY2JXeLztT2KaQe6ZyVBq5rFHjbp1kPkPru/WwoUPwg9
         mH6g==
X-Gm-Message-State: AOJu0YxMkbKnkBQeCev5BBmu1ErSPlY9cBLLOc4EhF80unaIsL/USmPJ
	2veRz7hVWmt7ftWwz5qIBq6xDk+gSP/T1CIFDcZb7IlGczB7iUBEwYgavTyRc3bKFAxj8prYn3N
	99m4hr5Y/wOvKRKyaUPkbhb+SuZN3dMKFMPzDLC+OYpwWmgT8tBWEHUPXi+yvLw==
X-Gm-Gg: AfdE7cnzxvQAZGbd/1L687glnr258Rx08yjAHwbdv7kIZ8lezdkQixCi4kZcMBOEHDP
	iFqna3i8JN0L9imuR3t4+VgXnGdsaWOf/wccixzTP47Iit46X1EQo+OfHL/yIE+FTR+P+TFdv/M
	on8Zdiua9Gu3r/ElWhGTiKR6xeE5o2vMe/0zxmybpJcHbOStFTjrjUxscjbJ4DO8DLaEAosq7LF
	4HK3fcPF3tp2UXOZHwMEIT7WOzhSSaT6SmtWHVXcvS9VCp0e73/Jo0zB9/OGwF3ZIxWk4U87Ucp
	xM0c5pBItEex4Aq9PN84hEL3RG2ptSM8+FWn0nPX8C3f6aJ2SyOaa6ysi9eteDMzOUMIYnQV/3R
	hnr7fkujR6Pg7j/s+1t82YZBqBGBUU+I4J9wG/9LaBay7P9hdPlbopNSi
X-Received: by 2002:a05:6000:144e:b0:475:f0f0:9ecc with SMTP id ffacd0b85a97d-47df0817d92mr9299811f8f.55.1783607401897;
        Thu, 09 Jul 2026 07:30:01 -0700 (PDT)
X-Received: by 2002:a05:6000:144e:b0:475:f0f0:9ecc with SMTP id ffacd0b85a97d-47df0817d92mr9299734f8f.55.1783607401281;
        Thu, 09 Jul 2026 07:30:01 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:263:8800:8714:9136:d3b4:25b3? ([2a01:cb1c:263:8800:8714:9136:d3b4:25b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8f1sm52624195f8f.3.2026.07.09.07.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 07:30:00 -0700 (PDT)
Message-ID: <802e57d4-7a35-474b-a291-8a8f74b51a6b@redhat.com>
Date: Thu, 9 Jul 2026 16:29:57 +0200
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
 <04c3d618-c38e-46bd-8618-ed95657b6a60@redhat.com>
 <e2dfd270-a831-06f4-6ddf-c14eb9bce1f8@linux.intel.com>
 <313af044-b9b7-496d-8d1c-dba61c606592@redhat.com>
 <ef311b13-565b-aa2e-2f35-a94bc53d975a@linux.intel.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <ef311b13-565b-aa2e-2f35-a94bc53d975a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ilpo,

On 7/9/26 11:04 AM, Ilpo Järvinen wrote:
> On Wed, 8 Jul 2026, Eric Auger wrote:
>> On 7/8/26 4:05 PM, Ilpo Järvinen wrote:
>>> On Wed, 8 Jul 2026, Eric Auger wrote:
>>>> On 7/7/26 6:12 PM, Ilpo Järvinen wrote:
>>>>> On Tue, 7 Jul 2026, Eric Auger wrote:
>>>>>
>>>>>> Hi Ilpo,
>>>>>>
>>>>>> On 12/19/25 6:40 PM, Ilpo Järvinen wrote:
>>>>>>> The resource loop in pbus_size_mem() handles optional resources that
>>>>>>> are either fully optional (SRIOV and disabled Expansion ROMs) or bridge
>>>>>>> windows that may be optional only for a part. The logic is little
>>>>>>> inconsistent when it comes to a bridge window that has only optional
>>>>>>> children resources as it would be more natural to treat it similar to
>>>>>>> any fully optional resource. As resource size should be zero in that
>>>>>>> case, it shouldn't cause any bugs but it still seems useful to address
>>>>>>> the inconsistency.
>>>>>>>
>>>>>>> Place the optional size related code of pbus_size_mem() into
>>>>>>> pbus_mem_size_optional() and add check into pci_resource_is_optional()
>>>>>>> for entirely optional bridge windows. Reorder the logic inside
>>>>>>> pbus_mem_size_optional() such that fully optional resources are handled
>>>>>>> the same irrespective to whether the resource is a bridge window or
>>>>>>> not.
>>>>>>
>>>>>> This patch seems to introduce a regression when trying to hotplug a
>>>>>> virtio-net-pci device behind a XIO3130 downstream port in the following
>>>>>> hierarchy.
>>>>>>
>>>>>> this happens with a v7.2-rc2 guest kernel, on an arm64 guest with qemu vmm.
>>>>>>
>>>>>>
>>>>>>
>>>>>> 00:01.0 Host bridge: Red Hat, Inc. QEMU PCIe Expander bridge
>>>>>> 	Subsystem: Red Hat, Inc. Device 1100
>>>>>>
>>>>>> |_ 0a:00.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
>>>>>>    Subsystem: Red Hat, Inc. Device 0000
>>>>>>    Kernel driver in use: pcieport
>>>>>>
>>>>>>    |_ 0b:00.0 PCI bridge: Texas Instruments XIO3130 PCI Express Switch
>>>>>>
>>>>>> 	(Upstream) (rev 02)
>>>>>> 	Kernel driver in use: pcieport
>>>>>>
>>>>>> 	|_ 0c:02.0 PCI bridge: Texas Instruments XIO3130 PCI Express
>>>>>> 		Switch (Downstream) (rev 01)
>>>>>> 		Kernel driver in use: pcieport
>>>>>
>>>>> Hi Eric,
>>>>>
>>>>> Thanks for the report.
>>>>>
>>>>> I cannot get much done with the log snippets. The first line with 
>>>>> difference is a symptom of something that originates from outside of the 
>>>>> snippet.
>>>>>
>>>>> Could you please take a log with dyndbg="file drivers/pci/*.c +p" on the 
>>>>> kernel command line and also include a /proc/iomem dump. Like 
>>>>> you did now, preferrably take those from both working and failing case so 
>>>>> I can easily diff them.
>>>>>
>>>>> --
>>>>>  i.
>>>>>
>>>>>
>>>>>> This produces the following trace
>>>>>>
>>>>>>
>>>>>> [   28.557947] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card present
>>>>>> [   28.557949] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
>>>>>> [   29.605376] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x020000 PCIe
>>>>>> Endpoint
>>>>>> [   29.605724] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000fff]
>>>>>> [   29.605765] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003fff 64bit
>>>>>> pref]
>>>>>> [   29.605816] pci 0000:0d:00.0: enabling Extended Tags
>>>>>> [   29.606994] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>>>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
>>>>>> [   29.606998] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
>>>>>> [   29.607003] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>> 0x00200000]: can't assign; no space
>>>>>> [   29.607005] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>> 0x00200000]: failed to assign
>>>>>> [   29.607007] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>>>>>> 64bit pref]: can't assign; no space
>>>>>> [   29.607008] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>>>>>> 64bit pref]: failed to assign
>>>>>> [   29.607010] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>> can't assign; no space
>>>>>> [   29.607012] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>> failed to assign
>>>>>> [   29.607014] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>> 0x00100000]: can't assign; no space
>>>>>> [   29.607016] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>> 0x00100000]: failed to assign
>>>>>> [   29.607018] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>>>> 64bit pref]: can't assign; no space
>>>>>> [   29.607019] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>>>> 64bit pref]: failed to assign
>>>>>> [   29.607021] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>> can't assign; no space
>>>>>> [   29.607022] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>> failed to assign
>>>>>> [   29.607025] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>>>> can't assign; no space
>>>>>> [   29.607026] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>>>> failed to assign
>>>>>> [   29.607027] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
>>>>>> assign; no space
>>>>>> [   29.607028] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
>>>>>> assign
>>>>>> [   29.607029] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>>>> can't assign; no space
>>>>>> [   29.607030] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>>>> failed to assign
>>>>>> [   29.607031] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
>>>>>> assign; no space
>>>>>> [   29.607032] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
>>>>>> assign
>>>>>> [   29.607033] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
>>>>>> [   29.611260] PCI: No. 2 try to assign unassigned res
>>>>>> [   29.611269] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>>>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
>>>>>> [   29.611272] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
>>>>>> [   29.611276] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>> 0x00200000]: can't assign; no space
>>>>>> [   29.611277] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>> 0x00200000]: failed to assign
>>>>>> [   29.611278] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>>>>>> 64bit pref]: can't assign; no space
>>>>>> [   29.611279] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>>>>>> 64bit pref]: failed to assign
>>>>>> [   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>> can't assign; no space
>>>>>> [   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>> failed to assign
>>>>>> [   29.611281] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>> 0x00100000]: can't assign; no space
>>>>>> [   29.611282] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>> 0x00100000]: failed to assign
>>>>>> [   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>>>> 64bit pref]: can't assign; no space
>>>>>> [   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>>>> 64bit pref]: failed to assign
>>>>>> [   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>> can't assign; no space
>>>>>> [   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>> failed to assign
>>>>>> [   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>>>> can't assign; no space
>>>>>> [   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>>>> failed to assign
>>>>>> [   29.611287] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
>>>>>> assign; no space
>>>>>> [   29.611288] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
>>>>>> assign
>>>>>> [   29.611288] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>>>> can't assign; no space
>>>>>> [   29.611289] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>>>> failed to assign
>>>>>> [   29.611289] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
>>>>>> assign; no space
>>>>>> [   29.611290] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
>>>>>> assign
>>>>>> [   29.611291] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
>>>>>> [   29.616141] ACPI: \_SB_.L0A2: Enabled at IRQ 37
>>>>>> [   29.616378] virtio-pci 0000:0d:00.0: virtio_pci: leaving for legacy
>>>>>> driver
>>>>>>
>>>>>> Previous to this commit hotplug was successful:
>>>>>>
>>>>>> vm-rhel10 login: [   38.385692] pcieport 0000:0c:02.0: pciehp:
>>>>>> Slot(0-1): Button press: will power on in 5 sec
>>>>>> [   38.385798] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card present
>>>>>> [   38.385799] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
>>>>>> [   39.553709] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x020000 PCIe
>>>>>> Endpoint
>>>>>> [   39.554018] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000fff]
>>>>>> [   39.554042] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003fff 64bit
>>>>>> pref]
>>>>>> [   39.554099] pci 0000:0d:00.0: enabling Extended Tags
>>>>>> [   39.555202] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>>>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
>>>>>> [   39.555206] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
>>>>>> [   39.555212] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>> 0x00200000]: can't assign; no space
>>>>>> [   39.555213] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>> 0x00200000]: failed to assign
>>>>>> [   39.555215] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>>>>>> 64bit pref]: can't assign; no space
>>>>>> [   39.555216] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>>>>>> 64bit pref]: failed to assign
>>>>>> [   39.555218] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>> can't assign; no space
>>>>>> [   39.555219] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>> failed to assign
>>>>>> [   39.555222] pcieport 0000:0c:02.0: bridge window [mem
>>>>>> 0x10a00000-0x10afffff]: assigned
>>>>>> [   39.555224] pcieport 0000:0c:02.0: bridge window [mem
>>>>>> 0x10b00000-0x10bfffff 64bit pref]: assigned
>>>>>> [   39.555225] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>> can't assign; no space
>>>>>> [   39.555227] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>> failed to assign
>>>>>> [   39.555228] pcieport 0000:0c:02.0: bridge window [mem
>>>>>> 0x10a00000-0x10afffff]: failed to expand by 0x100000
>>>>>> [   39.555230] pcieport 0000:0c:02.0: bridge window [mem
>>>>>> 0x10a00000-0x10afffff]: failed to add optional 100000
>>>>>> [   39.555232] pcieport 0000:0c:02.0: bridge window [mem
>>>>>> 0x10b00000-0x10bfffff 64bit pref]: failed to expand by 0x100000
>>>>>> [   39.555234] pcieport 0000:0c:02.0: bridge window [mem
>>>>>> 0x10b00000-0x10bfffff 64bit pref]: failed to add optional 100000
>>>>>> [   39.555236] pci 0000:0d:00.0: BAR 4 [mem 0x10b00000-0x10b03fff 64bit
>>>>>> pref]: assigned
>>>>>> [   39.555290] pci 0000:0d:00.0: BAR 1 [mem 0x10a00000-0x10a00fff]: assigned
>>>>>> [   39.555305] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
>>>>>> [   39.556804] pcieport 0000:0c:02.0:   bridge window [mem
>>>>>> 0x10a00000-0x10afffff]
>>>>>> [   39.557730] pcieport 0000:0c:02.0:   bridge window [mem
>>>>>> 0x10b00000-0x10bfffff 64bit pref]
>>>>>> [   39.559629] PCI: No. 2 try to assign unassigned res
>>>>>> [   39.559636] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>> can't assign; no space
>>>>>> [   39.559638] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>> failed to assign
>>>>>> [   39.559640] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>> can't assign; no space
>>>>>> [   39.559642] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>> failed to assign
>>>>>> [   39.559644] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
>>>>>> [   39.561078] pcieport 0000:0c:02.0:   bridge window [mem
>>>>>> 0x10a00000-0x10afffff]
>>>>>> [   39.562011] pcieport 0000:0c:02.0:   bridge window [mem
>>>>>> 0x10b00000-0x10bfffff 64bit pref]
>>>>>> [   39.564500] ACPI: \_SB_.L0A2: Enabled at IRQ 37
>>>>>> [   39.564541] virtio-pci 0000:0d:00.0: enabling device (0000 -> 0002)
>>>>>> [   39.572231] virtio_net virtio2 enp13s0: renamed from eth0
>>>>>>
>>>>>> Any clue?
>>>>>>
>>>>>> Thank you in advance
>>>>>>
>>>>>> Eric
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Additional motivation for this are the upcoming changes that add
>>>>>>> complexity to the optional sizing logic due to Resizable BAR awareness.
>>>>>>> The extra logic would exceed any reasonable indentation level if the
>>>>>>> optional sizing code is kept within the loop body.
>>>>>>>
>>>>>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>>>>> ---
>>>>>>>  drivers/pci/setup-bus.c | 77 +++++++++++++++++++++++++++++------------
>>>>>>>  1 file changed, 54 insertions(+), 23 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>>>>>>> index 3d1d3cefcdba..3fcc7641c374 100644
>>>>>>> --- a/drivers/pci/setup-bus.c
>>>>>>> +++ b/drivers/pci/setup-bus.c
>>>>>>> @@ -125,15 +125,6 @@ static resource_size_t get_res_add_size(struct list_head *head,
>>>>>>>  	return dev_res ? dev_res->add_size : 0;
>>>>>>>  }
>>>>>>>  
>>>>>>> -static resource_size_t get_res_add_align(struct list_head *head,
>>>>>>> -					 struct resource *res)
>>>>>>> -{
>>>>>>> -	struct pci_dev_resource *dev_res;
>>>>>>> -
>>>>>>> -	dev_res = res_to_dev_res(head, res);
>>>>>>> -	return dev_res ? dev_res->min_align : 0;
>>>>>>> -}
>>>>>>> -
>>>>>>>  static void restore_dev_resource(struct pci_dev_resource *dev_res)
>>>>>>>  {
>>>>>>>  	struct resource *res = dev_res->res;
>>>>>>> @@ -386,6 +377,8 @@ bool pci_resource_is_optional(const struct pci_dev *dev, int resno)
>>>>>>>  		return true;
>>>>>>>  	if (resno == PCI_ROM_RESOURCE && !(res->flags & IORESOURCE_ROM_ENABLE))
>>>>>>>  		return true;
>>>>>>> +	if (pci_resource_is_bridge_win(resno) && !resource_size(res))
>>>> adding
>>>>
>>>> && !dev->is_hotplug_bridge makes the hotplug successful.
>>>>
>>>>
>>>> My understanding is that otherwise the hotplug bridge window is
>>>> considered as optional and no memoy window is allocated to assign chid
>>>> device's BARS
>>>>
>>>> Please let me know if that makes sense. In the positive I can send a patch.
>>>
>>> I don't think that is the correct solution.
>>>
>>>
>>> These bridges, have both non-prefetchable and prefetchable windows, but 
>>> the initial setup only sets the non-prefetchable one to 2M (and nothing 
>>> more would fit to the associated root bus resource). There's only a single 
>>> root bus resource that is 2M + a bit more (to fit that BAR0).
>>>
>>> Now, when sizing the bridge windows, the kernel sizing algorithm just uses 
>>> the default 2M hotplug reservation to both of those windows as there are 
>>> not yet any real devices underneath (the default hp reservation is 
>>> controllable with hpmmiosize/hpmmioprefsize/hpmemsize cmdline parameters). 
>>> Thus, to fit everything, the root bus resource should be 4M + a bit more 
>>> for BAR0.
>>>
>>> However, it looks to me there's also a 4M add_size miscalculation (the 
>>> downstream bridge window is only 2M per each type):
>>>
>>> [    0.048078] pci 0000:0a:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 0b-0d] add_size 400000 add_align 100000
>>> [    0.048079] pci 0000:0a:00.0: bridge window [mem 0x00100000-0x000fffff] to [bus 0b-0d] add_size 400000 add_align 100000
>>
>> Hum even with the patch below I still get:
>>
>> [    0.047253] pci 0000:0a:00.0: bridge window [mem
>> 0x00100000-0x000fffff 64bit pref] to [bus 0b-0d] add_size 400000
>> add_align 100000
>> [    0.047254] pci 0000:0a:00.0: bridge window [mem
>> 0x00100000-0x000fffff] to [bus 0b-0d] add_size 400000 add_align 100000

If I comment the continue in the block hereafter in pbus_size_mem() it
works.

if (pbus_size_mem_optional(dev, i, align,
                           realloc_head, &add_align,
                           &children_add_size)) {
                                //continue;
}

Given r_size == 0, this allows to set aligns[order] += align;

isn't it requested for the parent bridges (the Root Port and Switch
Upstream port) to see the downstream alignment requirements and map them
out on boot?

Thanks

Eric

> 
> Okay, I'll then have to do a debug patch to know what the loop adds into 
> it. I'll try to get it done today.
> 
> Thanks anyway for testing.
> 

