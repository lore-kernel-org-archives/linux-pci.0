Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C92B2459D4
	for <linux-pci@vger.kernel.org>; Sat, 28 Feb 2026 00:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772240097; cv=none; b=XhEKZQNqIrLcZjbFKH/J3uMZFJknSQAFMsqyZUd7IV2ToIC2Rlt9JsBQrc3ImcThb0F6pkKSxbSOo7wdO32qC7n4LE5Y1jMje0k9iMaNAlTw7ao6IJvgtK3CBGI6v41TajqiuM3yNOSkHz8oCDTVKuuZn+nLFg89XfkQKN2CSt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772240097; c=relaxed/simple;
	bh=Gtpu7HR52/o57ZNKtvnSGR12WjLMNyqvF0KB5W4PZIU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fXo88fUQ6iwHEWI94fRA9ROSoyIerUB2xsrfqrLGP3yM27KU8Wl3RgvaTjZIWj4uZrHodJ2hIXc63+m+LVxkoAXTCu7ePA8XlMiiyxy1VR5Y8tt90qVI51uQYmsHu/2LCvpK2jB6tN5SBf458/1UMCGqISVTWfaoJJIoIemHddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHII+sgW; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHII+sgW"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56a8ebde349so2305507e0c.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 16:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772240094; x=1772844894; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oqjVAkGN45WCvwyHpK51yVytA2m9U+cdr8FXQh1dqPs=;
        b=OHII+sgW1y4alK0AQqJ4R3qYj25Mgy/jW/erkHgPbPOaH/56LwOji+PDqIMLy+lfee
         8/ucjP/7jwHu4e8eOV67ngrM56Vh3kXBrgTiff+KkCD58uParzv1gU+/HUQCeg2yCwlA
         eIXDPPMeLty8ocJzSO1m+/X30ph3Q3yf9nm7Zl6jaNmHgMlsL/dVTxDquoDuek+5i+6H
         OrjSZR9UtiJevsU9Oc0gXex4EKNeT5pnwNw0x6+bkNbDhn7RJ4ZUFAcud+Bb3PrnLW1D
         e5OmqpKnBxuMYytrmb+PMt0OfkEaPQRRFMMa2enwTeqImJfeRPqeSMGZsQB0jKHAUJlq
         cVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772240094; x=1772844894;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqjVAkGN45WCvwyHpK51yVytA2m9U+cdr8FXQh1dqPs=;
        b=QqNkeGIDVk1VT1gz8kaShgw3nJVjT2eoNrGZYo4Ka/vsqOFnRjbW5U1CBc1j42gD4q
         NPxCRtjPo4XOMqQe3FS1W7PxqgmsghLlSMcnd8fZHSC4d2GFKCaLnUSZTAF+xyTRYs85
         Lt2CAbUaMhU0mwfUKWJCr6keOCuwReP99oY+8HbPg2PbUMs2XcA+OTYEa0hd59E/coDl
         KrNcAhR1hxIsHsL2Ndh3bwqcA9SvqmM2uiJGLr+gCf0sOlRM/yi2aerz395sUCW9ITuB
         PoEZq7rkSzBm032bxrSZUyRKYUvNMpJ79Lfmkbvn1SbegFfJMtvPZ+NOIAbiJP7vGzJD
         iRrg==
X-Forwarded-Encrypted: i=1; AJvYcCXNM8HazSfurvDvUUQZGeqY09xrv1CQEp9688DVqH0RaGRYN5JJoq8dIQuczGgTzn54aOxwkM3n9bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxjSASumzKvzcj27YHuWPqZ8ENWMwKwW7fhUEySTLiCNmWwwv5
	nxUh+Zdrq89WVGnre/yzajZ7EFWPl1jcjhVt1GuVX8QJ3C1kGgUGRrZL
X-Gm-Gg: ATEYQzztQTOEIA7E1pU3qmlUL1Rtx3uxR8h4MSo0FZYTiPbojtAT2ZJ8BY6uln46+2O
	/UwngQvqtxyM97G8eUxJ6WSWYL5eU8AkNzgXhPrEkpgx8/ZcEPpEoU1jAN6xwizyX95vMGG9msB
	Y+0zt37Ibo11WjFh1j75NlAzUziJScEfuBlXUVh3dNNiL28R+a5ZsATZyQzl29ME7ZiCx91MXEP
	opdL8uURNeLvnOOMOybHJMfHaigSruxDxb0SSXSffaYgb2pqbBbjapWleViAiI5nbdUFKLSjfgb
	CYbluofbd/X8PRxLJ/2fMV4Qn1+qa7wBmtuyOr34zrhsEj1X/MqiA5xXkZkAaGQftGrv2sIg189
	BWI3ut9W0pVgJa7VHcQF501o+lxm5yCTAP9zh4hvWOIcu9rK8zdCW1fhKOLqg91U1JiDM+xRL9C
	8xk0ODB1jwBg==
X-Received: by 2002:a05:6122:d04:b0:544:c8bf:6509 with SMTP id 71dfb90a1353d-56aa09ec812mr2879599e0c.4.1772240094275;
        Fri, 27 Feb 2026 16:54:54 -0800 (PST)
Received: from geday ([2804:7f2:800b:feb1::dead:c001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a91bd2291sm8371795e0c.9.2026.02.27.16.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:54:53 -0800 (PST)
Date: Fri, 27 Feb 2026 21:54:41 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Geraldo Nascimento <geraldogabriel@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] PCI: rockchip: 5.0 GT/s speed discouraged by Rockchip
Message-ID: <cover.1772239598.git.geraldogabriel@gmail.com>
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
of their PCIe core.

Drop all code related to 5.0 GT/s operational speed from this driver.

Endpoint Mode driver was not tested.

---

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

---

Geraldo Nascimento (4):
  PCI: rockchip-ep: do not attempt 5.0 GT/s retraining
  PCI: rockchip-host: do not attempt 5.0 GT/s retraining
  PCI: rockchip: drive at 2.5 GT/s, error other speeds
  PCI: rockchip: drop 5.0 GT/s defines

 drivers/pci/controller/pcie-rockchip-ep.c   | 13 -------------
 drivers/pci/controller/pcie-rockchip-host.c | 20 --------------------
 drivers/pci/controller/pcie-rockchip.c      | 15 +++++++++------
 drivers/pci/controller/pcie-rockchip.h      |  3 ---
 4 files changed, 9 insertions(+), 42 deletions(-)

-- 
2.52.0

