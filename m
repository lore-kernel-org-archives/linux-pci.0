Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2298626F2B0
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963003; cv=pass; b=eoY/AAIGIJ11ho28OuOacDZDnOgpgP6NmbbHlXkuJHA5IIBzyurrWHdO1gONOvvMEIWbYran4oww3fVTB3rT4pP10MWUtl8X3z/MfGQi8nzRVMsCzucB56awP/D9lMxRBjCi/mTKIF9BatgX9KY5yndG6iqH/qmW6wLH3rAD4cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963003; c=relaxed/simple;
	bh=wOUZWaGczu1/9uaxYEVARYEnkKkoCC4ryISp2FSTVAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8bX4MNPBLRUdBOq3vC1+ii2KpYH6M2Zp3LXxkgx5ft8ra8y/6+ns18Pn9M7UroGejpuiSwU5ijyGy7KazER167EMHM08vBDNb8dU7t87JM7EbnHnfeyb6Mq9QisCQHG71EG1xbA856TbtdTsdS8+gu3pMKFcjeIxL/eYALIXaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oY944fAD; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oY944fAD"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-697564cb69eso197398a12.0
        for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 10:16:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783963000; cv=none;
        d=google.com; s=arc-20260327;
        b=Q5onrbSjnklBAhFr5iHOD3VLoJV4jsFFtKZazvXTCideEqocCy/4fmQIUqFnU3J2Rc
         Qfr/eHWnOhp1PTABT9HHKfj+GAZ/IHknc/QD2y9g2X5wsZKftBuwwAgvZXFnNc8YeEac
         K0Chtx5mMH3OfNaeTxwVv0/6HlmQ167TkuhxgXSerOQW/4P9L8uM0vAWW27uqbXTrhCp
         W7xYpJSSC+uyaFYj2oXMa4FrzUWnttW6rfqPq80KRAJoiEInbayVdVYAlnzzpsef5xsR
         g+qTP9EydY2bPY2zHqLIj9rCuxm6PlVUP4l6l+h8IMxB5q7gtds8LUBzRvETMPz8Ttoq
         9hHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wOUZWaGczu1/9uaxYEVARYEnkKkoCC4ryISp2FSTVAQ=;
        fh=3cRWA6/0UJByWeqil7/IxuY8MDagsLfC47FmjRdE08o=;
        b=hauXswKe3MnGiHzjkIwTmeQ776Ja73J/kNHAP0xKltbnLK4WMYNPGrexuQ64mHB/vM
         lt8Pm5BlAIypXH4hX7TmadimfBgi66qphHW/yq24bEVQBqeD92TWkxrtw6KCvBb4f2Ru
         pbJoP32VCHo5QXD0kPvX9mJ9iejJnNXzn+CLA1nZmfwDSzsySFs+DMxAgTToEqhAppej
         C/oa4cwrAGtx7kIoehk18ZJU2h9o2mKdNvAYaSAxuCWGszztwmrLaMLAcq5DC2+rp7rQ
         QC4TDfonWld1U/MaRrKjHBm7CN5YdPoC5hjP8y4a56WFqRNB1cqaVM2SoLNsOB2FlICh
         bZyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783963000; x=1784567800; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wOUZWaGczu1/9uaxYEVARYEnkKkoCC4ryISp2FSTVAQ=;
        b=oY944fAD7e4lRnypFCcgcgdTlMC2VWL46NrRnFV1IbIERMCH9V64/QKV2POyY+Jjxc
         qAmbxEUMfm2HDQx5pGByD5je5Bvwxz30gaYbrTmbgRRH0HoosisSN1RpzbHoFAGbMbEg
         6lM4FP8IpVIeco4JhGH36LMI5PBYJJ6h7nawC9YbufUbmndrrbrbN8kStmb3Ww9H7ysW
         TAO1dTaFM3bazsH/Y3/5o9DIiYaeAT3WuNa8fCUARw6Omi5sN5kp7hCZBcDa19kuuZNj
         GxxoOMKYhtYbTHQCnx4HEad7AXjrU/N1ZWxbJsV5uXIjdSR7auuYPJ+UybI2pM+XCrJg
         iG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783963000; x=1784567800;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wOUZWaGczu1/9uaxYEVARYEnkKkoCC4ryISp2FSTVAQ=;
        b=Q9fvOBVHmU4cLMssWpS78dKXOJA58p7WURjyg9IcGzCh+3aYtFk3El2QrL7J9Z+gv1
         pvrPAAMvQ+JWMWWPCmkRrEomHnvqUmxK+M1bGaN+chkdSHliPF8ezBj9hqwslnKJc+cG
         JbRBvPyMeOe4HED53TkdGLlkEQ/k7uMVuuH530qEZxpAL6HXY/gdcHKv9Pt4B6wwgQbL
         PqkiOWa6aEYYU4VQlBwbTZSPJrjRIk2OdA89bPSSQx4NTdw8NeFy4yVeujY9P3ChrYHt
         m1g63d90lzZPOCGokYMWW2AjV0W5t3k7DbVH9O102o8a0rGwYNqDUrEr1ub2Axy8+Pug
         gvHg==
X-Gm-Message-State: AOJu0Yzqs3ELIOu4idrqA1HZO0aRYeOkGfYQDsTLF7V84IEugwkrjyOe
	0N4zm3wPQzse3XXoppEQsHQ4Q+V9jA7huKEzWNLn9gJGGd4gE7B9AHosKzOX2Q7Y2MfPZJJI20X
	16sEvtBr3aNiQ7ESzsCkceFzRCPe4GqS6Bq/TjKo=
X-Gm-Gg: AfdE7cnJ61LPDFVIUSK48SCUuvy+79zlaIgIJ/kSmNXFVk81fCo4gxXhTzvv0dJEkPh
	5fk4K3z5msVf++TlWmEM13af/QSWUPE0Wot2MJpLAWjqCmOi8jn2DZ2A0Sx3O9ImBLuwkArhLxv
	VnBIrPO/Pz+RZLS7DlApLPIP/lfFNGxtUyqDSYhuCQXsMrhjC6jq94O/gE2KpTMoze216WPwgcV
	e+mG7mtFPIZUQcGk3gx68V5CoY0WGXRkR1CWcikV7+5Cqyzg+czWAEees/HLv+ydeH6WPB+wDW8
	MfV0kPBlRL2Hf0+T1Q==
X-Received: by 2002:a17:907:3e85:b0:c15:8fb4:e600 with SMTP id
 a640c23a62f3a-c161e96176bmr379296966b.20.1783963000503; Mon, 13 Jul 2026
 10:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604214051.11132-1-ali.alaei.tabatabaei@gmail.com> <20260628143450.92492-1-ali.alaei.tabatabaei@gmail.com>
In-Reply-To: <20260628143450.92492-1-ali.alaei.tabatabaei@gmail.com>
From: Ali Alaei <ali.alaei.tabatabaei@gmail.com>
Date: Mon, 13 Jul 2026 19:16:29 +0200
X-Gm-Features: AUfX_mzSrrwuzSJw5f-07CfXrgUp81Kg961q75bMC4copPLIVvT_S-r1jDR0p4Y
Message-ID: <CAAc=8H_TFPdnPpfkix4K4kKKwy30VAB8oYnuBBifuyzymAr3Ew@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow Lake-HX
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, lpieralisi@kernel.org, nirmal.patel@linux.intel.com, 
	jonathan.derrick@linux.dev, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Ping. Any feedback on this patch?
