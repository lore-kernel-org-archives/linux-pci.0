Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795496492;
	b=VWbMO5FTjd3XcKEB1r6JfgXaYEAGBzJvZwb/LBM5EWJSnXJIaTflt6VAU8I/4OI0++9n
	 zNH+kfrozOrufK9wHZc7pxsw6S7yuo4c1HhoHDCpnfpmtM7zLvMKrEHV1P5RFsqjqwXkd
	 lmFKL56bFmRe4t3MboDWZ+R56wJZbOM5rr6Y4gyMPWYijiyEa3Tickodo+p3gqElHJF5x
	 qlTYkWQvCBJngkpx/BOQa2FdEpmnVw1W065VjkCncQKtUXKQ0c3kxh30vtCQVr9IcvVql
	 ABCCu0PIvteTW84Nngqs8q9M07nYSaI0aSgUo2a4gt2G8S7OdWoHczFa0H59cgsIGhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795496492;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XM+P0UUh8M7+zT3EmoQUfy6DuwH+/xR6iA2fTPRkpYo=;
	b=gwCWRWAxHXiwTRrX9ymIJspFjjSc8jNB6K0OGYLdTZzVq9c7i+Sy2KaeJQyyVkpJeES4
	 IwbeGCWzqgP0vQFKfPPJnjWzfZQyTEYtwDo/bma4n/b8dTecyushneSXI4GjMmn1Nwk6R
	 BRQT51pY/Vvc7EOzIn7HK/y+FhCEZXr3PF7fQZYGPP8z1m+VEMc26Mfr8h0nK0jTU45iG
	 Ooav1FOyy6Casl1zUrT/FaOCKEWk6P3j6uRnSfc9ClOyT1cUjCjEXEQQyJofMRX9BFj6t
	 dqieaOq1ZBrD1aPgPYfPM6vpUxPmmUFfaP+ksVcSbwN99VOp7ifYtLGL+w6N8Xbghyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=XoN6dl4w;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A7A606A322;
	Tue, 24 Nov 2026 05:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40A7A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=XoN6dl4w
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A5CE440E02A9;
	Tue, 24 Nov 2026 05:01:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6vKUTZogjik0; Tue, 24 Nov 2026 05:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795496485; bh=XM+P0UUh8M7+zT3EmoQUfy6DuwH+/xR6iA2fTPRkpYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XoN6dl4w0hO8vS82WF2sVspVH2Ft2yCybHFMhRmD+El3S2igLXKpsYPHgCoUVcvmb
	 Oz8oGr8HDNWwBeOzl8rrUhUvaApVM9oPECC7d/9Ju/qibMK8Vo9T2dhtQWb95atjRZ
	 MPFM0BOsEaCCUjHB/s3oXpSVfkL0TSDZNVttkSIEVv2GKzR8SzLlMQ+RW/hewfU6W5
	 4Lxi7W6xN7fGfE33HLqD7S4d8vlc086is0sSBgTYcxlqpt4HVRdDWog3K8Mzi/W1Xf
	 UlKcVU9nRdy1tP9J3ON3tF/jnhKp2rFe62GH+8QqxhjC/dt63NbTVdeMLdHCUzfE6+
	 4AW7xbzjs7BZ1/+frP7bdFDkV52jvKF89A1KzaaLrpf0KbI9gVgkmGgQFkJjYVMo44
	 DvW/KaEZpAIIQXozkEuWEeDMy4WXvEsMy75lE8aVlUbMF5MxC29dzQ5NVno2nDYq4+
	 /foqT78Nar8WxvBxBRCsqHunGBN57QcfZswYl5yajf99gaCsX76l9xMNxDemElB4Cj
	 tcBle8899/aszxRJRuMvOp/ZfdSf3iNFzLRp+u047z7oLqR3blWLgzairNs1uj+r7Y
	 fjrtn9W6rytSEvHwabaQDXRpMAVcvSbpuc7IdEoHaYy3hSX82+tUZS2V6/Pbnayk03
	 Gd+BMPN4fLEPETqdC9IO9FsE=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2EB5340E0240;
	Tue, 24 Nov 2026 05:00:48 +0000 (UTC)
Date: Mon, 23 Nov 2026 21:00:45 -0800
From: Borislav Petkov <bp@alien8.de>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>, Dan Williams <djbw@kernel.org>,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 09/19] ACPI: extlog: Report errors independently of
 RAS consumers
Message-ID: <20261124050045.GOawUZ_S5imwUOyh8B@fat_crate.local>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
 <20261117111444.4185512-10-pierre.gondois@arm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261117111444.4185512-10-pierre.gondois@arm.com>

On Tue, Nov 17, 2026 at 12:10:19PM +0100, Pierre Gondois wrote:
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

So after rereading that link, we had this conversation back then about
reorganizing and reworking RAS error reporting and Dan (may he rest in peace)
wanted to unify and dump all the old cruft - especially since
ras_userspace_consumers() is not really used anymore. Apparently.

But what else uses it?

This is something other luserspace probably relies on and we should probably
do our due diligence and slowly deprecate it with a warning splat but not just
whack it unceremoniously.

And what I'm missing in all that effort is the big picture. What are you even
trying to achieve here, what's the point of all that gymnastics?

Unify GHES and acpi_extlog? That's it?

I'm sure there's much more to it than just a plain unification. 

Probably CXL-something is going to use this too eventually?

But I should not be guessing - I should be reading about the big picture
somewhere. No?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
