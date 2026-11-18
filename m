Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032269;
	b=uwov2ID/sx2Kxy3gxZJSgv9oPeE4be0Os2dZfsWkrab2zIJUra77M803zNxcPyCm8PAz
	 1pp/4kCFVhWzPEZKTKPFcoanUx6lD0iWj4dRim63VTCR2fdnXlfJkX7XrOD7S/a+YuZ8P
	 WwzBXJvpr5TPJpQDoOW8kt90cIXM2/aDhV1JkkKodnn55vGW1P4Fyao82Cq0H99UJ8HRg
	 4yy1RJn6jFhBkB0NH13Z5lPmsSyT7DpB2qoMbzDbyLBwyi4w0sobqsZUwh6WLva6Z8juq
	 u1URG+fSGo4nrvtMYLdZGDj7+ooKUnJqnyrlEkhK67ZcQ4ycZ97IkHwv0PlcePwDs9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032269;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KG1mjfcXzaJzGAZP0WznA6ezlruVcDCnyBjVr5/t4MQ=;
	b=qykSUIaNOPyxmSY8702iz7Y59OqBN9NfstwBBynq90zBlhNF5FnrLnaUe4RyLCDsA4wG
	 U57TwAsDSgMPqeS9vCO6yIK46ZUD62tC5jcVAncDJNRS54oi9VZAnZzsvj8ZlfXJYa1HD
	 M1KEIxvYrRMYHESA6qdZJzmmMJDNKB3Z9zYtupyWe0w0x42Zj1zRnLBrbYXz60MK2Dtnj
	 w789ha/Edy7fy2Ii85MsEuQGBKHs6PfMW5r7f0vgBrwFvXEJfaqongKJrW9xqNuoTL87Q
	 Hbf1hB8gFy/H7t4VwOV0so8s/wzv51Pmy6/6Hdmur/7O/BE7yxTUms3Ah986SppMjlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXsuDz2Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5D606A330;
	Wed, 18 Nov 2026 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXsuDz2Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D590A1F000C4;
	Wed, 18 Nov 2026 20:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795032268;
	bh=KG1mjfcXzaJzGAZP0WznA6ezlruVcDCnyBjVr5/t4MQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hXsuDz2QRvI+jQBnp0CteauGv8WTUwSyhTcW+rQ1X+BXjf4WM7RGS6D1q8KfBJwfr
	 jObpVFxMTFop4+tKCizD89fJAsULT4wcT96w1IGIjDzjn2NifJUmoeftL850htgPuQ
	 +9lnsce44uDoIC5/9+1jIGIcyQt/rXofzqVfRBbp6czao5x1dgpit0eXw0u8IxjKT0
	 KYUoWr5H3KcE4/InQ5Nq6if6L2lBqK6214K8V2i5kCd6Y3Pfx4AIPDA2LR4KVNqoz9
	 jBs7Otbc1XYyzrJLTSJ8p6R0WWQR67Av7pKKax+434DoYSvZq9+f5mjnTxJU1BkpvS
	 jZVBhwoHzIuFQ==
Date: Wed, 18 Nov 2026 20:04:17 +0000
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
 Zhuo <qiuxu.zhuo@intel.com>, Avadhut Naik <avadhut.naik@amd.com>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Kai-Heng Feng <kaihengf@nvidia.com>, Breno Leitao
 <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 12/19] ACPI: extlog: Extract CPER reporting from
 acpi_extlog
Message-ID: <20261118200417.42034547@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-13-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-13-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:22 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Extract the CPER reporting code to a separate file in order
> to re-use it in the GHES code in a later patch.
> 
> CONFIG_ACPI_EXTLOG selects ACPI_APEI_GHES and acpi_extlog_report()
> will be used in ghes.c, built with CONFIG_ACPI_APEI_GHES. Thus also
> build extlog.c under CONFIG_ACPI_APEI_GHES.
> 
> Relax the definition of extlog_mem[|2]_event tracepoints to
> CONFIG_ACPI_APEI_GHES. The common reporter references them even
> when CONFIG_ACPI_EXTLOG is disabled. Guard its memory trace calls
> with CONFIG_RAS because GHES can be enabled without RAS.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

There is too much going on in here that isn't code movement of
Kconfig stuff related to that.  Those other changes need their
own patches were you can describe fully why they are being done.

> diff --git a/drivers/acpi/apei/extlog.c b/drivers/acpi/apei/extlog.c
> new file mode 100644
> index 0000000000000..8eef33a4326a7
> --- /dev/null
> +++ b/drivers/acpi/apei/extlog.c

> +/**
> + * acpi_extlog_mem_error - trace a validated CPER memory section
> + * @gdata: section header followed by its payload
> + * @err_seq: sequence number shared by sections in the same error record
> + *
> + * The caller must validate the payload length, including any optional fields
> + * claimed by the memory validation bits, before calling this function.
> + */
> +static void acpi_extlog_mem_error(struct acpi_hest_generic_data *gdata, u32 err_seq)
> +{
> +#ifdef CONFIG_RAS
> +	struct cper_sec_mem_err *mem = acpi_hest_get_payload(gdata);
> +	const guid_t *fru_id;
> +	const char *fru_text;
> +
> +	if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
> +		fru_id = (guid_t *)gdata->fru_id;
> +	else
> +		fru_id = &guid_null;
> +	if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
> +		fru_text = gdata->fru_text;
> +	else
> +		fru_text = "";

See below. This work is done in the caller unless I'm going crazy
and it's a different fru entry...

> +
> +	trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
> +			       (u8)gdata->error_severity);
> +#endif
> +}
> +
> +/**
> + * acpi_extlog_mem2_error - trace a validated CPER memory section 2
> + * @gdata: section header followed by its payload
> + * @err_seq: sequence number shared by sections in the same error record
> + *
> + * The caller must validate the payload length before calling this function.
> + */
> +static void acpi_extlog_mem2_error(struct acpi_hest_generic_data *gdata, u32 err_seq)
> +{
> +#ifdef CONFIG_RAS
> +	struct cper_sec_mem_err2 *mem = acpi_hest_get_payload(gdata);
> +	const guid_t *fru_id;
> +	const char *fru_text;
> +
> +	if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
> +		fru_id = (guid_t *)gdata->fru_id;
> +	else
> +		fru_id = &guid_null;
> +	if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
> +		fru_text = gdata->fru_text;
> +	else
> +		fru_text = "";
> +
> +	trace_extlog_mem2_event(mem, err_seq, fru_id, fru_text,
> +				(u8)gdata->error_severity);
> +#endif
> +}
> +
> +/**
> + * acpi_extlog_report - report sections of a validated generic error status block
> + * @estatus: caller-owned status block, already checked by cper_estatus_check()
> + *
> + * The caller handles console output and firmware acknowledgment. Section
> + * processing, including PCIe recovery, does not depend on RAS consumers.
> + */
> +void acpi_extlog_report(const struct acpi_hest_generic_status *estatus)

Given there are functional changes in here, it may make sense to do them
separately from the code move  / factor out. 

> +{
> +	static atomic_t seqno = ATOMIC_INIT(0);

Why did this become an atomic?  I don't mind that but I'd have made
the change in a separate patch so you can explain it.

> +	struct acpi_hest_generic_data *gdata;
> +	const guid_t *fru_id;
> +	const char *fru_text;
> +	guid_t *sec_type;
> +	u32 err_seq;
> +
> +	/* log event via trace */
> +	err_seq = atomic_inc_return(&seqno);
> +	apei_estatus_for_each_section(estatus, gdata) {
> +		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
> +			fru_id = (guid_t *)gdata->fru_id;
> +		else
> +			fru_id = &guid_null;
> +		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
> +			fru_text = gdata->fru_text;
> +		else
> +			fru_text = "";
> +		sec_type = (guid_t *)gdata->section_type;
> +		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
> +			struct cper_sec_mem_err *mem = acpi_hest_get_payload(gdata);
> +
> +			if (gdata->error_data_length >= sizeof(*mem))
> +				acpi_extlog_mem_error(gdata, err_seq);

I'd move them with old name then rename in a follow up patch.
Particularly as the new code duplicates the fru stuff above - that
needs explaining which can't be done in code move patch.

> +		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
> +			struct cper_sec_mem_err2 *mem = acpi_hest_get_payload(gdata);
> +
> +			if (gdata->error_data_length >= sizeof(*mem))
> +				acpi_extlog_mem2_error(gdata, err_seq);

Same for this.

> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
> +			struct cxl_cper_sec_prot_err *prot_err =
> +				acpi_hest_get_payload(gdata);
> +
> +			cxl_cper_post_prot_err(prot_err,
> +					       gdata->error_severity,
> +					       gdata->error_data_length);
> +		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
> +			extlog_print_pcie(gdata);
> +		} else {
> +			void *err = acpi_hest_get_payload(gdata);
> +
> +			log_non_standard_event(sec_type, fru_id, fru_text,
> +					       gdata->error_severity, err,
> +					       gdata->error_data_length);
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_FOR_MODULES(acpi_extlog_report, "acpi_extlog");


