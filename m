Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EE837C119
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791312116; cv=pass; b=iHwvdunaGWE4EHcP2VB+4uDiUZCVB5+72GGi5FINfCZSipHCNvrU2TgUlyql/PLuUckDv9AfA6xSsmRWoCa9+6s+xLoqLinp9ktSGwejCy54MPhnmj2jAXR8rDv7JEDnYo2cHGTZOfL4qh+O5+lAm8BAu07AvVMLn4gr9uoeT3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791312116; c=relaxed/simple;
	bh=MpAzFgxVWCMOvK7jjl5NbxEMkYdvU1eQNoXVbITb2nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5TpBngj/qpesEhctBtGuqIJ+qfI+7AwaWcUKxfh0Ph3qtUi+PDmbH0GXmzNTvJMmTgeYXwiwjhw3j8oG+GDLfoBQ92oWrcyqGJIjxU7JoYm7mhXXVqXoTFPR4MkOfApZT++2J6WPn6o1ThDzAOSnbSwanjRDO1gxhLadaOF0+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D6uV6t5c; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6uV6t5c"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-144e1b6d52cso1227c88.1
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2026 11:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791312110; cv=none;
        d=google.com; s=arc-20260327;
        b=OWtxQu7kkWLpi7prJcBCD/PPVI/pYrcpwlbP6JNEuF5oajYsvqw977CMXEoesdunM1
         iSOPpjYeieJo0M0gx82L3An8vJODCGrGqOI4AxrG7SQzwZigumYPpYjyUV1r84MA7EtV
         eIYUNBxcJid7YqpTnyfaVI2sSemW09sftFXO9vLDXn/UoSW/xjUvfPe05pl5FkesRjQe
         iWTjo2v11m2v1ZEqtffhHFAwJxWpp14b/yhBCnQxd5E/uHXpxyew86guw4XIXF6iCJYZ
         veAEpCr0C15FJoEKuQqmZF7cH2x7k4h3cKJxagEFaUrJnW/FB9HtaQ3EZ88QU60bold3
         CI6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7ndOBpyUVrvLUL8/BucAq7YTN0AfiGwI+dPlm0Y1IOo=;
        fh=CoUeb+Yg1S6TMsNJcz3GsWUDiLIs7AWDt8Nj3nKkWe4=;
        b=nBr7YI9CpNjL9f9tmqx/9NzdzT6tSnw1Gd6Te0/GAlHcZJ9O67OEMcTWc/ojo9LBJA
         bwUuLX+QyruBNLd7yZcAKBXTY5Mc3WoZsOPxb0W1ewyVIaAJW1p5PEtCp7AtZDW8FyST
         IbIDf4diMdj54CL3WpAOJV8uTt+Yn9Arm09dNxWj4TN0z3kNgRe6irAXmMjmanljEr5F
         BZZkwLQD+rjYLhXHTWE4Zhyteq4jmHLt9mvuu00FJT7dgALs7YvQwMWH3XKXMZ84pNyL
         DKxCMWc5KDp8LvTLWJ7K+31/bIQP++OJkgnQDY33dGW1qiVQetWgPhxyDqFhwocGRhlU
         cR0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791312110; x=1791916910; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ndOBpyUVrvLUL8/BucAq7YTN0AfiGwI+dPlm0Y1IOo=;
        b=D6uV6t5cxilTp1Chf4NYnLBewK6R7vOxuEO1LWRldrmlSaiUTlna2YczJ1QTNJMIvY
         7El3vroNyPVvrG+7wjJZyFgaamUB5UkaXsWiM3nE60rakNg0qunxyoaQ2CdbgcWUuY8P
         hamDVJLYuZPZqauhpItsZF6X+ejgclt/xSyd+FzrkznN8YiEEUsq1fyKcDf/pCzgrnUJ
         nImAI/7JEnJonvn2+/qgEbk+ui5C9Vw/snV1SGQmre57vIfglz2eCqgV7GlkZ6BJq2BC
         G497kaAIEIQTWgLrTqXd/nn2GimjJE1OmuMCXmPRiN4LbNJ/JfHOYtrpg2JsRdA/Xag+
         s39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791312110; x=1791916910;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7ndOBpyUVrvLUL8/BucAq7YTN0AfiGwI+dPlm0Y1IOo=;
        b=01oF5zZMTsdrXDA0CEP3SMfKTE5lXbrx3IDnrk7cDMp7+/1Lbfg/TesLx8/Uv3ydSu
         nX4sINOLzfkmpGO4584H5CV/l0zRLDSo9O2/6u5VizLlHP1JR5PEi8WFKYy+5NAe5u+B
         7QRJPIlfHoothNAhdaPLRBmhwBzVjQ91d03nItemVPpJRFVgKRvouvhokMdD0rse+Gy6
         J05iNdGUm9vALCJ1A5dAxQjhmVEdEkUk1E0Blf/K2s0jkIRUqssK0AHNhTBLWPB6pJbb
         5TpuxTwpTff7jQkhDp+FAmTn9zqo8wYby6Gysojjqj4RAc3Ewue4XzMVcXsSfubbqAgb
         TkfA==
X-Forwarded-Encrypted: i=1; AKwUvBxhByraK8FmaZKx2217Iq2vyO75EVwZER3B6IoaG/1hXK9JCe969pIH8G8+odRPxbnTjhDOwnNuE2M=@vger.kernel.org
X-Gm-Message-State: AFuF++m6sCAL97SsoNUl9f76bMCm3YKhdifhaDGlsXflmEMjQ+X8ZkuY
	OhaNvWxM/5SCUZhQ9s/KE7ADepqXGxs/9bdSAY4Cem7G5T4T3ef7nxAYLtaBlZdtFRU43Fpfqrc
	1z3UFnd5xKOhk5XvEVHbVX2jYhSieNIJ44Hw8sUc=
X-Gm-Gg: AYBFou3Wl0d1JsYLNr8lmEcat65QJZ31NulbgXNdj6p19SFAaT3NXVGMXNJ2eCvx9Wz
	9Opm9SShV5vU5WQ15kilkTpungmPLN+MUbZrE8h4PeQVDdEKTsJoN1JIAnRx076eQTrfHuXyY+K
	GgybTVdW0pNXmOamB9rBqdId4mIQ7EoI22VZCj/5xGPffFE0pWK9pOC/4Fq+SzkbK0UoeNEPbgq
	JfflqVLjZqAojlS8e5r/DCqvTg/Sy8l0mUcaJLHEb7KrOvIbqlKX/c5rkDbCo2xakAMEyNhYwpz
	kbN03FrWEdhTkYM0uMaJ5n5TD42UQ3JgYrzlXfLFeHb9CKVlP8gEV79XHV0M9Zpkbt+PfwP6LUo
	4TTOsAE4sr/LAULSlaXUVQA9j9iG/YHfjtofs
X-Received: by 2002:a05:7022:28b:10b0:138:38c7:6adb with SMTP id
 a92af1059eb24-15df40d24b7mr384153c88.7.1791312109409; Tue, 06 Oct 2026
 11:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924173501.856380-1-dmatlack@google.com> <20260924173501.856380-3-dmatlack@google.com>
In-Reply-To: <20260924173501.856380-3-dmatlack@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Tue, 6 Oct 2026 11:41:38 -0700
X-Gm-Features: AclHuK9FyS0I6QMmX8Zk3xjrz1tbTyWGWZU5DOqGZ_KGJ50pE4yWQNuil68MSKM
Message-ID: <CAAdrzjt51Rduf556+BjDb6-M2mfDEgnTsbxTO3JHn70uu7sr5w@mail.gmail.com>
Subject: Re: [PATCH 02/15] PCI: Add an offset-indexed store for saved
 capability registers
To: David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 24, 2026 at 10:34 AM David Matlack <dmatlack@google.com> wrote:
>   - Each capability allocates its own buffer, at nine call sites (plus
>     one hand-built by a quirk) that can each fail independently. Four of
>     them (AER, DPC, PTM, TPH) ignore the failure

 After patch 1, DPC reports the failure with pci_err(), so at this
point only AER, PTM and TPH ignore it.

> +     *val = dword >> (8 * (off & (sizeof(u32) - 1)));

[...]

> +     unsigned int shift = 8 * (off & (sizeof(u32) - 1));

Nit: please put this shift in one small helper so the two copies can't
drift.

- Josh Hilke





- Josh Hilke
