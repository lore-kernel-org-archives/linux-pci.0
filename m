Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029015;
	b=ewJ8/ENjIRPbqKI8MV5hTbkH8yJgEk0Fxc1QQ5Py2h2XWqpPdOA5kIDiBufVel+DmW1y
	 jboorb+8wzyHWHVCi2N2Q7qOpp1YWmnw2YSS9c8U/honuwe5iA+HFn/E4x6WiwSWerN2v
	 s86giYXocd4aLvF3mQsPHfOFsNC3lPlbCVYb0kuJHujcoouGitlnj519VSTWrxb+9B2+5
	 XXM3PjG//RCflmLav2tGlb4re1XjWAhIqfulADLf3XcUhab5sAj6WufOmMQpHsZ7tsjLn
	 BSMBLTXW7hRkJyAOGSKRO318j2Hd7E/unYNSG9q3HGqUh8Dk+MX008aep1VdyZhdz3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029015;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iMRUsGYu7zSEFYynNiT3pkVIolltTYn1kN2e3iJRjP4=;
	b=IltnEzPskj44FbW/N9uF5PyT/CITWvJ6/OoMDS2c4brjI/4vlykKI5dl+mqxzLjFv4Fn
	 BFoTh/e/AYPKCGvTuIm11oSNNIT4lzttmG5ul1TWC7NeNJ6nC7tlRpkXUV6maANTj4JHf
	 3qK3WdEqok3lgJtkhI9TQubZBzkqNA+W09Kl22n7jZwPmz1uqrMBJdC01JShbk/tKso3h
	 OJeb2CP2cUhtrTXTNG7wEG98YEl4j5hDivR7Ok4ll7V9pS+qMlN8A1Ug8QaHrp26gEOBl
	 If4goVgqNWGaUqLwtKluANUVHiCKs17vhaw1VeqFx+48NK6jir0skOlbKhehs/JlYnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5Jph70J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4095C606A339;
	Wed, 18 Nov 2026 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5Jph70J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5081F000C4;
	Wed, 18 Nov 2026 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795029015;
	bh=iMRUsGYu7zSEFYynNiT3pkVIolltTYn1kN2e3iJRjP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N5Jph70JX2LYHDXBMhrdOmmHoE8hVNOQFsb0hD8QdJi5/HOJWMOWiILiGvRyS1xko
	 TYl8bryWfX649pvRtKP3OuUQLCY43WdJo6ES1ssjR6HL7W1Pe2MonCKbHUT3wFoXet
	 2Z/FI0yiiDwAwcCdHNWjtNP+PI/HMNp0VcQ6fsQVv7VlL/W+3M6ng8HiZQLY4s9az0
	 k44AVz0RsKIL2XEPtOV6t+CDqoZ6czFpIWR5Etk78FYZ6ggNhpZvY4LrhR78vAOMhf
	 +s7YaQykImzKFE5dj4WS/53WLMgCSKEuq/ymS0dhIYGrw6plUoYDkILvR9xTI0GgXz
	 0kWdY5+Vt60rw==
Date: Wed, 18 Nov 2026 19:10:03 +0000
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
 Avadhut Naik <avadhut.naik@amd.com>, "Fabio M. De Francesco"
 <fabio.m.de.francesco@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Kai-Heng Feng <kaihengf@nvidia.com>, Breno Leitao <leitao@debian.org>, Dan
 Williams <djbw@kernel.org>, Terry Bowman <terry.bowman@amd.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 04/19] ACPI: APEI: Use empty FRU values if valid bit
 is absent
Message-ID: <20261118191003.5a4a2ddd@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-5-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-5-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:14 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> When a status block contains multiple sections, a section without valid
> FRU fields inherits pointers from the preceding section.

Perhaps rewrite that so it is clear you are referring to the
implementation of the parser not spec requirement for it to get
them from previous section. That had me briefly confused -
I even wondered why I'd never noticed that requirement :)

> 
> Use empty fru_id and fru_text values whenever the matching VALID
> bit is not set instead of reusing the value of the previous loop.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Fixes tag seems appropriate for this one given it may be reporting
confusing or invalid data today.  Probably not a thing to rush
into stable but nice to tag it anyway.

With that small reword above.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/acpi/apei/ghes.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 703f3b7f700a6..444d8e82353a7 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -979,8 +979,8 @@ static void ghes_do_proc(struct ghes *ghes,
>  	int sev, sec_sev;
>  	struct acpi_hest_generic_data *gdata;
>  	guid_t *sec_type;
> -	const guid_t *fru_id = &guid_null;
> -	char *fru_text = "";
> +	const guid_t *fru_id;
> +	const char *fru_text;
>  	bool queued = false;
>  	bool sync = is_hest_sync_notify(ghes);
>  
> @@ -990,9 +990,13 @@ static void ghes_do_proc(struct ghes *ghes,
>  		sec_sev = ghes_severity(gdata->error_severity);
>  		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
>  			fru_id = (guid_t *)gdata->fru_id;
> +		else
> +			fru_id = &guid_null;
>  
>  		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
>  			fru_text = gdata->fru_text;
> +		else
> +			fru_text = "";
>  
>  		ghes_log_hwerr(sev, sec_type);
>  		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {

