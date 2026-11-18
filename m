Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029446;
	b=iUMQBGeJWGr3puMr3sK6R+S9fxs+mdrsCCRou2ShubjMJAqNd3PVsMptXCTaUHByN1Ps
	 uvBeSYlv1Dh9t/VU1HDllQoiTp+JJTMdWqB+0zr0jZkew+xi5SfDi4NVdfv3jwZwHsCV0
	 d/9x5NGelJqH98oxwGWendEZEbuTZLVcX/XoPtlfrYIUCUGNzV8ThK4EdV5UTOqa68FO1
	 nM0YDeydz8Usc7Aso7NoEiw88as2bxlUBBpf9RsWo6u3EdfIzlYyeSLkdqEjyifEhBnd+
	 ccnPj5owCvV5TBRW2oUrRh4zdb+CkMkMMMaru4/9J0qloQH2AvIxNkOFiP+48B1uwDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029446;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7owH4WUkerW4zIC+CKgnsga+eX0VNj1y0MG+J3/f8XA=;
	b=E8V6NqA+W8RS4mm+6nrxwz4L7xx4ph2+Zr+JCqsK3tXA/CtwcBibZQ4l8Cq/AJSJEje6
	 s1quq5YBV3gj9GH0U9SEemX+8IC6PObtrGSaPk32bGBvPr/gu3FhwnjFOeXqNmSiodwK4
	 4BpOFmgLdxDJit7q6XcF4QQzHsMd3EPb/qA9yc8lTMWXyWloT5SyDw5R7U45llnX+dJQb
	 RQVAezyPxppf8QvqxbDxIoqozLr9G8XXoqZOWpr7DiY1NUIFqpeLC4m/THol4RTSoWX+m
	 MNNA7DCx9hZ1fImJE3DU4raF95CNjrEuwGIMmuj1BbJnTmaYY7qckQRmxitcBMTxTDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUzLfTeG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257AD606A320;
	Wed, 18 Nov 2026 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUzLfTeG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BEA1F000C4;
	Wed, 18 Nov 2026 19:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795029446;
	bh=7owH4WUkerW4zIC+CKgnsga+eX0VNj1y0MG+J3/f8XA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jUzLfTeGVe+PVJWQpQLUkHhUrlMClo9R3mL7zgVI4gmp8SxXYkr468lUOUNgoDpeU
	 kDwzn7RvYzUgRVvJS5xWYx5ms43Uidq8z+Ldn5RfAAcFsGFAlQItErJV5WESWbYvpi
	 axnSxFLq3DJAwvWpYtGSR3KM/MimOlY/hMEOFBiiHnY2W/nMYpRdMakLP+OhixN/nn
	 +MGHg2u7eZ++8s1o7Po6K7SjXQL396mLgmhBnPeraKdNZeo8VyIJ2DeZ1MglbFhTNO
	 y+KLn3+Oa8wBs2ooCbN+hQsZZ/HOvwLcCmyAFlJrsOFDBIrI9ofXmIrCIG8xNrj3if
	 8sq5P1AiMZXDA==
Date: Wed, 18 Nov 2026 19:17:12 +0000
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
 <leitao@debian.org>, Dan Williams <djbw@kernel.org>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman
 <terry.bowman@amd.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 07/19] ACPI: extlog: Provide HEST generic data to
 extlog_print_pcie()
Message-ID: <20261118191712.19a5ebf6@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-8-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-8-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:17 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Pass struct acpi_hest_generic_data to extlog_print_pcie() and derive
> the payload, severity and length from it instead of passing them
> individually. This reduces the number of arguments and makes the
> section flags available for subsequent changes.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Looks fine as a standalone improvement.  So even though I haven't
yet read on far enough to see the usage of the flags:

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
