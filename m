Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637B19CC14;
	Thu, 21 May 2026 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372277; cv=none; b=BPefvcwuIb8zu3VfTg0ySf4O57cHPiw3ScemXCnDU9dnyOG5g1n9WSYRpSD6wn83Ko1hprZ0HVIl8vhszx7IuftVx3HgiAWd7I+qpS2fhq47cUF/N+E6p0AWOpuLxGgA4lEK6nPkqfG1DauG/oGIgXVWlZuRyKThIzurF++Nio4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372277; c=relaxed/simple;
	bh=FWH/NGzx2LGqb08RC7u+pA/G/lGYe9fGPgpUL1yfjKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4/1ruluatN6DG2veANtv6TbMzC7ddln8C24Vl+Zt39Fnvr0IKZR6wFOAfOYB27lfNGHqgbub9mXglFbGbR7eh6n1uBm8CRwQyBXQKnPr9lGVs0qBX0WbFeshNDddJBpG8TaFyBZlUkp91lrPPOceQu2zfP7qT6Q4R+6MN/dUcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndpLNb9V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndpLNb9V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC561F000E9;
	Thu, 21 May 2026 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372275;
	bh=FWH/NGzx2LGqb08RC7u+pA/G/lGYe9fGPgpUL1yfjKg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ndpLNb9V31MDOCE51O07TD0paBjDV8FdPPZQ+IHalbYt8bq8rT9j/AHMbdxgOtraC
	 7BrZ435+uFru4pZ4iNvPoVLnSTxlZROImDvan6wJVdHRGjojciQd15bS4sJ8jDfMvN
	 Aa7Ae91gv7DHSrsu5X1IN2gY91aNR/WkC0vKKIS+wAnnGILLEL12ssqhhK1R0Asixq
	 5LGHrO/gsSNJUYbZyz/aQbW0iSduIb9+nH+/NSq3K6o0wJH3Kup1y//wStU1gXUN4V
	 paZs57YiA7PIjomPJ7SgHp+wJ6CzQWec8M5ytY4Mp8lGz9RiQqC7wt0Vjn4g1acY4v
	 bIZE+MsooL2Hw==
Message-ID: <f08c6164-78d4-4c79-b4d9-d7e883e5a0c0@kernel.org>
Date: Thu, 21 May 2026 16:04:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/nouveau: tegra: Explicitly specify PMC instance
 to use
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mikko Perttunen <mperttunen@nvidia.com>,
 Dmitry Osipenko <digetx@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Mathias Nyman
 <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-ide@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-usb@vger.kernel.org, Thierry Reding <treding@nvidia.com>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
 <20260506-pmc-v1-2-a6de5da7216b@nvidia.com> <ag67dmFtSDBC6aPK@orome>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <ag67dmFtSDBC6aPK@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/26 10:00 AM, Thierry Reding wrote:
> would any of you mind giving an Acked-by so I can pick this up into the
> Tegra tree with the rest of the series?
Sorry, I thought I already replied to this.

Acked-by: Danilo Krummrich <dakr@kernel.org>
