Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795028261;
	b=Wq477i1G7s9f75fjTn5XOKWF17k2SBBIX/Z0/La9D+5LyLozhsqsLymxMkanOwuMtDZS
	 5jdAG1wKaK3KHHVKVaE3CJr74dcD8BShtuq/6zIGPNzgzNI16feHh4wBWH3vO4bO1ZsS6
	 INfQFgpc/KGLIUjSJdRIrDpKv3RUahe4ul+K0F3LHvbrO5RZSIyJSk4+/a+wrKYv8ZpVP
	 a6Z+3PFv9Kze360e3KKxgVfaq1tzMOD6SOdN1Si8Dn1xkEMjnvk1QtEUcbpxEy5OKq9rk
	 2hB8HRQ36G7rXs/OFwee4anb+9Q59y0bUC/xQ34uLq14mfx3znaeEVzeOGXmyPEQCEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028261;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wtLQxfMRtrekLd+atuTLxz0xh/VLPsXiZh9Wc00ROy0=;
	b=qXbIbmW7Pn1Dif3ZLgFclCMY/bLy1ACh7gsDq+F+ADlU7IDiBhMaxz+5wzAchpLs4cZE
	 8ZUChS2/R5xv6S+lvMAbVD4QpgfvUgTNisaTknfdP5hZseFYCT5FuUofO2JpQFq6JPa7K
	 qf+HB/LJGo9soofREm7U5dL8bN/Ul3k+8YaVxcqPeDMOq52NarfhLAUo+aR9uNk2RLbwc
	 2aynK0BCJ5pTRjehiXkcJ+vemg/beX3c4jqNIF+QAztR+jo3XVjE0SxY4/iaUGYKBsJDp
	 0lWywSlThHc9kgjj4MMSkFXwo150ky8f/6RtH5+JoHnkUrt2SWCSQjX2pEA+G7JmogA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuK7hCqB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19655606A31C;
	Wed, 18 Nov 2026 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuK7hCqB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66A11F000C5;
	Wed, 18 Nov 2026 18:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795028260;
	bh=wtLQxfMRtrekLd+atuTLxz0xh/VLPsXiZh9Wc00ROy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LuK7hCqBsWO5Cipeg3+rarR8Ul56thvo1icX282u2Yrw9tPr1sW27gfa7QmNrUKhd
	 VX7RACiX99M+VjFrFyVC09R7g/0PZak5M2u1SiUExVC8tfQEdxZfA7+/pcB0hbwDDk
	 QRD+m5Zx6BqDtSscym6xKDP9SaYQrFtvLGE/GWIIm7lIIdVf7J7W7AP+raXqGndq0c
	 XVbi2vVWqNVSs5KQhfa7Zf8KKvyuk6IQbdpi76SAX2L/OznyEhu8qjEu4xPLkcp5ws
	 94lXHDqPwhp04HXyGjmM6u27nyAcMKX/GnhkRiABcQhyDBrWxixSt19N8gKqfFXhEf
	 N0ch+X6AzXtig==
Date: Wed, 18 Nov 2026 18:57:21 +0000
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
 Avadhut Naik <avadhut.naik@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, Kai-Heng
 Feng <kaihengf@nvidia.com>, Breno Leitao <leitao@debian.org>, Dan Williams
 <djbw@kernel.org>, Terry Bowman <terry.bowman@amd.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 02/19] x86/APEI: Report Memory Error Section 2
 through MCE
Message-ID: <20261118185721.11639b38@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-3-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-3-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:12 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Add support for CPER Memory Error Section 2 through MCE, allowing
> to emit an mce_record trace event. The implementation follows
> the existing CPER Memory Error Section (1) implementation.
> 
> Fix the mismatch between the parameter definition/declaration
> of apei_mce_report_mem_error().

Do that separately.  Trivial but shouldn't be buried in a patch
doing anything else.

Otherwise seems fine to me but I'll defer to x86 folk on whether
this is the approach they prefer.

With the trivial change split out, for both of them.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 07306af5a54b9..703f3b7f700a6 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1030,6 +1030,7 @@ static void ghes_do_proc(struct ghes *ghes,
>  			}
>  
>  			atomic_notifier_call_chain(&ghes_report_mem2_chain, sev, mem_err);
> +			arch_apei_report_mem_error2(sev, mem_err);
>  			queued |= ghes_handle_memory_failure2(gdata, sev, sync);
>  		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>  			ghes_handle_aer(gdata);
> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
> index dc60f7db5524f..a92174793d9c2 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -52,6 +52,7 @@ int erst_clear(u64 record_id);
>  
>  int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data);
>  void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
> +void arch_apei_report_mem_error2(int sev, struct cper_sec_mem_err2 *mem_err);
>  
>  #endif
>  #endif

