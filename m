Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032429;
	b=J7Acc1FwRVaJBRFYBBMQtQcSZBSGSuQ94d0eGhO7mYARpi/N3OHoOB8mUqtzsYNYiSxN
	 xfskmfaivoWdlHoaIz9HffnVLcn+IaMzoSAcfuB+P/WOAE1jbJdBG+wU+4hYqfDXqGwnF
	 b+xxXT6mlUuCOJ/3sbIgFVazOUm9wIeST3fZLgcGmhC63mOPNRY9Ao0yJ30s61Tun+V83
	 BZ7coct0M0EwViFBV5NDQXR9U+qzwEgDjRK4axU0u3dDiDFlmkDe0XzUwzQBZQ4cxsoUj
	 F/E/22XQb97jGpf3stVzOCPWOQFDeN/ww8OYatsd8U3ncoIE+RLr93Z+Ytndonsw82A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032429;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ydr2zuUo4Y+Eu5vs2uIcRAQ0D83Gb2IoOYjqdt7Pl2g=;
	b=vjx7b1CMLWtIlDciOiAIhj6IjdiJ0kNyMxkmDlj7fThjo7h0swS2Od+MNPbMPU5vHtrd
	 xflz3O2dEW11WDo7FoPSBe6qSXJPUOu8GPhZkeo+24UnQk+WvuJnzQYhTvwk9j22X5no9
	 RzKL+COw/BpxhDTKxW753mCBBGnE+906nkcZGcjSqFoVy23wAIJ/uBEjfAKeAvQlfUqNU
	 BeQZhOrwT8B2f679wqByrY8zve7Gx2VFuXqBtePtQdYz6K3M9Tsa7LBbyAHuDinrZkCws
	 J9y9QVCNYZ+NN1NvqbWgZqUCOwxcBngl+tfj3kAWXD4bWFLm6Pjq0sCSR5mOGLanA8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPTRhgOs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D86F606A338;
	Wed, 18 Nov 2026 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPTRhgOs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0821F000D3;
	Wed, 18 Nov 2026 20:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795032429;
	bh=Ydr2zuUo4Y+Eu5vs2uIcRAQ0D83Gb2IoOYjqdt7Pl2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jPTRhgOsJ3gg9xAK3g1Kxi/CA9EBREb/tAFnQ69biXVG8KJQxY4VY55gGxMgxbxMm
	 HuUwmxC6iqTnSdybEJfmpuaXeFpp+csnzklAdxn7PjBEs5WIWMcgYJyhT2OFeTBee9
	 y0BRDXSr+3DPOn9WkTbyfg0ILxQAWuhvk5F26WpWV1g8oOstjYX+kdxU4ekO9rkTXw
	 Yy/qU9eXDfUrBkjNvne7I6B98W6eOVnwLr80IOwKhpsn7thKaHjd/uOO8F7ebaUdnZ
	 DWmuXVGRBFLjieYHQ1/v3GOQUEuJJguNK84Y5TVkq4/NJtLsBBkmSubqbE78/+3N8g
	 1tSzHbnWZ2khg==
Date: Wed, 18 Nov 2026 20:06:56 +0000
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
 <pawel.chmielewski@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, Radu
 Rendec <radu@rendec.net>, Avadhut Naik <avadhut.naik@amd.com>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, Breno Leitao
 <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>, Dan Williams
 <djbw@kernel.org>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 14/19] ACPI: APEI: Return status from
 cxl_cper_post_event()
Message-ID: <20261118200656.596420c2@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-15-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-15-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:24 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Callers cannot tell whether cxl_cper_post_event() queued a CPER event or
> discarded it. Return 0 if success and 1 if aborted. Existing callers
> continue to ignore the result for now.
> 
> A worker that is already scheduled still processes the queued event, so
> its schedule_work() return value does not indicate a delivery failure.
> 
> This prepares for a following patch moving PCI/CXL handling to
> extlog.c.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Given no error codes are returned, why not a bool return?

