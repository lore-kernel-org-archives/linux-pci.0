Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150369;
	b=IJ9HA0yr37fLuEpmlQ5PRRMG+Z0nIw0TX5tSQsZw8VIpw2tZJAS+EVJKBJcXDbVUAqK4
	 bxoxXWCrCyMQarEL6wMFvYTxwd7/rHKIPQvIlANjfk2U4hwXPK9wznRjUNxBz/tJKGr08
	 aP5MKGXWZRTL/qJJtUtQc17KvP8hm+fWgnBEja71CUehROM/lVTav2QTm3p5DfpI01aYU
	 QP058f3Bh49XDqtCI2uwYP7ic2Uh4BPkMDTwBj2xr2DLyaDSh2yp8jQL3p73AkkP8rfkU
	 5TRZSiNPWRiLfsisYGpKTtHf48nW5Y/XR8UTj7yw7T9kjWvcrUifeexGZmpzSV+EeKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QGQE3LAYpEwlaN5IMebgHt/LGKiGCVPD/r8B3CD/Y/o=;
	b=hww9g55bTRhE8WoE7AGXap3OwiEYhkdaipk5txoBHiwMG367eKIf1cJJwEIFIqz2YCqk
	 wtogesAXK7jYNPlQk4anQImSOvfOFWxfu86X+Dh0AaxVb/duzjH0gbtNufYtFobftFVNo
	 C0VWs8js34VefqH8ZZAjxTKgAlKm6AVFZ33kHzZNQBP56x9NZvnoQdvcRX1K9+NK04o2I
	 PtzQO2sxL8I8y2EfJporSd+GZYO9yUte+LZ80kN2TMf4Upk3xUqN7vuI11hV8+Y3kHzpb
	 icAc8aAw8XJ7xUybUAkPkLep3f3RoDPJGRNz8rLvx5joSgKWNtXlij91YLZeDJlunCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46958606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 01:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46958606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36661f953e4so729003eec.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 18:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793150368; x=1793755168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QGQE3LAYpEwlaN5IMebgHt/LGKiGCVPD/r8B3CD/Y/o=;
        b=h1TpY2BsShnknbHatxj/gkM/Q/3/CKzKz9pjSzaP3JN3Y1TA9yMEzkHEavgQ67JW4/
         7LLgSzyonsaWbGqdcnfcmRG0M9ffhLCRiyY3tchJ/wF9CBKKhLpNImF3K4uPUkuGCGIi
         GCnGGdOicWsqzQiNokqoYkglKfShaQyctGxrpBNIwAbQqMB79X7rI+miRj/m+RAJZLcZ
         Hq1tFtkbVIYR9dVRj/JUE/VyF4Vt49WaHsnGLoERz9//rfjinmkFBga5zTY5dNkf4CBj
         xxqhXoDA3AuAiNi1Wss+Xa84OHvM1p0h24CezQWiqaU21d78gh1Ka2S6lTcGBzqwLSoW
         fDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793150368; x=1793755168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QGQE3LAYpEwlaN5IMebgHt/LGKiGCVPD/r8B3CD/Y/o=;
        b=jXzwWMzBfXauB4B1PjSfLJ4wXoYn1MPdlnWZQvH/O7QjPH+RJz6Q3L7cnb/CG0cn3m
         /7qjzchQBhSvh7tpZ+3QU4EFOvmrXfMHMb8qh7yxN1cyHEZpLqR8dJZRhyug5xw0Hgg8
         xe5GDVtLWj1hY+UEn6N7GX3jirIrJE5fSSf78GuNv4c96c/EMPDZU0riLfr+XqCkbiDy
         LpmbPKGBYxqxQyKrdmal2Fp87/C0SRiEq/pdMKYaTqcYnf/kUL7dZ71eSYvIQ3q+j8d+
         7/7n1YhIARezA0ndlvYX6ImhQFYNWbgeq4yjEZinfBIkemraBthqNbjNKmo23ziFs0m5
         Ussg==
X-Forwarded-Encrypted: i=1; AKwUvBx0v/820EBaMGV0242//R2SLSePCAWgutSfQ5vOaZL/3rP3fyTtDcuGMnvt5782W1evGblyNx5voEM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKx93Tffr7ZRssO1nRYYRCUQHy+9xOS2Z+4Pe76qe46ttuiOchS
	EqP97SMMV63fTOLGgO9zZm3flUPyzcQQBByaMRti1ysdHzUuGeIxMus=
X-Gm-Gg: AYBFou31ar064pgdatIvqf+oChNLenAspvcXgnXZfSHhOisMAcuPQLcccpg2ZPWe9Nm
	JqGrcYpKxooIgif+ZOickYWkOmamveb5UbRurAQuJMqVtgBWjYpLrzBOc8za6vvGnfMuQfaHkmY
	l7DXw3ODSiHerjJvipyzM2p26yq9T2mM+RSG09iP9dWukodYkefuRDPfYuX+oQnNnC9LNqs9XQW
	Pb7FQA/MvwkdKmE1p2MU9EWogfH6IJAxfrTPWPuvcLZHCTgcMAoGr+qO8SsKaBbB3mdqlEQoL+Q
	JC+XbY7KxG9JGfGOCr6v9MtKQ2FThSAwmg0YNgU1SBwzN82OlHevfYrGpJ1T7yWH1nHE7rLYZkW
	Q97lz5tW2MwumBMnHq8fwonIDOnpKfVlwiALwWrYcy6WKsZnLXESqUDrgdKvh9+8EYuBtM9IZvc
	B0A3orAb+4W/mdZJq9yL70vNBQSuiIF5Er6jkNUAQPL8oM/++EUIMdgKvmjE3U3JcMKuyIZUats
	Jb1eiPFqMOCvRbSjhqYgNSGo2hUIpCsecHZ0M6auUehtyXvuLo0BKr/UYpFPvumfCtjzowsI5O8
	BMih1tMVwHN5YLA4lqcjnPAB8dSZz05h5ANBg5L1ATSm1zOWMvN3YwJNM9w/cIhSYsSnMX0WBKW
	jF8l53TR5/TKT
X-Received: by 2002:a05:7300:fd0f:b0:367:363f:6fe4 with SMTP id 5a478bee46e88-36a20440ad5mr1939920eec.32.1793150368183;
        Tue, 27 Oct 2026 18:19:28 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.115.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2392ecfdsm821863eec.17.2026.10.27.18.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 18:19:27 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: atharvatiwarilinuxdev@gmail.com
Cc: airlied@gmail.com,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	bhelgaas@google.com,
	bp@alien8.de,
	christian.koenig@amd.com,
	dave.hansen@linux.intel.com,
	dev@deq.rocks,
	dri-devel@lists.freedesktop.org,
	hansg@kernel.org,
	harry.wentland@amd.com,
	helgaas@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	kenneth.feng@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	mingo@redhat.com,
	platform-driver-x86@vger.kernel.org,
	simona@ffwll.ch,
	siqueira@igalia.com,
	sunpeng.li@amd.com,
	tglx@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 02/13] PCI: Disable pcie port and access on D3 on specific amd devices
Date: Tue, 27 Oct 2026 21:19:14 -0400
Message-ID: <20261028011915.8217-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028000841.6816-1-atharvatiwarilinuxdev@gmail.com>
References: <20261028000841.6816-1-atharvatiwarilinuxdev@gmail.com>
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

> I did not know about, i will try to remove the ignore_access code, and
> will tell you the results, i added it as a failsafe

I tested, and yes it works without ignore_access code, but we still need no_pcie_port.

