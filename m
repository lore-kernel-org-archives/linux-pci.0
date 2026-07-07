Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32546340419
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438957; cv=none; b=oKq2EqevTO4SYqlMVzoP5LH2hluOwHqZdXN8wptxA3RCCjeuCmdiKl9QPImg/EmvVZb5iExLKd3wUS4rp8wQj3GJ9O/1as7/HBcJ2AuMHvbtCa2QATv0LgxQw78wRaUFdQLtLMj+YGBjViLKLJDZIZcLDbPPRSXWAR2DUp1cSwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438957; c=relaxed/simple;
	bh=NrHWguCHqesRZxxzB6noe8Hof+3oH02M7UfwCHGNdJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PE7bT7jTnjCTPmPfPBnxhP3uCq01EmoQ4iPGAjCrHMeN55mOnXmABclS8b1c7J42oskYqZGddXYbBt3cPD0X/04kMp9gE7D+BQBKbUoeLHwnOYT2QamHl1kkKjGsxsu3mgRWQw0WEtmIQRWamh7I/oAgrJffyQy9cc9tUfUjOHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xdp0qt6W; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWUFYrZW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xdp0qt6W";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWUFYrZW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783438954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyN52IgTO8QpPaa6idqh074x9qYWNgZ+TQ4DPozn5z8=;
	b=Xdp0qt6Wpl62sFiCmEwoyyEkHtAL4C2LCZmpHTpvLvR/Fw6+fVPI+lDgrt5zrMShx/nMX/
	D5BSwFpRi0UyD26o8L0Q24Cglbxpb90zDJP8mPO9GXTr9jl8XAiFu40EpUnW0EYB2L0yA1
	/BtzwubL1DVM/FykaHafY76IMm7xX/w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-_Z_s29MkMbmf0aeqSSSkfA-1; Tue, 07 Jul 2026 11:42:33 -0400
X-MC-Unique: _Z_s29MkMbmf0aeqSSSkfA-1
X-Mimecast-MFC-AGG-ID: _Z_s29MkMbmf0aeqSSSkfA_1783438952
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493bb6a4336so36780785e9.3
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783438952; x=1784043752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qyN52IgTO8QpPaa6idqh074x9qYWNgZ+TQ4DPozn5z8=;
        b=XWUFYrZWyM/HedNiCxPY8yj8ayNjzgmrHrKoOYBztiXXf9ugBOgjOuHJyXunSAfSSt
         wh3NP4tC1fSZtx3QxIrl1VMeqktNn6adBSBA5fViH/Id//bXF5+lLExN1o4WXnx+t4zr
         6hz2Rm+lO/RUeNsXNpGIkVBQxWhhdufUBKBNNZorvIMFWs6V4Tfhwu7BuL/je1pkkEPh
         RHsrtfrhCrLPT7tFDl1n0Xn6iC8fWk3w22gWg6+QKYsff29YQQD9skTJY+pwDUXg8pCJ
         IE4WqBpUjpBVGCqIySepgVWggtBVNLRKz6GYefIq1yaBx5nZuejU6kQuqdB+o5cf0Nd3
         K/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438952; x=1784043752;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qyN52IgTO8QpPaa6idqh074x9qYWNgZ+TQ4DPozn5z8=;
        b=BB5OtLtjfYe8yTeGO71mdU/kweS6S6UmDTYxATBj0IkGzBIAmoedUdhU8y2cRyIoLJ
         MDQXuyNbM8RSRGDSHXFM/6ueHnZ7x4QDOo6PsBlSpKGA9LrfWRKe9ktGAl1/WPqLzeGF
         fulqxbpKH2dbDVJ8Gj9PuM3hytD2kW/sEkszINDSdRFMo4i8Un7ZSEZHtZ/z3XrHEgvX
         EdmNniHkJgWCa4JF/CCqPTuR/KMUiOqKrbCSIzSkiY31ntRZstb3uN8E/rFs57MCkTUJ
         3A5hAc+bS8GfjhxJiZxefJg5p5F1Cpot4rM8Q4dVR/0cJWkX2KScCvfor2gup57hUKsh
         vUFg==
X-Forwarded-Encrypted: i=1; AHgh+RrkgwR6bA7H8ImnPgOHS5/3yltIncXdOkAAgApza7JKh0KUH0Xa/aGEc8S1+u6qmE2+AmD2qL4lruM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKJuLY8pgX8wb7caV4sgoWHtg7VxrJeNgsj0Oci1AVc0WGl5bb
	p5cP1L2b7/st2O/e2usDfBxFzrv6+YatJgall320ar2mKpnBx/GuREtvUJT32fqquBNGTV4uYe7
	zUpbFLMyscDiATdF7wgX50y7FG79Q670HKLJAN43TrervIjh7T3m0FmIUAgerpw==
X-Gm-Gg: AfdE7cmGhtIb9PkelO5moleS/jc8pj+08zptE1K3EpvUkIOeOuxq213ZrArWFo37HZX
	8MZRYxOfNRLMpIJpofoYiplCXiK2dLKreaJ37FfQdOs+bregM2nVlqotrMiuyiHPj3upjpF8gXE
	8J4D2gV1zrBhJ4I9SmVb9YxZA9Zo/diEtsSyLumZ7JvCsN03Ayg6Cqzymf/MAwYkEMTQ3ZWivwr
	zv+Ow0K1DW0r4AN8qVj4sG/R8b5ykt+l9AqkgQujSFSaHt2LgX4X8trBwsPNSS7aYVODdDhAwQf
	nClaC/3JUbc8B6YLSUG1KbNxUGU3+/7eb5lJjtD0kU1XgdI9fXmhs22Ib1sGgvVsMa+FMdz0Fcj
	MfaenoGR2GIPNg2IyMJN/RTGgmMA1O5fbqerhhSahdzK6tdfMumCZ6seK
X-Received: by 2002:a05:600c:8b28:b0:492:3e44:214b with SMTP id 5b1f17b1804b1-493df069041mr60099505e9.13.1783438951339;
        Tue, 07 Jul 2026 08:42:31 -0700 (PDT)
X-Received: by 2002:a05:600c:8b28:b0:492:3e44:214b with SMTP id 5b1f17b1804b1-493df069041mr60099125e9.13.1783438950830;
        Tue, 07 Jul 2026 08:42:30 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:263:8800:8714:9136:d3b4:25b3? ([2a01:cb1c:263:8800:8714:9136:d3b4:25b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm31494048f8f.31.2026.07.07.08.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 08:42:30 -0700 (PDT)
Message-ID: <f23946f2-06ac-4607-8f2c-3ffbc52b627a@redhat.com>
Date: Tue, 7 Jul 2026 17:42:28 +0200
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
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@redhat.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
 <20251219174036.16738-14-ilpo.jarvinen@linux.intel.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20251219174036.16738-14-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ilpo,

On 12/19/25 6:40 PM, Ilpo Järvinen wrote:
> The resource loop in pbus_size_mem() handles optional resources that
> are either fully optional (SRIOV and disabled Expansion ROMs) or bridge
> windows that may be optional only for a part. The logic is little
> inconsistent when it comes to a bridge window that has only optional
> children resources as it would be more natural to treat it similar to
> any fully optional resource. As resource size should be zero in that
> case, it shouldn't cause any bugs but it still seems useful to address
> the inconsistency.
> 
> Place the optional size related code of pbus_size_mem() into
> pbus_mem_size_optional() and add check into pci_resource_is_optional()
> for entirely optional bridge windows. Reorder the logic inside
> pbus_mem_size_optional() such that fully optional resources are handled
> the same irrespective to whether the resource is a bridge window or
> not.

This patch seems to introduce a regression when trying to hotplug a
virtio-net-pci device behind a XIO3130 downstream port in the following
hierarchy.

this happens with a v7.2-rc2 guest kernel, on an arm64 guest with qemu vmm.



00:01.0 Host bridge: Red Hat, Inc. QEMU PCIe Expander bridge
	Subsystem: Red Hat, Inc. Device 1100

|_ 0a:00.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
   Subsystem: Red Hat, Inc. Device 0000
   Kernel driver in use: pcieport

   |_ 0b:00.0 PCI bridge: Texas Instruments XIO3130 PCI Express Switch

	(Upstream) (rev 02)
	Kernel driver in use: pcieport

	|_ 0c:02.0 PCI bridge: Texas Instruments XIO3130 PCI Express
		Switch (Downstream) (rev 01)
		Kernel driver in use: pcieport

This produces the following trace


[   28.557947] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card present
[   28.557949] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
[   29.605376] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x020000 PCIe
Endpoint
[   29.605724] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000fff]
[   29.605765] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003fff 64bit
pref]
[   29.605816] pci 0000:0d:00.0: enabling Extended Tags
[   29.606994] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
64bit pref] to [bus 0d] add_size 100000 add_align 100000
[   29.606998] pcieport 0000:0c:02.0: bridge window [mem size
0x00100000] to [bus 0d] add_size 100000 add_align 100000
[   29.607003] pcieport 0000:0c:02.0: bridge window [mem size
0x00200000]: can't assign; no space
[   29.607005] pcieport 0000:0c:02.0: bridge window [mem size
0x00200000]: failed to assign
[   29.607007] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
64bit pref]: can't assign; no space
[   29.607008] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
64bit pref]: failed to assign
[   29.607010] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
can't assign; no space
[   29.607012] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
failed to assign
[   29.607014] pcieport 0000:0c:02.0: bridge window [mem size
0x00100000]: can't assign; no space
[   29.607016] pcieport 0000:0c:02.0: bridge window [mem size
0x00100000]: failed to assign
[   29.607018] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
64bit pref]: can't assign; no space
[   29.607019] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
64bit pref]: failed to assign
[   29.607021] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
can't assign; no space
[   29.607022] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
failed to assign
[   29.607025] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
can't assign; no space
[   29.607026] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
failed to assign
[   29.607027] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
assign; no space
[   29.607028] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
assign
[   29.607029] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
can't assign; no space
[   29.607030] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
failed to assign
[   29.607031] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
assign; no space
[   29.607032] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
assign
[   29.607033] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
[   29.611260] PCI: No. 2 try to assign unassigned res
[   29.611269] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
64bit pref] to [bus 0d] add_size 100000 add_align 100000
[   29.611272] pcieport 0000:0c:02.0: bridge window [mem size
0x00100000] to [bus 0d] add_size 100000 add_align 100000
[   29.611276] pcieport 0000:0c:02.0: bridge window [mem size
0x00200000]: can't assign; no space
[   29.611277] pcieport 0000:0c:02.0: bridge window [mem size
0x00200000]: failed to assign
[   29.611278] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
64bit pref]: can't assign; no space
[   29.611279] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
64bit pref]: failed to assign
[   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
can't assign; no space
[   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
failed to assign
[   29.611281] pcieport 0000:0c:02.0: bridge window [mem size
0x00100000]: can't assign; no space
[   29.611282] pcieport 0000:0c:02.0: bridge window [mem size
0x00100000]: failed to assign
[   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
64bit pref]: can't assign; no space
[   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
64bit pref]: failed to assign
[   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
can't assign; no space
[   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
failed to assign
[   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
can't assign; no space
[   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
failed to assign
[   29.611287] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
assign; no space
[   29.611288] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
assign
[   29.611288] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
can't assign; no space
[   29.611289] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
failed to assign
[   29.611289] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
assign; no space
[   29.611290] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
assign
[   29.611291] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
[   29.616141] ACPI: \_SB_.L0A2: Enabled at IRQ 37
[   29.616378] virtio-pci 0000:0d:00.0: virtio_pci: leaving for legacy
driver

Previous to this commit hotplug was successful:

vm-rhel10 login: [   38.385692] pcieport 0000:0c:02.0: pciehp:
Slot(0-1): Button press: will power on in 5 sec
[   38.385798] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card present
[   38.385799] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
[   39.553709] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x020000 PCIe
Endpoint
[   39.554018] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000fff]
[   39.554042] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003fff 64bit
pref]
[   39.554099] pci 0000:0d:00.0: enabling Extended Tags
[   39.555202] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
64bit pref] to [bus 0d] add_size 100000 add_align 100000
[   39.555206] pcieport 0000:0c:02.0: bridge window [mem size
0x00100000] to [bus 0d] add_size 100000 add_align 100000
[   39.555212] pcieport 0000:0c:02.0: bridge window [mem size
0x00200000]: can't assign; no space
[   39.555213] pcieport 0000:0c:02.0: bridge window [mem size
0x00200000]: failed to assign
[   39.555215] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
64bit pref]: can't assign; no space
[   39.555216] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
64bit pref]: failed to assign
[   39.555218] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
can't assign; no space
[   39.555219] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
failed to assign
[   39.555222] pcieport 0000:0c:02.0: bridge window [mem
0x10a00000-0x10afffff]: assigned
[   39.555224] pcieport 0000:0c:02.0: bridge window [mem
0x10b00000-0x10bfffff 64bit pref]: assigned
[   39.555225] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
can't assign; no space
[   39.555227] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
failed to assign
[   39.555228] pcieport 0000:0c:02.0: bridge window [mem
0x10a00000-0x10afffff]: failed to expand by 0x100000
[   39.555230] pcieport 0000:0c:02.0: bridge window [mem
0x10a00000-0x10afffff]: failed to add optional 100000
[   39.555232] pcieport 0000:0c:02.0: bridge window [mem
0x10b00000-0x10bfffff 64bit pref]: failed to expand by 0x100000
[   39.555234] pcieport 0000:0c:02.0: bridge window [mem
0x10b00000-0x10bfffff 64bit pref]: failed to add optional 100000
[   39.555236] pci 0000:0d:00.0: BAR 4 [mem 0x10b00000-0x10b03fff 64bit
pref]: assigned
[   39.555290] pci 0000:0d:00.0: BAR 1 [mem 0x10a00000-0x10a00fff]: assigned
[   39.555305] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
[   39.556804] pcieport 0000:0c:02.0:   bridge window [mem
0x10a00000-0x10afffff]
[   39.557730] pcieport 0000:0c:02.0:   bridge window [mem
0x10b00000-0x10bfffff 64bit pref]
[   39.559629] PCI: No. 2 try to assign unassigned res
[   39.559636] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
can't assign; no space
[   39.559638] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
failed to assign
[   39.559640] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
can't assign; no space
[   39.559642] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
failed to assign
[   39.559644] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
[   39.561078] pcieport 0000:0c:02.0:   bridge window [mem
0x10a00000-0x10afffff]
[   39.562011] pcieport 0000:0c:02.0:   bridge window [mem
0x10b00000-0x10bfffff 64bit pref]
[   39.564500] ACPI: \_SB_.L0A2: Enabled at IRQ 37
[   39.564541] virtio-pci 0000:0d:00.0: enabling device (0000 -> 0002)
[   39.572231] virtio_net virtio2 enp13s0: renamed from eth0

Any clue?

Thank you in advance

Eric







> 
> Additional motivation for this are the upcoming changes that add
> complexity to the optional sizing logic due to Resizable BAR awareness.
> The extra logic would exceed any reasonable indentation level if the
> optional sizing code is kept within the loop body.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/setup-bus.c | 77 +++++++++++++++++++++++++++++------------
>  1 file changed, 54 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 3d1d3cefcdba..3fcc7641c374 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -125,15 +125,6 @@ static resource_size_t get_res_add_size(struct list_head *head,
>  	return dev_res ? dev_res->add_size : 0;
>  }
>  
> -static resource_size_t get_res_add_align(struct list_head *head,
> -					 struct resource *res)
> -{
> -	struct pci_dev_resource *dev_res;
> -
> -	dev_res = res_to_dev_res(head, res);
> -	return dev_res ? dev_res->min_align : 0;
> -}
> -
>  static void restore_dev_resource(struct pci_dev_resource *dev_res)
>  {
>  	struct resource *res = dev_res->res;
> @@ -386,6 +377,8 @@ bool pci_resource_is_optional(const struct pci_dev *dev, int resno)
>  		return true;
>  	if (resno == PCI_ROM_RESOURCE && !(res->flags & IORESOURCE_ROM_ENABLE))
>  		return true;
> +	if (pci_resource_is_bridge_win(resno) && !resource_size(res))
> +		return true;
>  
>  	return false;
>  }
> @@ -1258,6 +1251,54 @@ static resource_size_t calculate_head_align(resource_size_t *aligns,
>  	return head_align;
>  }
>  
> +/*
> + * pbus_size_mem_optional - Account optional resources in bridge window
> + *
> + * Account an optional resource or the optional part of the resource in bridge
> + * window size.
> + *
> + * Return: %true if the resource is entirely optional.
> + */
> +static bool pbus_size_mem_optional(struct pci_dev *dev, int resno,
> +				   resource_size_t align,
> +				   struct list_head *realloc_head,
> +				   resource_size_t *add_align,
> +				   resource_size_t *children_add_size)
> +{
> +	struct resource *res = pci_resource_n(dev, resno);
> +	bool optional = pci_resource_is_optional(dev, resno);
> +	resource_size_t r_size = resource_size(res);
> +	struct pci_dev_resource *dev_res;
> +
> +	if (!realloc_head)
> +		return false;
> +
> +	if (!optional) {
> +		/*
> +		 * Only bridges have optional sizes in realloc_head at this
> +		 * point. As res_to_dev_res() walks the entire realloc_head
> +		 * list, skip calling it when known unnecessary.
> +		 */
> +		if (!pci_resource_is_bridge_win(resno))
> +			return false;
> +
> +		dev_res = res_to_dev_res(realloc_head, res);
> +		if (dev_res) {
> +			*children_add_size += dev_res->add_size;
> +			*add_align = max(*add_align, dev_res->min_align);
> +		}
> +
> +		return false;
> +	}
> +
> +	/* Put SRIOV requested res to the optional list */
> +	add_to_list(realloc_head, dev, res, 0, align);
> +	*children_add_size += r_size;
> +	*add_align = max(align, *add_align);
> +
> +	return true;
> +}
> +
>  /**
>   * pbus_size_mem() - Size the memory window of a given bus
>   *
> @@ -1284,7 +1325,6 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
>  	resource_size_t aligns[28] = {}; /* Alignments from 1MB to 128TB */
>  	int order, max_order;
>  	resource_size_t children_add_size = 0;
> -	resource_size_t children_add_align = 0;
>  	resource_size_t add_align = 0;
>  
>  	if (!b_res)
> @@ -1311,7 +1351,6 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
>  			if (b_res != pbus_select_window(bus, r))
>  				continue;
>  
> -			r_size = resource_size(r);
>  			align = pci_resource_alignment(dev, r);
>  			/*
>  			 * aligns[0] is for 1MB (since bridge memory
> @@ -1327,25 +1366,17 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
>  				continue;
>  			}
>  
> -			/* Put SRIOV requested res to the optional list */
> -			if (realloc_head && pci_resource_is_optional(dev, i)) {
> -				add_align = max(align, add_align);
> -				add_to_list(realloc_head, dev, r, 0, 0 /* Don't care */);
> -				children_add_size += r_size;
> +			if (pbus_size_mem_optional(dev, i, align,
> +						   realloc_head, &add_align,
> +						   &children_add_size))
>  				continue;
> -			}
>  
> +			r_size = resource_size(r);
>  			size += max(r_size, align);
>  
>  			aligns[order] += align;
>  			if (order > max_order)
>  				max_order = order;
> -
> -			if (realloc_head) {
> -				children_add_size += get_res_add_size(realloc_head, r);
> -				children_add_align = get_res_add_align(realloc_head, r);
> -				add_align = max(add_align, children_add_align);
> -			}
>  		}
>  	}
>  

