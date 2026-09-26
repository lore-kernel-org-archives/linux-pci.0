Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C243B2F360A
	for <linux-pci@vger.kernel.org>; Sat, 26 Sep 2026 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790388044; cv=none; b=X/eKTmPtiYGPI/sRult15D6WfZ8AuWC47pLHOEsW2YRqJUam9NXf7CypqfeyyZ6rLoUeEnaAw8b+6xLAP+Lmgzvr3MawJoNAjFegwCw+Wj69GPS5Y1maY5ABBkAWiLKMixDfeUB3R/SLI5T9kwzzeGX448aLzg0v/F2yw6MkX0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790388044; c=relaxed/simple;
	bh=0vjNW6Z/VkAoXl22hdO6l846oxvS2SwLTPDA8B+TIy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fWcFU4sSxiHfwZ37qd+atIF/VBqjfemU0sYbjFoue9z7GCG3RmpY7gbFhPFgTfCdhsM8uX0LZuzeqMfslgPXsOPsDrk5RNQi2ChMYiNFkTARGQuRGk77H+Lz8KbVq9i66w3S668zOBSwVFMjY2PR5AIENMtQhYVYRTQAJZeyeCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exabit.io; spf=none smtp.mailfrom=exabit.io; dkim=pass (2048-bit key) header.d=exabit-io.20251104.gappssmtp.com header.i=@exabit-io.20251104.gappssmtp.com header.b=hfEjIGMl; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exabit.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=exabit.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exabit-io.20251104.gappssmtp.com header.i=@exabit-io.20251104.gappssmtp.com header.b="hfEjIGMl"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-398cb5615deso1206373a91.3
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 19:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exabit-io.20251104.gappssmtp.com; s=20251104; t=1790388042; x=1790992842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O/YZLqOMBC+Sifkt4qt6EWSQit/1O8w6WyxcrkXOcWo=;
        b=hfEjIGMlVOzjoLvEqA2WuZXqC/7MPvlRk1Buzd+YOMvq4S+2NgPi2A9WxNDuQ61N4P
         vypjJkpR66Tx7KcqYTohuXmj1taF9zeZ92OBNY2a9M/lH+n42ExTiOw3OU1jcF+QP7qx
         1PNH7YaTcXaq+BEqnGI394eicmNvrUppMApsOSAZlaeNEvdV2brw6/IJ6TLsU5j4IkXt
         rHPh4bwMeac5xAiZkjVT3Y6llhcSbQNl7MK26iaBEYrezMVC0GRjL4zJqKu7N5Yk46EG
         ozhp1jKLWbmTEoNVFBEGz3My3U4gn8tC7vqNQx2SlQ+QjFTxMFfTzfNNZzqZUyUk7UP8
         zx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790388042; x=1790992842;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/YZLqOMBC+Sifkt4qt6EWSQit/1O8w6WyxcrkXOcWo=;
        b=rVdk1FQKueSCRm+CsnslzwUgP2XaTZYsrXVTW6k6dJCNixn82SsQTivNtL26QX1k5E
         jnG2Qd02TAmbdiQUhhNmLmnoMKdzE/8AQeVV1iNFVUlbxVAxK0y8gC6X7FawsH36VRrC
         x5KI4nuQGucOvRA5msWrs/fD+5zYiEYmHE6xJjnz/knOZ0cZtiiFbx+hFiyyxPfKH+TU
         QT5zz03nvsejK7rcBGdW2qiX8a4PWpvOSvAEfYPsEF2BHJgtcPh9GcjWwANzOiXRzBYu
         ygvJVtcNQvpgkv9w6VDG+Awr8S7mfNXmPj83n9en12PayO3Yg3NTo+xZCfqfVUuxqQAr
         xc4Q==
X-Forwarded-Encrypted: i=1; AKwUvBy2cJ6COBsDxR21HMK2hrUOIG25Lj46AACGGz0kLKek6p0ocSFxTHskvqhmYd3izvt+iAEbVDYRiY4=@vger.kernel.org
X-Gm-Message-State: AFuF++n0LyjFlIQysK+3Pfmby8kqDN4vIAaiDhvi4pge0wizFa8glFAh
	PcGXP/d8qiu5cgIyGg7UaFQQnznIheHM8HoNbrc7W4IM8iEYOlwxBLToS+pKk+NFxKU=
X-Gm-Gg: AYBFou3NQuPosTiWSraexXtDm5yKVyKba1eBer/E85hEpg4sx3eZhoCOfkHdNkIL5Wn
	h6bU17HapvEkM31C5K80MmZ/OljpL5fyM7+RG+BTVIz47h1xg5dbn2S/QgPgOJY2lPOc6MzMR6H
	AQk/NYlh79sXcbwS0u1cmRpo0gB8D6XcP4sw1WiXgg6qzMwFmvyDWxQ4bAW7niiC+dDuBbrf81E
	fRlQEvX4ClJNtCaFhHtj3GYW/BY/hGJNt2qb53WWXeRImxGPAjt3PHMYSx5lij2yGmgLv+oNHdO
	Xlg9NcTGAYSclKmChhqGvrVho0YdERo5p35HgEbhY7jzfQFfqoDCmIzJQcRiUoBM0D+4ajMpQoJ
	FK0i5QgUF/eEZubPVHvHx5a36utQ70TNqQSMmerQ+bPqKDd7t594aX3lxxCbiBijSC9b4yQb3Uk
	bBeDMcp8HdSzSw+qfFFO33gqwzqQzdZqPJS/8mUhB+tIBajkwalXPEaeecTbKi1AvWVeMfk5TC6
	OcPL1BT9mtY06A4nim5AOrAyxRI4oJ8maP3eFQuX2mJd8gze8nbJvFVyHg4G4NPUyz/zLGAy6Y0
	uLXHk5afJf6DBf3OI9yDnjqGCg7X+yLw
X-Received: by 2002:a17:90b:2ccf:b0:3a0:cc33:22af with SMTP id 98e67ed59e1d1-3a0cc33259emr1890297a91.2.1790388041938;
        Fri, 25 Sep 2026 19:00:41 -0700 (PDT)
Received: from macpro2019-01.. (c-71-236-167-8.hsd1.or.comcast.net. [71.236.167.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0df64b233sm422959a91.2.2026.09.25.19.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 19:00:41 -0700 (PDT)
From: Nikolas Joshua Britton <nbritton@exabit.io>
To: Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] PCI: Resource placement algorithm fixes
Date: Sat, 26 Sep 2026 02:00:40 +0000
Message-ID: <20260926020040.8750-1-nbritton@exabit.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923131757.7792-1-ilpo.jarvinen@linux.intel.com>
References: <20260923131757.7792-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 23 Sep 2026, Ilpo Järvinen wrote:
> In addition, the series corrects composite resource sizing to account
> for gaps that have to be added due to alignment constaints and
> remainder space not fully connecting (filling space all the way to
> the bridge window align).

Hi Ilpo,

Thanks, the series fixes the Mac Pro 7,1 case from my report. That is
two Radeon Pro Vega II Duo cards, each with two GPU dies behind one root
port, and BAR0 resized to 32 GB by setting the ReBAR control and
rescanning the root port's bus (booted with pci=realloc).

I tested all five patches on top of v7.2.8, where they apply without
fuzz, against plain v7.2.8 built with the same config.

With plain v7.2.8 it fails as in the report: the root port window is
64G+4M, and the second die gets no BAR:

  pci 0000:06:00.0: bridge window [mem 0x90000000000-0x910003fffff 64bit pref]: assigned
  pci 0000:0b:00.0: BAR 0 [mem 0x90000000000-0x907ffffffff 64bit pref]: assigned
  pci 0000:0e:00.0: BAR 0 [mem size 0x800000000 64bit pref]: can't assign; no space

With the series, all four dies get their 32 GB BAR0, amdgpu binds all
four, and they form one XGMI hive. Each root port window is now 96G
(my one-liner gave 128G). The second sub-bridge window starts with the
die's 2M BAR2 at its left edge, and the two nested bridges below it
(0c:00.0, 0d:00.0) carry the same range:

  pci 0000:06:00.0: bridge window [mem 0x9e800000000-0x9ffffffffff 64bit pref]: assigned
  pci 0000:08:08.0: bridge window [mem 0x9e800000000-0x9f0001fffff 64bit pref]: assigned
  pci 0000:08:10.0: bridge window [mem 0x9f7ffe00000-0x9ffffffffff 64bit pref]: assigned
  pci 0000:0b:00.0: BAR 0 [mem 0x9e800000000-0x9efffffffff 64bit pref]: assigned
  pci 0000:0e:00.0: BAR 2 [mem 0x9f7ffe00000-0x9f7ffffffff 64bit pref]: assigned
  pci 0000:0e:00.0: BAR 0 [mem 0x9f800000000-0x9ffffffffff 64bit pref]: assigned

The second card (root port 16:00.0) is laid out the same way. No other
device lost a resource: the only "can't assign" messages left are for
the same I/O windows that fail on every kernel on this machine.

I used v7.2.8 rather than your v7.3-rc1 base because v7.3-rc4 powers
this machine off during boot, with or without the series. I haven't
looked into that yet.

Tested-by: Nikolas Joshua Britton <nbritton@exabit.io>
