Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525ED3D9DCE
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 05:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787032685; cv=none; b=Y2Ahf5iNVDC1PTqAOrNb6C5+ueU7pP5Rp3AfT62BS9CqQzoPd6dpjH0kbZyB+k+kfO1sK7GjqAgLNMOdfsfXbD0lhXZXjijEXxxkVPk/NDpFFjdE73Zghe209IBpbD52syGqXDtym4YHDqKvWx4PXv5u8bvKd15o6Ew+/uY8Byo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787032685; c=relaxed/simple;
	bh=6cfTo7WwTp9qwgztBPgqmMI5bDHvnXxIoSz+3yMP9VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saYsJLJs7/DPa6wxKqIWidGWIQ4wL4EQB5zTAVhOQUxXSTjHjmF6mqtsvdbXJywsn4Td7Q1THjC+qc7cv5OXWbc+8pe6bCTeGWiDiCUFW2HorHp4HyiAU418QcLaEYOVuurpruU5Jr77LfOkv/gWgRkvZCS2jiraXJaRrsXElE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BT6JkKTt; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BT6JkKTt"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84faf87d19dso4514566b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 22:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787032683; x=1787637483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6cfTo7WwTp9qwgztBPgqmMI5bDHvnXxIoSz+3yMP9VQ=;
        b=BT6JkKTtJ7x5ZpmXDiSG6AlSKdMQ86K499XUsz1EMOFMSuK76zoaILzRogEVwqIsQj
         v8MdxTDRmEMHnvr1vL3ZZ2snB6iETY7AYgNNJHYrWQrJCB9/h6A097qrfnwFmxml/s3E
         deTb7hLM4/N6o/Mq8CpPy4V36OUdUf6xFsDXbzWEjAzPFxn0jk5oSMiIa9g3E1aaT1KC
         AMBV4916L+LmKL+bCfibLGL9zdGak6h3HCPsI96PcOEvAuZ0jGbq7Lkmy0tXReeO4IyH
         EC1UhGxUrwEo0000SiVfL28XtrEJ8u/ZHF9slf/YRsaum+3fzzsBZuZhdAkHBe3uhMpM
         nrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787032683; x=1787637483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6cfTo7WwTp9qwgztBPgqmMI5bDHvnXxIoSz+3yMP9VQ=;
        b=HHesiqprqhzl/sX4cFCInQl4veRFFE1HfolSQMPzL9B1WBLjdLECLGe95T4NKm0W78
         Y0YCMnvr33wHG6JDuri/Oe/07orEhkdwj5FUzXF8noDkDg2jZcYStzaJmdmY0OvBa7s2
         vSaSnkW+RhBrHeitgs8U2wRwYysNzLFzFLOonR3SuqTfDDReMpbfluaR9zw0epLlUDiG
         hyBeGMQpqwQUd5Z4gB7/PH7rOUSblg9YuACZtSXAttU1VUSYuX3Smgpc6fTLGrbZx+qf
         ukUfw2oa0HVg3BuQklrmYanwIkVWfdy7o/F48QBwtjM4+SK2D/xclxYYQ4RF9C9OJj+E
         eYHg==
X-Forwarded-Encrypted: i=1; AHgh+RooXM6nGNgGVN8BomHRSvSOYUO/GM0+vpgRi3wL60CiRNkMUmsvml7mCuAj+3xRkABsYhB9WEO574M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3F8yYPt9i/2N+5nxEgjFq85RrdOqhOASvSkiIEXzlWZ6tDtdw
	MdabtoqYY07bLPx6OtYrmsjR2nX5oLVqL96hZNIjGvmWMCRpnL5tS8M4x7q+7HgH
X-Gm-Gg: AR+sD13edIvBP/+NlGM6p6PNumLc5Rg+p9leLVfiOc06CJQU2hIXddoK9aJTWYP92L0
	q4CKjt1Evbo6jolU1qWBi9MwtKjLp6nhnfkjh+5QiiJIcjonXMDWp7aN6+NidycBh2KkkcDVMRX
	VvPZUaJMC+4/QObt4QfsUW+Tnq9eOQQNcL7Sfc2raUdjzVhJPlLTISrwWnkFD1J5TwWW+XNkJgm
	UEFkifrrkuh4llzAtbo5cNDzWO7s1XQqpzT0eRnDzgXRv5TGPTZp62IZTj6MrK4nl3yZZULrfsA
	7NGpDTKu6ilSu2uiaLQvyzX1XAIUQ64nQXRtuF9rQrzc3IyFJRmVYzE+1bp7pcuqNlDaubDvzpk
	zZvnaPPzepO7lqyFLnifDdElx2FIsn21+eju6JLO4y01fzFx5P/XNmev+zaapkxcTy7g+J/cg6E
	Wq4ZxehwFiktuUWOjAGN0cyqdO8s6vlloeMtE52dwki24HwQzXL4+1R9C++3A0
X-Received: by 2002:a05:6a00:4f91:b0:84f:37c1:f887 with SMTP id d2e1a72fcca58-84fddfdf5b0mr29554045b3a.12.1787032683451;
        Mon, 17 Aug 2026 22:58:03 -0700 (PDT)
Received: from ubuntu.. ([2001:2d8:7009:fd05:a3e3:756b:e9de:8271])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6f8c0f6sm1062441b3a.39.2026.08.17.22.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 22:58:02 -0700 (PDT)
From: Rihyeon Kim <rihyeon8648@gmail.com>
To: David Jeffery <djeffery@redhat.com>
Cc: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	tarunsahu@google.com,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: Free the device name on the pci_setup_device() error path
Date: Tue, 18 Aug 2026 14:57:57 +0900
Message-ID: <20260818055757.60571-1-rihyeon8648@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CA+-xHTE20nzFqk+vQB=+jCz7=FiC63zMJAGtjM_nqxOuS_W_ZQ@mail.gmail.com>
References: <CA+-xHTE20nzFqk+vQB=+jCz7=FiC63zMJAGtjM_nqxOuS_W_ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for taking the time to look at both, much appreciated!

Rihyeon
