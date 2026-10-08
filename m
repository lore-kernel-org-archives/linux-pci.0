Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039848CD61
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452312; cv=none; b=rWYvBJw3b9Wr+FhpKULGX44AeKDgqdDDsu4NJrbllM7iZJ+1PG01xybMEo6kcpsAsaNlpKmzgO/e6uR7EGl5PoMlCxrB7cYrOGxYj/5Mn63zRswQlRdiWKC/ZN5GQHKI26hH0IqAHnNZ0xcLI/SPNL2508evAbG/kk1KeXH/7/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452312; c=relaxed/simple;
	bh=84HP+Q/4MF0jH3T+thQjERHPaSn8ckX+JDZ8SbWRQpc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVSWlbdSbNdQMZ+XNiLDWkqVYKkdmE4PZ69FVqTbO7MDp7kDIRKxKO8yqoCIki/e+/0BtLNON5xtfmWINNKUHQBDRFIH6SyKxcUo7m6L//ftzvLi27w7qK+5pPneuWPaMBuF+xA9xTAH2Dh1NOuOABuZpOpn4hUVndTElEngy0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgX20x7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgX20x7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF72D1F0089B
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 09:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791452310;
	bh=kP/gshIQfJiC2yK7AwFEC4ccBxmEWsvq29wx5/gMoo4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=NgX20x7Ux/thTBgaEsBhBZ5atC9a8+E7FhPFcDtOvYJW41kFr4JommHg18YLUc9XH
	 mnM5ov/moPA7ForVzLOB9iHZGLJMbhff8XCefxkMUktGvVpC3WgITaU0eNFYixTSDm
	 C4PS0PsRaF2WjZ6F26x6tHGqPg3lHJXOXyTm2i7wxTANogYrgx553+AfqFVbXp+jOd
	 x6uTo3OFo0DVTprp2xVvbqZRoX0+IoWXamsYQpm2CBbzCZ6caBwZM7osohTBae9PUo
	 gxAvzxulluLdSUf4D1i1wWMPjbFPjTghf8FiXaG+7XCT47ohnlByDovSc0Ds98wLP/
	 Esy75X4eYD+hQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5bad794b197so2995754e87.1
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2026 02:38:30 -0700 (PDT)
X-Gm-Message-State: AFq9FYKLcTOwpK2hcNjcp/W26CBmTNAxOmoLmkhfMLor6RqHN1GQ9ba1
	gftDxwnyRLAQ9tp4QY8vXSWIOmss457sl64J5aj9TJcgEXMlUlWxeXVbUJPeIUIDjfctjizWbiY
	1xRjEzUxLGhmGEDUf5vLgR2kQOaQzQ4OHJ4od2c1aEA==
X-Received: by 2002:a05:6512:b0f:b0:5b8:f1ae:cbf3 with SMTP id
 2adb3069b0e04-5bcd06c02b8mr1635149e87.21.1791452309518; Thu, 08 Oct 2026
 02:38:29 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Oct 2026 09:38:27 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Oct 2026 09:38:27 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <1791446700-100166-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1791446700-100166-1-git-send-email-shawn.lin@rock-chips.com>
Date: Thu, 8 Oct 2026 09:38:27 +0000
X-Gmail-Original-Message-ID: <CAMRc=Mfyjr8t_JmmvAmcmn_k7ZC7z61+G9E93eB2CZQLmkOrmA@mail.gmail.com>
X-Gm-Features: AclHuK_BNI6zXjeU0hyOmS3v2t13eMkSZ4I6XGloXg6HgDq26zhru0ozIC4tIA8
Message-ID: <CAMRc=Mfyjr8t_JmmvAmcmn_k7ZC7z61+G9E93eB2CZQLmkOrmA@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl: Only destroy devices created by pwrctrl core
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Oct 2026 10:05:00 +0200, Shawn Lin <shawn.lin@rock-chips.com> said:
> pci_pwrctrl_create_device() only creates platform devices for OF nodes
> that pci_pwrctrl_is_required() accepts, but pci_pwrctrl_destroy_device()
> unregisters the platform device of every available child node without
> that check.
>
> Nodes under a PCI host controller that are not pwrctrl devices may have
> been populated by another mechanism.  Destroying them here would tear
> down devices owned by other code.
>
> Mirror the check done at creation time so that only devices created by
> the pwrctrl core are removed.
>
> Fixes: 4c4132489201 ("PCI/pwrctrl: Add APIs to create, destroy pwrctrl devices")
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
