Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF6E299A84
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784325763; cv=none; b=M7u5X4+tXjx9tujydom9ofUdd85b6wCvYSi9l62H9GsAFs8E6Ww1pLWzWjSIC88rXdEfxf2w6bTt9uzwVfMPh6snbWDuaD6tM8I6ymUWN42UQ5BLa6F0rfPrU2s7C81N3FoLNeGUEQGIwt16NT9H0c29GYcNVgg2c7xlsM+NpaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784325763; c=relaxed/simple;
	bh=LxcbZe7BgnncPWKoPk5gxZGS/pQMdASC0LgCixjRw3Q=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=e9IiQhB2fCKHaiujwBTvsrziO16OVag2mLaSkgceKwWhX9DYRLrf830yFuPg4dUk0y06Vxpof0BOm//h7yG0bABeEY1AqiJa+Q+3xMUydQtSsyPycXyJUPOvkZFV8T08NMKPCZ4ij690CczUTAXrYsD2q3cUyGFtzORHuolkXKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ROU/9jFB; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ROU/9jFB"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c2cce930cso48421091cf.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 15:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784325760; x=1784930560; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HlCwb+1ZnQlT8KXH+VzgKgpVkzFEV+OYr4Ev43BkCgI=;
        b=ROU/9jFBhTKMed4ivYwVLd4Fj3zpN8w7Q0sedEggcUepLZwu73KbZETPQhoGQOjaKP
         +Ez7sh0ys+CRONjZ9La7yrZrkrT9xHjxVQqRZQXtKn/YMUY8KnTJc6YRO1IUsLdr/PzQ
         dIHSGfBY0dKhmZfoIGIxKc90boJLgSuSbndwVmB0sKMVE13fq6U2dzL2Kg5YMZ3CoC/C
         LaDuDxoHLWA0hcUySyFTY3f/zEjg9PnxndM1vm2VEXDHZNARWbQHkW+N+bdt/nRyjd+T
         TfeD0SQc/TU1WIUVISGAFmie8pacIBkEE09hlKRbl1gMrkw9r7ynNZ+S5K15TFouB/zv
         zSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784325760; x=1784930560;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HlCwb+1ZnQlT8KXH+VzgKgpVkzFEV+OYr4Ev43BkCgI=;
        b=dh94VV2XQVKlNUw1uo4islSWKlKeiw7uc/9oSCy2GNx4hOSBTyHTsohN7lsgtS93hN
         13lhg2rjCC1s/5DJY/dzoJdBP6Zg2c082Me3ScqayDOu0P/Tb5iAjQiZsDpygPXw5Go5
         iQrorRYperV4q1StaJlSWFncw7zW04HzlB3/yvpIdGhM0WA6M8UxtT+V3PaIvqfBL6Yh
         UBwlOMK44F+CmFpYk8lKOVRVcr8dkRDZc4VjPcMjGrMvlogqyZx/gEmpRtx8+mC9jIuq
         lSSSiiRyUdHlPrGAMByfRZQdJQgB632TBPTaQMedW23ou7DZ1sTHcL/v3mSffK9FjBrU
         lNJg==
X-Forwarded-Encrypted: i=1; AHgh+RpUFfGsksgeZ3uX8mmkGol4XfqSm64YARg6VbWFOf6DvYmXYuFWFvP0EgHCVGECaDTfxm/Dm+ZEKB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztFeNAzG/GREGXdpyhLadV+R/O89P7+43C/nlx2X67NvcUynmO
	XXN/j+tKWw6yRX2z2T6BEoRwaqfdyJ6DsXxdJdTNjMB34EOSsk7VZuyMwVSAknsx2s4=
X-Gm-Gg: AfdE7ckfdyOBERBcCxyzweYewfJhpW6XO83rId0GsGiOs9TKkus1yS0DjoJgSvtUWQM
	SzRstQ3JUT8J/VF8m6zBRTdbf7Cpka+99F1e6c3W4QhSjZitcukqreaqNipMF8t/1L+RySoc9xs
	CYulRlrYkwN9g8ciOF+BMwXArbt6+rALPCH09wlGBmXt7JpOM+re3R+Fh3A2lCD7oXNDpqsTVqO
	10sBmnSr50LWS/Nwd7fzBDS0m4/CKEA/srt9o7VMUOl+hSH4rvK4oIkhFqvmhy4+lKaZ1NcRZ6N
	BlHria/oDpWSgz43q3+vKSRZNCSZlLfEz0rnwFMRIH85dhJmKXIqGYHWPGEBCSVTvQosvWwfS7r
	HseGvW5c8RSCfxJkX+AF20A3qNkUlAKn0/3Jnz5D06xlgOQfxXMLDhlgThpYQxTbxxKoBlythKn
	rsQ7aidUJ/c1NJlYdEQeentdQfJRc2zAL0FxBlT0o=
X-Received: by 2002:ac8:5f06:0:b0:519:51af:febd with SMTP id d75a77b69052e-5213f668ee9mr42987041cf.46.1784325759954;
        Fri, 17 Jul 2026 15:02:39 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214f016aa5sm21849151cf.17.2026.07.17.15.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 15:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 07/12] PCI: Refactor matching logic for
 pci_dev_acs_ops
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
In-Reply-To: <20260710212616.1351130-8-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-8-dmatlack@google.com>
Date: Fri, 17 Jul 2026 22:02:35 +0000
Message-Id: <178432575544.189683.9290455764634301119.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=586;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=LxcbZe7BgnncPWKoPk5gxZGS/pQMdASC0LgCixjRw3Q=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWqZ+Wxzq3jD2mMABNI1669A+3RszfBn3ErJXV
 Y50TeZzWEGJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalqmfgAKCRC7dyhM23N6
 3sVSEACDLPUH2+MHEoWyXAsDxYRkVARIRC+B2caZvvSgXaiLKmKi7pEnnql+8FPdsbwKkqRf9Jo
 dQ2qaVmpxf3l7ARpfkVXvpF8obibHQVOtxBKAkqoFNEHzWZzOBT2vYoywdcdcaiRGpZ8X12q8Tl
 TZ6s50Ini0rYTCvZ6zZ0zyslIqeoYN/w21C1mnmLJA5l/oSdh8oF+nocO9jyy1UkYfclKEmsVfS
 aASn9AyStUUOLNMQvuee3N/W+Er5iAx44Oxg/HGGBmN+ofL/MrxdUAodAIg6NbpN0q5+5fKvDvD
 3KJcKOTnhHwhzxV3DvLnf1mAjYQ/jx4J4sTJYd8zPRCFQzvZ6IDSdiVzymUbhQvcVC66zvWuSgM
 zuzoedeSeAq72CoyoWiZ8xLA3hfJyhDVh4pzPcDA46ZJ0AgW7nAoqHiYNPJVCbtB2qPsQSNgU4G
 1APtHXn0r5wICS6gPX7ZNcb7gNjnMcy6DZnrtpb/EgW7mEZr3zXxyuTeJrA6i3CogY5HCwl3avb
 k6g3LAvAnL5AhxIdAkfMb/JyCoo7fbWVvu3QdRJZoo4BTMU36Y41oNHHfuKo4IvKo+GpHaqe6jl
 t0fLRciM4UeB0Huvqd6ER6xDzWL/FjnnKjzHSJX4hp19xMTADl+jaeSlOdLUWzkPxqF+6X+8KBF
 zC29UAmi2lxznvA==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On Fri, 10 Jul 2026 21:26:10 +0000, David Matlack <dmatlack@google.com> wrote:
> Refactor the logic to match devices to pci_dev_acs_ops by factoring out
> the loop and device matching into its own routine. This eliminates some
> duplicate code between pci_dev_specific_enable_acs() and
> pci_dev_specific_disable_acs_redir(), and will also be used in a
> subsequent commit to check if a device requires device-specific
> enable_acs() during a Live Update.
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>
