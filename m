Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127761;
	b=ABmgHuS/eM80FHaUnyylANFb0I0nKrFQYUecu/BMxtFxXQGfD0nubs09bPO3v5v6u2KT
	 kk6cMFgCebdTRIxr8CFDztpIhfqyFcgezpK/aAAOCgracEhao8KcHAJ4QUlw1YXoeNepS
	 dQKtFt/6UcT9hixV/ZvVYSux1BiqB4qXs3E/DbjSfpPs7c+KSmZctOpkmQoo+gOt71pW1
	 fUd+wmkDRQQFWai+HvKat03EOqcLE3gIGEzfSRfL24ZkVWQFBpyLk0BYLVWx1eRx1PLf9
	 gmyMtURHzzWWWglpHCtGpAMwBLazNXnqJ8RMaJfKezTgbuX/s53S3w+TNm2B6hN9Kpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=;
	b=BJNVtfZeRzOMXVqgtlB+nLhGdFj+Jv6LtzRql+h9UsJ+0Z0qwxS5mxrwq8z1DHLFPwy5
	 vLfpZBH4gcr8a0wPLaJqeGJkQulnGqki2yocq2DRzFWzmyOmzUm0bXcb1tFbp97aMCRNH
	 IPfmFLtOetpIHpEBccT6O86CMOwPlaJM8u6o92AmbmLJBx22bgNvXbhwegnmKYz9IlR41
	 hVYyiSoE+xL51q00nGmpwY71c/QQN+nvN/lO1RYGcRTuuSuYFObFS0YXqHzFced18PWKS
	 GmtNAOY7GQGwqwo96umjdcILjgyxYIKsPZVoWwD4Ef3Vuuan8CYErBszOBSXaZLeL3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rfFbYqnm;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7BE606A321
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 08:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C7BE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rfFbYqnm
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36a315ed211so47843eec.0
        for <linux-pci@vger.kernel.org>; Sun, 08 Nov 2026 00:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794127760; x=1794732560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=;
        b=rfFbYqnmrqZfeWjWTp72T2kiiZhsdPB9BB0dU1LZ9it1fl5s2iKLAlHTaYG4zuMcfQ
         aon2lxlRuyluT5v7V4y4M0i49WylN7ZlE4DEAsT61KXKnBObk7y2cza/8+Q6//dCWHwd
         Pk/s3VH5/0Eh0I7vvj2lF0Vlw2tdiNJu9KyesOB/pxE1w9p4jwZ3qiv+RyL8yWEV+KUz
         C6O243ilvNmZPtiONvUrTtpchpq8bjYafhBBUGYATAKJB/U5LdzkxJvXSMKJTjRGl4Gl
         E3H9TSPHOWLgwIxjWlicEMEPGJanc56c0D+2cGoLKVbLr34FIpZgdCxvSixQyjkk1Ud1
         XSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794127760; x=1794732560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=;
        b=H7VOytg9S86pxnve4iBctVnUXykVSpUrq5TOUYtBdiiLeUyO/FiCW+Wof7sweKi57d
         lwq5Y0d8c7TR83ETCqMT/4gr/BL0CHSbqPkuKZlRUuK7z+bZjgqe+X0VrdKHofJo5Vge
         qWdTfM5OyXgrGTP/833vhKKAXKZwQafkESBUtABEbdZP11ThZp+7VOzTRF4LaqA0ra4l
         1OmDEMe2hm3wsKZeTQrIsJGwT7zBjgiPISnn/A+p0ZB+85OncyTbricLMSIGqzZKEZhH
         JxTqPDa5vOc1VmB/sZd/X/5jI5IO/vVWMjSD7ja1A1S9DvhRVcc+RGyO+pfnz8mYBkzC
         n1Rg==
X-Forwarded-Encrypted: i=1; AL+hErFUFnr+tijSVAggw9cqkfKwQqvGUaULqZ9VdSyEa8hzt+u8K8GtFC6ztibUFHVmaxtD93QI+HT6qa8=@vger.kernel.org
X-Gm-Message-State: APuU4Z899tE9gKeDd2bKJd3KmXNRDObkNn/dN0p8PcIHVTNZuXcPQwSp
	13lRcAI8TWc1xA+lWgwFRhFpKuz7LTqZncXO2m+MwFnTHZIIwrc8QYKm
X-Gm-Gg: AYBFou28c3eSxdXF+N/nxz5A6kilYn6J/4XjEaEuypHTwgR1pnWiTRi/E4z0ewZYDna
	c3gcfhwd4d0ZvLVby1c6/yc64NQT3LxVB3cz7M0I3Y/VAzcylQSpNKoqSVMzTz0R/l12DKyBqy/
	3ZzqIo9+uCRlYotaajbxruVJUpdvM4OIkFscauer7Znj3FpB8R1zQiaSEqfCbkXSTZO/D0rFsdo
	jslDGkB224ypK2iQfEX97VS4vzSoS+Gtmv3B8KLDSdmE62evhbo19ipg7j/k6o+TsPhOAVRwbWv
	EdNPRHfo8I4xIBf90aDo80R30Kfn4Q52nEcF3/JRGa3DNYx16571mZR50tdnVMiGf14Jc6evtQu
	fypg1eVhSPrvl6HrMJYwbBd79zL2PHM8v5mINyXX/96Ik/e0EN4oiim7+O2BVcwCH24uzheOrxY
	7ejYLJSdMnkIlHq1cTkjcFUG3OVkvRdqyvlzWofQaIRCBdziGiZAsAgm7TRzeJcmUjPzFKAnhkF
	xVr26mi4BOCG49AP4KGz6uKMo2Zz9zWdUcmQDiz7jZVLnhdB/MQQ/+07QbLKXtBBPzGV4HKSZNk
	FoS+V2JYTEg5nJWGpaV+ClO0APf/UOX95m6TrgoHgCdwO4V7BG4=
X-Received: by 2002:a05:693c:20cd:20b0:364:377c:cabe with SMTP id 5a478bee46e88-370f8170360mr5884840eec.24.1794127760230;
        Sun, 08 Nov 2026 00:49:20 -0800 (PST)
Received: from localhost.localdomain ([103.177.253.80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372667d6088sm4445529eec.25.2026.11.08.00.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 00:49:19 -0800 (PST)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: mani@kernel.org
Cc: angelogioacchino.delregno@collabora.com,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	matthias.bgg@gmail.com,
	robh@kernel.org,
	ryder.lee@mediatek.com,
	sreekuttan2156239@gmail.com
Subject: Re: [PATCH v6] PCI: mediatek: Fix integer truncation and handle oversized resources
Date: Sun,  8 Nov 2026 08:48:21 +0000
Message-ID: <20261108084821.2827-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179389361906.20463.1092137538074974205.b4-ty@b4>
References: <179389361906.20463.1092137538074974205.b4-ty@b4>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Thanks for applying the patch!

Best regards,
Sreeraj
