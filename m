Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C7F3BFE4C
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525157; cv=none; b=HRs3DsAgyCNK9U8qHlLBB5N6ATbIEQ2k0Pg89IPh+iMZ2imF4GQ7WZzTyO8jw0Id2L9LacSO7Qa7Vru5r8UKkSeGyMRoUqmJxjSnFPiAj/mOLWlwRDxN5XF6KUkMQcUoWcJRnejc1DpTj3SGgjTX1LQIioLdbyGJQvBq358mCKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525157; c=relaxed/simple;
	bh=4671/B7kSSwuraPYLyTyalcrRTYoor4QFUJ18Nq7cho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VztNk41RCML4y4RQwDsFCa/jwDaH7aPJqJzyZF16uEwJtYrVxLaXdq2DTDxrlPx1qLgjRAGB9R4jGJMSJ1wwEIDIel5H1F4UxH82qeZ/W8mitotZrqSIvVFMl+2YH/ulTJNEuJRRZn7pxNJulq+vyE9AdKEKWL+n3Efoqbcm0kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VVgaLYg3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bAzPruJF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVgaLYg3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAzPruJF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783525154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgvBPPbzdqMwF+AGxDKfWmStxa0Wb/UJijMVqulmxOk=;
	b=VVgaLYg3hbRH0HLFKnT7NXSxXuoJlguuNPRITEvRwr8sHPz/sxnUZYWFa+JqwINO+HXs2t
	z21e0P6C7IvZvO+4ZWQMVaiFzonFC+1D9h1dHttDFP2aLYZCi3ztzpvf38u0+/CRSE9765
	y4QngI6BSJZut4ZzngsBzpV8TaYb5Fg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-LT_4GremOymtxEjXBKy3uQ-1; Wed, 08 Jul 2026 11:39:13 -0400
X-MC-Unique: LT_4GremOymtxEjXBKy3uQ-1
X-Mimecast-MFC-AGG-ID: LT_4GremOymtxEjXBKy3uQ_1783525152
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-473ac08a6a4so738541f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783525152; x=1784129952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZgvBPPbzdqMwF+AGxDKfWmStxa0Wb/UJijMVqulmxOk=;
        b=bAzPruJFplB+kAGIDZSY374/AzRiqJ5Xs8Qm53UyGz11d0M5M9wF+o0hwvyQZRT3N3
         yWQC85Y/nOSZ+Y0evUxC4hCp68Pl5LlWmtIsw/eOkTmSNXEo34T26z62xJ8LkJDRWQix
         estSTYkbF9p9w0BzmhuuCq1AXC/UMOlvRMncOnnh5T2/QeH+8P0KIiJHiN41FLtifWs5
         bo9uxvia4oHPjnl0Yy8OhARt0T08IwaVmIpjBCO7Z3h7dt+hE3sblZ6k+MYSXVwlzy+T
         3fzjFMJnQlDdAgwWZ6yxvdckHHEUB15WPhr5sPqN2DBPmmDi5mINGOBYvYRA+tphqD5m
         GZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525152; x=1784129952;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZgvBPPbzdqMwF+AGxDKfWmStxa0Wb/UJijMVqulmxOk=;
        b=CnAJ7FWsI+xI8j6tvEFlR9daCEUZJS00YcrBK+tu2roLm560GueNHHTUeCulzhCWY1
         Mmv6OHM8SqM+EQk60QO+Ij6AcYE7sPDhJXdNc0d+JOonXyFBpFjPnYIZ3GD1jpuGytuV
         qMf3/Q7ZbAq2ld1z8j9/0yIbSHTROAzo2F7K4SjkTSAnQ6T834Lp/zE0elTpCVcrfcZw
         GHPd7n3P4tvY6qTYVtcucKkn6AlAT+D+i6gE2+Hxre4RPHLPDQYAhUoFBui6+bkWIY7z
         SFr9iUr0KRAr6vciqviFl80E0kypZ3Q/agsOz+bT4LetTOTAMibBuLV+NOFgC+W6VZrq
         lKfg==
X-Gm-Message-State: AOJu0Yy8qR2SumVh+KI4PP9ycRuP8+g8IwE+K9WcfkijX5APCyFmXtiz
	AfQ3zL5eyvlsJmvLg7s2yv3pIOB9f4A/EWrB3V/6Us8qXF/NZJWPVpJDO7ygvCQdazhSu+VUl2n
	2cGMkS4pN+qrtPPg9CbS12DDwwdAGoH/pV470J808G88thGFGqRIf8bUCCLD2xg==
X-Gm-Gg: AfdE7clqkV8Uw0G7+0GChU6fY5zXX/vsUb/lC524WgZ4iFCU8Q8cBZxq2znAqYYo/LP
	5ogkw9RNpVHEYHthRCA6TZRheXo6lwngFJFujoxt4CaKsvht1QIQMk4SzwGWgO6ZBG/6rBEimb7
	SOTXh4qA+ZfLZ5NVMxGp6aQD82nGywKZBAPFm5ZxWQwU1o5hph9c/mBInVM0IPdNZKQ0DWxa2fE
	L96CTSbKtJvRZX5g3ovq/C9AN9/73cjEkSd/AjWP/pGENRv/mDZmlLwIGkqvllOVHIZ31KyH7YQ
	/XzS36aQv8XYDAsIFoCTiHCMPosHffeoZFk96t+++UgaMuk2qXW96+rHHUQxD5kjRbUqjn/12xk
	YlfPtO/G+MoST99k4IztolgEv98NiLiXRFKTP1ubMsg9s9DCwUgetWtT8
X-Received: by 2002:a05:6000:2f86:b0:475:f100:360d with SMTP id ffacd0b85a97d-47df0824681mr3637951f8f.60.1783525151670;
        Wed, 08 Jul 2026 08:39:11 -0700 (PDT)
X-Received: by 2002:a05:6000:2f86:b0:475:f100:360d with SMTP id ffacd0b85a97d-47df0824681mr3637896f8f.60.1783525151009;
        Wed, 08 Jul 2026 08:39:11 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:263:8800:8714:9136:d3b4:25b3? ([2a01:cb1c:263:8800:8714:9136:d3b4:25b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm42446264f8f.33.2026.07.08.08.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 08:39:10 -0700 (PDT)
Message-ID: <313af044-b9b7-496d-8d1c-dba61c606592@redhat.com>
Date: Wed, 8 Jul 2026 17:39:09 +0200
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
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <e2dfd270-a831-06f4-6ddf-c14eb9bce1f8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ilpo,

On 7/8/26 4:05 PM, Ilpo Järvinen wrote:
> On Wed, 8 Jul 2026, Eric Auger wrote:
>> On 7/7/26 6:12 PM, Ilpo Järvinen wrote:
>>> On Tue, 7 Jul 2026, Eric Auger wrote:
>>>
>>>> Hi Ilpo,
>>>>
>>>> On 12/19/25 6:40 PM, Ilpo Järvinen wrote:
>>>>> The resource loop in pbus_size_mem() handles optional resources that
>>>>> are either fully optional (SRIOV and disabled Expansion ROMs) or bridge
>>>>> windows that may be optional only for a part. The logic is little
>>>>> inconsistent when it comes to a bridge window that has only optional
>>>>> children resources as it would be more natural to treat it similar to
>>>>> any fully optional resource. As resource size should be zero in that
>>>>> case, it shouldn't cause any bugs but it still seems useful to address
>>>>> the inconsistency.
>>>>>
>>>>> Place the optional size related code of pbus_size_mem() into
>>>>> pbus_mem_size_optional() and add check into pci_resource_is_optional()
>>>>> for entirely optional bridge windows. Reorder the logic inside
>>>>> pbus_mem_size_optional() such that fully optional resources are handled
>>>>> the same irrespective to whether the resource is a bridge window or
>>>>> not.
>>>>
>>>> This patch seems to introduce a regression when trying to hotplug a
>>>> virtio-net-pci device behind a XIO3130 downstream port in the following
>>>> hierarchy.
>>>>
>>>> this happens with a v7.2-rc2 guest kernel, on an arm64 guest with qemu vmm.
>>>>
>>>>
>>>>
>>>> 00:01.0 Host bridge: Red Hat, Inc. QEMU PCIe Expander bridge
>>>> 	Subsystem: Red Hat, Inc. Device 1100
>>>>
>>>> |_ 0a:00.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
>>>>    Subsystem: Red Hat, Inc. Device 0000
>>>>    Kernel driver in use: pcieport
>>>>
>>>>    |_ 0b:00.0 PCI bridge: Texas Instruments XIO3130 PCI Express Switch
>>>>
>>>> 	(Upstream) (rev 02)
>>>> 	Kernel driver in use: pcieport
>>>>
>>>> 	|_ 0c:02.0 PCI bridge: Texas Instruments XIO3130 PCI Express
>>>> 		Switch (Downstream) (rev 01)
>>>> 		Kernel driver in use: pcieport
>>>
>>> Hi Eric,
>>>
>>> Thanks for the report.
>>>
>>> I cannot get much done with the log snippets. The first line with 
>>> difference is a symptom of something that originates from outside of the 
>>> snippet.
>>>
>>> Could you please take a log with dyndbg="file drivers/pci/*.c +p" on the 
>>> kernel command line and also include a /proc/iomem dump. Like 
>>> you did now, preferrably take those from both working and failing case so 
>>> I can easily diff them.
>>>
>>> --
>>>  i.
>>>
>>>
>>>> This produces the following trace
>>>>
>>>>
>>>> [   28.557947] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card present
>>>> [   28.557949] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
>>>> [   29.605376] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x020000 PCIe
>>>> Endpoint
>>>> [   29.605724] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000fff]
>>>> [   29.605765] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003fff 64bit
>>>> pref]
>>>> [   29.605816] pci 0000:0d:00.0: enabling Extended Tags
>>>> [   29.606994] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
>>>> [   29.606998] pcieport 0000:0c:02.0: bridge window [mem size
>>>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
>>>> [   29.607003] pcieport 0000:0c:02.0: bridge window [mem size
>>>> 0x00200000]: can't assign; no space
>>>> [   29.607005] pcieport 0000:0c:02.0: bridge window [mem size
>>>> 0x00200000]: failed to assign
>>>> [   29.607007] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>>>> 64bit pref]: can't assign; no space
>>>> [   29.607008] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>>>> 64bit pref]: failed to assign
>>>> [   29.607010] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>> can't assign; no space
>>>> [   29.607012] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>> failed to assign
>>>> [   29.607014] pcieport 0000:0c:02.0: bridge window [mem size
>>>> 0x00100000]: can't assign; no space
>>>> [   29.607016] pcieport 0000:0c:02.0: bridge window [mem size
>>>> 0x00100000]: failed to assign
>>>> [   29.607018] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>> 64bit pref]: can't assign; no space
>>>> [   29.607019] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>> 64bit pref]: failed to assign
>>>> [   29.607021] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>> can't assign; no space
>>>> [   29.607022] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>> failed to assign
>>>> [   29.607025] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>> can't assign; no space
>>>> [   29.607026] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>> failed to assign
>>>> [   29.607027] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
>>>> assign; no space
>>>> [   29.607028] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
>>>> assign
>>>> [   29.607029] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>> can't assign; no space
>>>> [   29.607030] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>> failed to assign
>>>> [   29.607031] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
>>>> assign; no space
>>>> [   29.607032] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
>>>> assign
>>>> [   29.607033] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
>>>> [   29.611260] PCI: No. 2 try to assign unassigned res
>>>> [   29.611269] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
>>>> [   29.611272] pcieport 0000:0c:02.0: bridge window [mem size
>>>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
>>>> [   29.611276] pcieport 0000:0c:02.0: bridge window [mem size
>>>> 0x00200000]: can't assign; no space
>>>> [   29.611277] pcieport 0000:0c:02.0: bridge window [mem size
>>>> 0x00200000]: failed to assign
>>>> [   29.611278] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>>>> 64bit pref]: can't assign; no space
>>>> [   29.611279] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>>>> 64bit pref]: failed to assign
>>>> [   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>> can't assign; no space
>>>> [   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>> failed to assign
>>>> [   29.611281] pcieport 0000:0c:02.0: bridge window [mem size
>>>> 0x00100000]: can't assign; no space
>>>> [   29.611282] pcieport 0000:0c:02.0: bridge window [mem size
>>>> 0x00100000]: failed to assign
>>>> [   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>> 64bit pref]: can't assign; no space
>>>> [   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>> 64bit pref]: failed to assign
>>>> [   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>> can't assign; no space
>>>> [   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>> failed to assign
>>>> [   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>> can't assign; no space
>>>> [   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>> failed to assign
>>>> [   29.611287] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
>>>> assign; no space
>>>> [   29.611288] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
>>>> assign
>>>> [   29.611288] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>> can't assign; no space
>>>> [   29.611289] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>> failed to assign
>>>> [   29.611289] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
>>>> assign; no space
>>>> [   29.611290] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
>>>> assign
>>>> [   29.611291] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
>>>> [   29.616141] ACPI: \_SB_.L0A2: Enabled at IRQ 37
>>>> [   29.616378] virtio-pci 0000:0d:00.0: virtio_pci: leaving for legacy
>>>> driver
>>>>
>>>> Previous to this commit hotplug was successful:
>>>>
>>>> vm-rhel10 login: [   38.385692] pcieport 0000:0c:02.0: pciehp:
>>>> Slot(0-1): Button press: will power on in 5 sec
>>>> [   38.385798] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card present
>>>> [   38.385799] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
>>>> [   39.553709] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x020000 PCIe
>>>> Endpoint
>>>> [   39.554018] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000fff]
>>>> [   39.554042] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003fff 64bit
>>>> pref]
>>>> [   39.554099] pci 0000:0d:00.0: enabling Extended Tags
>>>> [   39.555202] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
>>>> [   39.555206] pcieport 0000:0c:02.0: bridge window [mem size
>>>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
>>>> [   39.555212] pcieport 0000:0c:02.0: bridge window [mem size
>>>> 0x00200000]: can't assign; no space
>>>> [   39.555213] pcieport 0000:0c:02.0: bridge window [mem size
>>>> 0x00200000]: failed to assign
>>>> [   39.555215] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>>>> 64bit pref]: can't assign; no space
>>>> [   39.555216] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>>>> 64bit pref]: failed to assign
>>>> [   39.555218] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>> can't assign; no space
>>>> [   39.555219] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>> failed to assign
>>>> [   39.555222] pcieport 0000:0c:02.0: bridge window [mem
>>>> 0x10a00000-0x10afffff]: assigned
>>>> [   39.555224] pcieport 0000:0c:02.0: bridge window [mem
>>>> 0x10b00000-0x10bfffff 64bit pref]: assigned
>>>> [   39.555225] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>> can't assign; no space
>>>> [   39.555227] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>> failed to assign
>>>> [   39.555228] pcieport 0000:0c:02.0: bridge window [mem
>>>> 0x10a00000-0x10afffff]: failed to expand by 0x100000
>>>> [   39.555230] pcieport 0000:0c:02.0: bridge window [mem
>>>> 0x10a00000-0x10afffff]: failed to add optional 100000
>>>> [   39.555232] pcieport 0000:0c:02.0: bridge window [mem
>>>> 0x10b00000-0x10bfffff 64bit pref]: failed to expand by 0x100000
>>>> [   39.555234] pcieport 0000:0c:02.0: bridge window [mem
>>>> 0x10b00000-0x10bfffff 64bit pref]: failed to add optional 100000
>>>> [   39.555236] pci 0000:0d:00.0: BAR 4 [mem 0x10b00000-0x10b03fff 64bit
>>>> pref]: assigned
>>>> [   39.555290] pci 0000:0d:00.0: BAR 1 [mem 0x10a00000-0x10a00fff]: assigned
>>>> [   39.555305] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
>>>> [   39.556804] pcieport 0000:0c:02.0:   bridge window [mem
>>>> 0x10a00000-0x10afffff]
>>>> [   39.557730] pcieport 0000:0c:02.0:   bridge window [mem
>>>> 0x10b00000-0x10bfffff 64bit pref]
>>>> [   39.559629] PCI: No. 2 try to assign unassigned res
>>>> [   39.559636] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>> can't assign; no space
>>>> [   39.559638] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>> failed to assign
>>>> [   39.559640] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>> can't assign; no space
>>>> [   39.559642] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>> failed to assign
>>>> [   39.559644] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
>>>> [   39.561078] pcieport 0000:0c:02.0:   bridge window [mem
>>>> 0x10a00000-0x10afffff]
>>>> [   39.562011] pcieport 0000:0c:02.0:   bridge window [mem
>>>> 0x10b00000-0x10bfffff 64bit pref]
>>>> [   39.564500] ACPI: \_SB_.L0A2: Enabled at IRQ 37
>>>> [   39.564541] virtio-pci 0000:0d:00.0: enabling device (0000 -> 0002)
>>>> [   39.572231] virtio_net virtio2 enp13s0: renamed from eth0
>>>>
>>>> Any clue?
>>>>
>>>> Thank you in advance
>>>>
>>>> Eric
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>>
>>>>> Additional motivation for this are the upcoming changes that add
>>>>> complexity to the optional sizing logic due to Resizable BAR awareness.
>>>>> The extra logic would exceed any reasonable indentation level if the
>>>>> optional sizing code is kept within the loop body.
>>>>>
>>>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>>> ---
>>>>>  drivers/pci/setup-bus.c | 77 +++++++++++++++++++++++++++++------------
>>>>>  1 file changed, 54 insertions(+), 23 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>>>>> index 3d1d3cefcdba..3fcc7641c374 100644
>>>>> --- a/drivers/pci/setup-bus.c
>>>>> +++ b/drivers/pci/setup-bus.c
>>>>> @@ -125,15 +125,6 @@ static resource_size_t get_res_add_size(struct list_head *head,
>>>>>  	return dev_res ? dev_res->add_size : 0;
>>>>>  }
>>>>>  
>>>>> -static resource_size_t get_res_add_align(struct list_head *head,
>>>>> -					 struct resource *res)
>>>>> -{
>>>>> -	struct pci_dev_resource *dev_res;
>>>>> -
>>>>> -	dev_res = res_to_dev_res(head, res);
>>>>> -	return dev_res ? dev_res->min_align : 0;
>>>>> -}
>>>>> -
>>>>>  static void restore_dev_resource(struct pci_dev_resource *dev_res)
>>>>>  {
>>>>>  	struct resource *res = dev_res->res;
>>>>> @@ -386,6 +377,8 @@ bool pci_resource_is_optional(const struct pci_dev *dev, int resno)
>>>>>  		return true;
>>>>>  	if (resno == PCI_ROM_RESOURCE && !(res->flags & IORESOURCE_ROM_ENABLE))
>>>>>  		return true;
>>>>> +	if (pci_resource_is_bridge_win(resno) && !resource_size(res))
>> adding
>>
>> && !dev->is_hotplug_bridge makes the hotplug successful.
>>
>>
>> My understanding is that otherwise the hotplug bridge window is
>> considered as optional and no memoy window is allocated to assign chid
>> device's BARS
>>
>> Please let me know if that makes sense. In the positive I can send a patch.
> 
> I don't think that is the correct solution.
> 
> 
> These bridges, have both non-prefetchable and prefetchable windows, but 
> the initial setup only sets the non-prefetchable one to 2M (and nothing 
> more would fit to the associated root bus resource). There's only a single 
> root bus resource that is 2M + a bit more (to fit that BAR0).
> 
> Now, when sizing the bridge windows, the kernel sizing algorithm just uses 
> the default 2M hotplug reservation to both of those windows as there are 
> not yet any real devices underneath (the default hp reservation is 
> controllable with hpmmiosize/hpmmioprefsize/hpmemsize cmdline parameters). 
> Thus, to fit everything, the root bus resource should be 4M + a bit more 
> for BAR0.
> 
> However, it looks to me there's also a 4M add_size miscalculation (the 
> downstream bridge window is only 2M per each type):
> 
> [    0.048078] pci 0000:0a:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 0b-0d] add_size 400000 add_align 100000
> [    0.048079] pci 0000:0a:00.0: bridge window [mem 0x00100000-0x000fffff] to [bus 0b-0d] add_size 400000 add_align 100000

Hum even with the patch below I still get:

[    0.047253] pci 0000:0a:00.0: bridge window [mem
0x00100000-0x000fffff 64bit pref] to [bus 0b-0d] add_size 400000
add_align 100000
[    0.047254] pci 0000:0a:00.0: bridge window [mem
0x00100000-0x000fffff] to [bus 0b-0d] add_size 400000 add_align 100000
> 
> It's almost as if both of the child windows would be summed into it, not 
> just the one with the correct type. Maybe this is caused by the 
> pci_is_root_bus() thing in pbus_select_window_for_type() (which I don't 
> like but cannot currently really get rid of either) and 
> find_bus_resource_of_type() messing things up.
> 
> There's an attempt in the patch below to address that problem.
> 
> 
> But, even if the sizing would calculate 2M there, 2M + 2M windows are not 
> going to fit. This works what looks like by chance in the older kernel, 
> which (illogically) picks 1M required size for the both window (probably 
> that comes from min alignment) which magically just happens to fit to the 
> ~2M root bus resource.
> 
> So to solve that issue, you could try with hpmemsize=1M on the kernel's 
> cmndline to see if it elimnates those failures together with the patch 
> below.
Unfortunately it doens't (combination of this fix + hpmemsize=1M)
> 
> Why the system setup doesn't create large enough root bus resource for it 
> is way beyond my qemu and/or aarch64 knowledge and it seems to be where 
> the problem kind of originates from.

OK I need more time to investigate. I will come back to you.

Thanks

Eric
> 
> 
> --
> [PATCH 1/1] PCI: Fix mem resource type matching
> 
> pbus_select_window_for_type() handles root bus differently by calling
> find_bus_resource_of_type() with different sets of flags to handle
> memory window type fallbacks.
> 
> The first case is intended to match only exactly, but if type is
> IORESOURCE_MEM, the check in find_bus_resource_of_type() will not
> include IORESOURCE_MEM_64 in the mask. As a result, wrong resource
> may be selected even if a more precise match is available.
> 
> Similarly for the other case with IORESOURCE_PREFETCH.
> 
> Separate mask handling from the type of the particular resource to
> ensure the matching progresses from finer-grained matches towards more
> allowing matches.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/setup-bus.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index c0a949f2c995..912a30211505 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -209,17 +209,21 @@ static struct resource *pbus_select_window_for_type(struct pci_bus *bus,
>  		return NULL;
>  
>  	if (pci_is_root_bus(bus)) {
> -		win = find_bus_resource_of_type(bus, type, type);
> +		unsigned long mask = PCI_RES_TYPE_MASK;
> +
> +		win = find_bus_resource_of_type(bus, mask, type);
>  		if (win)
>  			return win;
>  
>  		type &= ~IORESOURCE_MEM_64;
> -		win = find_bus_resource_of_type(bus, type, type);
> +		mask &= ~IORESOURCE_MEM_64;
> +		win = find_bus_resource_of_type(bus, mask, type);
>  		if (win)
>  			return win;
>  
>  		type &= ~IORESOURCE_PREFETCH;
> -		return find_bus_resource_of_type(bus, type, type);
> +		mask &= ~IORESOURCE_PREFETCH;
> +		return find_bus_resource_of_type(bus, mask, type);
>  	}
>  
>  	switch (iores_type) {
> 
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482

