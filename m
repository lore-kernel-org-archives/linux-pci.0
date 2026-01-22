Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39FA3994D4;
	Thu, 22 Jan 2026 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102687; cv=none; b=MnjoJqPfaNl5UPIUtq3pl0GO9UTqubXiyfucNu7jqvsCPyy926vfwbVxGiqblIH6hXfUgH18EOa0y1XvobCPsbXIQRAz7sJ7bqiXJo0hQZ0KsMIzS6m9VlvciaolvMHnyL3JoaGlaYfeCYGnd73r6ECIfL0I/rXzqfCDq3UQ/Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102687; c=relaxed/simple;
	bh=Uim+gHiucovrUtCmviBxcekb8kgb+BJiT5AjE+uaH2c=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GlOfmKqFYas15gDEnvpHG2Kt8+iasbZfg2tkq6uecMUj4JSy7f44UgY63s1Z99n/C0Gypf8fKrjs1ajhtoxTvjIkJXTBjoTEMc+Un+XAZugMCDvrCoaFgGi218NWhVGGXM133JfuvUQigz6YWwnedFPsF7ZbGvQif/Ve550mwE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dw5V5Rvr; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dw5V5Rvr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769102645; x=1769707445; i=markus.elfring@web.de;
	bh=pd+dD7JdFhpQb2s812uG2qOIlnvTfk/PkLLFFAnWZGk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dw5V5Rvrlj80fo62zoBEWNy/nAqBH/d8xL8dIqBX9F0LQc6uPs3WpT/4dcoCTpSp
	 cxAKOPO7jnK24rvr8c3PuSpknlb9LF5BNN1/M+vrxOGZwyEGJeuHepvHKoQKggyMu
	 j43pSNP8yM64PwaeLpcPOewmGCSUsna6B5tx3FfvPZ+pz/a3RuYKkvQxFkciomF22
	 jhmFJL9oxII/g+ZOw/awhNvZ/itno5+EEWXgEiL3kP1ORH3f7meadT30sxhjUWoy0
	 j2DanpSrjC/XfbqWWqp5jn8XZwEe4lpRohGYcrEvLIQ2WUProJenVnlRFDEliSPkN
	 XCrmqSy5cQwCL+b47A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.239]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZB01-1vEOiz3sB7-00J1IT; Thu, 22
 Jan 2026 18:24:05 +0100
Message-ID: <bfdd40ff-43e5-4a84-a98d-522d4178626a@web.de>
Date: Thu, 22 Jan 2026 18:23:58 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Terry Bowman <terry.bowman@amd.com>, linux-pci@vger.kernel.org,
 linux-cxl@vger.kernel.org, Alejandro Lucero Palau <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Dan Williams <dan.j.williams@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>, Li Ming <ming.li@zohomail.com>,
 Pradeep Vinesh Reddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>,
 Robert Richter <rrichter@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260114182055.46029-12-terry.bowman@amd.com>
Subject: Re: [PATCH v14 11/34] PCI/AER: Move CXL RCH error handling to
 aer_cxl_rch.c
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260114182055.46029-12-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ryubp8ExKq9a89UcQDfkL0gEDl/fnhZFwysTut0hHSv+jYJsTxs
 XeLiPbq67/F87S800WFA0jQuPLicpLWKxN4h/lwZHw5gCCchybZdwBWsRSQiUlD0xpqK1vr
 em+Tste+WQhaiBwrelIEdgBZBonnCVgtCdxVtfg8PgnhlWFIr82U4EuorFVgxYMlhuM2aW0
 p8xun9+6dSgjYPNFEsOjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:B3M5g+o7r4U=;LdDqQthsp9acGHANXCGPqCX9oDs
 +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
 vs+2qCaMPvodUHlfUnZv/f3De+jP/i4PjCuzl+

=E2=80=A6
> +++ b/drivers/accel/thames/thames_gem.c
> @@ -0,0 +1,353 @@
=E2=80=A6
> +static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
> +{
=E2=80=A6
> +	device_lock(&dev->dev);
> +
> +	err_handler =3D dev->driver ? dev->driver->err_handler : NULL;
=E2=80=A6
> +out:
> +	device_unlock(&dev->dev);
> +	return 0;
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(device)(&dev->dev);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/device.h#L=
913

Regards,
Markus
