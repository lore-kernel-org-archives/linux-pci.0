Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630961;
	b=3AsugOf6vCoY9XmM/f0/J98cYwdQa+FQ+QYQQK8pzYa4j+WJB0ZNEdGMTdarSuY8jUK4
	 tyZ6iuvs9QIcbPQWlH7OEN32b5GK+oT205tT1hHxaGPCi9Ple/UjwcWpvTSLEMUHXsL26
	 Z7CCr6mxilAJAE9EndSSkrKDmlHx9eQ7T3m4HTIUgjiJbqvsah/R9VE20rF5oJhpew7UC
	 vSioIjZ7AnRMquSmvx9y3sWTBXwYq05DfiWxM/xKoxVlW4+mDHxnYdHiPW4v9PUNn+xV5
	 jJTPfezCPPZgYUiDdKJk0PLNKh2+5t6fxzcyBjlEpCUJ3fU3OXDkCwx+us+P50GJszA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=sfEVlacBV97ie02thpjOgM2D6cDC2tSVCZoWDEnfrKo=;
	b=jMKaePncSddynxCXjWOssM6ySAc3wPfU3gzNmWkUWNozVhtjLmfozEdfKwjYyUXewXru
	 5PVbUeO0c+dBtPWH788q0jayfRtKQTqc/RdDDNc8dkw7tW5Qf6lpUCjakUNkf+qaEwlKe
	 U8WO/SR07+IgQzfSWCdE/G7hAvD7WkKhbdGOIkwCcBQb/t+E8e1iYaUKkss23Mv+2Y6v4
	 IRhVJXHrqyQqRE9NKqSMVsQGolRtU71v0U3FEWvvVccvmorjBpgSUuD4LKH0RC6ro6EH+
	 x81C1/vQKjif17kd7DRyusknyPJbKyZrBzmKvGD62pehCS681kFMFpr4lU//rtSQOLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XltHJeJc;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912F2606A335
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 18:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 912F2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XltHJeJc
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2f052777c7cso60421075ad.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 10:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795630961; x=1796235761; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sfEVlacBV97ie02thpjOgM2D6cDC2tSVCZoWDEnfrKo=;
        b=XltHJeJcafnoz7rWSdh67DNM8cUVU33Kf/95Saqoq1SakVT7WitG6OsBqDZPGchsCE
         y/G1PGTFqEJu0lBEmJpEIiHh2bs+IcYU8n5pRQb6MCXjpvL2vVXWyjr78fxLTeBKFKQH
         LbZNOzgfAlbMrtPg3br43/a0SJZBBByAaTgwqOI1btWwBNj5Ty//bbU2AK1YZTsmpv+P
         Rx1sqeQZDnE6Me/PAQ2VZSIlCF1Pj+UVs+co5YrbldjuVaIcAFJ5jyFNTi9XJNwyBgom
         juH/Li+nPLPJ/sXNQ9fbhC3+mMLejxLcvsDBSkMQCDsTkfuIdqvNpOGCTIPpHqYCNwEs
         6FOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795630961; x=1796235761;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sfEVlacBV97ie02thpjOgM2D6cDC2tSVCZoWDEnfrKo=;
        b=Mw2cyUiIq7Oea711fLzK8wCEgJKPdmB3Xx0+2MX/oT9XNSrrk3JJxHrslUpdNy3kaQ
         6Pt4Bv0vwKsb2fjCei68Ze+6T00chniR/0zFD2juVpASIB26qHwl3bllxXMm+wVduaKj
         2tyRYKa5mDGNcoDUuqDYXgwkoUtAhljnnF28Js+nGYAUB1xtn8R9PqC09PGWVNdwFebY
         02c4hbBJA0mlsIE/U8c/TkBVOaXjGjaLtuXvnFqvnc0o1GYVXDLuJOXB+bWBl045HSU4
         fe+lVX0YySSJuoYA94wwPUoAYAHAIp7MoCYCWqkR4bC51FYh4rLPh0RZ/gs/xyUJK7Dd
         6ikg==
X-Forwarded-Encrypted: i=1; AL+hErGmwhp6Aud3iKORsOXKFVtwHGD1MJyb3YRybBtWreuLzY99E7mIXP17BVblaaZNCI4hltYtk+6RiAE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PU0oJ3fa+o/PucqjOET0PxSPiOSar3OZ8HGgJ1foFy81DLw77
	16B5p83tFj+WL6F9qnVna3Npnb79n73bej8qauCVaZqXRO6fLEVHRRF1LXeDwPL7x3Q974J1eR2
	k98SE2YTUCIOGBpQrGNvBGwq4B5DeZ876qQ==
X-Received: from plau5.prod.google.com ([2002:a17:903:3045:b0:2f0:349:b3a4])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce85:b0:2f0:3e44:4761 with SMTP id d9443c01a7336-2f03f25e801mr195497385ad.54.1795630960732;
 Wed, 25 Nov 2026 10:22:40 -0800 (PST)
Date: Wed, 25 Nov 2026 18:22:40 +0000
In-Reply-To: <115e024d-f49b-256f-550c-7a64b546a076@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125-pcie-link-endpoints-v8-0-19d49c17c05f@google.com>
 <20261125-pcie-link-endpoints-v8-1-19d49c17c05f@google.com> <115e024d-f49b-256f-550c-7a64b546a076@linux.intel.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125182240.2292209-1-rathodpriyank@google.com>
Subject: Re: [PATCH v8 1/3] PCI/ASPM: Add internal pcie_aspm_inhibit() helper
From: Priyank Rathod <rathodpriyank@google.com>
To: "=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lukas Wunner <lukas@wunner.de>, Manivannan Sadhasivam <mani@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ilpo,

Thanks for the feedback.  I reached out to Manivannan, Bjorn, and you on
the ASPM thread to check whether Manivannan has a v4 in progress or if I
can take over finishing the core ASPM changes cleanly first, and to align
on the per-state counter API details before implementing it.

Also noted on avoiding bullet lists in commit messages, and I will fix the
port->dev lifetime issue in pci_lmr_release() that sashiko-bot flagged on
patch 2/3 when preparing the next revision on top of the ASPM prerequisite.

Thanks,
Priyank
