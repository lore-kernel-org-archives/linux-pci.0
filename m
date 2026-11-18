Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795033380;
	b=lwk+ctUzLXR7fHoE3XHlkmrOmSuD23Cf01N8hls4EF+tNPm2AKYFijsftq6ElHQqSL8N
	 hgUXVMTwTYdiKtkZuVg3OHwpApCG7KU9mYqwJ2vgN7g/3TGMO9DsT5n+ECxKEeRD0iR05
	 cwFBe9M24px2yKBypXMrSqLpckKE4yO3QdJl4S+btFWv1IG5jY5HZKDZV6euyhCGx7FDX
	 zsEXxXT6r8HpeXA3IzSJgPT11Vl1BXTrMqbe329rJRNhi6tR+ksgAOVgA0yNnu5AM+avl
	 xVIa794xUXANp3Fp6DSTtmH1XYMx2yycWM4AZ2XkuupxQTN0M/iI+29Sa5NgNG9pbmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033380;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FkNN5wo0Am75uimk9STIjbiPLRC6EWagOnVoqK+PmwI=;
	b=fJftw59WEHD8faTc45XufLWwGmGBDE4XBbtKOujw2XycP83EXKMBFSkD9DvFHwXsq52M
	 j4ib+RjlQLskwmQgbtUTobDZOVDlGN2T66UGXHSvSXbHSDUUarCNT0FpyigO3lYdKUqLh
	 uan7JydI0TbhRWRu3pW73BNPrFAIYNXiBjVlEdIkxUlHBM26W/X32pkA0iwzZ8wTzeoIY
	 3guPSN9afam5aRzKYA6mk9Dz1nHEjqS/SzY1jYOTIMpqDTye+LXrxitgOLe3fCqibGOqJ
	 KQzpJdEpnFDCwOF4G3SR6d3ZyDBzhYu8CsZvgUIUxy8TOAVweoCO2khyDGPLlShV1AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HO+kR9le;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80590606A31C;
	Wed, 18 Nov 2026 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HO+kR9le
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDA61F000C4;
	Wed, 18 Nov 2026 20:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795033380;
	bh=FkNN5wo0Am75uimk9STIjbiPLRC6EWagOnVoqK+PmwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HO+kR9le6tB0FawCiLsaWoSXs/8ddm9MKA7CskHLF837GeTsPeoB5lgFe3cWD67uV
	 XsNRJE0ReBHK5Fd8No0uWvclkVoAFlM9KNkmbPkpOuQrR24u7zhn228ysy11LIU3i/
	 6BHjzy+TbbZio27gMtSikd14LBTXHv/pdmbIoRZY98jSWsJ536966HH/Fiwblqi+3U
	 8BT3a+HT4mOMLRFdS02BtqfnIX3gxvkBdJfEpUBfv0dmVPFGsBtAoNIBqJNCbK/VID
	 q0EtuArQSHGboVZmAa9JYRLubflyz0MG3h+ou0Ri5wmaaRHWTxiYLv0MVqq+HI1I/5
	 U+eOtWYOc3vIg==
Date: Wed, 18 Nov 2026 20:22:49 +0000
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
 Rendec <radu@rendec.net>, Avadhut Naik <avadhut.naik@amd.com>, Dave Jiang
 <dave.jiang@intel.com>, "Fabio M. De Francesco"
 <fabio.m.de.francesco@linux.intel.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, Breno Leitao <leitao@debian.org>, Dan Williams
 <djbw@kernel.org>, Terry Bowman <terry.bowman@amd.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 17/19] ACPI: APEI: Share the extlog PCIe handler with
 GHES
Message-ID: <20261118202249.76b98c39@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-18-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-18-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:27 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Remove ghes_handle_aer() and re-use the existing extlog_print_pcie()
> to have a common PCIe logging handler. Update the function
> documentation.
> 
> Except for the warning ("PCIe error section too small"),
> no functional change intended.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Fine if the earlier patch to add error handling flow
to extlog is fine.  I'll wait for more input from others on that.
