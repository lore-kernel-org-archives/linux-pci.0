Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C453A63F2;
	Mon,  9 Mar 2026 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056852; cv=none; b=qH9P+cKpMRK75eHO/rEchypbWEX4PnlOk0qPhcRTEgRUAvmyFOdtF0p7BPan8QJ4nCOsUFvp6lR5INkLNoS7zL/BG4dviTtgW619h7Cz2I7Wrhqpn6Fd82+hwZ7Rt3pNpRbV7zWdPUzsS2QiN/AfMHRFuXPU/Kcr1bLrIIxlkho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056852; c=relaxed/simple;
	bh=sz1Wv9sCn4SXjuqSpv6M2/avbC0D6YgltNPRQ7TT2e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHzZxfUqiY/Qw49la0+l2kM5TYsOVUxP3G5OH2n4O3UHpFZRQUuJL1wugCNDAjD7ip9Yl1paDQqnRy4F26uibnotwO//mvVpYPR878Qap0y2qqnHx868CQKIRt71K4k8JSJXAbcamWHa7TeLErAzAqEIYXSk8zf5Y3TQdaiNhZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCTCfSMo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCTCfSMo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2BFC2BC86;
	Mon,  9 Mar 2026 11:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773056851;
	bh=sz1Wv9sCn4SXjuqSpv6M2/avbC0D6YgltNPRQ7TT2e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pCTCfSMoyjrSq63PQRYrxGlnomjiWOj/+vS08VuguoO7o1lS72zLgmPPs78BTMiQl
	 MFI3bP/RdSDA5jjYc1vddi3Ut+KCuLvIHcx3+LAMjMCdKPYe8U39rImh1Bww71dcIw
	 Q0ILQ/iz26t/3zeD71hkhgmoaLLsW1+UkoO9k6SOiLSW0tSuyLLpJ+XOAV1phraJOv
	 VVnr2WySMJE7v/7/Ns4oSfil7yb4m54HcW/lEfWUISyBrVz5zzO26h3DRoPzxr/FKf
	 zrVgFtjYjbWelqmruDVpVf0BqoPxF0aZr/u1ESwtjYiY8qYuEuc2x/AJnAhyU9QgTT
	 SXJKW0561yutA==
Date: Mon, 9 Mar 2026 17:17:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, jingoohan1@gmail.com, kwilczynski@kernel.org, 
	bhelgaas@google.com, helgaas@kernel.org, robh@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] PCI: of: Remove max-link-speed generation
 validation
Message-ID: <movonqoagqttbph3hrcmjzeqioascuktwx6btk6rci5menjnxc@5ydgeu5h2ig7>
References: <20260308142629.75392-1-18255117159@163.com>
 <20260308142629.75392-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260308142629.75392-2-18255117159@163.com>

On Sun, Mar 08, 2026 at 10:26:28PM +0800, Hans Zhang wrote:
> The of_pci_get_max_link_speed() function currently validates the
> "max-link-speed" DT property to be in the range 1..4 (Gen1..Gen4).
> This imposes a maintenance burden because each new PCIe generation
> would require updating this validation.
> 
> Remove the range check so the function returns the raw property value
> (or a negative error code if the property is missing or malformed).
> Callers must now validate the returned speed against the range they
> support.  A subsequent patch adds such validation to the DWC driver,
> which is the primary user of this function.
> 
> This change allows future PCIe generations to be supported without
> modifying drivers/pci/of.c.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>

I take my Ack back. If we decide to go with validating DTS properties (which is
fine though for non-resources such as clocks), then we should make sure that it
happens in a single patch.

Right now, you remove the check in one patch and add it back in another. That
leaves a window...

- Mani

-- 
மணிவண்ணன் சதாசிவம்
