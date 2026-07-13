Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1CD3D16FC
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932540; cv=none; b=jjm51XYk1cHp/oLGhZU/uiEkSMRdJ2fIME6wciN4a9sn/8m11aGNnh1AGo+5ceaLoLG9jVqYSlBMbyDYjQn0HzgGeV25MwhH1r1aSi0js9OuKsT2jamEMrCqei5JClx/zvj3xEKkVnuIZAgdmOHxfXFGP2dtJ6gvieia0wn9va8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932540; c=relaxed/simple;
	bh=eV5SCnLcFK8GjGML0b3HYLsir0GlJ8aFNrm03lVPaFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZUOTT0taElD0WpAIF8YAuTty579h5GsVTrimnSMh4DYzTug8B+XKMHldiIRIRllGS6hmZE4WCu9t81ccrfdUN2IljVFGSeDW2IFJ3FmHq1XB8I8hlHCYse2ABRjOMRINVI7TcYAbQcTMgR1GSmfKa5C28vYkWpTcMIzg8g+tiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PLzUcIg5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lQKYNiv+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLzUcIg5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lQKYNiv+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783932532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IAFWvtK+8yIgIURMKISUDPimfWeWznr29QBs6DyxI6I=;
	b=PLzUcIg53ayW/l6GKhSD7VMSnHuMTHWALoTRlLInT/+phhJvXS70jPfVjCmqx3XmHfhwne
	pjlab8WgDzDaFx7bZQc5wvXIgWMACypjcydWCtuOJpK+QcLqD0bdunAvP7j6+0/d9GsYly
	u0EDPOE44Ubky0BYOifnAQp8RXVyBOA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-ReMTV4xAPNee0wxG--lIjw-1; Mon, 13 Jul 2026 04:48:50 -0400
X-MC-Unique: ReMTV4xAPNee0wxG--lIjw-1
X-Mimecast-MFC-AGG-ID: ReMTV4xAPNee0wxG--lIjw_1783932530
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4740be00302so3220350f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 01:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783932530; x=1784537330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IAFWvtK+8yIgIURMKISUDPimfWeWznr29QBs6DyxI6I=;
        b=lQKYNiv+KVG0cSE3LmIzhnT2dD6U+hXqvdl5oqOR6CRiFYjKUtrCeNL15wI4j/CFez
         4z5qrx+PZKzFxEMFovnnsNbhgt08SlLiVtz/kDdq9Dleph+ckURZ1f8WX3KOoZkwBUv1
         lyjii598iZAe9RvxaUWySp/PVL7jM4kwTw4BN6H5OhfFBrpWI0wpLoD6xbe7dYO5rJ/U
         bnwNEfkeOeZuKAJvlg2auy/OfhjSA7X1xMIKm4Dtm2KcmrvjbbjFrkWRrK8RHIb8oZAY
         HwP8vCrU8QbRWcbyuHAYuWda7UDLO9ONNtDSLaLfqHW8tO+oDjwMALRdMQHqbkyaIXGY
         T3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783932530; x=1784537330;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IAFWvtK+8yIgIURMKISUDPimfWeWznr29QBs6DyxI6I=;
        b=BXGk384BKldkiozS1xTTSJvGbJY/s+Wyu7h4lpuIzZ7kdl8pxJw6mlUWAF/tTD0lKM
         eyBAllrfUtb33hYwyGqWWaReqXRWqoZD7zw4QRk4sBmJ/zp8N+eFVXroFkZuw7XgPzNh
         OO5qEjXwqPQnACuBZk1sFcqe+5qP4/px31lqE/UUkfcz2MnjtwgmT2GgmmLENGj5JcTI
         Ie8rh5ftuXdAkp/pRvG+mhkLgJdj5ielGBNvShz7WJWLG80OOG90J7UVk2Nj81O6ThjL
         l/HawCWPSdn4giKve4qn7OpBX0NF0OH7CnU3IzxdpCSOWhRXvkesBZBnMdi2YjQDSsm4
         GYAg==
X-Gm-Message-State: AOJu0Yx64nHAFdWmn2iuWfUiTR6Zovbjosx7MZ3aD1YqfHbsNt+ra/zR
	VtEK2sZ+Z9rUcBV8bqKK0E3Eej02SweMW5KE3zzdhZwfLAyyhOeGdiSkLOOnF+uNL2rmtk1syhc
	Yd8jlR7kMYDBPI1MdA45shE3PmWLO4LKrBfbyMKdPPcgkQd1JC0pLsG3EDSARYQ==
X-Gm-Gg: AfdE7cmefFQRHVZ42hxK6DnR7ckzTHCH6CSFddLIjlMB9teFUyxWnvQT8rBzPZYsHvS
	ObRjQdMJmQrGzsacFz5WK5Zn/2auYiR/PofL+eBx4gO2Kdn+dk2V8s7epv6A4zdp1gCBD1gY1hb
	sEAzoxKf8nJAnoBADUOTuEjpLXwgPJZTvxPaTemQPRk9UaI5JeXaeEp6/v7fDl5EGnzP+f1zO4e
	v5qFc8V01yKniJeewP9DEZwXjD3xH5UMzifwc3Gq9/FusNmOZ7dWAGebJZFWQbamrflPvyTpdEn
	fnLfjWMTjyT4th5C1ZbsBLIwJOWbI9FbfQN/Zh2xPLxX+8Q0qtQbfaAPHHTvZaApDnCriQT3AkI
	r0MPTvRT8QahQEeimpCcQ297qAmkJRB/NoFkCRcISn8dbIiIsRjMNCg==
X-Received: by 2002:a05:6000:1866:b0:475:f0d1:eb56 with SMTP id ffacd0b85a97d-47f2dd0d63fmr9457667f8f.49.1783932529541;
        Mon, 13 Jul 2026 01:48:49 -0700 (PDT)
X-Received: by 2002:a05:6000:1866:b0:475:f0d1:eb56 with SMTP id ffacd0b85a97d-47f2dd0d63fmr9457625f8f.49.1783932528981;
        Mon, 13 Jul 2026 01:48:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae44sm79747130f8f.23.2026.07.13.01.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 01:48:48 -0700 (PDT)
Message-ID: <a68a6fef-958f-453a-8fc1-6ccbb2a8f801@redhat.com>
Date: Mon, 13 Jul 2026 10:48:47 +0200
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
 <802e57d4-7a35-474b-a291-8a8f74b51a6b@redhat.com>
 <fc981905-f6e0-fb9a-a905-9a65d01c8784@linux.intel.com>
 <24d4df44-45e0-4275-5ea9-196fd0af556d@linux.intel.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <24d4df44-45e0-4275-5ea9-196fd0af556d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ilpo,

On 7/10/26 2:43 PM, Ilpo Järvinen wrote:
> On Thu, 9 Jul 2026, Ilpo Järvinen wrote:
> 
>> On Thu, 9 Jul 2026, Eric Auger wrote:
>>> On 7/9/26 11:04 AM, Ilpo Järvinen wrote:
>>>> On Wed, 8 Jul 2026, Eric Auger wrote:
>>>>> On 7/8/26 4:05 PM, Ilpo Järvinen wrote:
>>>>>> On Wed, 8 Jul 2026, Eric Auger wrote:
>>>>>>> On 7/7/26 6:12 PM, Ilpo Järvinen wrote:
>>>>>>>> On Tue, 7 Jul 2026, Eric Auger wrote:
>>>>>>>>
>>>>>>>>> Hi Ilpo,
>>>>>>>>>
>>>>>>>>> On 12/19/25 6:40 PM, Ilpo Järvinen wrote:
>>>>>>>>>> The resource loop in pbus_size_mem() handles optional resources that
>>>>>>>>>> are either fully optional (SRIOV and disabled Expansion ROMs) or bridge
>>>>>>>>>> windows that may be optional only for a part. The logic is little
>>>>>>>>>> inconsistent when it comes to a bridge window that has only optional
>>>>>>>>>> children resources as it would be more natural to treat it similar to
>>>>>>>>>> any fully optional resource. As resource size should be zero in that
>>>>>>>>>> case, it shouldn't cause any bugs but it still seems useful to address
>>>>>>>>>> the inconsistency.
>>>>>>>>>>
>>>>>>>>>> Place the optional size related code of pbus_size_mem() into
>>>>>>>>>> pbus_mem_size_optional() and add check into pci_resource_is_optional()
>>>>>>>>>> for entirely optional bridge windows. Reorder the logic inside
>>>>>>>>>> pbus_mem_size_optional() such that fully optional resources are handled
>>>>>>>>>> the same irrespective to whether the resource is a bridge window or
>>>>>>>>>> not.
>>>>>>>>>
>>>>>>>>> This patch seems to introduce a regression when trying to hotplug a
>>>>>>>>> virtio-net-pci device behind a XIO3130 downstream port in the following
>>>>>>>>> hierarchy.
>>>>>>>>>
>>>>>>>>> this happens with a v7.2-rc2 guest kernel, on an arm64 guest with qemu vmm.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> 00:01.0 Host bridge: Red Hat, Inc. QEMU PCIe Expander bridge
>>>>>>>>> 	Subsystem: Red Hat, Inc. Device 1100
>>>>>>>>>
>>>>>>>>> |_ 0a:00.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
>>>>>>>>>    Subsystem: Red Hat, Inc. Device 0000
>>>>>>>>>    Kernel driver in use: pcieport
>>>>>>>>>
>>>>>>>>>    |_ 0b:00.0 PCI bridge: Texas Instruments XIO3130 PCI Express Switch
>>>>>>>>>
>>>>>>>>> 	(Upstream) (rev 02)
>>>>>>>>> 	Kernel driver in use: pcieport
>>>>>>>>>
>>>>>>>>> 	|_ 0c:02.0 PCI bridge: Texas Instruments XIO3130 PCI Express
>>>>>>>>> 		Switch (Downstream) (rev 01)
>>>>>>>>> 		Kernel driver in use: pcieport
>>>>>>>>
>>>>>>>> Hi Eric,
>>>>>>>>
>>>>>>>> Thanks for the report.
>>>>>>>>
>>>>>>>> I cannot get much done with the log snippets. The first line with 
>>>>>>>> difference is a symptom of something that originates from outside of the 
>>>>>>>> snippet.
>>>>>>>>
>>>>>>>> Could you please take a log with dyndbg="file drivers/pci/*.c +p" on the 
>>>>>>>> kernel command line and also include a /proc/iomem dump. Like 
>>>>>>>> you did now, preferrably take those from both working and failing case so 
>>>>>>>> I can easily diff them.
>>>>>>>>
>>>>>>>> --
>>>>>>>>  i.
>>>>>>>>
>>>>>>>>
>>>>>>>>> This produces the following trace
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> [   28.557947] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card present
>>>>>>>>> [   28.557949] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
>>>>>>>>> [   29.605376] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x020000 PCIe
>>>>>>>>> Endpoint
>>>>>>>>> [   29.605724] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000fff]
>>>>>>>>> [   29.605765] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003fff 64bit
>>>>>>>>> pref]
>>>>>>>>> [   29.605816] pci 0000:0d:00.0: enabling Extended Tags
>>>>>>>>> [   29.606994] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>>>>>>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
>>>>>>>>> [   29.606998] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>>>>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
>>>>>>>>> [   29.607003] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>>>>> 0x00200000]: can't assign; no space
>>>>>>>>> [   29.607005] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>>>>> 0x00200000]: failed to assign
>>>>>>>>> [   29.607007] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>>>>>>>>> 64bit pref]: can't assign; no space
>>>>>>>>> [   29.607008] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>>>>>>>>> 64bit pref]: failed to assign
>>>>>>>>> [   29.607010] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>>>>> can't assign; no space
>>>>>>>>> [   29.607012] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>>>>> failed to assign
>>>>>>>>> [   29.607014] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>>>>> 0x00100000]: can't assign; no space
>>>>>>>>> [   29.607016] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>>>>> 0x00100000]: failed to assign
>>>>>>>>> [   29.607018] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>>>>>>> 64bit pref]: can't assign; no space
>>>>>>>>> [   29.607019] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>>>>>>> 64bit pref]: failed to assign
>>>>>>>>> [   29.607021] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>>>>> can't assign; no space
>>>>>>>>> [   29.607022] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>>>>> failed to assign
>>>>>>>>> [   29.607025] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>>>>>>> can't assign; no space
>>>>>>>>> [   29.607026] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>>>>>>> failed to assign
>>>>>>>>> [   29.607027] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
>>>>>>>>> assign; no space
>>>>>>>>> [   29.607028] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
>>>>>>>>> assign
>>>>>>>>> [   29.607029] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>>>>>>> can't assign; no space
>>>>>>>>> [   29.607030] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>>>>>>> failed to assign
>>>>>>>>> [   29.607031] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
>>>>>>>>> assign; no space
>>>>>>>>> [   29.607032] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
>>>>>>>>> assign
>>>>>>>>> [   29.607033] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
>>>>>>>>> [   29.611260] PCI: No. 2 try to assign unassigned res
>>>>>>>>> [   29.611269] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>>>>>>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
>>>>>>>>> [   29.611272] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>>>>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
>>>>>>>>> [   29.611276] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>>>>> 0x00200000]: can't assign; no space
>>>>>>>>> [   29.611277] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>>>>> 0x00200000]: failed to assign
>>>>>>>>> [   29.611278] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>>>>>>>>> 64bit pref]: can't assign; no space
>>>>>>>>> [   29.611279] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>>>>>>>>> 64bit pref]: failed to assign
>>>>>>>>> [   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>>>>> can't assign; no space
>>>>>>>>> [   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>>>>> failed to assign
>>>>>>>>> [   29.611281] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>>>>> 0x00100000]: can't assign; no space
>>>>>>>>> [   29.611282] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>>>>> 0x00100000]: failed to assign
>>>>>>>>> [   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>>>>>>> 64bit pref]: can't assign; no space
>>>>>>>>> [   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>>>>>>> 64bit pref]: failed to assign
>>>>>>>>> [   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>>>>> can't assign; no space
>>>>>>>>> [   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>>>>> failed to assign
>>>>>>>>> [   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>>>>>>> can't assign; no space
>>>>>>>>> [   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>>>>>>> failed to assign
>>>>>>>>> [   29.611287] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
>>>>>>>>> assign; no space
>>>>>>>>> [   29.611288] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
>>>>>>>>> assign
>>>>>>>>> [   29.611288] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>>>>>>> can't assign; no space
>>>>>>>>> [   29.611289] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
>>>>>>>>> failed to assign
>>>>>>>>> [   29.611289] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
>>>>>>>>> assign; no space
>>>>>>>>> [   29.611290] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
>>>>>>>>> assign
>>>>>>>>> [   29.611291] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
>>>>>>>>> [   29.616141] ACPI: \_SB_.L0A2: Enabled at IRQ 37
>>>>>>>>> [   29.616378] virtio-pci 0000:0d:00.0: virtio_pci: leaving for legacy
>>>>>>>>> driver
>>>>>>>>>
>>>>>>>>> Previous to this commit hotplug was successful:
>>>>>>>>>
>>>>>>>>> vm-rhel10 login: [   38.385692] pcieport 0000:0c:02.0: pciehp:
>>>>>>>>> Slot(0-1): Button press: will power on in 5 sec
>>>>>>>>> [   38.385798] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card present
>>>>>>>>> [   38.385799] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
>>>>>>>>> [   39.553709] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x020000 PCIe
>>>>>>>>> Endpoint
>>>>>>>>> [   39.554018] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000fff]
>>>>>>>>> [   39.554042] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003fff 64bit
>>>>>>>>> pref]
>>>>>>>>> [   39.554099] pci 0000:0d:00.0: enabling Extended Tags
>>>>>>>>> [   39.555202] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
>>>>>>>>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
>>>>>>>>> [   39.555206] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>>>>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
>>>>>>>>> [   39.555212] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>>>>> 0x00200000]: can't assign; no space
>>>>>>>>> [   39.555213] pcieport 0000:0c:02.0: bridge window [mem size
>>>>>>>>> 0x00200000]: failed to assign
>>>>>>>>> [   39.555215] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>>>>>>>>> 64bit pref]: can't assign; no space
>>>>>>>>> [   39.555216] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
>>>>>>>>> 64bit pref]: failed to assign
>>>>>>>>> [   39.555218] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>>>>> can't assign; no space
>>>>>>>>> [   39.555219] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>>>>> failed to assign
>>>>>>>>> [   39.555222] pcieport 0000:0c:02.0: bridge window [mem
>>>>>>>>> 0x10a00000-0x10afffff]: assigned
>>>>>>>>> [   39.555224] pcieport 0000:0c:02.0: bridge window [mem
>>>>>>>>> 0x10b00000-0x10bfffff 64bit pref]: assigned
>>>>>>>>> [   39.555225] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>>>>> can't assign; no space
>>>>>>>>> [   39.555227] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>>>>> failed to assign
>>>>>>>>> [   39.555228] pcieport 0000:0c:02.0: bridge window [mem
>>>>>>>>> 0x10a00000-0x10afffff]: failed to expand by 0x100000
>>>>>>>>> [   39.555230] pcieport 0000:0c:02.0: bridge window [mem
>>>>>>>>> 0x10a00000-0x10afffff]: failed to add optional 100000
>>>>>>>>> [   39.555232] pcieport 0000:0c:02.0: bridge window [mem
>>>>>>>>> 0x10b00000-0x10bfffff 64bit pref]: failed to expand by 0x100000
>>>>>>>>> [   39.555234] pcieport 0000:0c:02.0: bridge window [mem
>>>>>>>>> 0x10b00000-0x10bfffff 64bit pref]: failed to add optional 100000
>>>>>>>>> [   39.555236] pci 0000:0d:00.0: BAR 4 [mem 0x10b00000-0x10b03fff 64bit
>>>>>>>>> pref]: assigned
>>>>>>>>> [   39.555290] pci 0000:0d:00.0: BAR 1 [mem 0x10a00000-0x10a00fff]: assigned
>>>>>>>>> [   39.555305] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
>>>>>>>>> [   39.556804] pcieport 0000:0c:02.0:   bridge window [mem
>>>>>>>>> 0x10a00000-0x10afffff]
>>>>>>>>> [   39.557730] pcieport 0000:0c:02.0:   bridge window [mem
>>>>>>>>> 0x10b00000-0x10bfffff 64bit pref]
>>>>>>>>> [   39.559629] PCI: No. 2 try to assign unassigned res
>>>>>>>>> [   39.559636] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>>>>> can't assign; no space
>>>>>>>>> [   39.559638] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>>>>> failed to assign
>>>>>>>>> [   39.559640] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>>>>> can't assign; no space
>>>>>>>>> [   39.559642] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
>>>>>>>>> failed to assign
>>>>>>>>> [   39.559644] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
>>>>>>>>> [   39.561078] pcieport 0000:0c:02.0:   bridge window [mem
>>>>>>>>> 0x10a00000-0x10afffff]
>>>>>>>>> [   39.562011] pcieport 0000:0c:02.0:   bridge window [mem
>>>>>>>>> 0x10b00000-0x10bfffff 64bit pref]
>>>>>>>>> [   39.564500] ACPI: \_SB_.L0A2: Enabled at IRQ 37
>>>>>>>>> [   39.564541] virtio-pci 0000:0d:00.0: enabling device (0000 -> 0002)
>>>>>>>>> [   39.572231] virtio_net virtio2 enp13s0: renamed from eth0
>>>>>>>>>
>>>>>>>>> Any clue?
>>>>>>>>>
>>>>>>>>> Thank you in advance
>>>>>>>>>
>>>>>>>>> Eric
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Additional motivation for this are the upcoming changes that add
>>>>>>>>>> complexity to the optional sizing logic due to Resizable BAR awareness.
>>>>>>>>>> The extra logic would exceed any reasonable indentation level if the
>>>>>>>>>> optional sizing code is kept within the loop body.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>>>>>>>> ---
>>>>>>>>>>  drivers/pci/setup-bus.c | 77 +++++++++++++++++++++++++++++------------
>>>>>>>>>>  1 file changed, 54 insertions(+), 23 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>>>>>>>>>> index 3d1d3cefcdba..3fcc7641c374 100644
>>>>>>>>>> --- a/drivers/pci/setup-bus.c
>>>>>>>>>> +++ b/drivers/pci/setup-bus.c
>>>>>>>>>> @@ -125,15 +125,6 @@ static resource_size_t get_res_add_size(struct list_head *head,
>>>>>>>>>>  	return dev_res ? dev_res->add_size : 0;
>>>>>>>>>>  }
>>>>>>>>>>  
>>>>>>>>>> -static resource_size_t get_res_add_align(struct list_head *head,
>>>>>>>>>> -					 struct resource *res)
>>>>>>>>>> -{
>>>>>>>>>> -	struct pci_dev_resource *dev_res;
>>>>>>>>>> -
>>>>>>>>>> -	dev_res = res_to_dev_res(head, res);
>>>>>>>>>> -	return dev_res ? dev_res->min_align : 0;
>>>>>>>>>> -}
>>>>>>>>>> -
>>>>>>>>>>  static void restore_dev_resource(struct pci_dev_resource *dev_res)
>>>>>>>>>>  {
>>>>>>>>>>  	struct resource *res = dev_res->res;
>>>>>>>>>> @@ -386,6 +377,8 @@ bool pci_resource_is_optional(const struct pci_dev *dev, int resno)
>>>>>>>>>>  		return true;
>>>>>>>>>>  	if (resno == PCI_ROM_RESOURCE && !(res->flags & IORESOURCE_ROM_ENABLE))
>>>>>>>>>>  		return true;
>>>>>>>>>> +	if (pci_resource_is_bridge_win(resno) && !resource_size(res))
>>>>>>> adding
>>>>>>>
>>>>>>> && !dev->is_hotplug_bridge makes the hotplug successful.
>>>>>>>
>>>>>>>
>>>>>>> My understanding is that otherwise the hotplug bridge window is
>>>>>>> considered as optional and no memoy window is allocated to assign chid
>>>>>>> device's BARS
>>>>>>>
>>>>>>> Please let me know if that makes sense. In the positive I can send a patch.
>>>>>>
>>>>>> I don't think that is the correct solution.
>>>>>>
>>>>>>
>>>>>> These bridges, have both non-prefetchable and prefetchable windows, but 
>>>>>> the initial setup only sets the non-prefetchable one to 2M (and nothing 
>>>>>> more would fit to the associated root bus resource). There's only a single 
>>>>>> root bus resource that is 2M + a bit more (to fit that BAR0).
>>>>>>
>>>>>> Now, when sizing the bridge windows, the kernel sizing algorithm just uses 
>>>>>> the default 2M hotplug reservation to both of those windows as there are 
>>>>>> not yet any real devices underneath (the default hp reservation is 
>>>>>> controllable with hpmmiosize/hpmmioprefsize/hpmemsize cmdline parameters). 
>>>>>> Thus, to fit everything, the root bus resource should be 4M + a bit more 
>>>>>> for BAR0.
>>>>>>
>>>>>> However, it looks to me there's also a 4M add_size miscalculation (the 
>>>>>> downstream bridge window is only 2M per each type):
>>>>>>
>>>>>> [    0.048078] pci 0000:0a:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 0b-0d] add_size 400000 add_align 100000
>>>>>> [    0.048079] pci 0000:0a:00.0: bridge window [mem 0x00100000-0x000fffff] to [bus 0b-0d] add_size 400000 add_align 100000
>>>>>
>>>>> Hum even with the patch below I still get:
>>>>>
>>>>> [    0.047253] pci 0000:0a:00.0: bridge window [mem
>>>>> 0x00100000-0x000fffff 64bit pref] to [bus 0b-0d] add_size 400000
>>>>> add_align 100000
>>>>> [    0.047254] pci 0000:0a:00.0: bridge window [mem
>>>>> 0x00100000-0x000fffff] to [bus 0b-0d] add_size 400000 add_align 100000
>>>
>>> If I comment the continue in the block hereafter in pbus_size_mem() it
>>> works.
>>
>> Many changes may appear working, but that doesn't necessarily make them 
>> correct. The behavior with the older "working" kernel included that pulled 
>> mandatory 1M sizes out of thin air and just happened to succeed with those 
>> sizes to let your hotplug scenario to "work". It's still just numbers 
>> pulled out of thin air (not derived from downstream resource sizes).
>>
>>> if (pbus_size_mem_optional(dev, i, align,
>>>                            realloc_head, &add_align,
>>>                            &children_add_size)) {
>>>                                 //continue;
>>> }
>>>
>>> Given r_size == 0, this allows to set aligns[order] += align;
>>>
>>> isn't it requested for the parent bridges (the Root Port and Switch
>>> Upstream port) to see the downstream alignment requirements and map them
>>> out on boot?
>>
>> It needs to be flexible. When not everything fits some things are more 
>> important than others (aka. optional). On of such things is hotplug 
>> reservation. If you'd change that behavior of the algorithm, be my guest 
>> to fix all the brokenness that will ensue. ;-)
>>
>> This here is the sizing algorithm. The actual assignments are done in a 
>> different phase, and they try first with optional parts included but if 
>> that fails, the algorithm falls back to first allocation all mandatory 
>> resources, and then as many optional ones as it can.
>>
>> (It seems I need to figure out why my debug patch does appear to be doing 
>> anything tomorrow.)
> 
> Hi again,
> 
> Apparently there was nothing wrong with it, just all resources in the 
> system I tested with were claimed earlier (by arch code, I suppose) so 
> there was nothing left to do for pbus_size_mem().
> 
> Here's the patch that should reveal what is calculated into each bridge 
> window. If there's an add_size 200000 row (or 100000 if you change the 
> reservation) without any "adding" entries it implies all memory is just 
> hp reservation.
> 
> It may print the same resource more than once in some cases but I didn't 
> want to spend my time on optimizing that part too much for a debug patch.
> 
> [DEBUG PATCH 1/1] PCI: Add debug print to show bridge window components
> 
> It's not always possible to know what going into final bridge window
> size/add_size calculation. Thus, add a debug print to show all
> resources processed by the size summing loop in pbus_size_mem().
> 
> NOT INTENDED FOR UPSTREAM IN CURRENT FORM.

Thanks for the debug patch. I sent you the guest console separately.

Best Regards

Eric

> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/setup-bus.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index c0a949f2c995..67410ee8eb82 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1215,7 +1215,8 @@ static resource_size_t calculate_head_align(resource_size_t *aligns,
>   *
>   * Return: %true if the resource is entirely optional.
>   */
> -static bool pbus_size_mem_optional(struct pci_dev *dev, int resno,
> +static bool pbus_size_mem_optional(struct pci_bus *bus, struct resource *b_res,
> +				   struct pci_dev *dev, int resno,
>  				   resource_size_t align,
>  				   struct list_head *realloc_head,
>  				   resource_size_t *add_align,
> @@ -1242,6 +1243,17 @@ static bool pbus_size_mem_optional(struct pci_dev *dev, int resno,
>  		}
>  	}
>  
> +	if (bus->self) {
> +		const char *r_name = pci_resource_name(dev, resno);
> +
> +		pci_dbg(bus->self, "%pR: adding %s: %s %pR size %llx + %llx align %llx/%llx\n",
> +			b_res, pci_name(dev), r_name, res,
> +			(unsigned long long)r_size,
> +			(unsigned long long)(dev_res ? dev_res->add_size : 0),
> +			(unsigned long long)align,
> +			(unsigned long long)(dev_res ? dev_res->min_align : 0));
> +	}
> +
>  	if (!optional)
>  		return false;
>  
> @@ -1325,7 +1337,7 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
>  				continue;
>  			}
>  
> -			if (pbus_size_mem_optional(dev, i, align,
> +			if (pbus_size_mem_optional(bus, b_res, dev, i, align,
>  						   realloc_head, &add_align,
>  						   &children_add_size))
>  				continue;
> @@ -1333,6 +1345,13 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
>  			r_size = resource_size(r);
>  			size += max(r_size, align);
>  
> +			if (bus->self) {
> +				pci_dbg(bus->self, "%pR: adding %s: %s %pR size %llx align %llx\n",
> +				b_res, pci_name(dev), r_name, r,
> +				(unsigned long long)r_size,
> +				(unsigned long long)align);
> +			}
> +
>  			/*
>  			 * If resource's size is larger than its alignment,
>  			 * some configurations result in an unwanted gap in
> 
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482

