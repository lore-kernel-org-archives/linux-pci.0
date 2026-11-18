Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795033057;
	b=3s0m31S9+LFJr4yoNr2DODL1vltJaaqoujtjhBCeoFWHGenlLiunZPJBp6WJlIy1CFnQ
	 VbqvuPO0dATkbwquDS/9tH4tmup087MREqc5nXX5fVBtlZ1QfYyRnziCkDuQ0GfbuR5m4
	 a3+IyvLIxMQrLTbrahgHCua1ZdLzeqGMMP6PJFMIpWTA4dfJwqKajI7/h88fKL70sM0OZ
	 M70USbN8Bvn13nacs8bDq2a8U9G2vEH1NzN3GW7hDNCLr6lwxxShj5EIjj8bX3eHD1+wb
	 K/DpVjSEIwBOhm+0VPBxtvO/7/0J1nTQIgJFXnR2d/duQ1pFMnoB2A2NZrEdQKDdn7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033057;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mVKoPdMSwhZTZlNTmmoGkN3w0L7rZ4fmniowdnKasL8=;
	b=tfgBxrm3ZKShXTBJmfVD39XFvQw1FR1/C+UdBbxZT7XTGARoon0ClDVwKdfrRUqqUOaa
	 y8Z9W7ADN6J3S1watRrCEih2ipwvucXlPUH1ryl8sEjuAfhON6cby0kWdgxhWZmQW8p4M
	 0zrvW5DRdtHhcVvGwjZUo4D0netUl9VKzy40B2bpx6fHt5UnQJfjMfojigqPIXaNgJe8J
	 i4Y7mVOwBX6aW3nutiLzOGe3FdxKmL+glQqJzUWFa0HmreeFrndHdXACcyJe9H0QdhcYF
	 7H1F0A40qDWiOVtMxQDvE0qzluxOyKTxvw4V+4l4RgqNRzViUcBogznITM6KxTYKlCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=beDKPYGP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A9F60A2602;
	Wed, 18 Nov 2026 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=beDKPYGP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8341F000C7;
	Wed, 18 Nov 2026 20:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795033057;
	bh=mVKoPdMSwhZTZlNTmmoGkN3w0L7rZ4fmniowdnKasL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=beDKPYGPep6s5kZbcTpNzbPBGelfYYwJQX6xK4lL4gSNE0x6CH+gKjVOdA9SVmNaF
	 EFYsCmTMH2K7XZmpsiepqr/FflIzKX2yvXmXBxzieXGu/Yg4Op50JpppR58y4hMhOr
	 gxRvQWKN+1Uu/YsnaRceSzATK+5zMhJYNIUJuJm3bEhTvlC4n0HkvwPz+89zXUclKx
	 zTSI+B1Jd58xjMI/cZSNq9L7JonxRc/hpfODsDcu87j7fuOPOq+drZ++9v73W7GEd8
	 OC7JDx6iVDYSLA0S43DhlYyrwrfp1+7v03nfEykZaJ9Y46uTRD9PddKSQLmRNu1Isq
	 mlQ8EPrQCrDYw==
Date: Wed, 18 Nov 2026 20:17:22 +0000
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
 Rendec <radu@rendec.net>, Avadhut Naik <avadhut.naik@amd.com>, Kai-Heng
 Feng <kaihengf@nvidia.com>, "Fabio M. De Francesco"
 <fabio.m.de.francesco@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Breno Leitao <leitao@debian.org>, Dan Williams <djbw@kernel.org>, Terry
 Bowman <terry.bowman@amd.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 16/19] ACPI: extlog: Report error severity using GHES
 bindings in MCE
Message-ID: <20261118201722.2e449ec9@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-17-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-17-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:26 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> MCE extended logs report raw CPER severity values to
> log_non_standard_event(). GHES relies on the GHES bindings in
> ghes_do_proc(). The rasdaemon interprets the severity
> as a GHES_SEV_* value.
> 
> Translate the CPER severity with ghes_severity() before reporting
> the event.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Bug? Fixes tag 

+ Upstream this sooner rather than later so drag to start of patch set.

> ---
>  drivers/acpi/apei/extlog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/extlog.c b/drivers/acpi/apei/extlog.c
> index 8cae5bdacf1c6..bd407436928b4 100644
> --- a/drivers/acpi/apei/extlog.c
> +++ b/drivers/acpi/apei/extlog.c
> @@ -216,7 +216,7 @@ void acpi_extlog_report(const struct acpi_hest_generic_status *estatus)
>  			void *err = acpi_hest_get_payload(gdata);
>  
>  			log_non_standard_event(sec_type, fru_id, fru_text,
> -					       gdata->error_severity, err,
> +					       ghes_severity(gdata->error_severity), err,
>  					       gdata->error_data_length);
>  		}
>  	}

