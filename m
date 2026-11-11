Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362407;
	b=BOTJvr3bettluV8WH+ywmmyp0HewDFPYlzeXRt97qSQ88zfSbEnn9NX82gKmvce3B5pY
	 TjZBGcK+d0nB878xv2sdWJtF6Z+u/VCuzb3uxx+68iP2lpgQG2OZeUBgocGvJiunhR8pT
	 bJdkkL+oiK4JAo/FvgIYCDCTSTZYK4h8DhmH6cyNo3oSloWA5A2iE6Fm9YQWzpaAPNhTQ
	 b5/+cvlvnNp0NUA7pWUUYtK8Fk4SVpPrdQxHEuJMTRbAP61X1Kz7lX6AdCLFGRIif2vTF
	 KuxaefraZs0ZCm4Ack2GNLt45Ew89OhtpxaGelr89kjTe2e5g0//w14m32ZPlICD5lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=knlC16tb0fmhvOu+uBq5yXSRa3dChQFTwNgKUBOfny0=;
	b=EgX8G/TN0J8o1ZDu0gHxn+bS99I2y9O3EOlwSP2m5gkDisAqfZAFURdZscq7XlS7EjzW
	 0T57c1fhnJhkOYpqFX60ycHSrdR22RZq4O4fWP1ibV2WYvOWemIrw+z5RdVYtKx5xQjNC
	 tiwV43oad24DHLrh2LzNei/U5ZP2EEREYldV/Ftxh3miMlAji4nUK3cvY9T8PqgpKizs/
	 7mRD3B5K/LBm3DY2quhPzVKAdV8nj5QYt8G2fJdLzD8tLUuF0vw6XshpkhtzRGMgYjZUu
	 jmv9Hg+lomxPBE9r7puRyC5rRv4gh/QBzouij1+uVrRleFNOY9q6eLm+GnDeTTXh1iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tpad2UdQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABB4606A320;
	Wed, 11 Nov 2026 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tpad2UdQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FB11F0089F;
	Wed, 11 Nov 2026 02:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362406;
	bh=knlC16tb0fmhvOu+uBq5yXSRa3dChQFTwNgKUBOfny0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Tpad2UdQeAgh+2njzB98sP2gOZQTlt2hzRsLShsmj6TGSv2IbgN6GhgoeKl4QoBSG
	 xQYl8ELxaTMDEej9ta9SrAxXKSK8/378qOIHSkPdc/I1k1yuLz5+CC54++DBb+7QKG
	 6mum//6kjU+OE2W4AgwGvEKpbSsaff6sbDHDYRXLMftegnKJplYruKKfvLp8KA2356
	 gWdUave4dwrGSkPIMSL4FjAUkVOzKKIMyRI08BTcgTvw7QjvrgVCa7ydPUgexVsker
	 +eJJYlcfffg6O6fN/puNDmVC+bo/A3OEbcouUhOo3umrc992+3wU4LDZ1A5F5yiJ6b
	 RTsW484tp9Prw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D8202380CFE6;
	Wed, 11 Nov 2026 02:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
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
Subject: Re: [PATCH] riscv: pci: allow write-combining mmap of PCI BARs
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179436240542.644035.285193769766011336.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 02:00:05 +0000
References: <20261110-riscv-pci-mmap-wc-v1-1-1d16fb8c74b4@kernel.org>
In-Reply-To: <20261110-riscv-pci-mmap-wc-v1-1-1d16fb8c74b4@kernel.org>
To: Troy Mitchell <troy@kernel.org>
Cc: linux-riscv@lists.infradead.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Paul Walmsley <pjw@kernel.org>:

On Tue, 10 Nov 2026 15:04:49 +0000 you wrote:
> Define arch_can_pci_mmap_wc() for RISC-V, so that the PCI core can
> create resourceN_wc in sysfs for prefetchable BARs. Without it, the only
> sysfs mapping of such a BAR is resourceN, which uses pgprot_device():
> with Svpbmt or XTheadMae that is the IO memory type, where every access
> is strongly ordered and nothing is merged.
> 
> resourceN_wc is mapped with pgprot_writecombine(), which selects the NC
> memory type when the kernel uses Svpbmt or XTheadMae. Without either,
> _PAGE_NOCACHE is 0 and pgprot_writecombine() changes nothing, so
> resourceN_wc would get the same PMA-defined attributes as resourceN and
> no write-combining at all. Make arch_can_pci_mmap_wc() true only when
> _PAGE_NOCACHE is non-zero. On 64-bit this is a runtime check, as
> _PAGE_NOCACHE is chosen at boot from the CPU extensions; on 32-bit it is
> always 0, so nothing changes there.
> 
> [...]

Here is the summary with links:
  - riscv: pci: allow write-combining mmap of PCI BARs
    https://git.kernel.org/riscv/c/79fc9d9467a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


