Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889263;
	b=XZGcIVkO5qaLZo3QgytA7czsATuL/M3M/7zEysATM2Noz/NT8u0mWL4DWoP0ZAdVWapM
	 XBETqDg+FwNzlGUogVyJ3CZ2Kmi+G7YUPS4RK4NpiLa3Z6sRFIWN8POTAjpmirSVKInqE
	 7sDVqYf+h4BXoAHpNBEAL8hckdfEfEZBfRxrnOsMJg60g4jzjJk5WXqCMXFwFpWIBhcKP
	 RyILu/d7y++DB17xfMr1SQxBFhKTr+2ZgzhNJgkKZrVA59LQNp+I+SEkiJkmUiuuwXYh3
	 lJGHrez3JNqTsKATLgKQ2S5MKU24SnF28IFD3o2YJJS6EZ+8vhj6QXX15oGZjfLYlqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889263;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=w67WbtLwCDT6cPYNGAsC5XzoRVxETDpsQAGG+PvMA2o=;
	b=luFRriyTHkmfHn/OhDhaSte5KsR+2qbyXENTpvNYKiR+Wl8WkSDuVO8JDCyCmOlh9Em+
	 uK90dIVPO2J+Sp7FHUiKX0ZUSmKJakulFvhVAhWgMwMvB3FJh8CKgWzFRT8VVV/GzCKZa
	 +XXoiB7vTkdjRaK/hgVkxFH4ie03E8Zywg5wxeJ3AWXwivSdvXFNeYl5h0W4dZy4WEtj+
	 2691Sx/DOV9vnmc9ztM+QsCRpz/KEyLIu6ovs5bImjLRpXqkX0EV/GpnrMLJzezRiAicV
	 BxvK/192WxawSREjjTCLDmrCp07+Cr35wrc4M6YzW67fNjDV17nog/Bx8cifIDfHmRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHRC5L44;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A717A606A33C;
	Thu,  5 Nov 2026 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHRC5L44
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82FF1F00919;
	Thu,  5 Nov 2026 14:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889262;
	bh=w67WbtLwCDT6cPYNGAsC5XzoRVxETDpsQAGG+PvMA2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oHRC5L44g9h8qK8SBDbqXCISMpG6T9DX8T7BE1e6vunXA3QSe12GzH4rZ8Y1GVZ9y
	 nD1N97inxY5gVNYIhm4dFwPeHD1YqNoh0pl6T6Rf0pSPnaCUBkwFa0rWc0ZFzu+jhK
	 qG4kS8u0pXktsYlTf1va+TxUP440Nkn3/7pGvCYv90ZTvykpuxzLF2XfdKLQR6zVzV
	 1US7Ct6sGBKlaPvgJd8I+OTdjwdLctOWjwViwtG6Eq9xBfk0mkXHb4HYFY9vwuJ3hq
	 GXXDoqKSR00efTaZXcFjdPd54cgCB5Vxmbl3rS6WI6a0KzlenQxCU6CugEKVb0x4px
	 Gvmxy+tl1euxg==
Date: Thu, 5 Nov 2026 20:04:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 0/3] PCI: qcom: Implement shutdown() to avoid SMMU/NoC
 errors on reboot
Message-ID: <auyT1HkNYFF9ro-p@debian>
References: <20261029-shutdown-v7-0-3fd7a76a6991@oss.qualcomm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261029-shutdown-v7-0-3fd7a76a6991@oss.qualcomm.com>

On Thu, Oct 29, 2026 at 09:49:26AM +0530, Krishna Chaitanya Chundru wrote:
> During system shutdown/reboot, power/clocks to the PCIe controller get
> removed regardless of link state. If the link is still up when that
> happens, it can trigger SMMU or NoC errors.
> 
> This series adds a shutdown() callback to the Qualcomm PCIe host driver
> that forces the link into L2/D3cold before shutdown proceeds, reusing
> the existing suspend_noirq() path.
> 
> Patch 1 fixes pci_host_common_d3cold_possible()'s underlying bus walk,
> which aborts as soon as it finds a device outside D3hot and can
> therefore miss a later PME-capable device -- something that becomes
> common once patch 3 starts forcing D3cold entry during shutdown while
> endpoints may still be in D0.
> 
> Patch 2 adds a force parameter to  dw_pcie_suspend_noirq() so that callers can
> set to make dw_pcie_suspend_noirq() force L2 entry during shutdown/
> reboot, skipping the D3cold capability check that can otherwise leave
> the link up if any endpoint hasn't suspended yet.
> 
> Patch 3 adds qcom_pcie_shutdown() and wires it up as .shutdown.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Please fix the build issue reported by kbot.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
