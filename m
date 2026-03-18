Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005FE392814;
	Wed, 18 Mar 2026 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773833260; cv=none; b=bFp7HjeRNZSc9j0dEc5R+Z2PFDrUUkvBubIy4KD3Jci9+P7SVD6LuARkQAEqGDhWERmKX82rIasdWvC5XvmhgIT1L/gcs8u0u+fCFRVDne2t6tVumhNBd9BZKuNCIyatiNW44TaZcAa24PhPUQsUOyD59HyuvHuVz5P1U+drujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773833260; c=relaxed/simple;
	bh=NRaSTkGhNSnulLHimzIqdeWJs/YNqIjAwnhWAJuFmgU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i/UiELd0lQUvl5jkFtf99vwxoicw47JvnjzDABf6oMbEm9rNU3RdOkwBurU2K70T+mc+sl0PvFtOxakqlw8jPDZHSN0VLShzL397OEBzlW7uSkFYZwYbMj2osQsG4ka1337fkMdKEwuthJH9MawCdBhZN+otCOW9vtA1F4VsLwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrNJ5e0l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrNJ5e0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB3BC19424;
	Wed, 18 Mar 2026 11:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773833259;
	bh=NRaSTkGhNSnulLHimzIqdeWJs/YNqIjAwnhWAJuFmgU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jrNJ5e0lt+Y+Snacff6/ta9fdsEBV0qPSD1PQNZQkwoPYPon1rw0eQC7zye6eNtnP
	 J/IdoCt7IXp3icZCUkrBwjWHGRbxkrDjLNZDN0RLizJlrZ/7DfotVQWKRDt2Veh4pB
	 IDV6qaG6AwilM3ijS5UD0OBENj4wMd1mi6s2DbG+upZQ6bgvyWvRawqVCUnpg24neF
	 WSRi931JzfcPecBLHalqyv+aBsNOfhtt7/B7SywhkOsa0e9s1GjEvMwf2dJX+hCx4P
	 dPrqY5jM/fCV/iMGwGfdsDaYf80W7aqzzB/nviiytGB4heG8G7p+ueuvGFPO05QVjt
	 HLXGLtmDh5wpA==
From: Vinod Koul <vkoul@kernel.org>
To: bhelgaas@google.com, mani@kernel.org, 
 Devendra K Verma <devendra.verma@amd.com>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, michal.simek@amd.com, Devendra.Verma@amd.com
In-Reply-To: <20260311111834.3750297-1-devendra.verma@amd.com>
References: <20260311111834.3750297-1-devendra.verma@amd.com>
Subject: Re: [PATCH v13 0/2] Add AMD MDB Endpoint and non-LL mode Support
Message-Id: <177383325715.408483.18354973261373934236.b4-ty@kernel.org>
Date: Wed, 18 Mar 2026 16:57:37 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 11 Mar 2026 16:48:32 +0530, Devendra K Verma wrote:
> This series of patch support the following:
> 
>  - AMD MDB Endpoint Support, as part of this patch following are
>    added:
>    o AMD supported device ID and vendor ID (Xilinx)
>    o AMD MDB specific driver data
>    o AMD specific VSEC capabilities to retrieve the base of
>      phys address of MDB side DDR
>    o Logic to assign the offsets to LL and data blocks if
>      more number of channels are enabled than configured
>      in the given pci_data struct.
> 
> [...]

Applied, thanks!

[1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
      commit: 14eb9a1d338fdc301a2297af86818ecf716b1539
[2/2] dmaengine: dw-edma: Add non-LL mode
      commit: b7560798466a07d9c3fb011698e92c335ab28baf

Best regards,
-- 
~Vinod


