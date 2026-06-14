Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3BB3BBFBC
	for <linux-pci@vger.kernel.org>; Sun, 14 Jun 2026 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781445467; cv=none; b=ejyPwVKXaIWKpIMqdlPg85ap2x0TcjeQxAIB7IuwXZX/yNQXJDZJdSIOd2PZhQwyEUoebgZ5NqNI4RlTp1E6pxPrLDjTL0iTLbMyZmFmABWHSmWgpt7xAV2MZ4aKBY7lU4/HbE4adtRmxX7l1APw4S8XSs25wTt/U+xPtDBo6iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781445467; c=relaxed/simple;
	bh=irEWipl5ns1PQEI0PQ7c6jRmzsY6W3c0XtAe+hBan18=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=cTwwxqCmCBNVL7mZYA54YuDOlExz3X0bdlII9hxfcwB2ZaSVQ22SFGHv+apJ+OFZgo6FhLeeMbQrfgk9GJqWU15rchh/hh4sNizszhSpfroVd5Jj/D8Iu2723RdMG+W5SNNBV8VLXRCdSxBzOrwY3e2GyYDJuUftwpoX3vG3GKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=YLzWLlR7; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YLzWLlR7"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-91587626a3eso289900985a.2
        for <linux-pci@vger.kernel.org>; Sun, 14 Jun 2026 06:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781445465; x=1782050265; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLWNaUJaCrsl1zSP87x78jJvGSQywThTy/hKOOZov1I=;
        b=YLzWLlR7uyAROZKIYR1IdIlmR37bn6/jKIS4qEhzOGAy1KhDFZwXhaZzhxgFhmXvrL
         6Ch0QIu6C5f5l3Afjz/E7qKA+9g4sCGgQ9W5Y0YNAbtloh7fkl46RyFjPBlL4ZVKC/kO
         xGmTxyHys9Xa1FaS5JYNPoGvtCpni4GgXSopguHTlmAAQVx8d16R+MLfpMe/mRsMzlLy
         iKgMfOb+5Ktms0NoszdyHGe4CUWWAaSGsE6xJxo9A3l9U6Trlwhow5VACM7gKTtG6HTW
         QirIoYFKMPVJkoUwCrz377LgmVE/GR/m6imm1a1f0r9zP7KRnh1b/T3RN7svsTFjwRHh
         pQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781445465; x=1782050265;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLWNaUJaCrsl1zSP87x78jJvGSQywThTy/hKOOZov1I=;
        b=LD9PNtWkalcaOdvx8MkFNUcQu6K7yMmYgpgA6sy+1wJSnr8bVDPxrMta9PwNdR5rXi
         rV3+Y6+VsoIrYjuB7XHSP5PHW3CxZmGncVXR9f9nvVknKWN6L+JMFtdFzVdiPAgHbhgQ
         q6sRZ1/yib9XozQIrX81bMshFQ0ns6txs2fLuiMVdQFZsankHVhOjBhQ2hgM9DcafEbF
         2sQ+w49M3xQUA+9kRO/fUti/7F5geGWRPsIIK2bdZnMGJ/UjD48GaQ9QDIELMAT9oK/s
         DlWuAhjpaLiv4jXkWPAq7v2rAB7rhM92x60N9aOCEsCKYx38yMX01p4jdBYkjnz0i9jX
         NCig==
X-Forwarded-Encrypted: i=1; AFNElJ/6p+74XD4FFbToVsXXKZi+aq3pjW6DrmJjZDoroQlYQQwgXkveeLnRgyemwM/dt40N0v6zYxXOUK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB1OZOiEYVr+TNIXzVnoXnyDD+F0qRbNL2gTH4zde0I5IbdQWg
	sHNJ6rQ1b8bOSZsgZenAlkP1cbIslEo/Ruopjar7GfV3lW7YRvEynT9qOzOzfXlZMHWKSlqvbGy
	cwwY3
X-Gm-Gg: Acq92OEbs82Xbs65EvEh0jnRzBTR6bZc8kGK0zIvODhwhXZayr62rh/mqzzvPXP1wiq
	vnuSqoN4V6kjAcKR/syM0tydKYZkamrfoJsll4RP31YvmKLy9ysUidwoltHq9K9TC8CG1QlTQXM
	ZlnAKLw5Rw3giyMa7nzeDzEnyP87Ks69wP1ofhSjvpPlwu9lmcw5/kfMoWF6FPWHl/SPYTHL6Mf
	3K65i2K4b2sdX7wmILcIV6D0nZbYBOQ/hOxWOBYg4XeOXRUMYPMgLHQ0bJv8JqO1J/hubPxeC51
	AZOazcxjBqh2ASd1Rq5YmovXMuytTAVGj7WLotZVLkhzyiq5yT3wjkvb8qoeIwXl2CvXEGh7Jaz
	DzkXdHwVbmtmGhfO9BHnHqg89CjQHJRZBFznFKAKahRbcypp/ii/GCU7wo+KhYHwe16yGJXLudc
	vk+lSj4c+Qmd5G7cZGla2MtKMddb0jWRU2+nIc0ep7pbUqXDcjdKKJX2U9wizA
X-Received: by 2002:a05:620a:2894:b0:915:cf88:1e3e with SMTP id af79cd13be357-9161bd3bcccmr1479704685a.41.1781445464857;
        Sun, 14 Jun 2026 06:57:44 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed7f16sm753609385a.1.2026.06.14.06.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 05/12] PCI: liveupdate: Keep bus numbers constant
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
In-Reply-To: <20260522202410.3104264-6-dmatlack@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-6-dmatlack@google.com>
Date: Sun, 14 Jun 2026 13:57:40 +0000
Message-Id: <178144546090.1266136.8524338598480624580.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=irEWipl5ns1PQEI0PQ7c6jRmzsY6W3c0XtAe+hBan18=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqLrNWjYliGNG1cbbcQyjqFHpsESyctol2Ow44V
 DNNc7IHDFWJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCai6zVgAKCRC7dyhM23N6
 3kjiD/sG69As1zhiS1Jh7oTEbv0MuNGQBkOQh5lHVUPS0gj+oBdU0SL1qDkUsD/9tAvcLQXxhY4
 /QEBcSzMRn2+VM2nH5sCYgMn00iu1wLRgHbnApGT8gEYefLC6tqiTimjXxxYEZXpQz9ApF3QtQ7
 uQ7fuxVwij6aGg2dzzTM5o+j0r7I05Zok88+cCVU2rlO6EuoInjgmjv65Xe6oq+Ds1zxZqhOecx
 ot6V9j27xklbNWnMVwGIEJdBHXJhF7LIartFve0H3o0TexujPaYa6bopI9KtSCGp9zJTyA0pQpK
 gNj34151bnveyddJ8hiUhPtMTv79KN5ncUVS5aJfGxPn/aFWbtqxiiOp0eU2mnJqh/6wNrM8cQ/
 NUoxJmWLdWzpvK3xaAUQMjvhqW56TPer7DfuxcsKhmOK0edcg9c8QgScp5vl6gu85NR4OeFHf1B
 kKZPXsYx8Wp75O5nb7T0vLt0ObMjKLsM03C/GOUWMQVcDp44U7NhXWs++LiuSgyzxtbuoRturS1
 ao58aoq9qHw1Gk4BTfu8Cxz4xPVAEIaydrmMgiamFRw3PAZUYr1WUIZUIQbwfaGlWx4ERcVXuLY
 aXr04c4Tx1rxrNZMN32g400K0heMVZ+AZvJQ7vrmDVSnc3QEXEoOT45iZ03sYksa0HWdCPAbLBt
 te2BUIp8i7sqexA==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On Fri, 22 May 2026 20:24:03 +0000, David Matlack <dmatlack@google.com> wrote:
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 4f2ec6ffdd16..2421bc218916 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -103,7 +118,7 @@
>  /**
>   * struct pci_liveupdate_global - Global state for PCI Live Update support
>   * @rwsem: Reader/writer semaphore used to protect the incoming and outgoing
> - *         FLBs, and the references to them in struct pci_dev.
> + *         FLBs and references to them in struct pci_dev.

This change does not belong to this patch.

> @@ -396,6 +411,72 @@ static void pci_liveupdate_flb_put_incoming(void)
>  	liveupdate_flb_put_incoming(&pci_liveupdate_flb);
>  }
>  
> +bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_dev *dev,
> +				      int pass)

This function requires a header comment; it is public and not self-descriptive.

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>
