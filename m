Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031113;
	b=vY0jEFSobpBeA7RPli2V38pslQANbR1tudr1BRrhP+HtEP+TE846ZODJnhvbszNjUjhG
	 00kKNAnyuJxGS6PPXwWBF6FMjp4YZhE88R8OREYKRtlL79Bid3GLifl+YFwK5oa7tjnfP
	 VPthSzcXfvR3kOQgjPR6T1h98wX3c579Ak6l7dZy1tioKcFvH9gXrgb6RE+i0tgxPNP9t
	 TLxBlD5A/Bbbk0UFq3PRL2HcL5+1FJSI0yfHbRqFDEJkY3VyysK3HmA601FTnixz8y6k5
	 1j0ohuEetm9Qy3tQ4yh6lOW3hquJ1lxBxzk0CPlXOgYT+5a2M3VXhAv9eOrKyZ19HhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031113;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=na5w5nNR+vMQdY7egGSiK+WyNzzJugfy513I7z+3ojw=;
	b=1HI8SWH1g4cB5BxzNcZeDszBf/Ki22t0KbfxUUbBf+aC6Bfvpz/2DOKjqSxsfuWelWhb
	 IAcJ0p/DJEOwIMwdnpzAqrLajCClTMglVKCQlyddqL0c1JoPIOoYHWNkoHjzOlXI/jDJp
	 CDjUbKhn0X8nZAyAahrz7ts9S+yiVQ7rYE5oa90vYv2bULKuBN9zF0wVBcP2Ua4nFmPmi
	 W69dGubCHv5zVG7i+aDNDZC2ziGMYYz2NfdOOJmkMxLBhru4stHvk6cXVABgwaHBeLrR8
	 BICGg9klWMwd42CJ3r5OnKCnX1nCGrBbwu3c8S6YcnUj4TVt6RlTwaC0hu5qBWnoA6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L6dt6FME;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857E6606A330;
	Wed, 18 Nov 2026 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L6dt6FME
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0221F000C4;
	Wed, 18 Nov 2026 19:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795031113;
	bh=na5w5nNR+vMQdY7egGSiK+WyNzzJugfy513I7z+3ojw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L6dt6FMEOP1zQQVYmvm4CWgf23sQN8hCZAeCPpJLUWYgTvFf7gXRCmY8q9oe8FB89
	 mFwKA3cTtvdAfFZFl9F4ioYJcVEsMKWTCue8zDVaHf+I205Vj88up8tmRM8/QJNPNo
	 vEQFVc++El8isjgs4ePvndtd+czHKU8rEk60UDeg/yTC1yvwG7kGmcolbdJL7mtuh4
	 TDuR2OHULNcxBLOrwg2XKiNuq/Wsl91E7uHihCnXYbc5Q2INuNk3OP0ridc8bmnQBi
	 e6EQvW9xW8L5Lje24dTZqRGEKPige77kZlY9Gtz4XcL4NGvfXo27DslnJIgUouq6sl
	 vJ13TA7NrXqog==
Date: Wed, 18 Nov 2026 19:45:08 +0000
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
 <pawel.chmielewski@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Kai-Heng Feng <kaihengf@nvidia.com>, Breno Leitao
 <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>, Dan Williams
 <djbw@kernel.org>, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 09/19] ACPI: extlog: Report errors independently of
 RAS consumers
Message-ID: <20261118194508.150029b4@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-10-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-10-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:19 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> The RAS consumer check removes:
> - trace events when no daemon is registered
> - CPER console report when one is registered
> This ties tracing, PCIe recovery and CXL protocol delivery to daemon
> registration, and can hide a fatal record when userspace cannot process
> its trace event before a reset.
> 
> Remove the RAS consumer registration condition and:
> - always emit trace events
> - print the CPER record only for CPER_SEV_FATAL
> 
> [1] additionally suggested to have a cmdline parameter to dynamically
> update the above policy. Keep a simple hard coded policy for now.
> 
> [1]
> https://lore.kernel.org/lkml/20240521183913.GGZkzqUSN1hdE-_OEY@fat_crate.local/

Use a link tag probably.

Link: https://lore.kernel.org/lkml/20240521183913.GGZkzqUSN1hdE-_OEY@fat_crate.local/ #1

I'm not entirely convinced this is a good idea without the policy aspect.
Still let us see what others think.

> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/acpi/acpi_extlog.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index e09ea571c32f5..16a16b12d8ccf 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -208,10 +208,9 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  	if (cper_estatus_len(tmp) > ELOG_ENTRY_LEN || cper_estatus_check(tmp))
>  		return NOTIFY_DONE;
>  
> -	if (!ras_userspace_consumers()) {
> +	/* Print fatal records regardless of RAS consumer registration. */
> +	if (tmp->error_severity == CPER_SEV_FATAL)
>  		print_extlog_rcd(NULL, tmp, cpu);
> -		goto out;
> -	}
>  
>  	/* log event via trace */
>  	err_seq++;
> @@ -255,7 +254,6 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  		}
>  	}
>  
> -out:
>  	mce->kflags |= MCE_HANDLED_EXTLOG;
>  	return NOTIFY_OK;
>  }

