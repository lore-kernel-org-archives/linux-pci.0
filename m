Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8520C26FD97
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 23:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784331042; cv=none; b=nsPKjVigpk4aCvFyw15VJfpA5fuDfvIREmNdsaomS2ErBiJLRAS9ZvksiTRYQeuB7alTCq3hfyTvS2zPyYu4CeoCQkgVkMvJ0eVxfIgqwsGvDaDo3C4zWNHln1mJ58TDxjr7Rik29aNN8JqmsIGAMl6zQVVxIsHX3xab8/eBpzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784331042; c=relaxed/simple;
	bh=cwll5ojRGw0w+GA5kxbSjj8gBXVrPV2vP/bR+u3qu5k=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=I1+9JRRbU3JXkpObZV4CuhYO7OUyz4H42IMZmWn2S8Fk0TkuUU+2wsW5WqKG0eEkBVk8pSqJdWANMmc4kLPLKMZON9+gQqs4GzH9C+r2nUxwEs1kafD1HHZpDQxTba2KP9daFYc3nStZxfAxrxViOWj/BY3iMOTiBgiefNdWVpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=hGcq60R/; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="hGcq60R/"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8f186025973so90644026d6.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 16:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784331040; x=1784935840; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PEzgM2Gr2GnhjRTo4YiC2+4P5iEfgV4/tsxVcY/iHLk=;
        b=hGcq60R/ZyH68/IqvZwygi0rxNjXGsOfGgtRiqiQ0BoJ1xj+V6FgiV33yhd7EWj2Ti
         2oNiR4w9ELb9fGZ8+ZRmmWTfzwN17sKFehaCwvRP9mS+PuxWrCi/x+qGsKwOgetVdl77
         KUPBe8LoJWWvYeH3/G3U9+jMyK9UHW3xACASWhpDBIfQBSNQ5Swq29TB/wnAm3ZEboye
         KSyhaEI80Ltd7r+B0eczrE7E50PfQfg2ErIsUtv91gR11Zt+4CapcRZ6KDnw9ahmHtJl
         xY7x49uFCCMhO+qprd0UBG0DIO7K0JB8yWAr34qhAe5amqqNEwcKyZTToUiM8B18I9ks
         w1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784331040; x=1784935840;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PEzgM2Gr2GnhjRTo4YiC2+4P5iEfgV4/tsxVcY/iHLk=;
        b=eDt9WDE92MRXTyHlyl3tANJeSLcoMRL7YGXpBeZnJY2xwGK+Crf42LCyp1MHKApehR
         NZaCFqAa97tmXXgxoFxZg+d/yEuQcMrTo9MS9hfeGyHPttzB+nlTJIYkzdQfMu9xQ3zG
         JlQXp+g+HPG3cIIvzGY8wkYom5uCKUYd+1boHGwSyLgSv5+2A9c02TRWu7UPefjyjF8L
         WUzN14DNbaoQg9vtwIqUQ51fs29B+CcByQcol5nTSZMBNorpoyPaXeECFEmhQ53l/p32
         RGRLUSSvWeH+kJQWxHJJgW+ZrU+fD68iAIXB/m6SKYMCQsRzakFpDUM8QhNzHlYDQseU
         oYZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq9R/z/oWxcgUEnGC2nLS7hAdEmYrrdKTg5woiWIv5txhog5opQ9evK0uJS/W2U//nHkvgdOgf+2B0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6GGkrP27hLicUzcywD7kO5Da2KAqe7QjRrs0TnZxXBP5gtRub
	SykrFCTMIgjUrv6m62pHcVDIc+qr79S2zUAA69thGQP/56+V9Dy7SQfgAORLhHxYLvI=
X-Gm-Gg: AfdE7ck4/rdhC3qeTBVADYC8MoStj1bMa8y0WK1qzZJm0gMfc0GqHvCTJ4AAfleyE5U
	TtCsGIXISRNXkgEdEECs6ceETa4mdkqIXEPjCKG7i+cdlRNGvBPyK6A4vrGEsCCnUlYJxEM5CBD
	oTbFRjxmvqgBPpUS+SxFTAPNZoytJsP4GNkxBv+7+hgIjiBEmLeCu0LMFvDNBAgorRk0DG2AOEZ
	Dl5gR8Aso96QabZPN2LT3tLk+sDUjyxuWOAaR0O+39yTECds/CI8jL0B9pOSzyTyTveSU2uRTLg
	MdS+H5zymaS+cvKOSBt1WCl5zE7EBQW+DK+m0uQM+dc2VtlnS1eOySy9Gtd5d+LHPHkvcKcKYCk
	J5LMR7J/3VkorKNKRpkFgsUbbEN5ZWuaZlSXHm3xOKPSvhU96mCVoTgmZOaBJ7EySWczewV1ZUh
	nlHXLGb6J2U04bo8cGW2PVgjxM8cq8vp1dTxJznfiGmTY87CO6jw==
X-Received: by 2002:a05:6214:4807:b0:8e9:f5de:d619 with SMTP id 6a1803df08f44-907784da90fmr56797966d6.56.1784331040363;
        Fri, 17 Jul 2026 16:30:40 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077871f766sm28579206d6.46.2026.07.17.16.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:30:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 10/12] PCI: liveupdate: Freeze preservation status
 during shutdown
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
In-Reply-To: <20260710212616.1351130-11-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-11-dmatlack@google.com>
Date: Fri, 17 Jul 2026 23:30:37 +0000
Message-Id: <178433103736.189683.14104484157018816623.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=678;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=cwll5ojRGw0w+GA5kxbSjj8gBXVrPV2vP/bR+u3qu5k=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWrseW7SPwOTtm1kzcWpOdZF2Wwm/mTro1PbnO
 BhI22jAjkGJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalq7HgAKCRC7dyhM23N6
 3iBJD/wJ+nRxR75OuWW3wtpYMQDKol4uxhjUSJYUOuyvweRovjjuACyx9p6/PrONMDh1yR3KCBd
 XKIIq4cIDra0zdFAnB70v+teL+vUXwgXL4FsjqfeMNQ8RDk6BuWEogaq9ED/vIKwmxiIuZ9Idel
 XXiHuXwwUCZZVKAJPpJ5JHzLLjUAH/Eii8tu6ckH1GUH2ePTX/r1nnhchIWg4HGnouD8HC7tVME
 K0whSSIfgfycSAHtG5cYny6ngWHUdXYOI2Q3a97FmnB+RKa4g9Ag+Llm6iMKYom4/9o2j9qUZ11
 d0WDFsVH9gW3GqSqnetsBL5L/c7OnEl/RIqGUM0zlYiUb727YtIfoXn9DpV6Z8+yNtrOm9iPgS5
 Ie6dckeuYoLHiVGduirWtSb250rhL9ozPyICTcqrg1woQo+jDQN++SUWm468PrJgf9qtar65lrs
 RQfzXAbY+3/3hrHs2GRzm7GMouU5Txb/7bvq5xX/5eX1vUtgr3A3WPkrfJke6e3Ik7ku9IObEJY
 NWG7xDzQqedcXzxVUkEpCq6BuJbQNJho9WV2Mj4Wlq0Zo2Wp/VywDc3HycJz3PTw83AIiyHw0s3
 qdw0MrqzDnG/Dyk4El1d7ow5KVN/N+v7DmdRb7U8qmLDILyi/hHxAefi4xjmVoU0+trUeBFOWHH
 2SrfN1XBYQ3BnJw==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On Fri, 10 Jul 2026 21:26:13 +0000, David Matlack <dmatlack@google.com> wrote:
> Freeze a device's outgoing preservation status (preserved or not
> preserved) during shutdown. This enables the PCI core and drivers to
> safely make decisions based on the device's preservation status during
> shutdown.
> 
> Note that pci_liveupdate_freeze() is triggered by the PCI core rather
> than from drivers participating in Live Update so that all devices can
> have their status frozen (i.e. prevent non-preserved devices from
> getting preserved late).
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>
