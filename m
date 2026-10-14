Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7E214ABE;
	Wed, 14 Oct 2026 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791938637; cv=none; b=h9TG97ojUp/+BNCrKmewCo992HB9jUF8cK/nsyQh0caMdC2pexw2JKkPlur0BMkXAzD6F7Pm+Z0K7RHEiYi1/qOSRJwDANTw6oSIQv6i4wBt/UwhssKBJwJw2wuLWdy8MqQmEEKHC/RGp4NJhBgoAPDF94/O0lGvyU7dSUAorYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791938637; c=relaxed/simple;
	bh=DEwAOojeiongagtOlt87yYGQZMkdExwAoe8IObQaKpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvuOTLFkKXlOf3oAv7eHS/eU8JEzCBPIVgJfH88BytOL/JsShDDq9UjVQEsy53dT3v043JNnt0O7FpmNE4ZhVzlfE1BPAObgkFXrjzYi9pdoeOFqvIkIycIlsF7TAzay2NHNRxA3sE+5H192ARuLlrApcxEjUVrjW/DNBOWd9r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XX09ma8s; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XX09ma8s"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7B61440E03BE;
	Wed, 14 Oct 2026 00:43:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ztWxKXfQInQV; Wed, 14 Oct 2026 00:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1791938629; bh=HttXpapOfloWP3Xee/1hRMeDOKEncI51M9qhqU6fyv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XX09ma8six+ptwY6QNDt4Xz7KzssK0RHt3WMMKFojSXKjcPQUcXoa99zhp6B1w9sq
	 zJfgvQnj675p4WjlGdMs2AtB6q2WBv0sv/Ds0qOtG/fdJ7dpw+6z2eNm3+aO+s8hmS
	 jK3QpLLOq0Elvq49hKvuEvsdZFn7sSdafzsTZGfCDeavNg52i+8qXWRCgnxf03iOie
	 ourSBUuwJC7E3kMsUeq0iD/w2S4dptT47b+cpMs9HDJZNdEsZZAfBQAeWiWwusL9sn
	 FEDpydHx8PC77UYWcdBFeu6ZAQlcAnbizWXQtjpt//S4JjrKg/1jACXDpYqKy/f4td
	 D1vMakca0o236kiWMylCwi000YZ6npjX1EpKMdbjKPQ2wimM0IqoSO9lY1oIFcmclQ
	 u3swMKoxul3gZuCXHJcIrWXN1VjxjgRLAvJa32P49S6gsJpVUE+75s79WFHKQu2LwG
	 fGyKy7KK9Q4mu/lExnstMWrdKA5WNkv7Xe+ZWKmlBCvyMy+z5VdP1lccbc9sy8/VEc
	 a9ksDoGUwT0WaP6tVwv3mczXRgsXGmDP6S70CcI65aZFE/BUsj6SXqc3tcX0mtU166
	 6tM2WfeBCjnz90pzs+vMHR9HPO94HyIiQmvMTmmPH9iJ2u/VB/RiduLhTOL4nMbGR5
	 DrhRIAb2g+025JqMhsm2949o=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9735F40E00E8;
	Wed, 14 Oct 2026 00:43:24 +0000 (UTC)
Date: Tue, 13 Oct 2026 17:43:21 -0700
From: Borislav Petkov <bp@alien8.de>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Nikolas Joshua Britton <nbritton@exabit.io>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Hans de Goede <hansg@kernel.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 8/8] PCI/quirks: Avoid certain address on Genoa systems
Message-ID: <20261014004321.GBas7QKRYgjdcIPLHb@fat_crate.local>
References: <81b4f4bf-b721-4b5b-8ddf-d040865f02b2@amd.com>
 <20261013224010.GA1589480@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013224010.GA1589480@bhelgaas>

On Tue, Oct 13, 2026 at 05:40:10PM -0500, Bjorn Helgaas wrote:
> But I'm frankly terrified to touch it because I'm skeptical that two
> more quirks are enough.  I just expect that whatever strategy BIOS
> uses to build these maps is likely to be used on many models.  I do

Do we have an explanation why BIOS is doing that shit?

Mario?

Btw, Mario, you should replace "Genoa" with "Zen4" everywhere so that it is
more clear to people.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
