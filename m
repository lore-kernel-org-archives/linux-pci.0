Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793926047;
	b=hcpsGmXNoMG58xAc+2DBG4tCPZYHB5Q1LHtkocDNH/pcCpoTJ3XPUJqBc4IkQk7XsiDp
	 lcXJzdTTA2Mguiif16CA378K/RLStFQ5EoP+UkwOS7g908I+k19iAQerLpi8U1CrOTu8M
	 GezfSVUTiqmYnjbeQlSvmgxjJ0bsVHUX+sLpyHwMtqitUWSK32HmkFDISmqATxm9WFJr7
	 mNOpNjREWQFs/7Kgi6lnlgrMPv3s9Iuho77R6ooPcisPKIo8qt4my/VPG4lf9jD8+u6wL
	 SynDA7ysI/VRp287D/EEXIWB3Ry4dcfvb2EuL6BSii8prkhBcd2oNGzbienSvLoNAhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Q/Pn/3oT6XlOFb2SsTcDdo2UH2iFiBAGJC3TZJWHkxg=;
	b=e6eSauhHYA0OGCWgExeudneoBr4qureZR8Wdct1XrJ3KaRc5/qNnKuP+fDlWuEY8Yz3D
	 6PQsYdfxF5qt/HgwxwENtgDKIQ9qSiaBu9FhPSO5kWs/41WSIuUbIkdJFy8FH15X/gdV8
	 uNr7L7koSJ6UZ8jWARaq3LdH7YhOXv6LSv+R2b+QZuc+KMg2EgyUQmIhfP/wIkzZfiX3a
	 0FhgmfoEx9OgKkPm2yI5i3OJlum6RLEPqKTb83i7rZzm3be0PnlhC1ATVc8yFE/e46I71
	 pPTmDxAXNrshQ5YYvej+MG8ujZGx5kR6YvrTDr7T73qNuq4THJGYLSKNJiIRpa7r8hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LIecB4O4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F339A606A326
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 00:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F339A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LIecB4O4
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c423b145922so12806666b.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 16:47:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793926045; cv=none;
        d=google.com; s=arc-20260327;
        b=RwcLBD6K7Y0d3IQuO/qpEde9CLWMniNlFZiUryelEkHHnqIxhc8+gru0UF1jpeDvp+
         b/w3o5CntG9UbvarF1jxOniEqM4Xr332Wvcd7Jg3iLoDZaKt059qvyBcWY2vpfsfkYb0
         Xjv6sgAVKdZ7gkVWMmp6QbeYT4dKOyDvKrVF6PtD52tWel198jZTyuSUMv7B9NyO3mWP
         gKJbwmumSynqGZsEtYQF6LLONlve4US4itjhYcl1VBVIRNv5CzWwPw3N+EKsMJUr57ps
         U+hsKDbHiZ6/fufG/WgGhV+a327/Z+HJEueLjYuml6FDgsdxGfyFGcveEKxRLHWDvPsf
         yNHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q/Pn/3oT6XlOFb2SsTcDdo2UH2iFiBAGJC3TZJWHkxg=;
        fh=fUElxgM2rFmNbbu88gVNTpk+W8AxgmRpwDxgJH6D8B0=;
        b=honHBS5K/6da4r/Fs+a79BzeTx0H7VLhAXT078etppQTr6I4X8V2lF+KyF4uYCqAJa
         AJFNkqJMOcozTWEUTLlHRz4yMGNShuKOneq7ndiKJjZJG3gPDVn/R795Ya4iRgi2WFp1
         mzcmG08C30yJYKo6BsO01gzqMA+HEiEL1hYKJHQnSwfMBA5wzjwmG1WtKPGkrBo+GVSA
         MZK4hb6ymzi5URLhZOP+jKEWgUfgGqxpx4UUp0znX/7r1PITCrIYw8pyIxFPlqNksfip
         HA7cynt15as2lTKGFZ7VijGY3rH5JD5cR526GONmkqyjD+Sbym8oF+VZs7Dv8t9+d2X/
         oOXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793926045; x=1794530845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q/Pn/3oT6XlOFb2SsTcDdo2UH2iFiBAGJC3TZJWHkxg=;
        b=LIecB4O4eRRofJzvG/tvhMmXYhpZUwPA4yerXfp7rVc7X2Gph9Vwlg1fKJRDBKiB+v
         bltFvkuSutP6NUJPujTY5Bf2qJxUuEvSIgLScLc6MmNyVYsK0a6XL9RBW2VEsy1hEl5w
         CyIlaoFv8GE3hhFrtCjbc5hWdtrudTSiVyvj2rds73tGX6xu3JT3gEqXsyZjIDw9psiY
         d5xo/cIn9UVGc0m9QgIeIyr8x4yTrp4HJba1n5Q/KJvI+79CbDI2BTutZtBCHxbBKdx7
         UxPa+C9LgG/ePsIOotML/nbEWEIqiiTCiHWORP5/pit0E2bmtumqXTxbeEfSF4oa/Zrl
         TErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793926045; x=1794530845;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q/Pn/3oT6XlOFb2SsTcDdo2UH2iFiBAGJC3TZJWHkxg=;
        b=NK3QuDTvVuZcAHTewWMJcsqyUPuGTUaG1mkjb1ZOENMyeI3VwTjVye3zrXdD61DpmL
         pKdbp/qG+jD2Bvwvf6Jf252pw3kTfzWvm/bY4j45pZIlKzgTwkEMDVlKS5eUgeu/JDxc
         q1rhsytFsM7Ry4AhlTJxwXjA3URNZffZNrGOA7pFGNFKlzpxLQa55HpN3ovyztywynOj
         /QA3Z0HYzrw/Tk5cKFCHg6TnFxxCKl0xtzWWn8PfmHWbexybdNQTRInv2NKsBJZuLDLp
         jRQJvN0QXt3ExKPhyhtmN2M1SU5GsrcYG+go/25kZE+Ud/6Nmf6/0v+l4B3/uhwFtIee
         8osg==
X-Forwarded-Encrypted: i=1; AKwUvByeuNLKdiEIa/b7Vs/JMHJB4gAA+0AgJpKZptGk0EwZiEs6Ppnr4aomdyDdqfkCWxnR5mzKF9EOsV4=@vger.kernel.org
X-Gm-Message-State: APuU4Z80oAojQlgMhT5e0eGjcKDFIbllMg9VuKH5gd/bfOJ8Q2xEsZwW
	5zK3SD/vw3iqZvESHlJXkQXk5Gu9W7pT5suuctbqfvjqtV680e0Y9zU58+PRkD9D9jqugiBOsL6
	jnsjIf9fpc8w6C1pVzC8zuLuSgk2UyH57maoXo47P
X-Gm-Gg: AYBFou1q/0pOxns/3rfB9ncn1FMNCOXJbv6HmXVD0ygFj8yhJhB23F6n3WX6ejChsp0
	uk9kzaoJ+jFZIocHL9FQHTehtzwbwiYPN1Xm65VXmrdsU4NA39hKtH4ja6AhOGd+pjo7nuLzQB6
	SfiDEu174KeLdQkTkjWhU5/dDj+ESQYPTX34H4I5L9YfEH7sdr1dgvKfONx7gC9shfjaUI+hyQQ
	NaANsl6zTyU+iugWrC92reuPUaqoTZHJbK1nP0aDYuTOIA+BYt1RS9Cqxd2kgutuLllsgPdH3AZ
	XdZiJTEdbj81wY6lo9CQGKeD9TcfC+jw9T1uEpaeBJ8kOMEoVbXjj0cinDIctnEy0slUHblrZGX
	K9R8IobSYcox2CMMsUDDFpdbJBj+z/DYde2qp6Q==
X-Received: by 2002:a17:907:8687:b0:c48:a838:c16d with SMTP id
 a640c23a62f3a-c4d34c333bdmr88685166b.30.1793926044754; Thu, 05 Nov 2026
 16:47:24 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 5 Nov 2026 16:46:58 -0800
X-Gm-Features: AclHuK-6t-LHK5FESHi0261vrVlL_qd-J_ZV2n6hQwmFkPQFVA0JTaSgUA12BTs
Message-ID: <CALzav=dOnBUdYKN8ucD8tMF_5RuQZOzYG2aW=K9Grd5itgvnMw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] PCI: Index saved capability state by
 configuration space offset
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 4:42=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:

> Merge Plan
> ----------
>
> This series applies on top of v10 of the PCI core support for Live
> Update series [2], which is targeting Linux 7.5. This series is
> targeting Linux 7.5 as well.
>
> Both series will be merged through liveupdate.git, matching the
> agreed-upon tree in the MAINTAINERS entry for PCI LIVE UPDATE.

Apologies, an update I made here got lost. The PCI core support for
Live Update is targeting 7.5, via liveupdate.git. _This_ series should
probably target 7.6. I doubt we can get reviews in time for 7.5. And
as for which tree, I am not sure. This series is mostly PCI core
changes, so I lean towards merging through the PCI tree. Only the last
commit touches drivers/pci/liveupdate.c.
