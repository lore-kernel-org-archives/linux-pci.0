Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0503526FD97
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784331141; cv=none; b=kDmhEjhc0pB1oshF2aIYFs9hNfO8zluhohD54xxhZtyhzY6l4KeFl80SklMJnGtMUrPiQ4UofoqTPrSdZI0dhRXqxJDhaDW88vq9v4t2F3jVOt+x7YJjZaXbO9hQ7SC8RJPbo9ywtV+syO6pyEc1ylhAvfo4jR1mjnJZoTgKFOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784331141; c=relaxed/simple;
	bh=s0LMm+OcoPpmqRB57FW8WPIACTHAgSpt/ofOePUvqwk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=rAy6/UyLvbT5QVTYVm8BMcbS83GLODgaN0JXO9nMfrrw9MYZjLyCSTfAGT2M9h0ukgBMbczqfaCmvVP/F5Pr5KtknJiyCxqbhjARBs/EWZfFLrjUY1MFH2Lw4J8crXDhQ2e/oGyp6KtlD+H+xas/j5BX2Xey0qfbQojanjE/Xkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=OEtm2LN3; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="OEtm2LN3"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e5d50b0dbso381140085a.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 16:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784331139; x=1784935939; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R+DUQOwOw2uIV4ajc2HeXFDWOg42tRR4f3JX3Z/V06A=;
        b=OEtm2LN3Dsz9hqIcPhUOPubE2FmzPc0aKumLQKhlUBnK7oTCcRu35TWCVq44o5685B
         rBcgA3oTit8bE+bOLRCfh7GTrMo+xqlHe2tqlKFUaTeHD0vey8o6/FLCPtu0mFqcqXip
         6Q7siChD40hvvjgVDEHL27pjkOxjkNUKdLhtOw0Cujogo16+eGSDS45daVjlE8IYNbom
         3WDU/fCVyi+iXNW0fgOehju2M1RFqAWc7vVxa9gTAGJgzldQkAH7I6lli9ouPALUjbjI
         JSnex+GZDzffLjDcery1Qu3loDCtnoZ5ZL2w1QZQbWfGdD/tBXquIwxZRZnnCdsZV5tZ
         QVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784331139; x=1784935939;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R+DUQOwOw2uIV4ajc2HeXFDWOg42tRR4f3JX3Z/V06A=;
        b=Z6qJS6YjyNLbFL/PCzoz11ikXl2bg2IxNxKv1jYgue9K25VSFXUWTzxR/1GgYg7psJ
         7ITjL3Vc2MaQtsoRhcNIsgb1RkDBBU+1ZbPBXi3fAQDMbftQB8B3fhwFOnV/5gAS1xNp
         bQKZTsMjjUJLtscFlpvhiZDfCKoagCJQlRhAOSjLH2FEuwEq7tUqDBjn9wDCfCKoAqMh
         2AJrJUrI56WC2cuoaQFd63dEn5l3wMuAHHwbLGGcKQnnBiYNr+45VblZiOl15pelPMah
         rTY6dajfBzNsThc8IPgSA3rOoVKOHPVRbMyopxI2va6jnw12c7bKmMuD9KEEpdvIVodr
         Atrg==
X-Forwarded-Encrypted: i=1; AHgh+Rolvb2vjSz2lRPF1zXpcAIPOAnT2eTY4ymJ9ZPs/04tPRsKIj9fC3268rb+40QwYlCSAu2c3qx+RfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7yp3VrpmNNNYS07NE0Iqv6gvJmesJZ0bBbNSbCk4c5ol2zcjO
	RlupxFoHMAU2sa8xswYLqoFBdOGhSk9nAZ3xgHl5VGHagMg9/Wg96RCj3Mm+ck8xvGftwudyf28
	knpCX
X-Gm-Gg: AfdE7clVyKNb3k55Yo+VzhMpUNzEjtNdlxLJ0zUjuxBJ80SoG5R/bjzsCgAxGfDJC9P
	Y0WNxbmd7KSWgvB/dRZDAfm2LYmRmyVb4B5liK43ZC2Wo2CRixlultSGYMyW5bUPrjQqNlFaV/D
	sxiqKMvqkus82XoCnwWaTxEWAP+s6aCcF5ZjzA8Ej/tw4c5UBQNZGUm6zPKB5TrV+HezLri0EOR
	fySgWoVvP0SHsVVJEe6nyK18BZGZ24FwvgA8WrJetso/hd+IxYmq3qtMq+soX9GTcpZWwJyl3bA
	Y1/e/IoRhRCHJLoIHQxX+BBfVBpFWiIFwFnZbObgQ9SsHCHPPYK5hWxr/gpxiI0OaGpigkr3Bin
	aOus1wQBhfhLQcD2oZjSQeDGcM7WfAwBizzJ46fq1wRjnwXv6hlYZ98ko0JTz8hglWvFhX+CuNw
	S8MBWKEwruJpdyeY/dtnO5vFwP7zlOh4VIpVo6E/Q=
X-Received: by 2002:a05:620a:472b:b0:92e:f3ca:2ecd with SMTP id af79cd13be357-930b41a0733mr524243585a.60.1784331138856;
        Fri, 17 Jul 2026 16:32:18 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm279957485a.35.2026.07.17.16.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 11/12] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
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
In-Reply-To: <20260710212616.1351130-12-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-12-dmatlack@google.com>
Date: Fri, 17 Jul 2026 23:32:15 +0000
Message-Id: <178433113516.189683.9930130364443329744.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=563;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=s0LMm+OcoPpmqRB57FW8WPIACTHAgSpt/ofOePUvqwk=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWruB0abwGG0XPrEN8HQE9RCrgd8/buD859gp2
 KaKebSgf3WJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalq7gQAKCRC7dyhM23N6
 3mj7EAC6bErgn8QbHlK63bz1p0Z8+rEQtPpeKYfyZoG2uWv9cDi5gkXPAA2cyXTEg8FWk+3dxwk
 y6gytV5WrSayDd6GSc5dQIvNqT/DfySvbzgAES3hjQEYplR6GGXtAvSOJrQm3brDRl3OO/+Jyt/
 RWwegnDu0EtMTwd45jI8iO64zYNbU6iXPDmoo6XX85I5an+0rvaOq2+751osnajpvrUctCRX6co
 rct8df07a7hqEr30tX3CdeA6FpiPhXcSZdcc7Y/mdkIvSPqDsKQWLerNa66FSM/YWQRJyQz75aK
 eh1RdPuqTNnMgn57asyEoYg5pPIxn2wSy1R2+6bmZnsj7Bfhs8kivkdPulT2cq/+tDvb/i1R8cg
 JRhN3kONqgHydgwy6TrTDZQzDKLE1v70UqFkEmihAIJqaxEBEeMylAu3uuCt/3Xf/N8ePqlq4p4
 Zl1+UFEzR12poe688gj93wg/k5DYz12wvCyUaVd1ftxDmqLc5IbkfD19MjDTMA2VHhZ2dygKp+5
 jBzpCI2Ct6WYvMfudLSRjaT4vueHL50oW8vh8gE2xIOaoOwkDXSTmru1jcXLEpWZBDxDnjbHWx2
 A8HHgGX6czH1+b8pT3wyIyMQzrFYbow7ruhbDMctEsSZ9cOZE5vkRTllxa+Bfy5AWxoJFldiSFq
 vnDsQy6niCySu6A==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On Fri, 10 Jul 2026 21:26:14 +0000, David Matlack <dmatlack@google.com> wrote:
> Do not disable bus mastering on outgoing preserved devices during
> pci_device_shutdown() for kexec.
> 
> Preserved devices must be allowed to perform memory transactions during
> a Live Update to ensure continuous operation.  Clearing the bus
> mastering bit would prevent these devices from issuing any memory
> requests while the new kernel boots.
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>
