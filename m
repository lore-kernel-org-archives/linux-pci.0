Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B663C392C4F
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 21:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784324929; cv=none; b=r+OqW4H5YZpfskB94OV0owd9sU/9c1oMTXfo/NbxIW2uK5X1GmGi1rlZ680Bsr/sfK90hqvTGkGsQzmKDKIKJRoxj70MlYlAD4i5BLOKdLfb0Dt7/G53XRxx+xgdkYX5Z3mGmYKgw9abA7HxAIa9c+PyjYLyX56gCzr6Zy9iehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784324929; c=relaxed/simple;
	bh=496HIZ5NHAZVhZ3LL7qzsW0iuwhuVPP7StMDlrFgMMk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=bNlsL87yYVFwV1kbhW+kn1zBsKgsh2VFzQ25sBhdTsmcTda8JqgtHKMbRKZcBe/uIgVB1yvX9PUmO/cK3XHIANR/QGcewctUQEBTmHGN5SqMqqA9mGMTuREOkO4l4srYvdfx4uxLI1T3oyfmlxQqhsb7yUPO9WB9iHj3hA+GDZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Dyh4dB/2; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Dyh4dB/2"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c0c68aa31so50672201cf.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 14:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784324926; x=1784929726; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zmfnNFiyVA8U0Zovz7XobfQoJyevheG0HUiwPSbCO8g=;
        b=Dyh4dB/2oii2ddBD5PqYjp+8vpfz0CZg8YySu0rn3tpeJy/V/+6yvaXZwLNxQExJb3
         WxRTWVEy2mvyNBzcRCnaMgeNto/hgBiH90mSYZMdMwhiJkzPIfqmcwKJKhc4XV806fj3
         kyQqTt7CgKLcRGvhcLpV/lKSNB7oILemFlGR1VakdG6xFiJgS102bCsPLWzWPchDTn5X
         YlQXTis234BznkcgYkD0uDb7sfwSpNokOhD53PxwC1VXgWIFV/WkI6SsO5Yq/oYoEP5o
         h5G1H9BrX2GiT2R4AQHPdWVIsUNfw6AT3IhNZ1092yyB1hG54b8L6tAJ6NfzWLOIjQxw
         2MBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784324926; x=1784929726;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zmfnNFiyVA8U0Zovz7XobfQoJyevheG0HUiwPSbCO8g=;
        b=aTeF8zBkjMpF87Xc8y4YKgdwt+ZK3d03pPWJj1Nib7+AipUSG8CpkJR83Oyr2aT9Yc
         bMTfrHjs+tihd6g5U3rl6uH9uFnJXMSCahLkbY5LRvobWfapNFoDmF9AecidMJpLxICf
         bd7Iwcr+JTBWUemgtlB6JU3Yl06HjYt5ijKTB+YnBZzwgOVRhlbfVbm3hGx4+xRqqOfd
         c/LOAV3O9OK+NNmXwAI1zyPRA7/VE/umVyCOG4IdxG6edcFmEynDyFQGEaTJ9WMrjSfe
         oQWTD6d92YYakqfq6YFnB5rD0h47S5kV7Nu/4v27HX4D6X07JUFJOQGWJi+kpsmwp7an
         H0xQ==
X-Forwarded-Encrypted: i=1; AHgh+RrlcYi0cFPeRJlrXXrkkY2ARTQwojO8HZklR+OjujM5D/PB8HWZM207TkRf6cIfm014iePwxsEUPeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUyL42dzPP07Wr/WsSULx4EQATkQoMKN+d58NozeFDcqwDAWQh
	S7N+3+Q0LgYBrmZYaTAk0ioXkwhQ05PT7Zrnx/tFxsyK7c5YvZvZDQCaKg1UkvTuvtk=
X-Gm-Gg: AfdE7cn0X1Jpp7fJLmJhadUtfIqd1MLeqgRoCsVCOt8sfcWNka/gmy+v4iFJiLYk+/7
	T7YyTqqRNVfZiarDv6iF8IXgKoMYCu+B5sQAiPRLbXF/+91vbAShwONy8TrLHFtCb30WpNbrX4F
	7MmxFli1xwSHpbC6A9c6JQhuJN/7YvvTS2VfqUpGXNofT/yHL360DBK3lXkoAIOwtwb4iOJ3ISm
	HwctRslxuYGWQbrjxDJ1M8yg2Ciu/5BOb1tuCQtzGPuY7EENPokt4eRAcLs/hS6vZaEcf3dFx/S
	h+QgUmfFg2YQrTfhzt+UPgT5NTvdYKBR1z57DFAi7/6rVYN2ejJ+Rj9R5Nx5RF0Hl8ADhe66fGm
	n/g8RPBUvniybRdwZa5QTixwwe/9C/rXGVPC1Rgl6aKTdbSzxCPV9GCddYPOXiJR92l4JoB6FOM
	CYgxFNjOU88nLpI+TCDcL9Viuh8OVyxYfl+3wg3WY=
X-Received: by 2002:a05:6214:4284:b0:8e1:694a:73d7 with SMTP id 6a1803df08f44-90778380e0fmr48191416d6.24.1784324926660;
        Fri, 17 Jul 2026 14:48:46 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786f79e1sm26338696d6.38.2026.07.17.14.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 14:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 05/12] PCI: liveupdate: Keep bus numbers constant
 during Live Update
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
In-Reply-To: <20260710212616.1351130-6-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-6-dmatlack@google.com>
Date: Fri, 17 Jul 2026 21:48:42 +0000
Message-Id: <178432492211.189683.10563224295975168718.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=934;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=496HIZ5NHAZVhZ3LL7qzsW0iuwhuVPP7StMDlrFgMMk=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWqM86KaHlniHcC84sbvvlVrTWaav3eU4iNKDj
 SHnfSycZhyJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalqjPAAKCRC7dyhM23N6
 3pAgD/sHtZxz2X4+/Faxm+h83v6Zqb8OrDRH1Mq0Fu/Ty4wrIDO9AUyUsVw70fA/N2MvHxp/1Xp
 KSw01NVB4QDW/o8OkXnordoL06ZSPy/CN8pA4ibrtaW5GTXc0HvVn9XjzLb5TpkRvVQUFoDZlNy
 xqZQfN5QkA5t46L/QfCx5fVPGdFvvCf7gpOQ3aPXbygWPYWSjBL7i6noJgIm8o7tHCxqOCtmJpS
 KLj9FwZbnQrxac6ZagR1+sP2hfHfTsL07j8Xkw3dqdwDw76uuBV3ulOvMvLHk3xJiU8BQmb57po
 lsovpsci8MA+2Nd5qdOYySDGKbbyoTcdUVGqI7ynPmbWL2z6/i/AoYW1JgUN86kg2moCic79wqs
 5LjPhY13xc59vZIJn1Xcd+9qdGgfK5FHgXJ246tswyKVxFHB0Fom6tFgtrU/3QwZeD2Y9dcSZwd
 UJP391ZDKWNhdRK1FDFkE47jOg9y93FaurAyMhna+kJORxVLU814KM6CtBCoIQAwjPE3q+SFwKK
 74v4OBYVRxM7McuhNVOnSHLnObJdMRoYfVJheKPIHNs8V60mCzqr8vQjLPpQVkTZWWxup01Mbxq
 yaOhEnGzX9FrYRbdujMNfroiOD9ejkFN1MRBE6SzdTWb4+cRb6JylvfqUF3OT9qHkmHG5WBvAYM
 euocaROZ3nCR11w==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On Fri, 10 Jul 2026 21:26:08 +0000, David Matlack <dmatlack@google.com> wrote:
> During a Live Update, preserved devices must be allowed to continue
> performing memory transactions so the kernel cannot change the fabric
> topology, including bus numbers, since that would require disabling
> and flushing any memory transactions first.
> 
> To keep bus numbers constant, always inherit the secondary and
> subordinate bus numbers assigned to bridges during scanning, instead of
> assigning new ones, if any PCI devices are being preserved. Note that
> the kernel inherits bus numbers even on bridges without any downstream
> endpoints that were preserved. This avoids accidentally assigning a
> bridge a new window that overlaps with a preserved device that is
> downstream of a different bridge.
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>
