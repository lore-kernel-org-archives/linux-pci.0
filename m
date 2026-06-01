Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA723393C
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 02:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780282667; cv=none; b=at0/y7WZbUS5533GIDtb3EllXX3f2RRzyBuKR/hVFNSoX0x85iflo20Glibqei+k+l91s1B9sWPOi8UlbIiFg2CnCn0fG9NbzUznsSN/R2444qmMOPLSyQ+YQqzMWSmQP4iaUwbhzb25E2adzrR/bQq1dKzbJJvvosZn7hfg7RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780282667; c=relaxed/simple;
	bh=6SyTLlkLlY7/nQLNxMMSWjNn0CtqMy26+6iLfA1gO70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkVNWJyTV4/kLSJhMIE1zU0+OmXAUtgj0jt7AQCFGKs4IssxR4HjAisDz+WoxdM6LMpZLaObXxr18Zyk7V7++e6bnbwrAfo37BPKH9VYJYv3DGRpxBnyAT51xctQKtd7ItkL4Kv23224MW9q7UG5757eqD9y36sfXkXDNceVIco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhIoKy1N; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhIoKy1N"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36da8439078so564224a91.2
        for <linux-pci@vger.kernel.org>; Sun, 31 May 2026 19:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780282665; x=1780887465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4dc1e6o27a5Kq5vwZr329EQ3xcv7LkgpKk1NAl1/Wo=;
        b=jhIoKy1NQTSrgAD568t+Ih4ilAVPu2nYlQED/WOlvg+tt1uKBDFeviqKmj7e9DLmYn
         d+CfGGz4jiI9EhDnzYZLFOivuMRQAvniSVWu9YmspZkh4d7z9C/ElXqPZDatMnFky3Wb
         L4f9fgPdTHlManft+6GUVMIYhfKXWcmMvXsfuH9RIaN8hmOj7xYebJXmks5WnFi4hyh+
         UG7e+vkd3YU1qmPc+vHuEwWHRIikF2hlFNmqvGLOFv8wzX67YD1GNJHE1cu/Wd2W9fOm
         CDGUJeA36ucWEm63LyckHXYrFH5pw6R3Om2nE/JVKYxFb/hQ1TfwXngG5i5/OqJz2jNS
         exRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780282665; x=1780887465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u4dc1e6o27a5Kq5vwZr329EQ3xcv7LkgpKk1NAl1/Wo=;
        b=N77yLG1MRgiMTxUktwZmsUHT3pUAdoi67nY0Ak1lGg/uuzWNY8xUp2sGlhn/qBxVz6
         4mTKtBUYcPQn+9l7SIxsDcooVekyT+6vD2jA2RVEma22mWEfcv2RZaF4zEKDGHKdfbIt
         I0bH8HmdH9qnGvb7YH4FQvl0ioPZ5nYX4hzPg+EzqAiCo2E4b5WlaCWL5du/2Ht/chRU
         hsVBO4kqJx2zajy1SB2FAKgjXh76i/5wXh+yLgK6l845eakfuulibqLwp/IW+rcLKQ73
         VpbiTscFTsOp6DrEZgu6tyy5gFpKL7CHHUY9ihdnJJXL9RW5ZCcouMAYZmKI1B3WyghG
         O9YQ==
X-Forwarded-Encrypted: i=1; AFNElJ/SlvwNiOKrB/vacW3m11bDD4y5F58ML3DnGrSqHVwpsEZSz04YJqvXET9vhlCin3N/IZR5gVfZyDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDETyaYJHghE/r13V7eRiTRXrqHCf3sVU8hpRFRb5VGcOUha5B
	XlI18DWgBmuT+WlqPtu8mq6Gv7u5wnU9zmzSpAsgZ0IxJPLn64pPwLJh
X-Gm-Gg: Acq92OFZS5mO6EJQ21FaGZOuykU5dRZfTXfcjmpmgk1S6gcZ6qkEqG8orjD5R0KM6zo
	MkhPNnAackTlFIz6BbdeXpMlV+scXTso2tSccfhqN2XWS9OhydGpgqNpJ1L4HfcQKhvSdcvI60r
	dpX+NYKiu1BdpvZy16SgOG/HhgkXGzGr61p8nHsbYAOTxEY0fwXD/qmogyQd5rv7L6m1YicBybi
	pW7ygyXaVAq3R5DH2xtZm/ECr+qIO3VINdd5yBKv6FjxLPdDMS/VH5HUOH7NvNknSuVYq5POuM1
	RS8+OccjT7PXlx7bfIZPypC0m6eFSZ3keGs0wfkO2OlY0a3/FQw4Is/DM+8xzTFpzuFCqMFHVwY
	Kntj6nQ2pqB/yKHFrX4vP2tCtjU75JMc1LWdJ1maajNZuAcxxsHpwoPBLv+P5eDNKrrxAVkIl1N
	nQcI0q/Hqe4jvo02OFo56lyG8KV39ES4jecg==
X-Received: by 2002:a17:90b:264e:b0:36a:ee1:fc24 with SMTP id 98e67ed59e1d1-36c4ff41964mr8396209a91.8.1780282665674;
        Sun, 31 May 2026 19:57:45 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc6a340b7sm9065397a91.11.2026.05.31.19.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 19:57:45 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Zixian Zeng <sycamoremoon376@gmail.com>,
	Han Gao <gaohan@iscas.ac.cn>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Han Gao <rabenda.cn@gmail.com>
Subject: Re: (subset) [PATCH 0/2] riscv: sophgo: sg2042: Enable PCIe DMA coherence
Date: Mon,  1 Jun 2026 10:57:24 +0800
Message-ID: <178028263198.557087.6386925175219722340.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260331171248.973014-1-gaohan@iscas.ac.cn>
References: <20260331171248.973014-1-gaohan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 01 Apr 2026 01:12:46 +0800, Han Gao wrote:
> The SG2042 hardware design supports cache-coherent PCIe.
> 
> With recent firmware updates [1], it allows to use DMA coherent.
> 
> [1] https://github.com/sophgo/edk2-non-osi/commit/017a5aea26a066fd2bf501b7893937183165af36
> 
> Han Gao (2):
>   dt-bindings: pci: sophgo: Add dma-coherent property for SG2042
>   riscv: dts: sophgo: Add dma-coherent to SG2042 PCIe controllers
> 
> [...]

Applied to for-next, thanks!

[2/2] riscv: dts: sophgo: Add dma-coherent to SG2042 PCIe controllers
      https://github.com/sophgo/linux/commit/e728a57834d06b9bbf9bbed69e3ea16416d257d5

Thanks,
Inochi

