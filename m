Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7475A43E9F5
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623501; cv=none; b=rx9pDZoiTryz3twuJQvrFOiQTt/A0TRqbFkKrYeGbH7dHuFGye0wlLNDIHQ0vNK6RWKeU8wiw53GNVsEDbtzomSj2hhek2a48I32FiCLtbUoREWYnQGGEmpkuQiRJJTIidAeOf93T2gNJ4JLaNxX0SZXqS/5UBNluTzJAeaAjHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623501; c=relaxed/simple;
	bh=1kDGigjH9Bd+ieIKS1Zpg/McayMKxT526HLIh+wIm5s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XUChuymsQ62lf+5/koDJbl4qkaiPj+M9MX3QQWduP0Wwl/AAquAmeiSk6aLljAuismXMKJIpmytfBmuR2e2e0oOyC562zYsTsRs6iA7acCbNjfGGTxIvDFAQ19DRBYi8zWCji4eYNDzrWpCVg9frHgP2QCXYm5DAZ5qvCSSsrfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ha+L8Vbl; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha+L8Vbl"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-306f36df4feso3293666eec.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781623500; x=1782228300; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7M8qZtmu0bZQdu1QNURqoYjrqJMG0t/ykNnN1cBj2w=;
        b=ha+L8VblI9SXgvSCHLAVuuaj9rioGQSDREYiYxQVaGuVEaVQ88JhbXZILvlyiQwbzl
         GhwIfoonDXzCEHvCVZqyWc+Yx1BrsSYU2Zad1+qJHAfuxpgEnCmCpMp0UrDST7wIxxw2
         la6qy9uQDSLPiu9EeTlh9Phktd9S5HlJnIrHonrxamdovi2DJtQVFLm3X+T2x/ZBK5Ug
         zzFGWhx5IBdjUM0ky/qLADViuOZI5LcJXdCFwfoenaVGIbEeaoj3PPPypiJbxetxgA0Y
         Csup7QnOrviv7/rAYjtG8eeimOSpHxHd06Qm7swRtKbVjl6gMOLW65tMJws7acLUpGxK
         bheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781623500; x=1782228300;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7M8qZtmu0bZQdu1QNURqoYjrqJMG0t/ykNnN1cBj2w=;
        b=CGA/1YCNeR8Xzvp0yswjxvmfXA+1DbL4g3R2CNLInvmu6RzHHrsuPurev70JYdezbN
         xLV8+TepN/5JJFCk3HTd53HpbPkPN39NxJFHv17UeSRUAK8ELr4wfybSDptpGxRsr9Sp
         ZOS1HZRZ7ynEGpwvyvDXNORSU90L3snmmvtbJ36j08lDhIOrKMBXNRFep1tu7/BGLqnn
         3dWaBW9nMeOR18+aEmdhZLqFZ4AvdgcPrxuov3QSy+AVDrzgLLvxiJ019s0yDGPcw42r
         M1WiVcipxF7aSD73AWIuHpTyrbYCUWNph3JLb7dHnvrtABC35CtBnQlgqMVby2ZKMESz
         SudA==
X-Forwarded-Encrypted: i=1; AFNElJ/HFW5DuX+YA1mNv2dTBn5BXv1cqqarCwTKz4nipRz/1kHTseEvEEUwGmtY6QAlq+yOuKfo7ZcHRk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOL5uf6Uf2GKY4wKoOmy0BMMxCyAz0C4Mlc3Atr+hkmKKxrud6
	RBMHBwv0xP0tPhKloZOm4FiOOPt+u0WFcy9N/fkcxtYfMXyS/7uN4hbZA1igtZsKwy8=
X-Gm-Gg: Acq92OE+dU6j4T4s9WP7tL/phnFeZFYqMcYmJdIFLovs5e+SIS+TwVu1jI6dH05hu3Q
	TVkAjGHMzg3irwtAhdEM8LG/qZFiVXyBajWZRKaYqKx3eVWCcIs/YVMHgEM+A3r2uZhy8fwoGNj
	O5gJIkSOxHq3ONHvbEoaTQb8cy6srS++2ibMfLLhK8/UHI7pNYupWFQi3Uc3aWDeUZJ2RTi6o6V
	WX6HqrbTZsDh1wMG1S5MiRryoCAsz554hHgZvpLJjH7S6tykf+3uRCCKTls/1IWWtAxMjPPVhB6
	fDzCDbOwnJxZwx4epyt0ZaEeaZzgEnc/z3830/+sLQdnD1TWYPq4JPuvKr9KYX9rtCotT1lbqEg
	g4ueJMpR55eg/555qAKfjbfQ5Hnzu44strstE/dC4vzvw1QEdvWYKzIKDp8AcSCEOsem4cJ9e2J
	UAjfCHEp5xOOtYiBPQsG6y
X-Received: by 2002:a05:7300:bb07:b0:2f9:1004:b2cd with SMTP id 5a478bee46e88-30ba3ad0bcfmr2565276eec.20.1781623499389;
        Tue, 16 Jun 2026 08:24:59 -0700 (PDT)
Received: from geday ([189.115.92.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb95450sm23757871eec.28.2026.06.16.08.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 08:24:58 -0700 (PDT)
Date: Tue, 16 Jun 2026 12:24:48 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geraldo Nascimento <geraldogabriel@gmail.com>
Subject: [PATCH v7 0/3] PCI: rockchip: 5.0 GT/s speed discouraged by Rockchip
Message-ID: <cover.1781622998.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dragan Simic already had warned me of potential issues with 5.0 GT/s
speed operation in Rockchip PCIe. However, in recent interactions
with Shawn Lin from Rockchip it came to my attention there's grave
danger in the unknown errata regarding 5.0 GT/s operational speed
of their PCIe core, including data loss.

Drop all code related to 5.0 GT/s operational speed from this driver.

Endpoint Mode driver was not tested.

Changes in v7:
- In pcie-rockchip.c (PATCH 3) drop unreachable code
- Link to v6: https://lore.kernel.org/all/cover.1781207474.git.geraldogabriel@gmail.com/T/

Changes in v6:
- Squashed patches 3 & 4 together as suggested by Mani
- More formal warning message as suggested by Dragan
- Set the 2.5 GT/s bit regardless of if link-speed is set to 2
- Link to v5: https://lore.kernel.org/all/cover.1772239598.git.geraldogabriel@gmail.com/T/

Changes in v5:
- Changed commit order to not break builds and adjusted copy pasted
  commit message. (thanks Charalampos!)
- Reintroduced behavior to force 2.5 GT/s in case there's something
  non-default in the DT. (thanks Dragan!)
- Link to v4: https://lore.kernel.org/linux-rockchip/cover.1772169998.git.geraldogabriel@gmail.com/T/

Changes in v4:
- Incorporate suggestion by Bjorn and refined by Dragan to drop the
  "catastrophic" code
- Link to v3: https://lore.kernel.org/linux-rockchip/cover.1772057799.git.geraldogabriel@gmail.com/T/

Changes in v3:
- Clarify warning message even though Rockchip won't disclose details
- Drop DT changes as they were applied as subset by Heiko
- Link to v2: https://lore.kernel.org/all/cover.1763415705.git.geraldogabriel@gmail.com/T/

Changes in v2:
- hard limit to 2.5 GT/s, not just warn
- add Reported-by: and Reviewed-by: Dragan Simic
- remove redundant declaration of max-link-speed from helios64 dts
- fix Link: of helios64 patch
- simplify RC mode comment
- Link to v1: https://lore.kernel.org/all/aRhR79u5BPtRRFw3@geday/T/

Geraldo Nascimento (3):
  PCI: rockchip-ep: do not attempt 5.0 GT/s retraining
  PCI: rockchip-host: do not attempt 5.0 GT/s retraining
  PCI: rockchip: drive at 2.5 GT/s, error other speeds

 drivers/pci/controller/pcie-rockchip-ep.c   | 13 -------------
 drivers/pci/controller/pcie-rockchip-host.c | 20 --------------------
 drivers/pci/controller/pcie-rockchip.c      | 14 ++++++--------
 drivers/pci/controller/pcie-rockchip.h      |  3 ---
 4 files changed, 6 insertions(+), 44 deletions(-)

-- 
2.54.0

