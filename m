Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793733696;
	b=Nghgk19SvIT6NdmuDTgsKyYxi1b+5i7Q3GyvBKQpeNn+JEoFpmlAVKdRL4xyRDAnYVzz
	 FZTgHEux3NqLJwfPu0alIr7LT8km2af/046CGF5Yi4njjOrrQ6iyIV5wYtCaSZagla9vu
	 dOKjbOkJL0vtnCjzfxstzoSCtbNcs5Pw6NdQKM9GZzr+dYaz6yPLrXgXMztqzVohb7w+n
	 WdOXqpzqyya2rDJVbIMPIyjhvbRnChM5e/UV5PrCTTg9jvup4UWZILxFpusw+cMjcycOE
	 qszR2C2ju4RG7WvCKCBQ7jnRqcmzxisMeOSchQ2hOh+LH6jUTzCrWeHHq0J299o4ntQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793733696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0uILcWGxRJkmEp+n0zS/w9W2zfSCMknq4cj8Cc7NJqk=;
	b=3PfdecQyFNG52ccjGCYyktvzCILcawAGlCnredM7AIS0HUN+rDCePG9NSPeOg3JsH/zR
	 928IaBnJp6P+TC3RP/VTvAp2xbBqEGTdo5JCx2vl3ZmcewXpEx66ppXaZlw+lhyqLy1gS
	 TviMKgZC0YCZs667lslbO4kA05ZSvUs8Fv1Cm2OH8AZCke0jshr+VZ3v4PUeoLP/Dalsg
	 pecN6wAu/lFI1GseaDx4PthDNwWDzvVLJGi1CzM7gbbHSaERWlX/Y48iuUiCV+XUswyZ4
	 kLgyVT0WyoK+M498FJDLbhql5tIcfBZLDxMhVGBREDIajUNDwbSDkXk4irK8bDHJVaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=daX3WSnq;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A8606A31B
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 19:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 913A8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=daX3WSnq
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eac6c5f927so1675915e0c.0
        for <linux-pci@vger.kernel.org>; Tue, 03 Nov 2026 11:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793733694; x=1794338494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0uILcWGxRJkmEp+n0zS/w9W2zfSCMknq4cj8Cc7NJqk=;
        b=daX3WSnq4qDjLDc80XZJ92cHFwfx/BNEqnqF7d0oiM8qdOwveA3kOfdkpnV0JQAqfJ
         9c5R4znbwgLfKPxmik9GaO+IAnvmTf/uQ6YP6XpZp+1ZS1e+LFiO9YK4lWdYesXRgPFq
         GMuOmLrdT7AQzH7vFJhtbl4KIA7vHxrZMr6eNBgZjPmDKKEDicV87Bpj3KlpcBlKNa39
         wxueRpM7ewhy0Qd1er83cA4fip43Hw6WqlNXArE1mJE6PFP9DdQboC3etpimf8naP3AV
         TM0xxfuHWyXdOm/5rrmF9zUS2yhPg4AS6HEwDL2/LzkGBSlRqRV0C9nk1Gp1FGYjChkk
         vrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793733694; x=1794338494;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0uILcWGxRJkmEp+n0zS/w9W2zfSCMknq4cj8Cc7NJqk=;
        b=IKxDL0gFrvQpNs/2wVZqkLsfg8CUhvbL5xI+khhaDfMQ5G98TsUCfCSZc0wupX+xRZ
         x3vpLwTnaTfUFHN/O0xI8//pat2vxzF6iNK0AzheWc1nC7Uc+VR6fz0UWyI+cqIdadne
         5Fjr8iSG+XwOZ4LALhy6ZpTfYc3IB1UJBQoBGmKIRa4UN3cuGgyJoFKkS+i1swGkuDKu
         zmrJUixf9zOqsqMG2IYy+zeIi4XmAHM7WXzMuIKrEgV1NZDZsedydnfsYt15O0t+OUcm
         i1SK/cVWAiRKkpIQoJof5uHLqoMtG0WGBg4bT8GP6Ntfi/HY0r+SyF4QjN+f51CX4HLt
         FG8A==
X-Forwarded-Encrypted: i=1; AKwUvBw6mTKh4UOIgGd2fknnJ0Iepa6QOrIlTp23u/PBY8LQpmWsorTHSVvTxoT++3pPZTGocE0KWhfG/iY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TXyo1Xce76+RRyJ5+qPDkVeLfechHk7pP/tzVZeAUYcAXW0R5
	381KAU/qUh3uaMCA6cGg6hTz3jAhhuG5XevLr9KnJ3DanyqaEMjQzO3GI4ZVMFAG0YM=
X-Gm-Gg: AYBFou1WLd7bukYSu5qPEcsVwGTDas38jh1A/K79sHqXsrX6Og9hvP29PUGb+gaiX/o
	stp8j51kCclJR49mfiuysMr7sMxkQHKo5qFLCLJco47WilyRrKcPRaI2miszOv3tm5Htl9tV8iX
	1PnR8F1HhOuzwf2TypcTSqIyX2Ncl+K/8yyob06ffRpSlx7oVxVmfeTaShHOmHHt4y0DBtg8gWQ
	p36iyUUvkJXh2/f4OXH5PJ+9TNdrIXxP2/PoUTiR4epYQPb93U3X2wGZTuOiMbxvfjNk2ZjXqQI
	6RxTAO1McEQ022MgwtEf1rLAsRCUn2qhCzB7MXtexm4XB2IiQUnIpyPMSGWu/OhvAguIVQqIY5O
	HxOWtfZVD7F8a788VwSYa9H8eVD1jiDQms4VzkbaMrN6P88SUtw6WRUl5vhy/bXpUoTYKm3g/V1
	TF9EijXvxLLXHh2qakDFWEIGA0/NDo5p6/3GB2FDfU+/s8jL5PWJLK/WuYdQoSgpEQXa1O2hSQb
	bqlmvaG2JLxcLu5dBgaMpMy4YS9WF4RT6mOUjw1xKICKpCNpun10OK+iMmh2sx+QBy3P/B/UqGe
	gXpudPuLKR7cwMo7fPflQLj0OZ1PsE9oXoxIJdnLLpEsQnscf9A+TcuGGLme6ezoTPfLjLCC++z
	x4IKMGVoiLzg0x40fmwoQHdPRezNIRY5kaOG2aGjJRqffVcydymDPIUnlmjP5U/4MGM0WDEAf7Q
	==
X-Received: by 2002:a05:6102:6c4:b0:7ce:78f9:adfe with SMTP id ada2fe7eead31-7d072c17d00mr5173411137.18.1793733689733;
        Tue, 03 Nov 2026 11:21:29 -0800 (PST)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d999c2ccsm560241.9.2026.11.03.11.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:21:29 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v10 00/13] PCI: liveupdate: PCI core support for Live Update
Date: Tue,  3 Nov 2026 14:21:10 -0500
Message-ID: <179373348545.623992.16522569527665218421.b4-ty@b4>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 13 Oct 2026 16:25:16 +0000, David Matlack wrote:
> This series can be found on GitHub:
> 
>   https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v10
> 
> This series introduces support in the PCI core for Live Update, enabling
> drivers to preserve PCI devices across a kexec-based kernel update
> without interrupting the device. This functionality is critical for
> minimizing downtime in environments where PCI devices (e.g., those
> assigned to VMs via VFIO) must continue operating or maintain state
> across a host kernel upgrade.
> 
> [...]

Applied, thanks!

https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=lu-pci-preservation

[01/13] PCI: liveupdate: Set up FLB handler for the PCI core
        commit: f874391deedec9be601bc044f2aed52a267a3671
[02/13] PCI: liveupdate: Track outgoing preserved PCI devices
        commit: e207461556c0d3a42fd59dc548e9e8f599aae298
[03/13] PCI: liveupdate: Track incoming preserved PCI devices
        commit: 42907d099a3c37f5a089d92465b3a61de9c7cbea
[04/13] PCI: liveupdate: Document driver binding responsibilities
        commit: 78d4d22c0d4e0830a5db9b903f1325b7fbe0eb17
[05/13] PCI: liveupdate: Auto-preserve upstream bridges across Live Update
        commit: 8178f14641e2d7acf648acc33a0cc070763250af
[06/13] PCI: liveupdate: Preserve bus numbers during Live Update
        commit: 3f832a32a1801a9e7b1dc4e88a3e1744a316b538
[07/13] PCI: Refactor matching logic for pci_dev_acs_ops
        commit: 966230f2ebac2013f60ba6376a6ca726f6427ecd
[08/13] PCI: Save and restore the ACS Control register and Egress Control Vector
        commit: 88016172c5585b1dd0d777ec529fcac577e4e94f
[09/13] PCI: liveupdate: Adopt ACS controls in incoming preserved devices
        commit: 1fabde9a0e4964ac43e8ef3f0c9619d8ed80cc23
[10/13] PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges
        commit: 5506c59d1b844edad5cf2a704f8b87b353b3a2bc
[11/13] PCI: liveupdate: Freeze preservation status during shutdown
        commit: dbe2c3dfd43f9aa094b59669b81aa92b8685d23f
[12/13] PCI: liveupdate: Do not disable bus mastering on preserved devices during kexec
        commit: 534abf9f0870b457e1e6f4ef8267b0471e9d2c2c
[13/13] Documentation: PCI: Add documentation for Live Update
        commit: 5d995129832f72dc7a3870eabb216d487a145cf3

Best regards,
-- 
Pasha

