Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04D937DE87
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784317109; cv=none; b=HvjK/cOAkYNC2pAprVvDaxUBuZJ6dB9C+vZYvR5YY3SF3v+SXRg60vGaSygZf05kXKMgKAIrCm0qjFYu9Yk5QpGeQNsmk0xPRh7SZvyOnYgQqUkdrJF/BgJa8jo2eJPDH9RzYvgqRNkdw/mv9oM+miyoz74M2Ez6O+DNU7IMAyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784317109; c=relaxed/simple;
	bh=jsqG06VtS3z0e6bZDXnLFvK+GuvHlYm90fGXP1i+Rc4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=cC+N2q02swKutn+Tst+pE1GotSbtv/+i2SJUVrsiOtcL6PyakR7IzG8zfLIljmabM6mfIdoJTVDuEdXdo3EiqMtLX3Ijsv/jXfy8i+TC/rmXrHdjEF+Ya7PxHgXUpJLKPW9Zjl8l5SxEc/hxNJZTvwb+R1OhJltwySNjqxrdYh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=G1D2wD+K; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="G1D2wD+K"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e5c92c389so484771985a.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 12:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784317106; x=1784921906; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RiZQbs+LeTBUPjzRfycx5zsOc9hplbGiAhbP9kI+IEQ=;
        b=G1D2wD+KZvztSWA/u3goFWQqG55tTrDzQBqmlt5F0iGOCrD5nuzZEhaOBb9Dszl64u
         eNgvFzny2Xm8Do3tCe5y3/E+qonPntuVENQR1MQnjn6/PvsFWesG9Z7HpJx/5Ixrt5FJ
         50MGl4nNkNRMOe6CSxL3MSe2XB9yKF9FQTzwkICEl9vduEAk3zDiIsVNRZBxX54OI6e7
         amUwq7zolixvaEnGI5M9noLut4JJgA7bCjvqxD8o2ZJ7sI1WIlNm6GhZl9/NGoEWKMX7
         HcwHORQjf9NYJB89GEMuboPtZemwV5ZewBfdXJZR4S5Pp4ndGibEB+hPAT2h4zAV8Qcf
         0gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784317106; x=1784921906;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RiZQbs+LeTBUPjzRfycx5zsOc9hplbGiAhbP9kI+IEQ=;
        b=G5CISKRR1T43y5/TBRXek69+4W5u2/s+rweFyrJck5tsawuO5d6CnZu0PxQ7kMVyGo
         93Bz6H9M/occxO8m9b/vxNNyDVQWN/KkRII5+t+PDwD3DPkGODPjLKbwSdWq7YTG/0BB
         PQ4ZC3FCSnkPWRkWlIto62XcDZek+ZAY+ewwV6gdqF2/km+Yo0yFqWfUNRLkbfFAB94R
         7wASG2EMrtctpuM9ybYOtoie62V6moDhAmpD8hvNff3sRjV3A1NAzOLAAAvOPryVqTtz
         diTXGK8dL1dV4/BgE4S2ugfxhjviQ20KOHyp5oAJpSR2ZHmv99PBudr8g8/GsQBA2ulj
         jwqw==
X-Forwarded-Encrypted: i=1; AHgh+RqASgTesfOHTXebD5piRjrSs6rBQGzpXXztTvbbWPpkF+SmuyIHPuaIjmtkZkNnf+LnoBSWaKLSf54=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrO2M5G7myWztAs4Wc1Rmv85YkKzRKlzy5dyEh2nUZFoKUwXW3
	/pBt1UDI77KPErd8qWlA3Cno2J8YWFPcVba3SqVJshgDl8GG22zD+4SXrd9MthexZ7c=
X-Gm-Gg: AfdE7clzFdAelAa9ZacDoB59b5ELWLrZRA75IqcUBQkudWyFNXHs+texL6unsu04B+p
	Z3f373XOTmeEob9Aw/MrN/5YHUmtxAXvV6lWCrk1zHyRueD4PaezB4xvSa/LjQxEIV9mMIo5K6l
	7JVDaCfC1HRPHabf1OF+L+FNF+yogKMpVzu2wAbysdH7nx3KYHaWikyEXNRqqrLvjrGKv3xrCp5
	2siH7LlNbNaMilKi3PKH9+UjWUxXhVrmiPKivl2eCOY65uxvRK4es+UfkXDD2pgASSuwDPbYa1T
	zqjrdOdNtCEEZwDZPDyYBxc3YeqeDVejQDP2ZTl7iY/0zEegVU8dNU6mym6nNTSJMkTouJOI7zq
	x+MmuBiNLIRaNByMTjMD6KgbbOzG5c0EHMYqkoQ2yOjI2Atmq24Cg9/gy8xQxc/kIV4z1kH2tS7
	A6n61SVpHvEG+wwGL9XRTwMfy1qH3n8VCXTzrBnLo=
X-Received: by 2002:a05:620a:2319:20b0:92e:c117:5ed1 with SMTP id af79cd13be357-930b431cdc2mr336172685a.81.1784317106546;
        Fri, 17 Jul 2026 12:38:26 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b5461ad9sm227825085a.38.2026.07.17.12.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 02/12] PCI: liveupdate: Track outgoing preserved PCI
 devices
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260710212616.1351130-3-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-3-dmatlack@google.com>
Date: Fri, 17 Jul 2026 19:38:18 +0000
Message-Id: <178431709881.189683.11618075685237566784.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=783;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=jsqG06VtS3z0e6bZDXnLFvK+GuvHlYm90fGXP1i+Rc4=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWoSv7CPVSgTbWNsDTFax6B9Q5Aiwar1MuXi8H
 x50paKyCOCJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalqErwAKCRC7dyhM23N6
 3vd9D/9LK37IfAvABvCB3smI016O0dV4EVZWcpeNUJPs9CXoBkx1Bef0DMELfdieowtWX/lZleI
 xBJjyEEYD1cTVAp9Zja352m0E+GSJZFaN7w55yvbXEfHV9Wb+1/lx/ltYe85mtIx9n9fwyYlfRI
 cCjhFjcK5JKexzWd59YK+m7BMK3xRXzT6+TR9nVUvVmpnJZbQTfy1g9AtHgNhWDIWuigLUxhLgP
 tQhOMUeQYgJjt5HieCsENdL/zFDDKVpq7YGmYkYBoMq1t3efoa8nwdrIZRvKII9b4HPgkjvk23x
 b+WVxvPZyeeIuWUsI/RvHNH76AcUzjK26tUi90y5PF7JSXQFfsu6n+NJPRXALO/L+bkORobGVLy
 oJHJRNYALyLfmmtP9iaFQQpO2DXd7YAlrUqnOM/GhEnZZ0SFXYFXFT3o5Uy+iwjdSXUsGMH66rz
 F/TkgJk6p9KD0noyJ0goJF1Qor4MRSKBziJCYSxFbmcnjSBiuP71TIuHZ+uFy2qYt4rr7Wz/lIs
 JMCpUM70IwXa7+7E9bW/3jCxbYEKT4aV0r7ZLPGzC0EPMlrHJuwBmS4WaKP5Z6CWIGyr5+Kpgs5
 arq11V5kI8UaDm+rqkudultVgSV24G7f/68wOBq+Vr/HL/P30cLAjMqvZ9B5WdBK3aHWce5vLci
 t8z3cfef0fMXsQw==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On Fri, 10 Jul 2026 21:26:05 +0000, David Matlack <dmatlack@google.com> wrote:
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 899758883dd5..03075ce06ac9 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -125,6 +160,157 @@ static struct liveupdate_flb pci_liveupdate_flb = {
> [ ... skip 18 lines ... ]
> +static struct pci_dev_ser *pci_get_empty_or_append(struct pci_flb_outgoing *outgoing)
> +{
> +	struct pci_dev_ser *dev_ser, *found = NULL;
> +	struct kho_block_set_it it;
> +	int err;
> +	u32 count = 0;

Nit, please move count above err, to follow reverse-christmas-tree order 
for declarations.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>
