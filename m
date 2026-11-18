Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795028812;
	b=t6IbR5AKUs/URcE4AELs+MrlqNIdTq1+O4Bf3LeIMpsFCTRlCwspy0AqWH4UM+xA8Znb
	 sO5G54wGOkTcXgEZNXC0OOj5yQiF4pMWDIRYQ7PeyYM8XKWiUl0JHF4KVos89CsHQh6su
	 R0WMgW457TB55OC92cvDCBW6MP4bmrlH+4PbdLaCLJlwbrulyBG5T4KL5/SUgMbSCyL2Q
	 HjlW+g1lx99axrEaYONgodpRIz8VoBVkyKERP1GNQBd+C7zRucCuKmeIU2yU7WzHYi56U
	 hRxjjtUFKTRLInUWJ997kPOso9HcsRd8KrwugUSz3TangXvocvZ8qgsFzWq3ugMoLuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028812;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FxU/Ni1onbxi/KQipCfK1DOJbeJSAyS+b8tm3BOgzg0=;
	b=xssrOyuXMKmxGn7UuywfVeBJiXGHIjMIhsKCWXrQa91Ea08/jqwBNE2whZ6gl3N0RQq2
	 3VlKQ9K9c0QGyRsd1lJFLfkQQtWMmcI6vOZi2XlsgTyrNJ6VBIR4qV31ITaIOlur7nHao
	 w0MrbaIegKz9dhXzCSnIEykJhG4OqOfOXN5CpgIUSfNLDT31teNj1887dMwnv+ifFXXuM
	 eet2wq1YvcbYcj368/0MZ62CRQcfbdhuBEAh0fX5QnMWBQrsTyT58fZj+pqLD8pG5uc9B
	 4Toc0uv8NgW8iQ+kmqyXq/nfeotuZ4Uwd7BUdLFpOny6ysrnZdl+99H/LGRtnoY7kwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mreWieIE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7082606A320;
	Wed, 18 Nov 2026 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mreWieIE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0B11F000C6;
	Wed, 18 Nov 2026 19:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795028811;
	bh=FxU/Ni1onbxi/KQipCfK1DOJbeJSAyS+b8tm3BOgzg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mreWieIEaUoX19DC2dVQNzL2lS1r8X5JzevZX7IjEC+p2+DHMU4GBywPDUtVPxOod
	 84VmnE/dXuVDNsUJW+PDqRipf8wypZ4XHnyy2qKxr65aAe4c6emLFnEspzwz5tkIa9
	 EVV9c5zEuvi6o39Df8A2tSqC9uLv0sDtRLn5F0N6rZ15cFCjjqYMVcfmiaH3hGjFEr
	 vMGgCsy2OwEgoqKk0lgP5i9zBXf17k3iJ4N1U2irfcj63qY0KfeYN4UjpbFyx/XQgi
	 Quj+pmGct4j0iOOFX64pwDIL80xg6AHF/RKk/iEkJoQzFEz8ZCBGuhUNupviiiStUg
	 NmIlSDb8uPdSg==
Date: Wed, 18 Nov 2026 19:06:35 +0000
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
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, Breno Leitao
 <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>, Dan Williams
 <djbw@kernel.org>, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 03/19] ras: Bound CPER FRU strings in trace events
Message-ID: <20261118190635.4e1a65b8@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-4-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-4-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:13 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> CPER FRU text occupies a fixed 20-byte field and need not contain a NUL
> terminator. Using __string() can read past the field and, for a short
> nonstandard section, past the end of the firmware record.
> 
> Bound FRU text in the legacy memory and nonstandard trace events with
> __string_len() and strnlen(), as already done for the Section 2 event.

Given the many many definitions of __string() in different parts
of the tracepoint infrastructure, might be worth a pointer here
to where it trips up.  I think that's just in stage5 with other
stages ignoring the actual length.

Patch seems valid to me and not directly related to rest of the series.
So perhaps a hardening change to pull out ahead?

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  include/ras/ras_event.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index ce759ee1cf4cc..069c7b3a5e6c0 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -39,7 +39,7 @@ TRACE_EVENT(extlog_mem_event,
>  		__field(u64, pa)
>  		__field(u8, pa_mask_lsb)
>  		__field_struct(guid_t, fru_id)
> -		__string(fru_text, fru_text)
> +		__string_len(fru_text, fru_text, strnlen(fru_text, 20))
>  		__field_struct(struct cper_mem_err_compact, data)
>  	),
>  
> @@ -370,7 +370,7 @@ TRACE_EVENT(non_standard_event,
>  	TP_STRUCT__entry(
>  		__array(char, sec_type, UUID_SIZE)
>  		__array(char, fru_id, UUID_SIZE)
> -		__string(fru_text, fru_text)
> +		__string_len(fru_text, fru_text, strnlen(fru_text, 20))
>  		__field(u8, sev)
>  		__field(u32, len)
>  		__dynamic_array(u8, buf, len)

