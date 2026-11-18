Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032872;
	b=vRUYA6yRcMUsoKMj1Bu4e7o3wbndT79y5Xhxt8z1oZ8BWfn0bdYdNqSLUr6BRlm01iuR
	 ON3U1bVhrjCfsjv+dkeiBsa+OrUXZtJuI3OhbMEhmhZXW9hn14Xd/m2sXTr3WV3Sw/Xn6
	 6m9+A8wxSRFyx4CawXUUNCLkvqU4ib2tWb85auJOh9qYWnaGtTXejYf8QSeLVlOkl2Xf0
	 Y3sObXeFk8hT0PHMemsxONf9izXeHAjTI3UWs9nwcDaq9OSLesDsS9ttm3JgYCVVd3C6F
	 6nA3B7sXCnxuH2t7N7B7XOb7RTLzEdw2/XmJFgsl+I3e8Oj8fWgCM2nH0iStqaRLAcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032872;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pUhs6fW7JTG/XV7F5yinkkxTZdkT2kLrXXwi/BnqRWo=;
	b=WsMx3aWmGtkg2QgEmTqhvNawLZ22OCgrvN7rC2KUWZ6J1eY2Yf3E2vHhe33oUp3OIk7K
	 xm8B4xYKiMMIU/RBP3p2Q7f87zeL3kyMqpKjSdf/tHwqaJ045aN4mMoTemu17jpg4HXFA
	 LF0/hQHiety5P56m4B2qXu5OiAiE3VDaqsWEZ4YhtC4SmaYYg07V377VfGldPyxKFn8VU
	 cFcqE8oqdfWnXAFg1nVxOFnGN3BXG4EXjzhUPuhBxh1KgZ0BGZFvSZC7s9OMuBO1pufPn
	 WlnCtP3sXgFd3ASnO636t4qFYh2nOG8cZno2FIgW2dfrMAoU75fApY1qow3UXYDWfHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SgDlJU9K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAAF606A335;
	Wed, 18 Nov 2026 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SgDlJU9K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292131F000C4;
	Wed, 18 Nov 2026 20:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795032872;
	bh=pUhs6fW7JTG/XV7F5yinkkxTZdkT2kLrXXwi/BnqRWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SgDlJU9KQwoCY7Uj7jzC0Qcq473jHIyRID8jZ5fvl0wB8SFc8SfBVnUdD2m1Pkfe0
	 +FVlzCHOF7CVIbheRt1Jaf9XvfAoDCOfZ/vlacxvcQLrCIbwz8PHgMf5+VIWDS7UuG
	 QRu4rUGXHUZ7Zz31zetvTyZdx+z4u86WqG/VRcFvfFMDnCjF8VsBTrucw6yDPEiGdg
	 G3gD80JGuI+UFz0js3gcgBM4TLrupQLcWQ1MR6bNT4PnOL35ZjP7jKGCZOtjde1+t0
	 NqQm5QLRhKfiqVaVmdoONuIgH2vX9a4TwcmTVUIT2/tiwHfVpfXxa0azpvAEVvUQET
	 6qKwxwvqSqcKg==
Date: Wed, 18 Nov 2026 20:14:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
 James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Hanjun Guo
 <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai
 Xue <xueshuai@linux.alibaba.com>, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>, Pawel Chmielewski
 <pawel.chmielewski@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, Qiuxu
 Zhuo <qiuxu.zhuo@intel.com>, Radu Rendec <radu@rendec.net>, Avadhut Naik
 <avadhut.naik@amd.com>, "Fabio M. De Francesco"
 <fabio.m.de.francesco@linux.intel.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, Breno Leitao
 <leitao@debian.org>, Dan Williams <djbw@kernel.org>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman
 <terry.bowman@amd.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 15/19] ACPI: APEI: Extend common CPER reporting for
 GHES section types
Message-ID: <20261118201426.5698499a@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-16-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-16-pierre.gondois@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 12:10:25 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Add ARM processor tracing and CXL media delivery to acpi_extlog_report()
> to prepare for GHES reuse. Trace CXL records as nonstandard events when
> validation or queueing fails, preserving their payload and FRU metadata.
> 
> Reuse acpi_extlog_mem_err_min_len() to accept legacy 73-byte memory
> sections while rejecting records with missing fields marked valid.

I'd do this separately and add more info on why... 
The others are more trivial

> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

