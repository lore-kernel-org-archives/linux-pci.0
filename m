Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104303;
	b=ZkCN2j2E/iBF0A3eAzCd+8wvuFIk5DA8gzE1AtRjZKd9bsSq7ynSHzTn4PtyEJs0r05H
	 VVXIEU7KSnpRPSMfXzeqGKch8NBLeVc3T61923/MzY4WxQaiibk8vT4JhrQfz49zNWEm6
	 f85q6p4aqpIH4Ug52qMsKWkATnh48+REnJ9Tj0ksVWwvOM22KHwBRS2ZWe48wIO3ErT9A
	 EbB+lXkMjUDzPSKqfiTtTg6I25XDBeFiJ3/6/JasOvIvNgjgdNoSoACAYv20yANHYHtEI
	 85TvvAyOiLflWtp7/oe6QP0f/gSMwW/xTktbw3mwY+zcFH42iXMQH1vrLD1tc7oL92Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104303;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=hbK+kWkYYKm/efLUoBKOSkktiP3/Wop2eoAi4ChS1QA=;
	b=U+lAuqP9ibvqbTE2DQEy/jT2sL4/Y9SGMj6t/6lh4cgFVj80gM8aypFNriBSiYSFUNtE
	 qYKBCezF/6xEKKEsvEdKyRk3l3n0/NALpdCapyI4yf95EvnENLuPM0VAK8+0dzrboGGI3
	 mpENxDjDUZ4eNr+h3Y3COXvY+SaDEBK+mQpFm39D042j190/rlcR1nr3PmjdVVQxIJ0Qd
	 1xsEVwFZN09KFRcBqkpo1LS9BUCERKzr2IZz/ohyNfGMKhJX6dXVDQY6bLInfKdv0MDr9
	 h3ra330ETc3rZpu85Uh5ftG4yE/jZP5W9yWA7z1ntzbHMC276qBryaq1X1+DrZp+KXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9WwW2ar;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC7E606A324;
	Thu, 19 Nov 2026 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9WwW2ar
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7631F000C7;
	Thu, 19 Nov 2026 16:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104302;
	bh=hbK+kWkYYKm/efLUoBKOSkktiP3/Wop2eoAi4ChS1QA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=d9WwW2ar0YOTWbnyoAZZOi6xLhgyjF+NG7ZochlTRKamLVWoY9yrclWCRcsMHo3zW
	 8qrPXHFN9J6HJKjcHz6sCgf+oZiPHGmTTdMyMB91gKzkzhxElmrwZW6cGd8euvjMGq
	 1Ehir73ksQGmS2lNCWJ2uI+Z5+hW6X1pXlQwW+RZWwaC5CJRouw3q0W9kw31G5mnT9
	 QwtstSKgVHu8L4g6Zv76NEEnoMLqEVGaDWV6kWzeZ9ptLSvq735A5h6tMOWMitaFaa
	 xwOmtfpOK+0R2wx1hD6BqcMc1By2Y6YtyqxvENb4t7nr2xQyJtknRE318tG9+c5AzT
	 V8fJZFr7i9jdw==
Message-ID: <3657995d-b4f7-4a0d-9615-1c56a0127de1@kernel.org>
Date: Thu, 19 Nov 2026 10:04:56 -0600
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] Fix amdgpu detection of pci=realloc
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Oz Tiram <oz@shift-computing.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
References: <20261111-vfct-regression-v6-0-393797bbb6e3@amd.com>
 <5cf8f937-acc8-475e-ba0c-6be00defbb53@amd.com>
 <CADnq5_PAarNZ24xOU3MqVfEra1hSOqgrKQxvLppyCWZQebr_yw@mail.gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CADnq5_PAarNZ24xOU3MqVfEra1hSOqgrKQxvLppyCWZQebr_yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/19/26 09:57, Alex Deucher wrote:
> On Thu, Nov 19, 2026 at 10:30 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>>
>>
>> On 11/11/26 10:43, Mario Limonciello wrote:
>>> amdgpu needs to know the bus number the platform assigned a device to
>>> be able to match firmware images against the right device.
>>>
>>> This was previously adjusted to be a soft filter due to
>>> commit 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with
>>> soft filter") where if everything but the number matched to take a device.
>>>
>>> This however fails when there are two identical devices.  Instead save the
>>> initial bus number to the PCI device structure and then match that.
>>>
>>> Link: https://lore.kernel.org/linux-pci/20261015124843.203905-1-mario.limonciello@amd.com/
>>> Link: https://lore.kernel.org/amd-gfx/20261019194106.2796150-1-alexander.deucher@amd.com/
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> Changes in v6:
>>> - Capture the firmware secondary bus number when reading bridge windows and
>>>     ignore unconfigured values so rescans cannot replace it with runtime data
>>>     (Sashiko).
>>> - No change needed in the VFCT consumers; they continue to read the cached
>>>     value from the upstream bridge.
>>> - Link to v5: https://patch.msgid.link/20261110-vfct-regression-v5-0-f49fae981bf3@amd.com
>>>
>>> Changes in v5:
>>> - Record the firmware secondary bus number only on the bridge struct pci_dev,
>>>     guard it with a validity bit, and keep it across rescans (Bjorn, Lijo).
>>> - Drop pci_bus::number_initial and have amdgpu/radeon read the saved bridge
>>>     number when matching VFCT entries.
>>>
>>> Changes in v4:
>>> - Retain secondary bus bus number for a bridge across rescans, and the child bus is initialized
>>>     from it during allocation, before registration callbacks run. (Sashiko)
>>> - Rename variable to clarify it's for bridges (Lijo)
>>> - Link to v3: https://patch.msgid.link/20261026-vfct-regression-v3-0-fe9586ed6978@amd.com
>>>
>>> Changes in v3:
>>> - Preserve the firmware bus number across bridge renumbering, capturing the
>>>     secondary bus number before pci_scan_bridge_extend() clears it.
>>> - Adjust member name in all patches
>>> - Add tags
>>> - Link to v2: https://patch.msgid.link/20261020-vfct-regression-v2-0-d2394d11450a@amd.com
>>>
>>> Changes in v2:
>>> - pci_alloc_dev(NULL) remains safe.
>>> - For buses behind a reassigned bridge, the PCI core now saves the firmware secondary bus
>>>     number before clearing the bridge configuration and carries it into the newly allocated bus.
>>>     Devices discovered there inherit that original number.
>>> - Add changes for radeon too.
>>> - Link to v1: https://patch.msgid.link/20261019-vfct-regression-v1-0-5a63ddd378dd@amd.com
>>>
>>> ---
>>> Mario Limonciello (3):
>>>         PCI: Cache bridge firmware secondary bus number
>>>         drm/amdgpu: Match VFCT using initial PCI bus number
>>>         drm/radeon: Match VFCT using initial PCI bus number
>>>
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 ++++++++++-------------
>>>    drivers/gpu/drm/radeon/radeon_bios.c     | 25 +++++++++++--------------
>>>    drivers/pci/probe.c                      | 16 ++++++++++++++--
>>>    include/linux/pci.h                      |  4 ++++
>>>    4 files changed, 39 insertions(+), 29 deletions(-)
>>> ---
>>> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
>>> change-id: 20261019-vfct-regression-2142fc52852a
>>>
>>> Best regards,
>>> --
>>> Mario Limonciello <mario.limonciello@amd.com>
>>
> 
> Is v6 preferred to v7?
> 
> Alex

My local linking between message IDs got messed up.  Yes comments on v7 
please, thanks for catching.

