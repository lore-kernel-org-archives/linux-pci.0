Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029259;
	b=q+V/7Lmvj2dT77K23c+M3T39ChYoyQLH+FW3SyMqNihfFrL+KbkU9jDQgUFumyZZO04l
	 QYKrqhpsVnHXoKfBObQXP+lruBJhnUtyDWurdfiVERIzJvwAF2fnPVzmPGzyajJn3jPVM
	 MAvWsdz+6nF/zT5M0nBXZXtIuE/CyBBK6uVRSXCbrJ31/JOHc8oNGUDQvcOSp8rLlv/ET
	 o4xW88466ENVvcfvu4A3EyWMWz2xmf2lQLWwAm7T/P+pYQyCsmbnUcqHnsn0Vj8y5OmlU
	 kZTeghyn0Ido1b9HG/hOU3Hx0HG/ggYhjdEz3Q0W3Aq9hSlBKG+qUp1XERKQ45G4K7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029259;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=d9SMOsxwAFQZaUBngPgxh+BWRFva5JtsprMZmImAyMc=;
	b=H/CctYTdGOiJP+/Pg5lb4jfvNfP8yQI7Uj3GbNK56i5jiGlsuSzWzVsc5oQp65g5DpOD
	 519YAzmu8jYpBBnMSteJm8Ow70xCeTJNTaihvBuORipd6aX4J9eWGsgOjchZmRQ/arScC
	 RE3E4eeF+LiYUVoybnLm9Fvkd/wLfgztPwlGyzvLaxxGoHkX9gjZLe30eVkCDIpyA6Ff6
	 6KOK5S0o/crljwVvyvDsz7PUs5enm/NgKu+1tKtyE+ehOXhjVBuFijn20SB2zq3EeQbBU
	 u05Fxh1F0QOrK3g9+jUhv+NMQJ2QMHu0ib+rVCXWnhh9xEavH8NVlJqlu49NrzfOWyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxoeVWsw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE3B606A31C;
	Wed, 18 Nov 2026 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxoeVWsw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AF51F000C4;
	Wed, 18 Nov 2026 19:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795029259;
	bh=d9SMOsxwAFQZaUBngPgxh+BWRFva5JtsprMZmImAyMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VxoeVWswVKJ9uEK5QYTOLpSc/fG1ejiOdRS9ttIaxvwDjkbx+fjATQoIvZarZK5Cr
	 30BaMKHJoZpLs0TqJQ4KjckA9GnwiI96q2cSEqA85pWEgY/3QBJhLZb0Hn1X1vicLX
	 aDOcOvlF6cn6ceiorWrs31apZUXj7aELEInkTtjYkp3l6ZtIzCZqJJ82TM9yllYjg2
	 KGokbS+cmhTz2BxpxZj5B1KPuHCJi74n908Uz8seXJfpXOOR+67Rtimd+mBJzJZZnv
	 uzXK52FpqEtPGxEmJEKo5kD9xygQ852Tw0g8oaUipdAbx8Y3bJ5AqunBoOvaLt3xe4
	 MkCUysXXoCmAw==
Date: Wed, 18 Nov 2026 19:14:08 +0000
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
 Zhuo <qiuxu.zhuo@intel.com>, Radu Rendec <radu@rendec.net>, Avadhut Naik
 <avadhut.naik@amd.com>, Dave Jiang <dave.jiang@intel.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, "Fabio M. De Francesco"
 <fabio.m.de.francesco@linux.intel.com>, Breno Leitao <leitao@debian.org>,
 Dan Williams <djbw@kernel.org>, Terry Bowman <terry.bowman@amd.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 06/19] ACPI: APEI: Remove aer allocation in
 ghes_handle_aer()
Message-ID: <20261118191408.2005b091@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-7-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-7-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:16 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> aer_recover_queue() now copies the input aer_regs instead of
> storing a pointer to the struct. Use a local variable to pass
> aer_regs in ghes_handle_aer() and remove the memory allocation
> introduced by:
> commit e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error
> status data has multiple sections")
> 
> No functional change intended.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Just one trivial thing.

I didn't bother figuring out impact of the change discussed on previous
patch on this one, so no tags for this version.

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 57406494ec1f7..d7ef84e3b988e 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -32,7 +32,6 @@
>  #include <linux/slab.h>
>  #include <linux/vmcore_info.h>
>  #include <acpi/apei.h>
> -#include <acpi/ghes.h>
>  #include <ras/ras_event.h>
>  
>  #include "../pci.h"
> @@ -1413,18 +1412,15 @@ static DECLARE_WORK(aer_recover_work, aer_recover_work_func);
>   * @severity: AER_CORRECTABLE, AER_NONFATAL or AER_FATAL
>   * @aer_regs: snapshot of the device's AER Capability registers
>   *
> - * Queue an error record received from firmware through APEI GHES.  The
> - * record is processed later from a workqueue, which logs the error and,
> + * Queue an error record received from firmware. The record is processed
> + * later from a workqueue, which logs the error and,
>   * for uncorrectable errors, attempts recovery of the device.

Whilst noisier, you should probably still rewrap that last line.

>   *

