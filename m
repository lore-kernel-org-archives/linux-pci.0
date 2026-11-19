Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098199;
	b=T4ZrA+rkY/hU/7WMMe2aPI8ty9/O2e3AULfjfb/jcJ9iXF9oNSIwwwzS1F1FhiEsybPL
	 Ndn/q1oJGEstKw25bnmlvTuzdZV2H9Ug+6K+a93GVVN4j2CSilet1X75JyOTTqnwVWFQX
	 VCSNsjrW6wwTAhBhkFX30rjyCdLZhqGXSbXLb6aKAyHiRND213lk2UdFg2CDqj1fTL/3F
	 9p1o2BimTRT+juHtcQQFYfsMsiI/87sbPZzCZlSTiP62ssBRTu8dM08R4UpCBXsNGvCfT
	 CZ64UxZZpjZB6Gl6HR/t3ZG3QBWHg/FH2jG7CXJwnBSie3F1Q/fDvOYN8PwBLajCvFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=msdP55vXlTy09UO8puWvvjC8jVxycl34xfHbtsiaeYU=;
	b=3gODqo2HiL98KP7mdEwGau6idGybJUGTeebluZpFgzrVsbKTuBI3zpqcisXAhntmjrcr
	 qqiru0UOOwEMzx5fyhB0hDge0h48sRZdytxMDv9/u7Eiky3aBgxxK0n2TbXIOh/laN6Kx
	 NPvBqGA3GuD8WDLddU4fY+IW4/gG6aCwUNDYv2XNfbneR52+Y9fTu6NL62bWqeLjChOj/
	 znL7YuDkA2f6TdeXM8yhsCXUmO3VhKTDQxRqG78B43RWKHFI7DwT2rPQ8ZjAjLWc1qmeo
	 KUR/xWzR1f2GNG1DMTXvPoINwDIn3daOT9K7k04g/WjBYIgDzCMh84v9vCJ+4Zj8lpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZQZx+Caf;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D585606A334
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 14:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D585606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZQZx+Caf
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b3acec6677so3303502c88.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 06:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795098198; x=1795702998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=msdP55vXlTy09UO8puWvvjC8jVxycl34xfHbtsiaeYU=;
        b=ZQZx+CafJ5sxSFPQQyG/F1QUdmwM+0jyz51i3cLNmRf0AGkpQ+ZnCpBfBA3HXufm/Q
         Ra+N8okJV3kOThm9oQsZNK89WDQDpzgsvgjiZo+09l8NdlFuhaXfs52Mnz9h6frCUFOc
         EGefdz1RZ3j1CGmvo+566APwO8MNo0OS5m+BsgKG+brlLQsmsaBrAte5hyTKQokS8kQP
         MFYu/TP3mPJuYCEW6UsLsmae8BramVwEubGfKQJd/qHW3Nelkru39Wx0r4BoMyUcC1xK
         8IYI6pRineGwyRr8fGLu0tfblqqACuO7In20mbZSwNXZ+KAlkOJ99QdWYHE8x255pSC/
         cX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098198; x=1795702998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=msdP55vXlTy09UO8puWvvjC8jVxycl34xfHbtsiaeYU=;
        b=f7g83KqGHXhuoU2kGcP5a4/T9G9NcLhOQIdr3GXGUBK4epUBmOx9rn1vjLwEQk7+x5
         jDubWkIVYhQY8sJL4GaVQaVhGpKD+fBAgEAeL9Zya7MjS2CAjYkL5E9Bstmo8icIC9Se
         mIz/iWSp7l1LOM6e5qPK0P7lz0kgNDMf26Rmplns9UBXGyQBuDT4Iy490OlCpmk8Qb+M
         k+yRugw4vyreJ2NB0MTiXhG/uCplP5FZUG5RYrAt4zBkdeGdmbd1jxTW+Oq1Ol69LKP1
         ZUO82mDk9oJ8mR/x5iDuijZUPGONqYrE6+b2Rid6jjWMn4Lof1YHEcu+TPSC1twKl3Bl
         9+zg==
X-Forwarded-Encrypted: i=1; AL+hErEf90ZvPWVgOF6A6Lej7wvpoZyFuzmGEmttc2+rmWZtuHjrxO9W3HLusrUsh76V8Fl6l5jz89Px9zI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/c3MbjFF+NAVPqvkO4uOSlR/Ucl7G/ph2ACLBxM4edV0D1oL9y
	Nr9kdOyQKsz+RK0rFT45ds0S0re6l8fQ466A5Ia6JMWsMiEZus7ZeoVF
X-Gm-Gg: AYBFou02yVUwbmgOpk81mUlAZMvjo7YAZueiKNECi+Q2R0oTAQBrIrwphOY0fgYZ8Uh
	/fTX+qVy61Xzm0w15mUmr6FutVafstU7QQ68EGfkKbmidIos7XjR4DCBuG1JortlNAAmYvbYi8P
	ZM8UQoEh5WhSuD7sco+dCFuy002G209uPvfEqOIUdNnJzzAD3+PR/YM6AAUaQaYkc6IE64nj64A
	/QFnyjepiocL/cvxo72CdGN6sbzQzMFgbnVqeVcbGhzbKXIUNsLxVCuwsNqyL2qyhRSXQIxP6vA
	y0azI9wVvivcLK/U65B7HG5YT1U75Tby2oqIxHvH/orT92a3vecxFvEl3WkmpHeUERsA3SVQy8Q
	P72I+Nm6Ss6WIFPnvmPYvnDByxXIymHAj6P5S7abjeKwjj54rFDyn0XwVRqD5VF7+nF20m3eK4a
	HdpABNp6E4jy+l1p3gxL1MbRPi/MmHUkyUakPvwzlG37CLKZ8Em1bqxSafvXtbhzIDdEJBhz37m
	r2fzkKYHd5vF6eLUGy3VFM/Ejxk6E3LgY5nWJMmlMMmmDg7zvHN77D2wCb9x7HSdxYTTs+nzcpc
	hcQv5fbKxjmu2nrWz1tBZUKE19rHc/0jEXwQAUAoSAMpol8Ews6V
X-Received: by 2002:a05:701a:c961:b0:1b5:10cf:c402 with SMTP id a92af1059eb24-1b543d09a83mr5609963c88.10.1795098197560;
        Thu, 19 Nov 2026 06:23:17 -0800 (PST)
Received: from localhost.localdomain ([103.149.158.188])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b549e398e4sm10306022c88.15.2026.11.19.06.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:23:17 -0800 (PST)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: krzk@kernel.org
Cc: alim.akhtar@samsung.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	kwilczynski@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	peter.griffin@linaro.org,
	robh@kernel.org,
	sreekuttan2156239@gmail.com
Subject: Re: [PATCH v8] PCI: exynos: Handle PCIe PHY initialization errors 
Date: Thu, 19 Nov 2026 14:22:51 +0000
Message-ID: <20261119142251.2665-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <0a3b7886-3800-42ee-8e22-80944114dfcf@kernel.org>
References: <0a3b7886-3800-42ee-8e22-80944114dfcf@kernel.org>
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

Hi Krzysztof,

Thank you for your feedback. I would like to clarify a few things regarding the patches 
and the concerns you raised.

The code is not entirely AI-written, as you claim. The reason I sent multiple patches on 
the same day is that I was working on them over time and submitting them as they were ready. 
They were not all written and sent at once. There was a time gap between the submissions, so 
please don't assume that I was blindly sending random patches just to get past the review process.

Regarding the v2 to v9 revisions, I admit that I blindly trusted your Shashiko reviews. I submitted 
the patches on my holiday, assuming that Shashiko was properly trained on the latest Linux kernel 
source code. I also assumed that, since the PCI subsystem uses Shashiko for patch reviews, its 
feedback would be reliable enough to trust.

If Shashiko repeatedly reports issues that are incorrect or misleading, why is it being used as a 
review tool in the first place? Isn't relying on such feedback equally problematic? I trusted its 
suggestions because I assumed that the review system was reliable and that its feedback had been 
properly validated.

Manivannan Sadhashivam also advised me not to blindly trust automated review tools. However, he 
explained his concerns constructively and helped me understand where I was going wrong. 
He understood that I had trusted Shashiko's feedback in good faith. I appreciate that kind of 
review because it helps contributors learn and improve rather than simply questioning their 
understanding or dismissing their work as AI-generated slop.

I'm not claiming that my patches are perfect, and I'm willing to take responsibility for genuine 
mistakes. But dismissing the work as "100% AI-written slop" simply because I submitted multiple 
revisions is unfair. Humans can also submit multiple patches in a single day. That alone does not 
prove that the code is AI-generated or that the author doesn't understand it.

I understand your concerns about code quality, and I will take greater care to verify every review 
comment instead of blindly trusting automated feedback in the future.

I respect your experience and feedback, and I am willing to learn from genuine technical criticism. 
My intention has always been to contribute quality code to the Linux kernel and improve through the 
review process. I hope you can understand my perspective as well.

Best regards, 
Sreeraj
